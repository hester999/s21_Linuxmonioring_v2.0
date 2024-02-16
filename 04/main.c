#include <stdio.h>
#include <stdlib.h>
#include "time.h"

void ip_gen(char* ip_str) {
    int octet1 = rand() % 256;
    int octet2 = rand() % 256;
    int octet3 = rand() % 256;
    int octet4 = rand() % 256;
    sprintf(ip_str, "%d.%d.%d.%d", octet1, octet2, octet3, octet4);
}

void response_gen(char* response){
    int arr[] = {200, 201, 400, 401, 403, 404, 500, 501, 502, 503};
    int rand_index = rand() % 10;
    sprintf(response,"%d",arr[rand_index]);
}

void method_gen(char* method){
    char *arr[] = {"GET", "POST", "PUT", "PATCH", "DELETE"};
    int rand_index = rand() % 5;
    sprintf(method, "%s",arr[rand_index]);
}



void url_gen(char* url) {
    char *paths[] = {"/", "/api/data", "/items", "/search?q=example", "/user/profile"};
    char* urls[] = {
            "https://www.google.com",
            "https://www.yandex.ru",
            "https://www.wikipedia.org",
            "https://www.amazon.com",
            "https://www.facebook.com",
            "https://www.twitter.com",
            "https://www.instagram.com",
            "https://www.linkedin.com",
            "https://www.netflix.com",
            "https://www.spotify.com",
            "https://www.apple.com",
            "https://www.microsoft.com",
            "https://www.github.com",
            "https://www.stackoverflow.com",
            "https://www.reddit.com"
    };

    sprintf(url, "%s%s", urls[rand() % 15],paths[rand() % 5]);
}

void agent_gen(char* agent) {
    char *arr[] = {"Mozilla", "Google Chrome", "Opera", "Safari", "Internet Explorer", "Microsoft Edge", "Crawler and bot", "Library and net tool"};
    sprintf(agent, "%s", arr[rand() % 8]);
}

void get_time(char* time_str, int index, int day_offset) {
    time_t baseTime = time(NULL);
    struct tm *now = localtime(&baseTime);

    // Устанавливаем время в начало дня и добавляем смещение в днях
    now->tm_hour = 0;
    now->tm_min = 0;
    now->tm_sec = 0;
    now->tm_mday += day_offset; // Добавляем смещение дней для каждого файла лога

    // Добавляем минуты для разнообразия записей внутри одного дня
    now->tm_min = index;

    // Конвертируем измененное время обратно в формат времени
    mktime(now);

    // Форматируем время в формате логов nginx
    strftime(time_str, 30, "%d/%b/%Y:%H:%M:%S %z", now);
}

int main() {
    srand((unsigned)time(NULL));
    int count_recorders_per_day = 100 + rand() % 901; // Сколько записей генерируем на день

    for (int day = 0; day < 5; day++) {
        char filename[25];
        sprintf(filename, "log_day_%d.log", day + 1); // Создаем имя файла для каждого дня
        FILE *file = fopen(filename, "w+"); // Открываем файл для записи

        if (file == NULL) {
            perror("Error opening file");
            return -1;
        }

        for (int i = 0; i < count_recorders_per_day; i++) {
            char ip_str[16];
            char response[16];
            char method[16];
            char time[30];
            char url[100];
            char agent[100];
            int body_bytes_sent;

            ip_gen(ip_str);
            response_gen(response);
            method_gen(method);
            get_time(time, i, day); // Добавляем смещение в днях для каждого файла лога
            url_gen(url); // URL запроса
            agent_gen(agent);
            body_bytes_sent = rand() % 5000 + 100; // Примерный размер тела ответа

            fprintf(file, "%s - - [%s] \"%s %s HTTP/1.1\" %s %d \"%s\" \"%s\"\n",
                    ip_str, time, method, url, response, body_bytes_sent, "-", agent); // Используем "-" для referer, если он неизвестен
        }

        fclose(file); // Закрываем файл после записи
    }

    return 0;
}
