Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932150AbeCJPnM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 10:43:12 -0500
Date: Sat, 10 Mar 2018 15:43:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v5] Staging: iio: adis16209: Change some macro names
Message-ID: <20180310154306.0dd311a5@archlinux>
In-Reply-To: <1520676614-9556-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1520676614-9556-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 10 Mar 2018 15:40:14 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Make some of the macro names according to the names
> given in the datasheet of the adis16209 driver and
> have slight indentation in field definitions to make
> them clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I applied an earlier version so this should have been an
incremental patch not a new version of that one.

I have since pushed a tree out with that patch and it's a non
rebasing tree (as others may be basing their patches on it).

Hence please send a new patch to just make the indentation changes.

Thanks,

Jonathan

> ---
> 
> Changes in v5
>   -Re-send the corrected patch.

Please keep previous change lot here as well.

> 
>  drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index d8aef9c..ed2e89f 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -68,21 +68,21 @@
>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>  
> -#define ADIS16209_DIAG_STAT_REG			0x3C
> -#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> -#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
> -#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> -#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> +#define ADIS16209_STAT_REG			0x3C
> +#define  ADIS16209_STAT_ALARM2			BIT(9)
> +#define  ADIS16209_STAT_ALARM1			BIT(8)
> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>  /* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
>  
> -#define ADIS16209_GLOB_CMD_REG			0x3E
> -#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
> -#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
> -#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
> +#define ADIS16209_CMD_REG			0x3E
> +#define  ADIS16209_CMD_SW_RESET			BIT(7)
> +#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
> +#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
>  
>  #define ADIS16209_ERROR_ACTIVE			BIT(14)
>  
> @@ -238,29 +238,29 @@ static const struct iio_info adis16209_info = {
>  };
>  
>  static const char * const adis16209_status_error_msgs[] = {
> -	[ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> -	[ADIS16209_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16209_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16209_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16209_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> +	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> +	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
>  };
>  
>  static const struct adis_data adis16209_data = {
>  	.read_delay = 30,
>  	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> -	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
> -	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
> +	.glob_cmd_reg = ADIS16209_CMD_REG,
> +	.diag_stat_reg = ADIS16209_STAT_REG,
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
>  	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16209_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_LOW_BIT),
> +	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16209_STAT_POWER_LOW_BIT),
>  };
>  
>  static int adis16209_probe(struct spi_device *spi)

