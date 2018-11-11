Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWXg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:23:36 -0500
Date: Sun, 11 Nov 2018 12:35:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: iio: ad7816: Do not use busy_pin in
 case of AD7818
Message-ID: <20181111123503.3a4acef2@archlinux>
In-Reply-To: <3f0bc36261c54c945a3213ef03425099e57e9060.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <3f0bc36261c54c945a3213ef03425099e57e9060.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 13:06:24 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> AD7818 does not support busy_pin functionality as per datasheet.
> Hence drop busy_pin when AD7818 is used.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

A slight concern that I can't immediately find an answer to,
is whether we should be waiting a short while for the ad7818 given
we can't wait on the gpio?  We can add this in a follow up patch
if it is necessary.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7816.c | 35 ++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 12c4e0ab4713..3cda5cd09365 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -43,6 +43,7 @@
>   */
>  
>  struct ad7816_chip_info {
> +	kernel_ulong_t id;
>  	struct spi_device *spi_dev;
>  	struct gpio_desc *rdwr_pin;
>  	struct gpio_desc *convert_pin;
> @@ -52,6 +53,12 @@ struct ad7816_chip_info {
>  	u8  mode;
>  };
>  
> +enum ad7816_type {
> +	ID_AD7816,
> +	ID_AD7817,
> +	ID_AD7818,
> +};
> +
>  /*
>   * ad7816 data access by SPI
>   */
> @@ -78,8 +85,10 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	while (gpiod_get_value(chip->busy_pin))
> -		cpu_relax();
> +	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +		while (gpiod_get_value(chip->busy_pin))
> +			cpu_relax();
> +	}
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -359,6 +368,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  
> +	chip->id = spi_get_device_id(spi_dev)->driver_data;
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
> @@ -373,12 +383,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			ret);
>  		return ret;
>  	}
> -	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
> -	if (IS_ERR(chip->busy_pin)) {
> -		ret = PTR_ERR(chip->busy_pin);
> -		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> -			ret);
> -		return ret;
> +	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
> +						GPIOD_IN);
> +		if (IS_ERR(chip->busy_pin)) {
> +			ret = PTR_ERR(chip->busy_pin);
> +			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	indio_dev->name = spi_get_device_id(spi_dev)->name;
> @@ -409,9 +422,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  }
>  
>  static const struct spi_device_id ad7816_id[] = {
> -	{ "ad7816", 0 },
> -	{ "ad7817", 0 },
> -	{ "ad7818", 0 },
> +	{ "ad7816", ID_AD7816 },
> +	{ "ad7817", ID_AD7817 },
> +	{ "ad7818", ID_AD7818 },
>  	{}
>  };
>  
