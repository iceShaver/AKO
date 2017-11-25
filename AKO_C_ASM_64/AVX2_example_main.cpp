#include <stdio.h>
#include <stdlib.h>
#include <chrono>
using namespace std::chrono;
extern "C" int FMA(float * matrixA_, float * matrix_b, float scalar, int count);

#define ARRAY_SIZE (1024*1024)
#define LOOP_COUNT 10000
#define OPERATIONS_COUNT 2
#define GIGA_INV 1.0e-9

__declspec(align(64))float fa[ARRAY_SIZE];
__declspec(align(64))float fb[ARRAY_SIZE];

int main()
{
	float scalar = 2.0;

	printf("Initialing\n");
	for (int i = 0; i < ARRAY_SIZE; ++i)
	{
		fa[i] = (float)i + 0.1f;
		fb[i] = (float)i + 0.2f;
	}



	printf("Calculating without AVX2 \n");
	auto start_timestamp = high_resolution_clock::now();
	for (int i = 0; i < LOOP_COUNT; ++i)
		for (int k = 0; k < ARRAY_SIZE; ++k) 
			fa[k] = scalar*fa[k] + fb[k];
	auto stop_timestamp = high_resolution_clock::now();
	double delta_time_seconds = duration<double>(stop_timestamp - start_timestamp).count();
	double GFLOPS = (GIGA_INV * LOOP_COUNT * ARRAY_SIZE * OPERATIONS_COUNT) / delta_time_seconds;
	printf("GFlops = %f, secs = %f\n\n", GFLOPS, delta_time_seconds);



	for (int i = 0; i < ARRAY_SIZE; ++i)
	{
		fa[i] = (float)i + 0.1f;
		fb[i] = (float)i + 0.2f;
	}

	printf("Calculating with AVX2 \n");
	start_timestamp = high_resolution_clock::now();
	for (int i = 0; i < LOOP_COUNT; ++i)
		FMA(fa, fb, scalar, ARRAY_SIZE);
	stop_timestamp = high_resolution_clock::now();
	delta_time_seconds = duration<double>(stop_timestamp - start_timestamp).count();
	GFLOPS = (GIGA_INV * LOOP_COUNT * ARRAY_SIZE * OPERATIONS_COUNT) / delta_time_seconds;
	printf("GFlops = %f, secs = %f\n", GFLOPS, delta_time_seconds);



}