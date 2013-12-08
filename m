Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33292 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3LHNMu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Dec 2013 08:12:50 -0500
Message-ID: <52A4704F.905@kernel.org>
Date: Sun, 08 Dec 2013 13:12:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 1/2] iio:cm36651: Convert to new event config interface
References: <1386413120-13289-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1386413120-13289-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/07/13 10:45, Lars-Peter Clausen wrote:
> Switch the cm36651 driver to the new IIO event config interface as the old one
> is going to be removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Beomho Seo <beomho.seo@samsung.com>
Applied to the togreg branch of iio.git (initially pushed out as the testing
branch until build tests are complete).

Thanks for clearing this one up.  For reference of others, Lars' original
patch set crossed with this driver.

Beomho, if you want to add an ack or tested by then there is probably a day
or two before I'll get around to sending this on togreg.

Jonathan
> ---
>  drivers/iio/light/cm36651.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 21df571..2a0eb8d 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -488,7 +488,11 @@ static int cm36651_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
> -					u64 event_code, int *val)
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					enum iio_event_info info,
> +					int *val, int *val2)
>  {
>  	struct cm36651_data *cm36651 = iio_priv(indio_dev);
>  
> @@ -498,7 +502,11 @@ static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
>  }
>  
>  static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
> -					u64 event_code, int val)
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					enum iio_event_info info,
> +					int val, int val2)
>  {
>  	struct cm36651_data *cm36651 = iio_priv(indio_dev);
>  	struct i2c_client *client = cm36651->client;
> @@ -520,7 +528,10 @@ static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
>  }
>  
>  static int cm36651_write_prox_event_config(struct iio_dev *indio_dev,
> -					u64 event_code, int state)
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					int state)
>  {
>  	struct cm36651_data *cm36651 = iio_priv(indio_dev);
>  	int cmd, ret = -EINVAL;
> @@ -536,7 +547,9 @@ static int cm36651_write_prox_event_config(struct iio_dev *indio_dev,
>  }
>  
>  static int cm36651_read_prox_event_config(struct iio_dev *indio_dev,
> -							u64 event_code)
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir)
>  {
>  	struct cm36651_data *cm36651 = iio_priv(indio_dev);
>  	int event_en;
> @@ -559,12 +572,22 @@ static int cm36651_read_prox_event_config(struct iio_dev *indio_dev,
>  	.channel2 = IIO_MOD_LIGHT_##_color,		\
>  }							\
>  
> +static const struct iio_event_spec cm36651_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				BIT(IIO_EV_INFO_ENABLE),
> +	}
> +};
> +
>  static const struct iio_chan_spec cm36651_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_INT_TIME),
> -		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER)
> +		.event_spec = cm36651_event_spec,
> +		.num_event_specs = ARRAY_SIZE(cm36651_event_spec),
>  	},
>  	CM36651_LIGHT_CHANNEL(RED, CM36651_LIGHT_CHANNEL_IDX_RED),
>  	CM36651_LIGHT_CHANNEL(GREEN, CM36651_LIGHT_CHANNEL_IDX_GREEN),
> @@ -591,10 +614,10 @@ static const struct iio_info cm36651_info = {
>  	.driver_module		= THIS_MODULE,
>  	.read_raw		= &cm36651_read_raw,
>  	.write_raw		= &cm36651_write_raw,
> -	.read_event_value	= &cm36651_read_prox_thresh,
> -	.write_event_value	= &cm36651_write_prox_thresh,
> -	.read_event_config	= &cm36651_read_prox_event_config,
> -	.write_event_config	= &cm36651_write_prox_event_config,
> +	.read_event_value_new	= &cm36651_read_prox_thresh,
> +	.write_event_value_new	= &cm36651_write_prox_thresh,
> +	.read_event_config_new	= &cm36651_read_prox_event_config,
> +	.write_event_config_new	= &cm36651_write_prox_event_config,
>  	.attrs			= &cm36651_attribute_group,
>  };
>  
> 
