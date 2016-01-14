Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: pressure: mpl115: support MPL115A1
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1452789018-16255-1-git-send-email-akinobu.mita@gmail.com>
 <1452789018-16255-2-git-send-email-akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5697CEE7.6070908@metafoo.de>
Date: Thu, 14 Jan 2016 17:37:59 +0100
MIME-Version: 1.0
In-Reply-To: <1452789018-16255-2-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 01/14/2016 05:30 PM, Akinobu Mita wrote:
> mpl115 driver currently supports i2c interface (MPL115A2).
> There is also SPI version (MPL115A1).  The difference between them
> is only physical transport so we can easily support both while sharing
> most of the code.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/pressure/Kconfig  |   8 +-
>  drivers/iio/pressure/mpl115.c | 258 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 236 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 6f2e7c9..fa628b7 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -31,11 +31,11 @@ config HID_SENSOR_PRESS
>            will be called hid-sensor-press.
>  
>  config MPL115
> -	tristate "Freescale MPL115A2 pressure sensor driver"
> -	depends on I2C
> +	tristate "Freescale MPL115A1/2 pressure sensor driver"
> +	depends on (SPI_MASTER && I2C!=m) || I2C

Hi,

for combined SPI and I2C support please follow a scheme similar to that used
by the mma7455 driver
(http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/iio?id=a84ef0d181d917125f1f16cffe53f84c19968969)
and split the driver into a core support module and one module each for I2C
and SPI support.

That is a much cleaner approach and avoids issues that can happen if core
I2C support is build as a module and core SPI support is built-in.

- Lars
