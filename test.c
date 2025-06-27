// test.c — Chronomètre UART avec RTC
#include <stdint.h>

#define HEXADDRESS        (*(volatile uint32_t *) 0x8010)
#define LEDADDRESS        (*(volatile uint32_t *) 0x8000)
#define SWITCHADDRESS     (*(volatile uint32_t *) 0x8004)

#define UART_TXDATA       (*(volatile uint32_t *)  0x8060)
#define   UARTSRADDRESS   (*(volatile uint32_t *)  0x8068)
#define   UARTCRADDRESS   (*(volatile uint32_t *)  0x8064)
#define   RXDATAADDRESS   (*(volatile uint32_t *)  0x806C)

#define RTC_SEC_ADDRESS   (*(volatile uint8_t *)   0x8100)
#define RTC_MIN_ADDRESS   (*(volatile uint8_t *)   0x8104)
#define RTC_MMSS_ADDRESS  (*(volatile uint32_t *)  0x810C)

unsigned int integer_to_bcd (unsigned int  in);
unsigned int integer_to_bcd (unsigned int  in){
	unsigned int out = 0;
	unsigned int i;
	for (i=0;in;i++) {
		out |= (in%10)<<(4*i);
		in /=10;
        }
        return out;
}
void tx_write (unsigned c){
  while(UARTSRADDRESS&0x01);
  UART_TXDATA = c;
}
void send_string(const char* str) {
    while (*str) {
        tx_write(*str++);
    }
}
void delay() {
    for (volatile int i = 0; i < 50000; i++);
}

char rx_read (void){
  char c;
  while((UARTSRADDRESS&0x02) != 0x02);
  c = RXDATAADDRESS;
}
void send_time(uint8_t h, uint8_t m, uint8_t s) {
    char buffer[9];
    buffer[0] = '0' + (h / 10);
    buffer[1] = '0' + (h % 10);
    buffer[2] = ':';
    buffer[3] = '0' + (m / 10);
    buffer[4] = '0' + (m % 10);
    buffer[5] = ':';
    buffer[6] = '0' + (s / 10);
    buffer[7] = '0' + (s % 10);
    buffer[8] = '\0';
    send_string("Temps d'arrivee :");
    send_string(buffer);
    send_string("\r\n");
}

int main() {
    int i = 0;
    char c;
    UARTCRADDRESS = 0x03; //enable RX and TX
    int cpt = 0;
    int cpt2 =0;
    char buff[100];
    unsigned int min_bcd;
    unsigned int sec_bcd;
    while (1) {
      if(SWITCHADDRESS & 0x1 == 1){
          if(cpt == 0){
            RTC_MMSS_ADDRESS = 0;
            cpt ++;
          }
          else{
            unsigned int min_bcd = integer_to_bcd(RTC_MIN_ADDRESS);
            unsigned int sec_bcd = integer_to_bcd(RTC_SEC_ADDRESS);
            HEXADDRESS = (min_bcd << 8) + sec_bcd;
            LEDADDRESS = RTC_SEC_ADDRESS;
            cpt2 = 0;
            delay();
          }
      }
      else{
        cpt = 0;
        if(cpt2 == 0){
          send_time(0, RTC_MIN_ADDRESS, RTC_SEC_ADDRESS);
          cpt2 ++;
        }
        

        
      }

    }
} 
