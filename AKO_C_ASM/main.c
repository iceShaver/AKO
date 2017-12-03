#include <stdio.h>
#include <stdlib.h>

int max3(int a, int b, int c);
int max4(int a, int b, int c, int d);
void inc(int * a);
void neg(int * a);
void dec_ptr_ptr(int ** a);
void swap_array_pairs(int arr[], int n);
int __stdcall _multiply3(int a, int b, int c);
int __stdcall _sum3(int a, int b, int c);
unsigned square_sum(unsigned a, unsigned b);
void bubble_sort(int arr[], const int n)
{
	for (int i = n; i > 1; --i)
	{
		swap_array_pairs(arr, i);
	}
}
//----------------------------------------------------------------------------
extern float srednia_harm(float*arr, unsigned n);
extern float series_sum(float x);
extern float array_sum_SSE(char * a_src, char * b_src, char * dest);
extern void add_SSE(float * p_array, float * q_array, float * r_array);
extern void sqrt_SSE(float * src, float * dest);
extern void invert_SSE(float * src, float * dest);
extern void int2float_array(int*src, float*dest);
extern void float_arr_odd_inc_even_dec_4(float * arr);
extern void add_3_arrays(float * arr);
void z5_1_srednia_harm()
{
	unsigned n;
	scanf_s("%d", &n);
	float * arr = malloc(n * sizeof(float));
	if (arr == NULL)
	{
		fprintf(stderr, "Unable to allocate memory");
		return;
	}
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
void SSE_instructions_example()
{
	float p[] = { 1.0, 1.5, 2.0, 2.5 };
	float q[] = { 0.25, -0.5, 1.0, -1.75 };
	float r[4];

	add_SSE(p, q, r);
	printf("Suma:\n");
	printf("%f %f %f %f\n", p[0], p[1], p[2], p[3]);
	printf("%f %f %f %f\n", q[0], q[1], q[2], q[3]);
	printf("%f %f %f %f\n", r[0], r[1], r[2], r[3]);
	printf("Pierwiastek:\n");
	sqrt_SSE(p, r);
	printf("%f %f %f %f\n", p[0], p[1], p[2], p[3]);
	printf("%f %f %f %f\n", r[0], r[1], r[2], r[3]);
	printf("Odwrotnoœæ:\n");
	invert_SSE(p, r);
	printf("%f %f %f %f\n", p[0], p[1], p[2], p[3]);
	printf("%f %f %f %f\n", r[0], r[1], r[2], r[3]);

}
void z5_3_array_sum_SSE()
{
	int array_size = 16;
	char a_array[] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char b_array[] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	char * result = malloc(array_size * sizeof(char));
	if (result == NULL)
	{
		fprintf(stderr, "Unable to allocate memory");
		return;
	}
	for (int i = 0; i < array_size; ++i)
		printf("%4d ", a_array[i]);
	putchar('\n');
	for (int i = 0; i < array_size; ++i)
		printf("%4d ", b_array[i]);
	putchar('\n');
	array_sum_SSE(a_array, b_array, result);
	for (int i = 0; i < array_size; ++i)
		printf("%4d ", result[i]);
	printf("\n");
	free(result);
}
void z5_4_int2float_array()
{
	int a[] = { -17, 24 };
	float r[4];
	int2float_array(a, r);
	printf("%f %f\n", r[0], r[1]);
}
void z5_5_float_arr_odd_inc_even_dec_4()
{
	float arr[] = { 27.5, 143.57, 2100.0, -3.51 };
	printf("%f %f %f %f\n", arr[0], arr[1], arr[2], arr[3]);
	float_arr_odd_inc_even_dec_4(arr);
	printf("%f %f %f %f\n", arr[0], arr[1], arr[2], arr[3]);
}
void z5_6_add_3_arrays()
{
	float results[4];
	add_3_arrays(results);
	printf("%f %f %f %f\n", results[0], results[1], results[2], results[3]);
}

int main(int argc, char* argv[])
{
	z5_1_srednia_harm();
	//z5_2_series_sum();
	//SSE_instructions_example();
	//z5_3_array_sum_SSE();
	//z5_4_int2float_array();
	//z5_5_float_arr_odd_inc_even_dec_4();
	//z5_6_add_3_arrays();
	return 0;
}
