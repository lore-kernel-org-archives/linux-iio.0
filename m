Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeIBNGv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 09:06:51 -0400
Date: Sun, 2 Sep 2018 09:51:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: sc27xx: Add raw data support
Message-ID: <20180902095140.70b6fd5e@archlinux>
In-Reply-To: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 29 Aug 2018 14:04:04 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> The headset device will use channel 20 of ADC controller to detect events,
> but it needs the raw ADC data to do conversion according to its own formula.
> 
> Thus we should configure the channel mask separately and configure channel
> 20 as IIO_CHAN_INFO_RAW, as well as adding raw data read support.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
I'm still a little unclear on whether there is fundamentally something different
about this channel or whether this is just a policy decision for particular
(possibly all) board.  For now we'll go with this change, but if anyone screams
we will have to then go the nasty route of supporting both processed and raw
for channel 20.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes from v1:
>  - None.
> 
> ---
>  drivers/iio/adc/sc27xx_adc.c |   80 ++++++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 2b60efe..153c311 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -273,6 +273,17 @@ static int sc27xx_adc_read_raw(struct iio_dev *indio_dev,
>  	int ret, tmp;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		ret = sc27xx_adc_read(data, chan->channel, scale, &tmp);
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = tmp;
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_PROCESSED:
>  		mutex_lock(&indio_dev->mlock);
>  		ret = sc27xx_adc_read_processed(data, chan->channel, scale,
> @@ -315,48 +326,47 @@ static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
>  	.write_raw = &sc27xx_adc_write_raw,
>  };
>  
> -#define SC27XX_ADC_CHANNEL(index) {				\
> +#define SC27XX_ADC_CHANNEL(index, mask) {			\
>  	.type = IIO_VOLTAGE,					\
>  	.channel = index,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |	\
> -			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate = mask | BIT(IIO_CHAN_INFO_SCALE),	\
>  	.datasheet_name = "CH##index",				\
>  	.indexed = 1,						\
>  }
>  
>  static const struct iio_chan_spec sc27xx_channels[] = {
> -	SC27XX_ADC_CHANNEL(0),
> -	SC27XX_ADC_CHANNEL(1),
> -	SC27XX_ADC_CHANNEL(2),
> -	SC27XX_ADC_CHANNEL(3),
> -	SC27XX_ADC_CHANNEL(4),
> -	SC27XX_ADC_CHANNEL(5),
> -	SC27XX_ADC_CHANNEL(6),
> -	SC27XX_ADC_CHANNEL(7),
> -	SC27XX_ADC_CHANNEL(8),
> -	SC27XX_ADC_CHANNEL(9),
> -	SC27XX_ADC_CHANNEL(10),
> -	SC27XX_ADC_CHANNEL(11),
> -	SC27XX_ADC_CHANNEL(12),
> -	SC27XX_ADC_CHANNEL(13),
> -	SC27XX_ADC_CHANNEL(14),
> -	SC27XX_ADC_CHANNEL(15),
> -	SC27XX_ADC_CHANNEL(16),
> -	SC27XX_ADC_CHANNEL(17),
> -	SC27XX_ADC_CHANNEL(18),
> -	SC27XX_ADC_CHANNEL(19),
> -	SC27XX_ADC_CHANNEL(20),
> -	SC27XX_ADC_CHANNEL(21),
> -	SC27XX_ADC_CHANNEL(22),
> -	SC27XX_ADC_CHANNEL(23),
> -	SC27XX_ADC_CHANNEL(24),
> -	SC27XX_ADC_CHANNEL(25),
> -	SC27XX_ADC_CHANNEL(26),
> -	SC27XX_ADC_CHANNEL(27),
> -	SC27XX_ADC_CHANNEL(28),
> -	SC27XX_ADC_CHANNEL(29),
> -	SC27XX_ADC_CHANNEL(30),
> -	SC27XX_ADC_CHANNEL(31),
> +	SC27XX_ADC_CHANNEL(0, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(1, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(2, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(3, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(4, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(5, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(6, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(7, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(8, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(9, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(10, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(11, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(12, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(13, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(14, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(15, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(16, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(17, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(18, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(19, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(20, BIT(IIO_CHAN_INFO_RAW)),
> +	SC27XX_ADC_CHANNEL(21, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(22, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(23, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(24, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(25, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(26, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(27, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(28, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(29, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(30, BIT(IIO_CHAN_INFO_PROCESSED)),
> +	SC27XX_ADC_CHANNEL(31, BIT(IIO_CHAN_INFO_PROCESSED)),
>  };
>  
>  static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
> -- 
> 1.7.9.5
> 
