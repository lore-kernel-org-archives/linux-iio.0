Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753629AbeCRIWH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 04:22:07 -0400
Date: Sun, 18 Mar 2018 08:22:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 2/9] Staging: iio: accel: adis16201: Remove
 unnecessary comments
Message-ID: <20180318082201.56db5299@archlinux>
In-Reply-To: <1521230786-18155-3-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
        <1521230786-18155-3-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 01:36:19 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove few unnecessary comments since the macro definitions clearly
> justify their purpose.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Seems like a good balance between enough information and too much noise
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> v2:
>    -reodered patch series.
> 
>  drivers/staging/iio/accel/adis16201.c | 36 -----------------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 767ebf0..6c06c0d 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -22,96 +22,66 @@
>  
>  #define ADIS16201_STARTUP_DELAY_MS	220
>  
> -/* Flash memory write count */
>  #define ADIS16201_FLASH_CNT      0x00
>  
> -/* Output, power supply */
>  #define ADIS16201_SUPPLY_OUT     0x02
>  
> -/* Output, x-axis accelerometer */
>  #define ADIS16201_XACCL_OUT      0x04
>  
> -/* Output, y-axis accelerometer */
>  #define ADIS16201_YACCL_OUT      0x06
>  
> -/* Output, auxiliary ADC input */
>  #define ADIS16201_AUX_ADC        0x08
>  
> -/* Output, temperature */
>  #define ADIS16201_TEMP_OUT       0x0A
>  
> -/* Output, x-axis inclination */
>  #define ADIS16201_XINCL_OUT      0x0C
>  
> -/* Output, y-axis inclination */
>  #define ADIS16201_YINCL_OUT      0x0E
>  
> -/* Calibration, x-axis acceleration offset */
>  #define ADIS16201_XACCL_OFFS     0x10
>  
> -/* Calibration, y-axis acceleration offset */
>  #define ADIS16201_YACCL_OFFS     0x12
>  
> -/* x-axis acceleration scale factor */
>  #define ADIS16201_XACCL_SCALE    0x14
>  
> -/* y-axis acceleration scale factor */
>  #define ADIS16201_YACCL_SCALE    0x16
>  
> -/* Calibration, x-axis inclination offset */
>  #define ADIS16201_XINCL_OFFS     0x18
>  
> -/* Calibration, y-axis inclination offset */
>  #define ADIS16201_YINCL_OFFS     0x1A
>  
> -/* x-axis inclination scale factor */
>  #define ADIS16201_XINCL_SCALE    0x1C
>  
> -/* y-axis inclination scale factor */
>  #define ADIS16201_YINCL_SCALE    0x1E
>  
> -/* Alarm 1 amplitude threshold */
>  #define ADIS16201_ALM_MAG1       0x20
>  
> -/* Alarm 2 amplitude threshold */
>  #define ADIS16201_ALM_MAG2       0x22
>  
> -/* Alarm 1, sample period */
>  #define ADIS16201_ALM_SMPL1      0x24
>  
> -/* Alarm 2, sample period */
>  #define ADIS16201_ALM_SMPL2      0x26
>  
> -/* Alarm control */
>  #define ADIS16201_ALM_CTRL       0x28
>  
> -/* Auxiliary DAC data */
>  #define ADIS16201_AUX_DAC        0x30
>  
> -/* General-purpose digital input/output control */
>  #define ADIS16201_GPIO_CTRL      0x32
>  
> -/* Miscellaneous control */
>  #define ADIS16201_MSC_CTRL       0x34
>  
> -/* Internal sample period (rate) control */
>  #define ADIS16201_SMPL_PRD       0x36
>  
>  /* Operation, filter configuration */
>  #define ADIS16201_AVG_CNT        0x38
>  
> -/* Operation, sleep mode control */
>  #define ADIS16201_SLP_CNT        0x3A
>  
> -/* Diagnostics, system status register */
>  #define ADIS16201_DIAG_STAT      0x3C
>  
> -/* Operation, system command register */
>  #define ADIS16201_GLOB_CMD       0x3E
>  
> -/* MSC_CTRL */
>  
> -/* Self-test enable */
>  #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
>  
>  /* Data-ready enable: 1 = enabled, 0 = disabled */
> @@ -123,18 +93,13 @@
>  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> -/* DIAG_STAT */
>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
>  
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
>  
> -/* SPI communications failure */
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -/* Flash update failure */
>  #define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
>  
>  /* Power supply above 3.625 V */
> @@ -143,7 +108,6 @@
>  /* Power supply below 3.15 V */
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>  
> -/* GLOB_CMD */
>  
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
>  #define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)

