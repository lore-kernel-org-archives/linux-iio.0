Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:40984 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUQoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Oct 2018 12:44:55 -0400
Date: Sun, 21 Oct 2018 10:31:38 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181021083138.GB7662@x220.localdomain>
References: <20181021061924.GA11073@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181021061924.GA11073@nishad>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On paź 21, 2018 11:49, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.

Hi!

See my comments below.

> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 110 +++++++++++++++---------
>  drivers/staging/iio/resolver/ad2s1210.h |   3 -
>  2 files changed, 71 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..ed372a5f9130 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -15,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> @@ -73,6 +73,11 @@ struct ad2s1210_state {
>  	const struct ad2s1210_platform_data *pdata;
>  	struct mutex lock;
>  	struct spi_device *sdev;
> +	struct gpio_desc *sample;
> +	struct gpio_desc *a0;
> +	struct gpio_desc *a1;
> +	struct gpio_desc *res0;
> +	struct gpio_desc *res1;
>  	unsigned int fclkin;
>  	unsigned int fexcit;
>  	bool hysteresis;
> @@ -91,8 +96,8 @@ static const int ad2s1210_mode_vals[4][2] = {
>  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
>  				     struct ad2s1210_state *st)
>  {
> -	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
> -	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
> +	gpiod_set_value(st->a0, ad2s1210_mode_vals[mode][0]);
> +	gpiod_set_value(st->a1, ad2s1210_mode_vals[mode][1]);
>  	st->mode = mode;
>  }
>  
> @@ -152,8 +157,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
>  
>  static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
>  {
> -	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
> -			  gpio_get_value(st->pdata->res[1]);
> +	int resolution = (gpiod_get_value(st->res0) << 1) |
> +			  gpiod_get_value(st->res1);
>  
>  	return ad2s1210_resolution_value[resolution];
>  }
> @@ -164,10 +169,10 @@ static const int ad2s1210_res_pins[4][2] = {
>  
>  static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
>  {
> -	gpio_set_value(st->pdata->res[0],
> -		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> -	gpio_set_value(st->pdata->res[1],
> -		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> +	gpiod_set_value(st->res0,
> +			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> +	gpiod_set_value(st->res1,
> +			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
>  }
>  
>  static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> @@ -401,15 +406,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	gpio_set_value(st->pdata->sample, 0);
> +	gpiod_set_value(st->sample, 0);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->sample, 1);
>  	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
>  	if (ret < 0)
>  		goto error_ret;
> -	gpio_set_value(st->pdata->sample, 0);
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->sample, 0);
> +	gpiod_set_value(st->sample, 1);
>  error_ret:
>  	mutex_unlock(&st->lock);
>  
> @@ -466,7 +471,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	s16 vel;
>  
>  	mutex_lock(&st->lock);
> -	gpio_set_value(st->pdata->sample, 0);
> +	gpiod_set_value(st->sample, 0);
>  	/* delay (6 * tck + 20) nano seconds */
>  	udelay(1);
>  
> @@ -512,7 +517,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  error_ret:
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->sample, 1);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
>  	mutex_unlock(&st->lock);
> @@ -628,32 +633,59 @@ static const struct iio_info ad2s1210_info = {
>  	.attrs = &ad2s1210_attribute_group,
>  };
>  
> -static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> +static int ad2s1210_setup_gpios(struct spi_device *spi,
> +				struct ad2s1210_state *st)

This change is not needed. The st has the spi_device inside. Use container_of()
macro here.

>  {
> -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> -	struct gpio ad2s1210_gpios[] = {
> -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> -		{ st->pdata->a[0], flags, "a0" },
> -		{ st->pdata->a[1], flags, "a1" },
> -		{ st->pdata->res[0], flags, "res0" },
> -		{ st->pdata->res[0], flags, "res1" },
> -	};
> +	int ret = 0;
> +	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> +
> +	st->sample = devm_gpiod_get(&spi->dev, "sample", GPIOD_IN);
> +	if (IS_ERR(st->sample)) {
> +		ret = PTR_ERR(st->sample);
> +		dev_err(&spi->dev, "Failed to request sample GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	st->a0 = devm_gpiod_get(&spi->dev, "a0", flags);
> +	if (IS_ERR(st->a0)) {
> +		ret = PTR_ERR(st->a0);
> +		dev_err(&spi->dev, "Failed to request a0 GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	st->a1 = devm_gpiod_get(&spi->dev, "a1", flags);
> +	if (IS_ERR(st->a1)) {
> +		ret = PTR_ERR(st->a1);
> +		dev_err(&spi->dev, "Failed to request a1 GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	st->res0 = devm_gpiod_get(&spi->dev, "res0", flags);
> +	if (IS_ERR(st->res0)) {
> +		ret = PTR_ERR(st->res0);
> +		dev_err(&spi->dev, "Failed to request res0 GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	st->res1 = devm_gpiod_get(&spi->dev, "res1", flags);
> +	if (IS_ERR(st->res1)) {
> +		ret = PTR_ERR(st->res1);
> +		dev_err(&spi->dev, "Failed to request res1 GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}

To reduce the redundant code here, create an array of structs. The struct will
have a pointer to gpio_desc, name of the gpio and the gpios' flags. Then you can
use for loop to get all the needed gpios:

for (l = 0; l < ARRAY_SIZE(str); l++) {
	str[l].ptr = devm_gpiod_get(&spi->dev, str[l].name, str[l].flags);
	if (IS_ERR(str[l].res1)) {
		...
	}
}

> -	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> +	return ret;
>  }
>  
> -static void ad2s1210_free_gpios(struct ad2s1210_state *st)
> +static void ad2s1210_free_gpios(struct spi_device *spi,
> +				struct ad2s1210_state *st)
>  {
> -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> -	struct gpio ad2s1210_gpios[] = {
> -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> -		{ st->pdata->a[0], flags, "a0" },
> -		{ st->pdata->a[1], flags, "a1" },
> -		{ st->pdata->res[0], flags, "res0" },
> -		{ st->pdata->res[0], flags, "res1" },
> -	};
> -
> -	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> +	devm_gpiod_put(&spi->dev, st->sample);
> +	devm_gpiod_put(&spi->dev, st->a0);
> +	devm_gpiod_put(&spi->dev, st->a1);
> +	devm_gpiod_put(&spi->dev, st->res0);
> +	devm_gpiod_put(&spi->dev, st->res1);
>  }

This whole function ad2s1210_free_gpios is not needed anymore because you are
using the devm API (it's called from probe and remove, so you are safe).

>  static int ad2s1210_probe(struct spi_device *spi)
> @@ -670,7 +702,7 @@ static int ad2s1210_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	st->pdata = spi->dev.platform_data;
> -	ret = ad2s1210_setup_gpios(st);
> +	ret = ad2s1210_setup_gpios(spi, st);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -702,7 +734,7 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	return 0;
>  
>  error_free_gpios:
> -	ad2s1210_free_gpios(st);
> +	ad2s1210_free_gpios(spi, st);
>  	return ret;
>  }
>  
> @@ -711,7 +743,7 @@ static int ad2s1210_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(indio_dev);
> -	ad2s1210_free_gpios(iio_priv(indio_dev));
> +	ad2s1210_free_gpios(spi, iio_priv(indio_dev));
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> index e9b2147701fc..63d479b20a6c 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.h
> +++ b/drivers/staging/iio/resolver/ad2s1210.h
> @@ -12,9 +12,6 @@
>  #define _AD2S1210_H
>  
>  struct ad2s1210_platform_data {
> -	unsigned int		sample;
> -	unsigned int		a[2];
> -	unsigned int		res[2];
>  	bool			gpioin;
>  };
>  #endif /* _AD2S1210_H */

-- 
Slawomir Stepien
