Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160520170500.GA2620@d830.WORKGROUP>
References: <20160520170500.GA2620@d830.WORKGROUP>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 20 May 2016 10:34:54 -0700
Message-ID: <CAKzfze_7C-WWy0NUtgAEj5XYZ-qUmMWxEOVV8-F9haU=CW_tLQ@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: add HDC1000 and HDC1008 product names
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 20, 2016 at 10:05 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> hdc100x supports Texas Instruments HDC1000 and HDC1008 relative
> humidity and temperature sensors. Add these product names to
> Kconfig and to the drivers device id structure to enable finding
> the product by name and using it to add a device.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>  drivers/iio/humidity/Kconfig   | 8 ++++----
>  drivers/iio/humidity/hdc100x.c | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 738a86d..f155386 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -26,11 +26,11 @@ config HDC100X
>         tristate "TI HDC100x relative humidity and temperature sensor"
>         depends on I2C
>         help
> -        Say yes here to build support for the TI HDC100x series of
> -        relative humidity and temperature sensors.
> +         Say yes here to build support for the Texas Instruments
> +         HDC1000 and HDC1008 relative humidity and temperature sensors.
>
> -        To compile this driver as a module, choose M here: the module
> -        will be called hdc100x.
> +         To compile this driver as a module, choose M here: the module
> +         will be called hdc100x.
>
>  config HTU21
>         tristate "Measurement Specialties HTU21 humidity & temperature sensor"
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index fa47676..0deb874 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -302,6 +302,8 @@ static int hdc100x_probe(struct i2c_client *client,
>
>  static const struct i2c_device_id hdc100x_id[] = {
>         { "hdc100x", 0 },
> +       { "hdc1000", 0 },
> +       { "hdc1008", 0 },

Personally I think adding more device ids that don't add any per chip
configuration is just adding clutter.
There is a reason I used "hdc100x" when I wrote the driver :)


>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
> --
> 2.1.4
>
