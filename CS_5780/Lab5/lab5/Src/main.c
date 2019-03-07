/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  ** This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * COPYRIGHT(c) 2019 STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

volatile int xLow;
volatile int xHigh;
volatile int xData;
volatile int yLow;
volatile int yData;
volatile int flag = 0;

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

	// Enable the GPIO pins
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
	RCC->AHBENR |= RCC_AHBENR_GPIOCEN;

	// Alternate Function for PB11/13
	GPIOB->MODER |= (1 << 27); 
	GPIOB->MODER |= (1 << 23);
	
	// Open Drain for PB11/13
	GPIOB->OTYPER |= (1 << 13); 
	GPIOB->OTYPER |= (1 << 11);
	
	// Activating I2C2_SDA and I2C2_SCL
	GPIOB->AFR[1] |= (1 << 12);
	GPIOB->AFR[1] |= (5 << 20);
	
	// Set PB14 to output, push-pull output type, initialize/set pin high
	GPIOB->MODER |= (1 << 28);
	GPIOB->ODR |= (1 << 14);
	
	// Set PC0 to output, push-pull output type, initialize/set pin high
	GPIOC->MODER |= 1;
	GPIOC->ODR |= 1;
	
	// Enable GPIO General Purpose Output mode
	GPIOC->MODER |= 0x55000; 
	
	// Enable I2C Peripheral
	RCC->APB1ENR |= RCC_APB1ENR_I2C2EN;
	
	// Set TIMINGR register to 100kHz parameters
	I2C2->TIMINGR |= (1 << 28); // Prescaler set to 1
	I2C2->TIMINGR |= 0x13; // SCL set to 0x13
	I2C2->TIMINGR |= (0xF << 8); // SCLH set to 0xF
	I2C2->TIMINGR |= (1 << 17); // SDADEL set to 0x2
	I2C2->TIMINGR |= (1 << 22); // SCDEL set to 0x4
	
	// Enable I2C Peripheral in PE bit in CR1
	I2C2->CR1 |= 1;
	
	
  /* Configure the system clock */
  SystemClock_Config();

  while (1)
  {
		/*GYRO INITITIALIZE*/
		if(I2C_FLAG_TXIS & (1 << 1) && flag == 0)
		{
			//I2C2->TXDR |= 0x0F; // writing address of who_am_i register
			I2C2->TXDR |= 0x20; // gyroscope axes
			//I2C2->TXDR |= (1 << 4); // PD enable
			//I2C2->TXDR |= 0xA8; // Write into Output X
			//GPIOC->ODR |= 0x40; // red
		}
		if(I2C_FLAG_TC & (1 << 6) && flag == 0)
		{
			//GPIOC->ODR |= 0x200; // green
			// Clear SADD and NBYTES
			I2C2->CR2 &= ~((0x7F << 16) | (0x3FF << 0));
			// Set SADD and NBYTES
			I2C2->CR2 |= (0x6B << 1) | (8 << 16);
			// Read operation in RD_WRN
			I2C2->CR2 |= (1 << 10); 	
			// Start
			I2C2->CR2 |= (1 << 13);
		}
		
		/*Read from Gyro and modify PD bit*/
		if(I2C_FLAG_RXNE & (1 << 2) && flag == 0)
		{
			GPIOC->ODR |= 0x100; // orange
			if(I2C_FLAG_TC & (1 << 6))
			{
				GPIOC->ODR |= 0x80; // blue
				I2C2->RXDR |= I2C_RXDR_RXDATA | (1 << 4); //Activates PD bit
				
				// Stop condition
				I2C2->CR2 |= (1 << 14);
				flag = 1;
			}
		}
		
		
	/*Read x and y data, starting with just x*/ 
		if(I2C_FLAG_TXIS & (1 << 1) && flag == 1)
		{
			I2C2->TXDR = 0x28; //Writing memory address to be able to read xLow
		}
		if(I2C_FLAG_TC & (1 << 6) && flag == 1)
		{
			//GPIOC->ODR |= 0x200; // green
			// Clear SADD and NBYTES
			I2C2->CR2 &= ~((0x7F << 16) | (0x3FF << 0));
			// Set SADD and NBYTES
			I2C2->CR2 |= (0x6B << 1) | (8 << 16);
			// Read operation in RD_WRN
			I2C2->CR2 |= (1 << 10); 	
			// Start
			I2C2->CR2 |= (1 << 13);
		}
			
		if(I2C_FLAG_RXNE & (1 << 2) && flag == 1)
		{
			GPIOC->ODR |= 0x100; // orange
			if(I2C_FLAG_TC & (1 << 6))
			{
				GPIOC->ODR |= 0x80; // blue
				xLow = I2C_RXDR_RXDATA;
				
				// Stop condition
				I2C2->CR2 |= (1 << 14);
			}
		}
		/*Reading xHigh*/
		if(I2C_FLAG_TXIS & (1 << 1) && flag == 1)
		{
			I2C2->TXDR = 0x29; //Writing memory address to be able to read xHigh
		}
		if(I2C_FLAG_TC & (1 << 6) && flag == 1)
		{
			//GPIOC->ODR |= 0x200; // green
			// Clear SADD and NBYTES
			I2C2->CR2 &= ~((0x7F << 16) | (0x3FF << 0));
			// Set SADD and NBYTES
			I2C2->CR2 |= (0x6B << 1) | (8 << 16);
			// Read operation in RD_WRN
			I2C2->CR2 |= (1 << 10); 	
			// Start
			I2C2->CR2 |= (1 << 13);
		}
			
		if(I2C_FLAG_RXNE & (1 << 2) && flag == 1)
		{
			GPIOC->ODR |= 0x100; // orange
			if(I2C_FLAG_TC & (1 << 6))
			{
				GPIOC->ODR |= 0x80; // blue
				xHigh = I2C_RXDR_RXDATA;
				
				// Stop condition
				I2C2->CR2 |= (1 << 14);
				xData = (xHigh << 8) | xLow;
			}
		}
		
		if(xData < 0)
		{
			GPIOC->ODR |= 0x40; // red
		}
		else 
		{
			GPIOC->ODR |= 0x200; // green
		}
		
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /**Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /**Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSI;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(char *file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
