#include <opencv2/highgui.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>
#include <vector>
#include <iomanip> // для форматирования вывода

int main() {
    // Открытие камеры
    cv::VideoCapture cap(0, cv::CAP_V4L2); // Открыть первую камеру, указываю использовать Video4Linux
    if (!cap.isOpened()) { // Проверка, удалось ли открыть камеру
        std::cerr << "Error(1): Failed to open camera!" << std::endl;
        return -1;
    }
    std::cout << "Camera Opened Successfully!" << std::endl; // Вывод в терминал, что доступ к камере получен


    // Загрузка каскадов лица и носа
    cv::CascadeClassifier face_cascade; // Объявление объекта каскада лица
    if (!face_cascade.load(cv::samples::findFile("haarcascade_frontalface_default.xml"))){ // Загрузка каскада лица
        std::cerr << "Error(2): Failed to load face cascade!" << std::endl;
        return -1;
    }
    std::cout << "Face Cascade Loading Successful!" << std::endl;


    cv::CascadeClassifier nose_cascade; // Объявление объекта каскада носа
    if (!nose_cascade.load(cv::samples::findFile("haarcascade_mcs_nose.xml"))){ // Загрузка каскада носа
        std::cerr << "Error(3): Failed to load nose cascade!" << std::endl;
        return -1;
    }
    std::cout << "Nose Cascade Loading Successful!" << std::endl;


    // Объявление переменных
    cv::Mat frame, gray_frame; // Матрица для хранения каждого кадра
    int frame_count = 0; // Счётчик обработанных кадров
    double fps = 0.0; // FPS

    
    /*
    double total_time = 0.0; // Общее время работы с кадром
    double total_capture_time = 0.0; // Время захвата кадра
    double total_processing_time = 0.0; // Время обработки кадра
    double total_display_time = 0.0; // Время вывода кадра
    */

    // Основной цикл
    double start_time = static_cast<double>(cv::getTickCount()); // Засекаю начальное время для FPS
    while (1) {
        double total_time = 0.0; // Общее время работы с кадром
        // Захват кадра
        double capture_start_time = static_cast<double>(cv::getTickCount()); // Фиксирую время до захвата кадра

        cap >> frame; // Захватить кадр с камеры
        if (frame.empty()) { // Проверка на пустой кадр (ошибка захвата)
            std::cerr << "Error: Failed to capture frame!" << std::endl;
            return -1;
        }

        double capture_end_time = static_cast<double>(cv::getTickCount()); // Фиксирую время после захвата кадра
        double capture_time = (capture_end_time - capture_start_time) / cv::getTickFrequency(); // Вычисление времени захвата кадра в секундах
        //total_capture_time += capture_time; // Суммирую очередное значение времени, затраченное на захват кадра, с предыдущими


        // Обработка кадра
        double processing_start_time = static_cast<double>(cv::getTickCount()); // Фиксирую время до обработки кадра

        cv::cvtColor(frame, gray_frame, cv::COLOR_BGR2GRAY); // Преобразование кадра в оттенки серого
        cv::equalizeHist(gray_frame, gray_frame); // Улучшаю контрастность изобр-я

        std::vector<cv::Rect> faces; // Вектор для для хранения координат найденых лиц
        face_cascade.detectMultiScale(gray_frame, faces, 1.1, 3, 0, cv::Size(30, 30)); // Обнаружение лица

        for (const auto& face : faces) {
            //cv::rectangle(frame, face, cv::Scalar(255, 0, 0), 2); // Синий прямоугольник

            cv::Mat faceROI = gray_frame(face); // Создаю область интереса (ROI) для лица

            std::vector<cv::Rect> noses; // Вектор для для хранения координат найденых носов
            nose_cascade.detectMultiScale(faceROI, noses, 1.1, 3, 0, cv::Size(20, 20)); // Обнаружение носа

            for (const auto& nose : noses) {
                cv::Rect nose_rect(face.x + nose.x, face.y + nose.y, nose.width, nose.height); // Корректировка координат носа
                //cv::rectangle(frame, nose_rect, cv::Scalar(0, 255, 0), 2); // Зеленый прямоугольник

                // Красный круг, с центром в центре найденного носа, радиус - половина ширины найденного носа
                cv::circle(frame, cv::Point(nose_rect.x + nose_rect.width / 2, nose_rect.y + nose_rect.height / 2), nose_rect.width / 2, cv::Scalar(0, 0, 255), -1);
            }
        }
        
        ++frame_count; // Увеличиваю счётчик обработанных кадров после обработки кадра (для FPS)

        double current_time = static_cast<double>(cv::getTickCount()); // Получаю текущее время (для FPS)

        double elapsed_time = (current_time - start_time) / cv::getTickFrequency(); // Вычисляю прошедшее время в секундах (для FPS)

        // для FPS
        if (elapsed_time > 1.0) { // Проверка, прошла ли секунда
            fps = frame_count / elapsed_time; // Вычисление FPS (кол-во обработ. кадров / прошедшее время, к. больше секунды)
            frame_count = 0; // Сброс кол-ва обработанных кадров
            start_time = current_time; // Обновление стартового времени, для последуюищх вычислений FPS
        }

        std::string fps_text =  "FPS: " + std::to_string(static_cast<int>(fps)); // Строка с FPS 
        cv::putText(frame, fps_text, cv::Point(10, 30), cv::FONT_HERSHEY_SIMPLEX, 1.0, cv::Scalar(0, 255, 0), 2); // Вывод FPS
        
        double processing_end_time = static_cast<double>(cv::getTickCount()); // Фиксирую время после обработки кадра
        double processing_time = (processing_end_time - processing_start_time) / cv::getTickFrequency(); // Вычисляю время обработки кадра в секундах
        //total_processing_time += processing_time; // // Суммирую очередное значение времени, затраченное на обработку кадра, с предыдущими

        // Вывод кадра
        double display_start_time = static_cast<double>(cv::getTickCount()); // Фиксирую время до вывода кадра
        
        cv::imshow("Camera Feed", frame); // Показывать кадр в окне
        
        double display_end_time = static_cast<double>(cv::getTickCount()); // Фиксирую время после вывода кадра
        double display_time = (display_end_time - display_start_time) / cv::getTickFrequency(); // Вычисляю время вывода кадра в секундах
        //total_display_time += display_time; // // Суммирую очередное значение времени, затраченное на вывод кадра, с предыдущими

        total_time = capture_time + processing_time + display_time; // Общее время

        // Проценты
        double capture_percent = (capture_time / total_time) * 100.0;
        double processing_percent = (processing_time / total_time) * 100.0;
        double display_percent = (display_time / total_time) * 100.0;

        // Вывод в консоль информации о времени, затраченном на захват, обработку и вывод кадра с обновлением на каждой итерации цикла
        // 3 цифры после десятичной точки
        std::cout << "\rCapture time: " << std::fixed << std::setprecision(3) << capture_time 
                  << " s (" << capture_percent << "%) | Processing time: " << processing_time 
                  << " s (" << processing_percent << "%) | Display time: " << display_time 
                  << " s (" << display_percent << "%)" << std::flush;

        if (cv::waitKey(100) == 27) { // Если нажата клавиша ESC (код 27), выходим из цикла
            break;
        }
    }

    std::cout << std:: endl;
    cap.release(); // Закрыть камеру
    cv::destroyAllWindows(); // Закрыть все окна
    return 0;
}
