Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45635 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbHBSJC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:09:02 -0400
Subject: Re: [PATCH v2 6/8] iio:adc:berlin2-adc: use channel-array size
 directly
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438035998.git.knaack.h@gmx.de>
 <7fa1609e70603e150ce0c41f1b74c2ff1112df01.1438035998.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5CBC.8080005@kernel.org>
Date: Sun, 2 Aug 2015 19:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <7fa1609e70603e150ce0c41f1b74c2ff1112df01.1438035998.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 23:39, Hartmut Knaack wrote:
> Drop the otherwise unused definition of the channel-array size and use it
> directly in _probe - makes it a bit more obvious.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Applied.
> ---
>  drivers/iio/adc/berlin2-adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 1e1d618ce152..6e20c856f479 100644
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
> 

