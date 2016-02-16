Return-Path: <afd@ti.com>
Subject: Re: [PATCH] iio: health/afe4403: select REGMAP_SPI
To: Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
References: <1455637959-3169264-1-git-send-email-arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56C34AF8.7080104@ti.com>
Date: Tue, 16 Feb 2016 10:14:48 -0600
MIME-Version: 1.0
In-Reply-To: <1455637959-3169264-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/16/2016 09:52 AM, Arnd Bergmann wrote:
> The newly added afe4403 driver uses the regmap facility to abstract
> the I2C and SPI access. However, it fails to ensure that regmap_spi
> is actually present:
>
> drivers/iio/built-in.o: In function `afe4403_probe':
> :(.text+0x9bf8): undefined reference to `__devm_regmap_init_spi'
>
> This adds a Kconfig select statement like the afe4404 I2C driver
> has.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
> ---
>   drivers/iio/health/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
> index f0c19779ac27..c5f004a8e447 100644
> --- a/drivers/iio/health/Kconfig
> +++ b/drivers/iio/health/Kconfig
> @@ -10,6 +10,7 @@ menu "Heart Rate Monitors"
>   config AFE4403
>   	tristate "TI AFE4403 Heart Rate Monitor"
>   	depends on SPI_MASTER
> +	select REGMAP_SPI
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER
>   	help
>

Oversight on my part, thanks for fix.

Acked-by: Andrew F. Davis <afd@ti.com>
