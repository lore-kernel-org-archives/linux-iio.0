Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60486 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdCEOD1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 09:03:27 -0500
Subject: Re: [PATCH] staging: iio: adis16209: Group similar macros into enums
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1488715674-22836-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <14baa561-3513-cf49-2c41-c7abfc91218f@kernel.org>
Date: Sun, 5 Mar 2017 14:03:24 +0000
MIME-Version: 1.0
In-Reply-To: <1488715674-22836-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 12:07, Narcisa Ana Maria Vasile wrote:
> If the macros are related, they should be grouped into an enum
> for clarity.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Some misunderstandings here.  Only the scan index or register addresses
can make sense as enums.  Not the contents of the registers.
> ---
>  drivers/staging/iio/accel/adis16209.c | 84 ++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8ff537f..706e119 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -104,62 +104,72 @@
>  /* Operation, system command register */
>  #define ADIS16209_GLOB_CMD       0x3E
The stuff above here could be an enum in theory but not as nice as doing
it for the scan indexes as you have done below.
>  
> +#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +
>  /* MSC_CTRL */
>  
> -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> -#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> +enum adis16209_msc_ctrl {
This doesn't make sense as an enum.  Just makes things harder to read.
> +	/* Self-test at power-on: 1 = disabled, 0 = enabled */
> +	ADIS16209_MSC_CTRL_PWRUP_SELF_TEST = BIT(10),
>  
> -/* Self-test enable */
> -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> +	/* Self-test enable */
> +	ADIS16209_MSC_CTRL_SELF_TEST_EN = BIT(8),
>  
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> +	/* Data-ready enable: 1 = enabled, 0 = disabled */
> +	ADIS16209_MSC_CTRL_DATA_RDY_EN = BIT(2),
>  
> -/* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +	/* Data-ready polarity: 1 = active high, 0 = active low */
> +	ADIS16209_MSC_CTRL_ACTIVE_HIGH = BIT(1),
>  
> -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> +	/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> +	ADIS16209_MSC_CTRL_DATA_RDY_DIO2 = BIT(0),
> +};
>  
>  /* DIAG_STAT */
>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> +enum adis16209_diag_stat {
> +	/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> +	ADIS16209_DIAG_STAT_ALARM2 = BIT(9),
>  
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> +	/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> +	ADIS16209_DIAG_STAT_ALARM1 = BIT(8),
>  
> -/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> -#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> +	/* Self-test diagnostic error flag:
> +	 * 1 = error condition, 0 = normal operation
> +	 */
> +	ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT = 5,
>  
> -/* SPI communications failure */
> -#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> +	/* SPI communications failure */
> +	ADIS16209_DIAG_STAT_SPI_FAIL_BIT = 3,
>  
> -/* Flash update failure */
> -#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> +	/* Flash update failure */
> +	ADIS16209_DIAG_STAT_FLASH_UPT_BIT = 2,
>  
> -/* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +	/* Power supply above 3.625 V */
> +	ADIS16209_DIAG_STAT_POWER_HIGH_BIT = 1,
>  
> -/* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +	/* Power supply below 3.15 V */
> +	ADIS16209_DIAG_STAT_POWER_LOW_BIT = 0,
> +};
>  
>  /* GLOB_CMD */
>  
> -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> -
> -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +enum adis16209_glob_cmd {
Again, not appropriate use of an enum. They should be
used for things that are unique indexes rather than 
parts of a register.
> +	ADIS16209_GLOB_CMD_SW_RESET = BIT(7),
> +	ADIS16209_GLOB_CMD_CLEAR_STAT = BIT(4),
> +	ADIS16209_GLOB_CMD_FACTORY_CAL = BIT(1),
> +};
>  
> -#define ADIS16209_SCAN_SUPPLY	0
> -#define ADIS16209_SCAN_ACC_X	1
> -#define ADIS16209_SCAN_ACC_Y	2
> -#define ADIS16209_SCAN_AUX_ADC	3
> -#define ADIS16209_SCAN_TEMP	4
> -#define ADIS16209_SCAN_INCLI_X	5
> -#define ADIS16209_SCAN_INCLI_Y	6
> -#define ADIS16209_SCAN_ROT	7
> +enum adis16209_scan {
> +	ADIS16209_SCAN_SUPPLY,
> +	ADIS16209_SCAN_ACC_X,
> +	ADIS16209_SCAN_ACC_Y,
> +	ADIS16209_SCAN_AUX_ADC,
> +	ADIS16209_SCAN_TEMP,
> +	ADIS16209_SCAN_INCLI_X,
> +	ADIS16209_SCAN_INCLI_Y,
> +	ADIS16209_SCAN_ROT,
This last one makes sense. So keep this one.
> +};
>  
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
> 

