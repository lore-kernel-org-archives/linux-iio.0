Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55848 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdCDRZe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 12:25:34 -0500
Subject: Re: [PATCH 3/4] staging: iio: adis16209: Move contents of the header
 to the source file
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <cover.1488634510.git.narcisaanamaria12@gmail.com>
 <c9cf8beb40cc1cdb4ac084ffe24b36c321497564.1488634510.git.narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1797fe0d-b9f7-385b-f56e-76d4f25fa72d@kernel.org>
Date: Sat, 4 Mar 2017 16:32:36 +0000
MIME-Version: 1.0
In-Reply-To: <c9cf8beb40cc1cdb4ac084ffe24b36c321497564.1488634510.git.narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/17 13:47, Narcisa Ana Maria Vasile wrote:
> The contents of the header file are used only by this single
> source file. Move content into .c file and remove header.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Nice patch.

Applied to the togreg branch of iio.git and pushed out as staging.

As a follow up if you are tempted, the naming of these .c files as core
makes little sense if there aren't any other .c files for the chips in question.
So perhaps rename them to (for example) adis16209.c including updating the make
file.

It's a small but worthwhile tidy up.

Another one would be to look at how some of these drivers use an enum for
the channel indexes.  To my mind that is more elegant than the set of defines
here as it implicitly groups them as all being about the same thing.
So if you want to improve that it would be great as well.

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.h      | 144 -----------------------------
>  drivers/staging/iio/accel/adis16209_core.c | 140 +++++++++++++++++++++++++++-
>  2 files changed, 139 insertions(+), 145 deletions(-)
>  delete mode 100644 drivers/staging/iio/accel/adis16209.h
> 
> diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
> deleted file mode 100644
> index 315f1c0..0000000
> --- a/drivers/staging/iio/accel/adis16209.h
> +++ /dev/null
> @@ -1,144 +0,0 @@
> -#ifndef SPI_ADIS16209_H_
> -#define SPI_ADIS16209_H_
> -
> -#define ADIS16209_STARTUP_DELAY	220 /* ms */
> -
> -/* Flash memory write count */
> -#define ADIS16209_FLASH_CNT      0x00
> -
> -/* Output, power supply */
> -#define ADIS16209_SUPPLY_OUT     0x02
> -
> -/* Output, x-axis accelerometer */
> -#define ADIS16209_XACCL_OUT      0x04
> -
> -/* Output, y-axis accelerometer */
> -#define ADIS16209_YACCL_OUT      0x06
> -
> -/* Output, auxiliary ADC input */
> -#define ADIS16209_AUX_ADC        0x08
> -
> -/* Output, temperature */
> -#define ADIS16209_TEMP_OUT       0x0A
> -
> -/* Output, x-axis inclination */
> -#define ADIS16209_XINCL_OUT      0x0C
> -
> -/* Output, y-axis inclination */
> -#define ADIS16209_YINCL_OUT      0x0E
> -
> -/* Output, +/-180 vertical rotational position */
> -#define ADIS16209_ROT_OUT        0x10
> -
> -/* Calibration, x-axis acceleration offset null */
> -#define ADIS16209_XACCL_NULL     0x12
> -
> -/* Calibration, y-axis acceleration offset null */
> -#define ADIS16209_YACCL_NULL     0x14
> -
> -/* Calibration, x-axis inclination offset null */
> -#define ADIS16209_XINCL_NULL     0x16
> -
> -/* Calibration, y-axis inclination offset null */
> -#define ADIS16209_YINCL_NULL     0x18
> -
> -/* Calibration, vertical rotation offset null */
> -#define ADIS16209_ROT_NULL       0x1A
> -
> -/* Alarm 1 amplitude threshold */
> -#define ADIS16209_ALM_MAG1       0x20
> -
> -/* Alarm 2 amplitude threshold */
> -#define ADIS16209_ALM_MAG2       0x22
> -
> -/* Alarm 1, sample period */
> -#define ADIS16209_ALM_SMPL1      0x24
> -
> -/* Alarm 2, sample period */
> -#define ADIS16209_ALM_SMPL2      0x26
> -
> -/* Alarm control */
> -#define ADIS16209_ALM_CTRL       0x28
> -
> -/* Auxiliary DAC data */
> -#define ADIS16209_AUX_DAC        0x30
> -
> -/* General-purpose digital input/output control */
> -#define ADIS16209_GPIO_CTRL      0x32
> -
> -/* Miscellaneous control */
> -#define ADIS16209_MSC_CTRL       0x34
> -
> -/* Internal sample period (rate) control */
> -#define ADIS16209_SMPL_PRD       0x36
> -
> -/* Operation, filter configuration */
> -#define ADIS16209_AVG_CNT        0x38
> -
> -/* Operation, sleep mode control */
> -#define ADIS16209_SLP_CNT        0x3A
> -
> -/* Diagnostics, system status register */
> -#define ADIS16209_DIAG_STAT      0x3C
> -
> -/* Operation, system command register */
> -#define ADIS16209_GLOB_CMD       0x3E
> -
> -/* MSC_CTRL */
> -
> -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> -#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> -
> -/* Self-test enable */
> -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> -/* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> -
> -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> -
> -/* DIAG_STAT */
> -
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> -
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> -
> -/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> -#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> -
> -/* SPI communications failure */
> -#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> -
> -/* Flash update failure */
> -#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> -
> -/* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> -
> -/* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> -
> -/* GLOB_CMD */
> -
> -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> -
> -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> -
> -#define ADIS16209_SCAN_SUPPLY	0
> -#define ADIS16209_SCAN_ACC_X	1
> -#define ADIS16209_SCAN_ACC_Y	2
> -#define ADIS16209_SCAN_AUX_ADC	3
> -#define ADIS16209_SCAN_TEMP	4
> -#define ADIS16209_SCAN_INCLI_X	5
> -#define ADIS16209_SCAN_INCLI_Y	6
> -#define ADIS16209_SCAN_ROT	7
> -
> -#endif /* SPI_ADIS16209_H_ */
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index a599e19..8ff537f 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -21,7 +21,145 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#include "adis16209.h"
> +#define ADIS16209_STARTUP_DELAY	220 /* ms */
> +
> +/* Flash memory write count */
> +#define ADIS16209_FLASH_CNT      0x00
> +
> +/* Output, power supply */
> +#define ADIS16209_SUPPLY_OUT     0x02
> +
> +/* Output, x-axis accelerometer */
> +#define ADIS16209_XACCL_OUT      0x04
> +
> +/* Output, y-axis accelerometer */
> +#define ADIS16209_YACCL_OUT      0x06
> +
> +/* Output, auxiliary ADC input */
> +#define ADIS16209_AUX_ADC        0x08
> +
> +/* Output, temperature */
> +#define ADIS16209_TEMP_OUT       0x0A
> +
> +/* Output, x-axis inclination */
> +#define ADIS16209_XINCL_OUT      0x0C
> +
> +/* Output, y-axis inclination */
> +#define ADIS16209_YINCL_OUT      0x0E
> +
> +/* Output, +/-180 vertical rotational position */
> +#define ADIS16209_ROT_OUT        0x10
> +
> +/* Calibration, x-axis acceleration offset null */
> +#define ADIS16209_XACCL_NULL     0x12
> +
> +/* Calibration, y-axis acceleration offset null */
> +#define ADIS16209_YACCL_NULL     0x14
> +
> +/* Calibration, x-axis inclination offset null */
> +#define ADIS16209_XINCL_NULL     0x16
> +
> +/* Calibration, y-axis inclination offset null */
> +#define ADIS16209_YINCL_NULL     0x18
> +
> +/* Calibration, vertical rotation offset null */
> +#define ADIS16209_ROT_NULL       0x1A
> +
> +/* Alarm 1 amplitude threshold */
> +#define ADIS16209_ALM_MAG1       0x20
> +
> +/* Alarm 2 amplitude threshold */
> +#define ADIS16209_ALM_MAG2       0x22
> +
> +/* Alarm 1, sample period */
> +#define ADIS16209_ALM_SMPL1      0x24
> +
> +/* Alarm 2, sample period */
> +#define ADIS16209_ALM_SMPL2      0x26
> +
> +/* Alarm control */
> +#define ADIS16209_ALM_CTRL       0x28
> +
> +/* Auxiliary DAC data */
> +#define ADIS16209_AUX_DAC        0x30
> +
> +/* General-purpose digital input/output control */
> +#define ADIS16209_GPIO_CTRL      0x32
> +
> +/* Miscellaneous control */
> +#define ADIS16209_MSC_CTRL       0x34
> +
> +/* Internal sample period (rate) control */
> +#define ADIS16209_SMPL_PRD       0x36
> +
> +/* Operation, filter configuration */
> +#define ADIS16209_AVG_CNT        0x38
> +
> +/* Operation, sleep mode control */
> +#define ADIS16209_SLP_CNT        0x3A
> +
> +/* Diagnostics, system status register */
> +#define ADIS16209_DIAG_STAT      0x3C
> +
> +/* Operation, system command register */
> +#define ADIS16209_GLOB_CMD       0x3E
> +
> +/* MSC_CTRL */
> +
> +/* Self-test at power-on: 1 = disabled, 0 = enabled */
> +#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> +
> +/* Self-test enable */
> +#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> +
> +/* Data-ready enable: 1 = enabled, 0 = disabled */
> +#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> +
> +/* Data-ready polarity: 1 = active high, 0 = active low */
> +#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +
> +/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> +#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> +
> +/* DIAG_STAT */
> +
> +/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> +#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> +
> +/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> +#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> +
> +/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> +#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> +
> +/* SPI communications failure */
> +#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> +
> +/* Flash update failure */
> +#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> +
> +/* Power supply above 3.625 V */
> +#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +
> +/* Power supply below 3.15 V */
> +#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +
> +/* GLOB_CMD */
> +
> +#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> +#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> +#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> +
> +#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +
> +#define ADIS16209_SCAN_SUPPLY	0
> +#define ADIS16209_SCAN_ACC_X	1
> +#define ADIS16209_SCAN_ACC_Y	2
> +#define ADIS16209_SCAN_AUX_ADC	3
> +#define ADIS16209_SCAN_TEMP	4
> +#define ADIS16209_SCAN_INCLI_X	5
> +#define ADIS16209_SCAN_INCLI_Y	6
> +#define ADIS16209_SCAN_ROT	7
>  
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
> 

