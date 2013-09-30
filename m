Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45554 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab3I3Tz2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2013 15:55:28 -0400
Message-ID: <5249E55B.8040205@kernel.org>
Date: Mon, 30 Sep 2013 21:55:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/18] staging:iio:lis3l02dq: Switch to new event config
 interface
References: <1380200317-19355-1-git-send-email-lars@metafoo.de> <1380200317-19355-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/26/13 13:58, Lars-Peter Clausen wrote:
> Switch the lis3l02dq driver to the new IIO event config interface as the old one
> is going to be removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Hi Lars,

As this one is in staging, lets take advantage of the fact that we now
have the ability to have shared elements.  It's an ABI change so I wouldn't
suggest this for drivers outside staging.

The threshold value is shared by all channels (only one address to write) for each
of the two types.


> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c | 53 ++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index bb852dc..5cd9c45 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -190,14 +190,20 @@ static u8 lis3l02dq_axis_map[3][3] = {
>  };
>  
>  static int lis3l02dq_read_thresh(struct iio_dev *indio_dev,
> -				 u64 e,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir,
> +				 enum iio_event_info info,
>  				 int *val)
>  {
>  	return lis3l02dq_read_reg_s16(indio_dev, LIS3L02DQ_REG_THS_L_ADDR, val);
>  }
>  
>  static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
> -				  u64 event_code,
> +				  const struct iio_chan_spec *chan,
> +				  enum iio_event_type type,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info,
>  				  int val)
>  {
>  	u16 value = val;
> @@ -503,9 +509,19 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -#define LIS3L02DQ_EVENT_MASK					\
> -	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
> -	 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
> +static const struct iio_event_spec lis3l02dq_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	}
> +};
>  
>  #define LIS3L02DQ_CHAN(index, mod)				\
>  	{							\
> @@ -523,7 +539,8 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			.realbits = 12,				\
>  			.storagebits = 16,			\
>  		},						\
> -		.event_mask = LIS3L02DQ_EVENT_MASK,		\
> +		.event_spec = lis3l02dq_event,			\
> +		.num_event_specs = ARRAY_SIZE(lis3l02dq_event),	\
>  	 }
>  
>  static const struct iio_chan_spec lis3l02dq_channels[] = {
> @@ -535,14 +552,14 @@ static const struct iio_chan_spec lis3l02dq_channels[] = {
>  
>  
>  static int lis3l02dq_read_event_config(struct iio_dev *indio_dev,
> -					   u64 event_code)
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir)
>  {
>  
>  	u8 val;
>  	int ret;
> -	u8 mask = (1 << (IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code)*2 +
> -			 (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
> -			  IIO_EV_DIR_RISING)));
> +	u8 mask = (1 << (chan->channel2*2 + (dir == IIO_EV_DIR_RISING)));
>  	ret = lis3l02dq_spi_read_reg_8(indio_dev,
>  				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
>  				       &val);
> @@ -587,16 +604,16 @@ error_ret:
>  }
>  
>  static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
> -					u64 event_code,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
>  					int state)
>  {
>  	int ret = 0;
>  	u8 val, control;
>  	u8 currentlyset;
>  	bool changed = false;
> -	u8 mask = (1 << (IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code)*2 +
> -			 (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
> -			  IIO_EV_DIR_RISING)));
> +	u8 mask = (1 << (chan->channel2*2 + (dir == IIO_EV_DIR_RISING)));
>  
>  	mutex_lock(&indio_dev->mlock);
>  	/* read current control */
> @@ -654,10 +671,10 @@ static const struct attribute_group lis3l02dq_attribute_group = {
>  static const struct iio_info lis3l02dq_info = {
>  	.read_raw = &lis3l02dq_read_raw,
>  	.write_raw = &lis3l02dq_write_raw,
> -	.read_event_value = &lis3l02dq_read_thresh,
> -	.write_event_value = &lis3l02dq_write_thresh,
> -	.write_event_config = &lis3l02dq_write_event_config,
> -	.read_event_config = &lis3l02dq_read_event_config,
> +	.read_event_value_new = &lis3l02dq_read_thresh,
> +	.write_event_value_new = &lis3l02dq_write_thresh,
> +	.write_event_config_new = &lis3l02dq_write_event_config,
> +	.read_event_config_new = &lis3l02dq_read_event_config,
>  	.driver_module = THIS_MODULE,
>  	.attrs = &lis3l02dq_attribute_group,
>  };
> 
