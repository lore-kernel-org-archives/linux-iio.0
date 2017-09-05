Return-Path: <SRS0=nxDZ=AG=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 1/2] iio: ad_sigma_delta: Implement a dedicated reset
 function
To: Dragos Bogdan <dragos.bogdan@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20170905121445.26913-1-dragos.bogdan@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0ea75f81-fe63-4d54-6167-463c53dd8fd5@metafoo.de>
Date: Tue, 5 Sep 2017 14:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170905121445.26913-1-dragos.bogdan@analog.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/05/2017 02:14 PM, Dragos Bogdan wrote:
> Since most of the SD ADCs have the option of reseting the serial
> interface by sending a number of SCLKs with CS = 0 and DIN = 1,
> a dedicated function that can do this is usefull.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 28 ++++++++++++++++++++++++++++
>  include/linux/iio/adc/ad_sigma_delta.h |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d10bd0c97233..22c4c17cd996 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -177,6 +177,34 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
>  }
>  EXPORT_SYMBOL_GPL(ad_sd_read_reg);
>  
> +/**
> + * ad_sd_reset() - Reset the serial interface
> + *
> + * @sigma_delta: The sigma delta device
> + * @reset_length: Number of SCLKs with DIN = 1
> + *
> + * Returns 0 on success, an error code otherwise.
> + **/
> +int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
> +	unsigned int reset_length)
> +{
> +	uint8_t *buf;
> +	unsigned int size;
> +	int ret;
> +
> +	size = DIV_ROUND_UP(reset_length, 8);
> +	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memset(buf, 0xff, size);
> +	ret = spi_write(sigma_delta->spi, buf, size);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ad_sd_reset);
> +
>  static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 5ba430cc9a87..1fc7abd28b0b 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -111,6 +111,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	unsigned int size, unsigned int *val);
>  
> +int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
> +	unsigned int reset_length);
> +
>  int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, int *val);
>  int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
> 
