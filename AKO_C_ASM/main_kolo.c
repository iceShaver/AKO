#include <stdio.h>
#include <stdlib.h>
#define RESET 1
#define GET_NEXT 0
extern int roznica(int * odjemna, int ** odjemnik);
extern int * kopia_tablicy(int tabl[], unsigned int n);
extern char * komunikat(char * tekst);
extern int * szukaj_elem_min(int tablica[], int n);
extern void szyfruj(char * tekst);
extern unsigned int kwadrat(unsigned int a);
extern unsigned char iteracja(unsigned char a);
extern void pole_kola(float*pr);
extern float avg_wd(int n, void *tablica, void *wagi);
extern unsigned NWD(unsigned a, unsigned b);
extern unsigned liczba_procesorow(void);
void z1() {
	int a, b, *wsk, wynik;
	wsk = &b;
	a = 21; b = 25;
	wynik = roznica(&a, &wsk);
}
void z2() {
	int arr[] = { 1,2,3,4,5,6,7,7,89 };
	int * new_array = kopia_tablicy(arr, sizeof arr);
	for (unsigned i = 0; i < 9; i++)
		printf("%d ", new_array[i]);
}
void z3() {
	puts(komunikat("dasfd"));
}
void z4() {
	int arr[] = { 100,2,3,-5,7,4,3,2,6,8,-4,34 };
	int * min = szukaj_elem_min(arr, 12);
	printf("%d\n", *min);
}
unsigned get_next_number(int reset) {
	static unsigned prev = 0;
	if (reset)
		return prev = 0;
	if (prev == 0)
		return prev = 0x52525252;
	unsigned char a = (((1 << 30) & prev) >> 30) ^ (((1 << 31) & prev) >> 31); //get XOR of 30 and 31 byte of prev
	prev <<= 1;
	prev += a;
	return prev;

}
void szyfruj_kontrolnie(char * tekst) {
	get_next_number(RESET);
	while (*tekst) *tekst++ ^= (unsigned char)get_next_number(GET_NEXT);
}
void odszyfruj(char * txt) {

}
void z5() {
	unsigned char txt[] = "tekst do zaszyfrowania";
	printf("%s\n", txt);
	szyfruj(txt);				// szyfruj asm
	printf("%s\n", txt);
	szyfruj_kontrolnie(txt);	// odszyfruj c
	printf("%s\n", txt);
}
void z6() {
	printf("%u\n", kwadrat(65535));
}
void z7() {
	unsigned char w = iteracja(32);
	printf("%u\n", w);
}
void z15() {
	float k;
	scanf_s("%f", &k);
	pole_kola(&k);
	printf("%f\n", k);
}

void z17() {
	float tablica[] = { 5, 6, 7, 8 };
	float wagi[] = { 1, 2, 3, 4 };
	printf("%f\n", avg_wd(4, tablica, wagi));


}
void z18() {
	printf("%u\n", NWD(42, 56));
}
void z20() {
	printf("%u\n", liczba_procesorow());
}
int main() {
	z20();
	return 0;
}