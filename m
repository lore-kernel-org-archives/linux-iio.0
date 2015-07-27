Return-Path: <antoine.tenart@free-electrons.com>
Date: Mon, 27 Jul 2015 09:49:27 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 6/8] iio:adc:berlin2-adc: use channel-array size directly
Message-ID: <20150727074927.GF16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <e64898d4f93ba8049aa016e1cf8cf8345783557a.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e64898d4f93ba8049aa016e1cf8cf8345783557a.1437862404.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 26, 2015 at 12:43:24AM +0200, Hartmut Knaack wrote:
> Drop the otherwise unused definition of the channel-array size and use it
> directly in _probe - makes it a bit more obvious.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/iio/adc/berlin2-adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 1d14290ba6f2..c840ba8b2aa4 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -103,7 +103,6 @@ static const struct iio_chan_spec berlin2_adc_channels[] = {
>  	BERLIN2_ADC_CHANNEL(7, IIO_VOLTAGE),	/* reserved */
>  	IIO_CHAN_SOFT_TIMESTAMP(8),		/* timestamp */
>  };
> -#define BERLIN2_N_CHANNELS	ARRAY_SIZE(berlin2_adc_channels)
>  
>  static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
>  {
> @@ -324,8 +323,8 @@ static int berlin2_adc_probe(struct platform_device *pdev)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &berlin2_adc_info;
>  
> -	indio_dev->num_channels = BERLIN2_N_CHANNELS;
>  	indio_dev->channels = berlin2_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(berlin2_adc_channels);
>  
>  	/* Power up the ADC */
>  	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
> -- 
> 2.4.3
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
