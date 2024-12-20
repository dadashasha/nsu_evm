#define _POSIX_C_SOURCE 199309L
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define PI 3.1415926535897

double CalcSin(double x, long long n);

int main(int argc, char **argv){
    if (argc < 3) {
        printf("Bad input! Few arguments. Enter x and n in command line.");
        return -1;
    }

    if (argc > 3){
        printf("Bad input! A lot of arguments. Enter x and n in command line.");
        return -1;
    }

    struct timespec res, start, end;

    if (clock_getres(CLOCK_MONOTONIC_RAW, &res) == 0){ // сравнивается с 0, так как 0 значит успешное выполнение
        printf("Timer resolution: %ld sec, %ld nanosec.\n", res.tv_sec, res.tv_nsec);
    } else {
        perror("Call error clock_getres!");
    }

    char *endptr_x, *endptr_n;
    long x = strtol(argv[1], &endptr_x, 10);
    long long n = strtol(argv[2], &endptr_n, 10);

    if (*endptr_x != '\0'){
        printf("Error: Invalid input for x: %s\n", argv[1]);
        return -1;
    }

    if (*endptr_n != '\0'){
        printf("Error: Invalid input for n: %s\n", argv[2]);
        return -1;
    }

    clock_gettime (CLOCK_MONOTONIC_RAW, &start);

    double sinx = CalcSin((double)x, n);
    
    clock_gettime(CLOCK_MONOTONIC_RAW, &end);

    printf("%lf\n", sinx);
    printf("Time takken: %lf sec.\n", end.tv_sec - start.tv_sec + 0.000000001*(end.tv_nsec-start.tv_nsec));
    
    return 0;
}

double CalcSin(double x, long long n){
    double sinx = 0;
    x = x * PI / 180; // перевод градусы в радианы, иначе некорректные вычисления
    double sum = x;
    for (long long i = 1; i <= 2 * n - 1; i += 2){
        sinx += sum;
        sum = (sum * x * x * (-1)) / ((i + 1) * (i + 2));
    }
    return sinx;
}
