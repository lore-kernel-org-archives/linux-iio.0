Return-Path: <lars@metafoo.de>
Message-ID: <50E13BBA.1000801@metafoo.de>
Date: Mon, 31 Dec 2012 08:16:10 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging:iio:adis16260: select IIO_ADIS_LIB to fix build
 error
References: <1356932195-31437-1-git-send-email-yuanhan.liu@linux.intel.com>
In-Reply-To: <1356932195-31437-1-git-send-email-yuanhan.liu@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/31/2012 06:36 AM, Yuanhan Liu wrote:
> Commit 9d5e9fdf turned the code to use adis library, so it depends on
> adis lib. But it forgot to select it at Kconfig file. Thus if adis is
> not enabled, it will produce following build errros(catched by Fengguang's
> 0-DAY kernel build testing system):
>   ERROR: "adis_initial_startup" [drivers/staging/iio/gyro/adis16260.ko] undefined!
>   ERROR: "adis_init" [drivers/staging/iio/gyro/adis16260.ko] undefined!
>   ERROR: "adis_write_reg" [drivers/staging/iio/gyro/adis16260.ko] undefined!
>   ERROR: "adis_read_reg" [drivers/staging/iio/gyro/adis16260.ko] undefined!
>   ERROR: "adis_single_conversion" [drivers/staging/iio/gyro/adis16260.ko] undefined!
> 
> Selecting IIO_ADIS_LIB at Kconfig file fixes this issue.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>

Hi,

Thanks. But I already sent a similar patch some time ago. See
http://www.spinics.net/lists/linux-iio/msg07128.html

- Lars

> ---
>  drivers/staging/iio/gyro/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
> index ea295b2..476207a 100644
> --- a/drivers/staging/iio/gyro/Kconfig
> +++ b/drivers/staging/iio/gyro/Kconfig
> @@ -27,6 +27,7 @@ config ADIS16130
>  config ADIS16260
>  	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
>  	depends on SPI
> +	select IIO_ADIS_LIB
>  	select IIO_TRIGGER if IIO_BUFFER
>  	select IIO_SW_RING if IIO_BUFFER
>  	help
