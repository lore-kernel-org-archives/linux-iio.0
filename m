Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57672 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756738AbdEGWbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:31:02 -0400
Subject: Re: [PATCH v3 8/9] iio: light: rpr0521 channel numbers reordered
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@intel.com>,
        linux-iio@vger.kernel.org
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-8-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bbc90ea4-d0d0-bd84-0c79-366559717f3e@kernel.org>
Date: Sun, 7 May 2017 12:54:58 +0100
MIME-Version: 1.0
In-Reply-To: <1493983193-8753-8-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 12:19, Mikko Koivunen wrote:
> Move proximity channel from last to first in structs to avoid confusion
> later with buffered triggers. Proximity data output is first in rpr0521
> register map.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> ---
>  drivers/iio/light/rpr0521.c |   40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 41b3023..2dc5e38 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -78,9 +78,9 @@ static const struct rpr0521_gain rpr0521_pxs_gain[3] = {
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
> @@ -89,6 +89,10 @@ struct rpr0521_reg_desc {
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
> @@ -97,10 +101,6 @@ static const struct rpr0521_reg_desc rpr0521_data_reg[] = {
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
> @@ -110,6 +110,13 @@ static const struct rpr0521_gain_info {
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
> @@ -124,13 +131,6 @@ static const struct rpr0521_gain_info {
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
> @@ -198,6 +198,14 @@ static const struct attribute_group rpr0521_attribute_group = {
>  
>  static const struct iio_chan_spec rpr0521_channels[] = {
Hmm. ordering here matters not in the slightest.  Still I guess
it makes sense to change it for consistency if nothing else so
fair enough.
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
> @@ -215,14 +223,6 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
> -	{
> -		.type = IIO_PROXIMITY,
> -		.address = RPR0521_CHAN_PXS,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	}
>  };
>  
>  static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
> 

