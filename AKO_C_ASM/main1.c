#include <stdio.h>
int max3(int a, int b, int c);
int max4(int a, int b, int c, int d);
void inc(int * a);
void neg(int * a);
void dec_ptr_ptr(int ** a);
void swap_array_pairs(int arr[], int n);
int __stdcall _multiply3(int a, int b, int c);
int __stdcall _sum3(int a, int b, int c);
unsigned square_sum(unsigned a, unsigned b);
void bubble_sort(int arr[],const int n)
{
	for (int i = n; i > 1; --i)
	{
		swap_array_pairs(arr, i);
	}
}

int main(int argc, char* argv[])
{

	int number = -10;
	int * number_ptr = &number;

	dec_ptr_ptr(&number_ptr);
	printf("%d\n", number);


	printf("%u", square_sum(3, 2));
	putchar('\n');
	return 0;
}
