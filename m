Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37636 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbdDHPJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 11:09:12 -0400
Subject: Re: [PATCH v2 5/7] iio: light: rpr0521 channel numbers reordered
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0de3b366-5d48-bbd0-b6c2-f8a995a4b06e@kernel.org>
Date: Sat, 8 Apr 2017 16:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <1491566839-3925-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/17 13:07, Mikko Koivunen wrote:
> Moved proximity channel from last to first in structs to avoid confusion
> later with buffered triggers. Proximity data output is first in rpr0521
> register map.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Doesn't result in any ABI change that I can see so fine by me if
it makes your code a bit simpler.
> ---
>  drivers/iio/light/rpr0521.c |   41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 35c759b..dc522fd 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -80,9 +80,9 @@ static const struct rpr0521_gain rpr0521_pxs_gain[3] = {
>  };
>  
>  enum rpr0521_channel {
> +	RPR0521_CHAN_PXS,
>  	RPR0521_CHAN_ALS_DATA0,
>  	RPR0521_CHAN_ALS_DATA1,
> -	RPR0521_CHAN_PXS,
>  };
>  
>  struct rpr0521_reg_desc {
> @@ -91,6 +91,10 @@ struct rpr0521_reg_desc {
>  };
>  
>  static const struct rpr0521_reg_desc rpr0521_data_reg[] = {
> +	[RPR0521_CHAN_PXS]	= {
> +		.address	= RPR0521_REG_PXS_DATA,
> +		.device_mask	= RPR0521_MODE_PXS_MASK,
> +	},
>  	[RPR0521_CHAN_ALS_DATA0] = {
>  		.address	= RPR0521_REG_ALS_DATA0,
>  		.device_mask	= RPR0521_MODE_ALS_MASK,
> @@ -99,10 +103,6 @@ static const struct rpr0521_reg_desc rpr0521_data_reg[] = {
>  		.address	= RPR0521_REG_ALS_DATA1,
>  		.device_mask	= RPR0521_MODE_ALS_MASK,
>  	},
> -	[RPR0521_CHAN_PXS]	= {
> -		.address	= RPR0521_REG_PXS_DATA,
> -		.device_mask	= RPR0521_MODE_PXS_MASK,
> -	},
>  };
>  
>  static const struct rpr0521_gain_info {
> @@ -112,6 +112,13 @@ static const struct rpr0521_gain_info {
>  	const struct rpr0521_gain *gain;
>  	int size;
>  } rpr0521_gain[] = {
> +	[RPR0521_CHAN_PXS] = {
> +		.reg	= RPR0521_REG_PXS_CTRL,
> +		.mask	= RPR0521_PXS_GAIN_MASK,
> +		.shift	= RPR0521_PXS_GAIN_SHIFT,
> +		.gain	= rpr0521_pxs_gain,
> +		.size	= ARRAY_SIZE(rpr0521_pxs_gain),
> +	},
>  	[RPR0521_CHAN_ALS_DATA0] = {
>  		.reg	= RPR0521_REG_ALS_CTRL,
>  		.mask	= RPR0521_ALS_DATA0_GAIN_MASK,
> @@ -126,13 +133,6 @@ static const struct rpr0521_gain_info {
>  		.gain	= rpr0521_als_gain,
>  		.size	= ARRAY_SIZE(rpr0521_als_gain),
>  	},
> -	[RPR0521_CHAN_PXS] = {
> -		.reg	= RPR0521_REG_PXS_CTRL,
> -		.mask	= RPR0521_PXS_GAIN_MASK,
> -		.shift	= RPR0521_PXS_GAIN_SHIFT,
> -		.gain	= rpr0521_pxs_gain,
> -		.size	= ARRAY_SIZE(rpr0521_pxs_gain),
> -	},
>  };
>  
>  struct rpr0521_samp_freq {
> @@ -197,6 +197,14 @@ static const struct attribute_group rpr0521_attribute_group = {
>  
>  static const struct iio_chan_spec rpr0521_channels[] = {
>  	{
> +		.type = IIO_PROXIMITY,
> +		.address = RPR0521_CHAN_PXS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	},
> +	{
>  		.type = IIO_INTENSITY,
>  		.modified = 1,
>  		.address = RPR0521_CHAN_ALS_DATA0,
> @@ -214,15 +222,6 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
> -	{
> -		.type = IIO_PROXIMITY,
> -		.address = RPR0521_CHAN_PXS,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	}
>  };
>  
>  static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
> 

