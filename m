Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934262AbeCGUoz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:44:55 -0500
Date: Wed, 7 Mar 2018 20:44:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 05/11] Staging: iio: accel: Add _REG suffix to registers
Message-ID: <20180307204450.2cc869e6@archlinux>
In-Reply-To: <1520236170-14668-6-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-6-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:24 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Addition of _REG suffix to the register definitions allows a distinction
> between registers and register fields. The various registers and its field
> bits are grouped together to improve readability and easy indentification.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
This one looks good. I will pick it up once you've tweaked the
predecessor patches.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 133 ++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 445cb56..476b1c3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,75 +20,64 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY_MS	220
> -#define ADIS16201_FLASH_CNT		0x00
> +#define ADIS16201_STARTUP_DELAY_MS				220
> +#define ADIS16201_FLASH_CNT					0x00
>  
>  /* Data Output Register Information */
> -#define ADIS16201_SUPPLY_OUT     0x02
> -#define ADIS16201_XACCL_OUT      0x04
> -#define ADIS16201_YACCL_OUT      0x06
> -#define ADIS16201_AUX_ADC        0x08
> -#define ADIS16201_TEMP_OUT       0x0A
> -#define ADIS16201_XINCL_OUT      0x0C
> -#define ADIS16201_YINCL_OUT      0x0E
> +#define ADIS16201_SUPPLY_OUT_REG				0x02
> +#define ADIS16201_XACCL_OUT_REG					0x04
> +#define ADIS16201_YACCL_OUT_REG					0x06
> +#define ADIS16201_AUX_ADC_REG					0x08
> +#define ADIS16201_TEMP_OUT_REG					0x0A
> +#define ADIS16201_XINCL_OUT_REG					0x0C
> +#define ADIS16201_YINCL_OUT_REG					0x0E
>  
>  /* Calibration Register Definition */
> -#define ADIS16201_XACCL_OFFS     0x10
> -#define ADIS16201_YACCL_OFFS     0x12
> -#define ADIS16201_XACCL_SCALE    0x14
> -#define ADIS16201_YACCL_SCALE    0x16
> -#define ADIS16201_XINCL_OFFS     0x18
> -#define ADIS16201_YINCL_OFFS     0x1A
> -#define ADIS16201_XINCL_SCALE    0x1C
> -#define ADIS16201_YINCL_SCALE    0x1E
> +#define ADIS16201_XACCL_OFFS_REG				0x10
> +#define ADIS16201_YACCL_OFFS_REG				0x12
> +#define ADIS16201_XACCL_SCALE_REG				0x14
> +#define ADIS16201_YACCL_SCALE_REG				0x16
> +#define ADIS16201_XINCL_OFFS_REG				0x18
> +#define ADIS16201_YINCL_OFFS_REG				0x1A
> +#define ADIS16201_XINCL_SCALE_REG				0x1C
> +#define ADIS16201_YINCL_SCALE_REG				0x1E
>  
>  /* Alarm Register Definition */
> -#define ADIS16201_ALM_MAG1       0x20
> -#define ADIS16201_ALM_MAG2       0x22
> -#define ADIS16201_ALM_SMPL1      0x24
> -#define ADIS16201_ALM_SMPL2      0x26
> -#define ADIS16201_ALM_CTRL       0x28
> -
> -#define ADIS16201_AUX_DAC        0x30
> -#define ADIS16201_GPIO_CTRL      0x32
> -#define ADIS16201_MSC_CTRL       0x34
> -
> -#define ADIS16201_SMPL_PRD       0x36
> -#define ADIS16201_AVG_CNT        0x38
> -#define ADIS16201_SLP_CNT        0x3A
> +#define ADIS16201_ALM_MAG1_REG					0x20
> +#define ADIS16201_ALM_MAG2_REG					0x22
> +#define ADIS16201_ALM_SMPL1_REG					0x24
> +#define ADIS16201_ALM_SMPL2_REG					0x26
> +#define ADIS16201_ALM_CTRL_REG					0x28
> +
> +#define ADIS16201_AUX_DAC_REG					0x30
> +#define ADIS16201_GPIO_CTRL_REG					0x32
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define ADIS16201_SMPL_PRD_REG					0x36
> +#define ADIS16201_AVG_CNT_REG					0x38
> +#define ADIS16201_SLP_CNT_REG					0x3A
> +
> +/* Miscellaneous Control Register Definition */
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define  ADIS16201_MSC_CTRL_SELF_TEST_EN			BIT(8)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_EN				BIT(2)
> +#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH		BIT(1)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1			BIT(0)
>  
>  /* Diagnostics, system status register */
> -#define ADIS16201_DIAG_STAT      0x3C
> +#define ADIS16201_DIAG_STAT_REG					0x3C
> +#define  ADIS16201_DIAG_STAT_ALARM2				BIT(9)
> +#define  ADIS16201_DIAG_STAT_ALARM1				BIT(8)
> +#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
> +#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT			2
> +#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT			1
> +#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT			0
>  
>  /* Operation, system command register */
> -#define ADIS16201_GLOB_CMD       0x3E
> -
> -
> -#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -
> -#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> -#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
> -
> -#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
> -
> -
> -#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
> -
> -#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
> -
> -#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
> -
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
> -
> -#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
> -
> -#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
> -
> -#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
> +#define ADIS16201_GLOB_CMD_REG					0x3E
> +#define  ADIS16201_GLOB_CMD_SW_RESET				BIT(7)
> +#define  ADIS16201_GLOB_CMD_FACTORY				BIT(1)
>  
> -#define ADIS16201_ERROR_ACTIVE          BIT(14)
> +#define ADIS16201_ERROR_ACTIVE					BIT(14)
>  
>  enum adis16201_scan {
>  	ADIS16201_SCAN_ACC_X,
> @@ -101,10 +90,10 @@ enum adis16201_scan {
>  };
>  
>  static const u8 adis16201_addresses[] = {
> -	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> -	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
>  };
>  
>  static int adis16201_read_raw(struct iio_dev *indio_dev,
> @@ -208,16 +197,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
> -	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
> @@ -237,9 +226,9 @@ static const char * const adis16201_status_error_msgs[] = {
>  
>  static const struct adis_data adis16201_data = {
>  	.read_delay = 20,
> -	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16201_GLOB_CMD,
> -	.diag_stat_reg = ADIS16201_DIAG_STAT,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,

