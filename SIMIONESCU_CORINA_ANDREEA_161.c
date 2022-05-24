// SIMIONESCU CORINA ANDREEA, 161, problema 5

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
double e = 2.71;
double p = 10;
int x;

void *function1()
{
    int i, n = 200;
    for (i = 1; i <= x / 2; i++)
    {
        pthread_mutex_lock(&mutex1);
        p *= e;

        printf("Accesare e^x de catre thread 1!\n");
        printf("Valoare e^x = %lf\n", p);
        pthread_mutex_unlock(&mutex1);
        sleep(1);
    }
}
void *function2()
{
    int i, n = 200;

    for (i = 1; i <= x / 2; i++)
    {
        pthread_mutex_lock(&mutex1);
        p *= e;

        printf("Accesare e^x de catre thread 2!\n");
        printf("Valoare e^x = %lf\n", p);
        pthread_mutex_unlock(&mutex1);
        sleep(1);
    }
}

int main(int argv, char *argc[])
{
    int rc1, rc2;

    char *c = argc[1];
    x = atoi(c);

    pthread_t thread1, thread2;
    // creare thread-uri
    if ((rc1 = pthread_create(&thread1, NULL, &function1, NULL)))
    {
        printf("Eroare de creare thread-uri! %d \n", rc1);
    }

    if ((rc2 = pthread_create(&thread2, NULL, &function2, NULL)))
    {
        printf("Eroare de creare thread-uri! %d\n", rc2);
    }

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    printf("Sfarsit executie threaduri!\n");

    double s = (p - 1 / p) / 2;
    printf("Valoarea lui sinus hiperbolic este : %lf", s);
    exit(EXIT_SUCCESS);
}
