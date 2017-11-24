#include <stdio.h>
#include <stdlib.h>
extern float srednia_harm(float*arr, unsigned n);
extern float series_sum(float x);
extern float array_sum_SSE(char * a_src, char * b_src, char * dest, unsigned count);
void z5_1_srednia_harm();
void z5_2_series_sum();
void z5_3_array_sum_SSE();

void z5_1_srednia_harm()
{
	unsigned n;
	scanf_s("%d", &n);
	float * arr = malloc(n * sizeof(float));
	if (arr == NULL)
		fprintf(stderr, "Unable to allocate memory");
	for (int i = 0; i < (int)n; ++i)
		scanf_s("%f", arr + i);
	printf("%f\n", srednia_harm(arr, n));
	free(arr);
}

void z5_2_series_sum()
{
	float x;
	scanf_s("%f", &x);
	printf("%f\n", series_sum(x));
}

void z5_3_array_sum_SSE()
{
	char a_array[] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char b_array[] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	char result[16];
	array_sum_SSE(a_array, b_array, result, 16);
	for (int i = 0; i < 16; ++i)
		printf("%d ", result+i);
	printf("\n");
}

int main(int argc, char* argv[])
{
	//z5_1_srednia_harm();
	z5_2_series_sum();
	//z5_3_array_sum_SSE();
	return 0;
}
