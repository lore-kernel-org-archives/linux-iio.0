Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933736AbeCGUmP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:42:15 -0500
Date: Wed, 7 Mar 2018 20:42:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 04/11] Staging: iio: accel: Rename few macro definitions
Message-ID: <20180307204210.748056eb@archlinux>
In-Reply-To: <1520236170-14668-5-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-5-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:23 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Rename few macros with appropriate names specifying their usage/function.
Most of these are obviously good, but for one I didn't understand your
reasoning.

Given there are only a few of them, I'd put some more description here
to explain why you changed each one.

Thanks,

Jonathan
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 59c1166..445cb56 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,9 +20,8 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY		220
> -
> -#define ADIS16201_FLASH_CNT      0x00
> +#define ADIS16201_STARTUP_DELAY_MS	220
> +#define ADIS16201_FLASH_CNT		0x00
>  
>  /* Data Output Register Information */
>  #define ADIS16201_SUPPLY_OUT     0x02
> @@ -69,7 +68,7 @@
>  
>  #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
>  
> -#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
>  
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> @@ -80,14 +79,14 @@
>  
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
> +#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
>  
>  #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
>  
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>  
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
> +#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
What was the logic behind this particular change?

>  
>  #define ADIS16201_ERROR_ACTIVE          BIT(14)
>  
> @@ -231,7 +230,7 @@ static const struct iio_info adis16201_info = {
>  
>  static const char * const adis16201_status_error_msgs[] = {
>  	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
>  	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
>  };
> @@ -244,11 +243,11 @@ static const struct adis_data adis16201_data = {
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16201_STARTUP_DELAY,
> +	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
>  };

