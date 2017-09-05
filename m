Return-Path: <SRS0=B1td=AG=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
 <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Sep 2017 11:56:02 +0200
Message-ID: <CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Andrew F. Davis" <afd@ti.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Daniel Mack <daniel@zonque.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 5, 2017 at 11:44 AM, Lukas Wunner <lukas@wunner.de> wrote:
> The Texas Instruments DAC7512 has the exact same pinout, programming
> interface and power-down modes as the Texas Instruments DAC121S101 and
> Analog Devices AD5320, which are already supported by the IIO driver
> ad5446.c.  Remove the duplicate misc driver.
>
> This requires user space to migrate to the standardized IIO sysfs ABI.
> (In other words, it needs to change a filename.)
>
> The IIO driver supports the chip's features more fully, e.g. the ability
> to power down the output or choose one of the available powerdown modes.
>
> There is an oddity with the misc driver in that it initializes the SPI
> slave to SPI_MODE_0, in contradiction to the datasheet which specifies
> that data is latched in on the falling edge, implying that SPI_MODE_1
> or SPI_MODE_2 must be used.  Another oddity is that Kconfig and the
> MODULE_DESCRIPTION() claim the chip has 16-bit resolution although it
> actually has 12-bit.
>
> Datasheets:
> http://www.ti.com/lit/ds/symlink/dac7512.pdf
> http://www.ti.com/lit/ds/symlink/dac121s101.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5320.pdf
>
> Cc: Daniel Mack <daniel@zonque.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Good catch, removing duplicate code is usually a good idea.

However, for the incompatible user space ABI change, we need a better
reasoning why this is safe to do and won't catch users by surprise.

If anyone relies on the old ABI and can't be expected to change,
we need to stay compatible. Do we know who uses the old driver?

>  arch/arm/configs/pxa_defconfig      |   3 +-
>  arch/arm/configs/raumfeld_defconfig |   3 +-
>  drivers/iio/dac/ad5446.c            |  10 ++++
>  drivers/misc/Kconfig                |  10 ----
>  drivers/misc/Makefile               |   1 -
>  drivers/misc/ti_dac7512.c           | 103 ------------------------------------
>  6 files changed, 14 insertions(+), 116 deletions(-)
>  delete mode 100644 drivers/misc/ti_dac7512.c

For the defconfig changes:

Acked-by: Arnd Bergmann <arnd@arndb.de>

> -
> -static const struct spi_device_id dac7512_id_table[] = {
> -       { "dac7512", 0 },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(spi, dac7512_id_table);
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id dac7512_of_match[] = {
> -       { .compatible = "ti,dac7512", },
> -       { }
> -};

The other driver doesn't appear to have an of_match table, so
I suspect it won't automatically get loaded.

Can you update
Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
in an appropriate way to list all the IDs that are supported
by the IIO driver, and make sure that the driver supports
all the IDs that it needs?

        Arnd
