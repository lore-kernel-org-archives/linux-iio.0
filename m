Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCCPmK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 10:42:10 -0500
Date: Sat, 3 Mar 2018 15:42:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 3/6] Staging: iio: adis16209: Add _REG postfix for
 registers
Message-ID: <20180303154205.5b17900b@archlinux>
In-Reply-To: <36a368e0dfc4ddbad460a4af117e088e80441a03.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
        <36a368e0dfc4ddbad460a4af117e088e80441a03.1519995673.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  2 Mar 2018 18:55:56 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> The defined names for registers does not make it very
> clear that they are registers and hence, add _REG postfix.
> This improves the readability of the code.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16209.c | 85 ++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 830c278..151120f 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -23,85 +23,85 @@
>  #define ADIS16209_STARTUP_DELAY_MS	220
>  
>  /* Flash memory write count */
> -#define ADIS16209_FLASH_CNT      0x00
> +#define ADIS16209_FLASH_CNT_REG		0x00
>  
>  /* Output, power supply */
> -#define ADIS16209_SUPPLY_OUT     0x02
> +#define ADIS16209_SUPPLY_OUT_REG	0x02
>  
>  /* Output, x-axis accelerometer */
> -#define ADIS16209_XACCL_OUT      0x04
> +#define ADIS16209_XACCL_OUT_REG		0x04
>  
>  /* Output, y-axis accelerometer */
> -#define ADIS16209_YACCL_OUT      0x06
> +#define ADIS16209_YACCL_OUT_REG		0x06
>  
>  /* Output, auxiliary ADC input */
> -#define ADIS16209_AUX_ADC        0x08
> +#define ADIS16209_AUX_ADC_REG		0x08
>  
>  /* Output, temperature */
> -#define ADIS16209_TEMP_OUT       0x0A
> +#define ADIS16209_TEMP_OUT_REG		0x0A
>  
>  /* Output, x-axis inclination */
> -#define ADIS16209_XINCL_OUT      0x0C
> +#define ADIS16209_XINCL_OUT_REG		0x0C
>  
>  /* Output, y-axis inclination */
> -#define ADIS16209_YINCL_OUT      0x0E
> +#define ADIS16209_YINCL_OUT_REG		0x0E
>  
>  /* Output, +/-180 vertical rotational position */
> -#define ADIS16209_ROT_OUT        0x10
> +#define ADIS16209_ROT_OUT_REG		0x10
>  
>  /* Calibration, x-axis acceleration offset null */
> -#define ADIS16209_XACCL_NULL     0x12
> +#define ADIS16209_XACCL_NULL_REG	0x12
>  
>  /* Calibration, y-axis acceleration offset null */
> -#define ADIS16209_YACCL_NULL     0x14
> +#define ADIS16209_YACCL_NULL_REG	0x14
>  
>  /* Calibration, x-axis inclination offset null */
> -#define ADIS16209_XINCL_NULL     0x16
> +#define ADIS16209_XINCL_NULL_REG	0x16
>  
>  /* Calibration, y-axis inclination offset null */
> -#define ADIS16209_YINCL_NULL     0x18
> +#define ADIS16209_YINCL_NULL_REG	0x18
>  
>  /* Calibration, vertical rotation offset null */
> -#define ADIS16209_ROT_NULL       0x1A
> +#define ADIS16209_ROT_NULL_REG		0x1A
>  
>  /* Alarm 1 amplitude threshold */
> -#define ADIS16209_ALM_MAG1       0x20
> +#define ADIS16209_ALM_MAG1_REG		0x20
>  
>  /* Alarm 2 amplitude threshold */
> -#define ADIS16209_ALM_MAG2       0x22
> +#define ADIS16209_ALM_MAG2_REG		0x22
>  
>  /* Alarm 1, sample period */
> -#define ADIS16209_ALM_SMPL1      0x24
> +#define ADIS16209_ALM_SMPL1_REG		0x24
>  
>  /* Alarm 2, sample period */
> -#define ADIS16209_ALM_SMPL2      0x26
> +#define ADIS16209_ALM_SMPL2_REG		0x26
>  
>  /* Alarm control */
> -#define ADIS16209_ALM_CTRL       0x28
> +#define ADIS16209_ALM_CTRL_REG		0x28
>  
>  /* Auxiliary DAC data */
> -#define ADIS16209_AUX_DAC        0x30
> +#define ADIS16209_AUX_DAC_REG		0x30
>  
>  /* General-purpose digital input/output control */
> -#define ADIS16209_GPIO_CTRL      0x32
> +#define ADIS16209_GPIO_CTRL_REG		0x32
>  
>  /* Miscellaneous control */
> -#define ADIS16209_MSC_CTRL       0x34
> +#define ADIS16209_MSC_CTRL_REG		0x34
>  
>  /* Internal sample period (rate) control */
> -#define ADIS16209_SMPL_PRD       0x36
> +#define ADIS16209_SMPL_PRD_REG		0x36
>  
>  /* Operation, filter configuration */
> -#define ADIS16209_AVG_CNT        0x38
> +#define ADIS16209_AVG_CNT_REG		0x38
>  
>  /* Operation, sleep mode control */
> -#define ADIS16209_SLP_CNT        0x3A
> +#define ADIS16209_SLP_CNT_REG		0x3A
>  
>  /* Diagnostics, system status register */
> -#define ADIS16209_DIAG_STAT      0x3C
> +#define ADIS16209_DIAG_STAT_REG		0x3C
>  
>  /* Operation, system command register */
> -#define ADIS16209_GLOB_CMD       0x3E
> +#define ADIS16209_GLOB_CMD_REG		0x3E
>  
>  /* MSC_CTRL */
>  
> @@ -165,10 +165,10 @@ enum adis16209_scan {
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
>  	[ADIS16209_SCAN_AUX_ADC] = { },
> -	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL },
> -	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL },
> -	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL },
> -	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL },
> +	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
> +	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
>  	[ADIS16209_SCAN_ROT] = { },
>  	[ADIS16209_SCAN_TEMP] = { },
>  };
> @@ -266,18 +266,19 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16209_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
> -	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
> +			 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
>  			0, 0, 14),
> -	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
>  			0, 0, 14),
> -	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
>  	IIO_CHAN_SOFT_TIMESTAMP(8)
>  };
>  
> @@ -297,9 +298,9 @@ static const char * const adis16209_status_error_msgs[] = {
>  
>  static const struct adis_data adis16209_data = {
>  	.read_delay = 30,
> -	.msc_ctrl_reg = ADIS16209_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16209_GLOB_CMD,
> -	.diag_stat_reg = ADIS16209_DIAG_STAT,
> +	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,

