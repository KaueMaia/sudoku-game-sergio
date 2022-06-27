#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint8_t BYTE;
int BLOCK_SIZE = 512;

int main(int argc, char *argv[])
{
    if (argc > 2)
    {
        return 1;
    }

    FILE *file = fopen(argv[1], "r");

    BYTE *buffer = malloc(512);
    int counter = 0;
    while (fread(buffer, 1, BLOCK_SIZE, file) == BLOCK_SIZE)
    {
        char filename[9];
        sprintf(filename, "%03i.jpg", counter);
        printf("meu nome de arquivo: %s\n", filename);
        FILE *img0 = fopen(filename, "w");
        fwrite(buffer, 1, BLOCK_SIZE, img0);
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            fclose(img0);
            counter++;
            sprintf(filename, "%03i.jpg", counter);
            printf("meu nome de arquivo: %s\n", filename);
            FILE *img1 = fopen(filename, "w");
            fwrite(buffer, 1, BLOCK_SIZE, img1);
        }
    }
    fclose(img1);
    free(buffer);
    fclose(file);
    if(file == NULL)
    {
        return 1;
    }
    printf("%s\n", argv[1]);
}