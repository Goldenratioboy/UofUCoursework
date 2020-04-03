int main(void)
{

		HAL_Init(); // Reset of all peripherals, init the Flash and Systick
		SystemClock_Config(); //Configure the system clock
		/* This example uses HAL library calls to control
		the GPIOC peripheral. You'll be redoing this code
		with hardware register access. */
		//__HAL_RCC_GPIOC_CLK_ENABLE(); 
		RCC->AHBENR |= RCC_AHBENR_GPIOCEN;
		RCC->AHBENR |= RCC_AHBENR_GPIOAEN;	
	
	
		/*LED GPIO*/
		GPIOC->MODER = 0x5000;
		GPIOC->OTYPER &= 0x0;
		GPIOC->OSPEEDR &= 0x0;
		GPIOC->PUPDR &= 0x0;
	
		/*Push button GPIO*/
		GPIOA->MODER &= 0x0;
		GPIOA->OSPEEDR &= 0x0;
		GPIOA->PUPDR |= 0x2;
	
		GPIOC->ODR &= 0x0;
		GPIOC->ODR |= 0x80;
		
		int temp = 0;
		int flag = 0;

		uint32_t debouncer = 0;
		
		while (1) {

			
			debouncer = (debouncer << 1); // Always shift every loop iteration
			
			if ((GPIOA->IDR & 0x1) == 1)  { // If input signal is set/high
				debouncer |= 0x01; // Set lowest bit of bit-vector
			}
			
			if (debouncer == 0xFFFFFFFF) {
			// This code triggers repeatedly when button is steady high!
					if(flag == 1)
					{
						temp = ~temp;
						flag = 0;
					}
				//HAL_Delay(10); // Delay 200ms
			}
			if (debouncer == 0x00000000) {
			// This code triggers repeatedly when button is steady low!
				flag = 1;
				
				if(temp)
				{
				GPIOC->ODR &= 0x000;
				GPIOC->ODR |= 0x40;	
				}
				else
				{
				GPIOC->ODR &= 0x0;
				GPIOC->ODR |= 0x80;
				}				
				//HAL_Delay(10);
			}
			if (debouncer == 0x7FFFFFFF) {
			// This code triggers only once when transitioning to steady high!
				HAL_Delay(10);
			}
		}


}