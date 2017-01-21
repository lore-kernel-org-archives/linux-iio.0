Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34560 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAUMeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 07:34:36 -0500
Subject: Re: [PATCH] iio: accel: st_accel: add !SENSORS_LIS3LV02D depedency
To: Arnd Bergmann <arnd@arndb.de>
References: <20170120162615.3718940-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <81fbb625-4626-d204-3ade-6640f01ad506@kernel.org>
Date: Sat, 21 Jan 2017 12:34:34 +0000
MIME-Version: 1.0
In-Reply-To: <20170120162615.3718940-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/17 16:25, Arnd Bergmann wrote:
> warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_SPI_3AXIS which has unmet direct dependencies (IIO && !SENSORS_LIS3_SPI && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_SPI)
> 
> Fixes: 762227721fe6 ("iio: accel: st_accel: handle deprecated bindings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
At least at first glance, this is a different approach to fixing the issue
from the one Linus took.  I think that one has already been picked up
by Greg (or will be shortly).  Linus, please confirm this is the same issue.

thanks,

Jonathan
> ---
>  drivers/iio/accel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index ea295fe0f561..590ba8835fdc 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -120,6 +120,7 @@ config HID_SENSOR_ACCEL_3D
>  config IIO_ST_ACCEL_3AXIS
>  	tristate "STMicroelectronics accelerometers 3-Axis Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
> +	depends on !SENSORS_LIS3LV02D
>  	select IIO_ST_SENSORS_CORE
>  	select IIO_ST_ACCEL_I2C_3AXIS if (I2C)
>  	select IIO_ST_ACCEL_SPI_3AXIS if (SPI_MASTER)
> 

