Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55037 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaBHOik (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 09:38:40 -0500
From: Marek Vasut <marex@denx.de>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [RFC] iio: mxs-lradc: Add support for current source
Date: Sat, 8 Feb 2014 15:38:32 +0100
Cc: linux-iio@vger.kernel.org
References: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201402081538.32202.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday, January 28, 2014 at 02:52:30 PM, Harald Geyer wrote:
> We pretend the current source to be an independent 4-bit DAC,
> which seems to be a valid use of the device. The channel also
> allows reading back the value previously written.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> The LRADC can drive two of its ADC channels with a defined current
> between 0 and 300uA to allow reading thermistors without external
> current source. I'm not sure what the right IIO ABI in this case
> should be. The way it is done now has the advantage that no new
> ABI is needed and somebody might actually use the device as very
> low resolution DAC. OTOH the relationship between output and input
> channels is a bit non obvious this way.
> 
> Also note, that I didn't find any documentation about the expected
> current unit in iio. I think uA is a reasonable choice, but this
> should be confirmed and documented at least.
> 
> Harald
> 
>  drivers/staging/iio/adc/mxs-lradc.c |   80
> +++++++++++++++++++++++++++++++++++ 1 files changed, 80 insertions(+), 0
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index df71669..48b1ed7 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -303,6 +303,11 @@ struct mxs_lradc {
>  #define	LRADC_CTRL2				0x20
>  #define	LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
>  #define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
> +#define	LRADC_CTRL2_TEMP_SENSOR_IENABLE1	(1 << 9)
> +#define	LRADC_CTRL2_TEMP_SENSOR_IENABLE0	(1 << 8)
> +#define	LRADC_CTRL2_TEMP_ISRC1_OFFSET		4
> +#define	LRADC_CTRL2_TEMP_ISRC0_OFFSET		0
> +#define	LRADC_CTRL2_TEMP_ISRC_MASK		(0x0f)
> 
>  #define	LRADC_STATUS				0x40
>  #define	LRADC_STATUS_TOUCH_DETECT_RAW		(1 << 0)
> @@ -891,6 +896,31 @@ static int mxs_lradc_read_temp(struct iio_dev
> *iio_dev, int *val) return IIO_VAL_INT;
>  }
> 
> +static int mxs_lradc_read_current(struct mxs_lradc *lradc,
> +			const struct iio_chan_spec *chan, int *val)
> +{
> +	*val = 0;
> +	if (chan->channel == 0) {
> +		if ((readl(lradc->base + LRADC_CTRL2) &
> +					LRADC_CTRL2_TEMP_SENSOR_IENABLE0) == 0)
> +			return IIO_VAL_INT;
> +		*val = (readl(lradc->base + LRADC_CTRL2) >>
> +					 LRADC_CTRL2_TEMP_ISRC0_OFFSET) &
> +				LRADC_CTRL2_TEMP_ISRC_MASK;
> +	} else if (chan->channel == 1) {
> +		if ((readl(lradc->base + LRADC_CTRL2) &
> +					LRADC_CTRL2_TEMP_SENSOR_IENABLE1) == 0)
> +			return IIO_VAL_INT;
> +		*val = (readl(lradc->base + LRADC_CTRL2) >>
> +					LRADC_CTRL2_TEMP_ISRC1_OFFSET) &
> +				LRADC_CTRL2_TEMP_ISRC_MASK;

You can use parametrized macros here, lik LRADC_CTRL2_TEMP_ISRCn_OFFSET(n) , 
that way you'd trim down the code duplication here nicely. DTTO for the other 
large chunk of code down below.

[...]
