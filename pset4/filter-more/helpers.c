#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    int tmpBlue = 0, tmpRed = 0, tmpGreen = 0;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            tmpBlue = image[i][j].rgbtBlue;
            tmpRed = image[i][j].rgbtRed;
            tmpGreen = image[i][j].rgbtGreen;

            int avgValue = round(((float) tmpBlue + (float) tmpRed + (float) tmpGreen) / 3);

            image[i][j].rgbtBlue = avgValue;
            image[i][j].rgbtRed = avgValue;
            image[i][j].rgbtGreen = avgValue;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    int tmpBlue1 = 0, tmpRed1 = 0, tmpGreen1 = 0, tmpBlue2 = 0, tmpRed2 = 0, tmpGreen2 = 0;
    RGBTRIPLE tmp1, tmp2;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            tmp1 = image[i][j];
            tmp2 = image[i][width - j];

            image[i][j] = tmp2;
            image[i][width - j] = tmp1;

            // tmpBlue = image[i][j].rgbtBlue;
            // tmpRed = image[i][j].rgbtRed;
            // tmpGreen = image[i][j].rgbtGreen;

            // image[i][j].rgbtBlue = avgValue;
            // image[i][j].rgbtRed = avgValue;
            // image[i][j].rgbtGreen = avgValue;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    return;
}
