#include <stdio.h>
typedef __int64 I64;
//extern I64 find64_max(I64 * arr, I64 n);
//extern I64 sum7(I64 v1, I64 v2, I64 v3, I64 v4, I64 v5, I64 v6, I64 v7);
extern I64 square_sum64(I64 a, I64 b);
int main(int argc, char* argv[])
{
	//I64 results[] = {
	//	-15, 4000000, -345679,
	//	88046592, -1, 2297645,
	//	7867023, -19000444, 31,
	//	456000000000000,
	//	444444444444444,
	//	-123456789098765
	//};
	//I64 v1 = 1, v2 = 2, v3 = 3, v4 = 4, v5 = 5, v6 = 6, v7 = 7;
	//printf("%I64d\n", find64_max(results, 12));
	//printf("%I64d\n", sum7(v1, v2, v3, v4, v5, v6, v7));
	printf("%I64u\n", square_sum64(1000000, 3));
	return 0;
}
