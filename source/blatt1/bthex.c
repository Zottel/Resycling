
int bthex(unsigned char a){
	const char *digits = "0123456789ABCDEF";

	int res;
	unsigned char *ptr = (unsigned char *) &res;
	*(ptr + 1) = *(digits + (a & 0x0F));
	*(ptr) = *(digits + (a >> 4));
	return res;
}

