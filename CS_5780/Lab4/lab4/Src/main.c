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
volatile int data = 0;
volatile int globalData = 0;
volatile int flag = 0;

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/*Helper method to determine validity of c. Makes sure that it is a valid led char
	1 return is true
	0 return is false
*/

int isValid(char c)
{
	if(c == 114 || c == 103 || c == 111 || c == 98)
	{
		return 1;
	}
	else return 0;
}


void TXcharUSART(char c){
	//Transmitting data by checking 7th bit for exit or continue
	
	
	while((USART3->ISR & (0x1 << 7)) == 0)
	{
			/*Exits once the flag is updated*/
	}
	
	/*Assign value to transmit register*/
	USART3->TDR = c;
	
}


/*Start Prompt for the program*/
void start()
{
	TXcharUSART('C');
	TXcharUSART('M');
	TXcharUSART('D');
	TXcharUSART('?');
}

/*Resets global variables for new LED Command*/
void reset()
{
	data = 0;
	globalData = 0;
}
/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  SystemClock_Config();
	
	/*Enables USART*/
	RCC->APB1ENR |= RCC_APB1ENR_USART3EN;
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
	
	/*Enable LED*/
	RCC->AHBENR |= RCC_AHBENR_GPIOCEN;
	
	/*All LEDs in General Purpose Output Mode*/
	GPIOC->MODER = 0x55000; 
	
	/*Enable Pins 10 & 11 with alternate function 4*/
	GPIOB->AFR[1] |= 0x4400; //Computer Systems!
	
	// *ASK SUMANTH HOW TO BIT MASK BELOW
	GPIOB->MODER =  0xA00000; //Alternate Function Mode for PB10/11 "1010 WITH 21 ZEROS"
	
	
	/*Set BRR and Enable bits*/
	USART3->BRR = HAL_RCC_GetHCLKFreq()/9600;
	
	/*Enable Receive and Transmit bits*/
	USART3->CR1 |= 0xC;
	
	/*Enable USART, all other registers become READ ONLY*/
	USART3->CR1 |= 0x1;
	USART3->CR1 |= (1 << 5);
  //USART3->CR1 |= (1 << 7);	
	
	NVIC_EnableIRQ(USART3_4_IRQn);
	NVIC_SetPriority(USART3_4_IRQn, 1);
	
	
	start();
	
  while (1)
  {	
		
			//Check validity of data
			if(data == 48 || data == 49 || data == 50) //Red, Orange, Green, Blue/
			{		
						switch (globalData) {
							case 114:
								if(data == 48)
								{
									GPIOC->ODR &= (0 << 7); //Turns off red led
									reset();
								}
								else if(data == 49)
								{
									GPIOC->ODR |= 0x40; //Turns on red led
									reset();
								}
								else if(data == 50)
								{
									GPIOC->ODR ^= 0x40; //Toggles red led
									reset();
								}
								break;
							case 103:
								if(data == 48)
								{
									GPIOC->ODR &= (0 << 10); //Turns off green led
									reset();
								}
								else if(data == 49)
								{
									GPIOC->ODR |= 0x200; //Turns on green led
									reset();
								}
								else if(data == 50)
								{
									GPIOC->ODR ^= 0x200; //Toggles green led
									reset();
								}
								break;
								
							case 111:
								if(data == 48)
								{
									GPIOC->ODR &= (0 << 9); //Turns off orange led
									reset();
								}
								else if(data == 49)
								{
									GPIOC->ODR |= 0x100; //Turns on orange led
									reset();
								}
								else if(data == 50)
								{
									GPIOC->ODR ^= 0x100; //Toggles orange led
									reset();
								}
								break;
								
							case 98:
								if(data == 48)
								{
									GPIOC->ODR &= (0 << 8); //Turns off orange led
									reset();
								}
								else if(data == 49)
								{
									GPIOC->ODR |= 0x80; //Turns on orange led
									reset();
								}
								else if(data == 50)
								{
									GPIOC->ODR ^= 0x80; //Toggles orange led
									reset();
								}
								break;
						}
			}
		
  }
}

void USART3_4_IRQHandler(){
	
	if(flag == 0)
	{

		//USART3->TDR = 'S';
		while((USART3->ISR & (0x1 << 5)) == 0)
		{
			// Exits when transmit complete
		}
		globalData = USART3->RDR;
		
		//If data is invalid we will not set the flag
		if(isValid(globalData) == 1)
		{
			flag = 1;
		}
		else start();
		
	}
	else
	{
		while((USART3->ISR & (0x1 << 5)) == 0)
		{
			// Exits when transmit complete
		}
		data = USART3->RDR;
		flag = 0;
		start();
	}
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
