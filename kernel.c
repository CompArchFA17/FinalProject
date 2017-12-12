void main(void)
{
	// Message we want to print
	const char *string = "Welcome Kernel!";

	// Pointer to start of video memory
	char *videoMemory = (char*)0xb8000;

	// Loop index	
	unsigned int i = 0;
	unsigned int j = 0;

	// Clear screen
	while(j < 80 * 2) {
		videoMemory[j] = ' ';

		// Color
		videoMemory[j+1] = 0x07; 		
		j = j + 2;
	}


	// Reset Counter
	j = 0;

	// Print string to screen
	while(string[j] != '\0') {
		videoMemory[i] = string[j];

		// Color
		videoMemory[i+1] = 0x0f;
		++j;
		i = i + 2;
	}
	return;
}
