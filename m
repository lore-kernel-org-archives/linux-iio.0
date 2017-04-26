Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58010 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953990AbdDZFaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 01:30:22 -0400
Subject: Re: [PATCH v3 1/2] staging: iio: isl29028: correct proximity sleep
 times
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
References: <20170425013434.1206-1-masneyb@onstation.org>
 <20170425013434.1206-2-masneyb@onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f09b0e66-48ef-8e46-b8ea-b379464c5bfd@kernel.org>
Date: Wed, 26 Apr 2017 06:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170425013434.1206-2-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/17 02:34, Brian Masney wrote:
> The sysfs attribute in_proximity_sampling_frequency_available currently
> shows the values 1 3 5 10 13 20 83 100. These values are supposed to
> correspond to the sleep values 800 400 200 100 75 50 12.5 0 (all in ms).
> When passing in a sampling frequency of 3, it actually uses a sleep
> time of 200ms instead of the expected 400ms value. This patch changes
> the value shown by this sysfs attribute to use fixed-point numbers so
> that the correct sampling frequency is shown to the user. This patch
> also changes the code that updates the proximity sampling frequency to
> only allow values that are shown in the _available sysfs attribute.
> 
> The original code showed the value 83 that corresponds to the sleep
> time 12 ms. The data sheet actually lists 12.5 ms as the sleep time,
> so the proximity frequency was updated to 80.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 70 +++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 5375e7a..aeb5082 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -64,8 +64,25 @@
>  
>  #define ISL29028_POWER_OFF_DELAY_MS		2000
>  
> -static const unsigned int isl29028_prox_sleep_time[] = {800, 400, 200, 100, 75,
> -							50, 12, 0};
> +struct isl29028_prox_data {
> +	int sampling_int;
> +	int sampling_fract;
> +	int sleep_time;
> +};
> +
> +static const struct isl29028_prox_data isl29028_prox_data[] = {
> +	{   1, 250000, 800 },
> +	{   2, 500000, 400 },
> +	{   5,      0, 200 },
> +	{  10,      0, 100 },
> +	{  13, 300000,  75 },
> +	{  20,      0,  50 },
> +	{  80,      0,  13 }, /*
> +			       * Note: Data sheet lists 12.5 ms sleep time.
> +			       * Round up a half millisecond for msleep().
> +			       */
> +	{ 100,  0,   0 }
> +};
>  
>  enum isl29028_als_ir_mode {
>  	ISL29028_MODE_NONE = 0,
> @@ -76,32 +93,37 @@ enum isl29028_als_ir_mode {
>  struct isl29028_chip {
>  	struct mutex			lock;
>  	struct regmap			*regmap;
> -	unsigned int			prox_sampling;
> +	int				prox_sampling_int;
> +	int				prox_sampling_frac;
>  	bool				enable_prox;
>  	int				lux_scale;
>  	enum isl29028_als_ir_mode	als_ir_mode;
>  };
>  
> -static int isl29028_find_prox_sleep_time_index(int sampling)
> +static int isl29028_find_prox_sleep_index(int sampling_int, int sampling_fract)
>  {
> -	unsigned int period = DIV_ROUND_UP(1000, sampling);
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(isl29028_prox_sleep_time); ++i) {
> -		if (period >= isl29028_prox_sleep_time[i])
> -			break;
> +	for (i = 0; i < ARRAY_SIZE(isl29028_prox_data); ++i) {
> +		if (isl29028_prox_data[i].sampling_int == sampling_int &&
> +		    isl29028_prox_data[i].sampling_fract == sampling_fract)
> +			return i;
>  	}
>  
> -	return i;
> +	return -EINVAL;
>  }
>  
>  static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
> -					unsigned int sampling)
> +					int sampling_int, int sampling_fract)
>  {
>  	struct device *dev = regmap_get_device(chip->regmap);
>  	int sleep_index, ret;
>  
> -	sleep_index = isl29028_find_prox_sleep_time_index(sampling);
> +	sleep_index = isl29028_find_prox_sleep_index(sampling_int,
> +						     sampling_fract);
> +	if (sleep_index < 0)
> +		return sleep_index;
> +
>  	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  				 ISL29028_CONF_PROX_SLP_MASK,
>  				 sleep_index << ISL29028_CONF_PROX_SLP_SH);
> @@ -112,16 +134,18 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
>  		return ret;
>  	}
>  
> -	chip->prox_sampling = sampling;
> +	chip->prox_sampling_int = sampling_int;
> +	chip->prox_sampling_frac = sampling_fract;
>  
>  	return ret;
>  }
>  
>  static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  {
> -	int sleep_index, ret;
> +	int prox_index, ret;
>  
> -	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
> +	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling_int,
> +					   chip->prox_sampling_frac);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -132,8 +156,12 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  		return ret;
>  
>  	/* Wait for conversion to be complete for first sample */
> -	sleep_index = isl29028_find_prox_sleep_time_index(chip->prox_sampling);
> -	msleep(isl29028_prox_sleep_time[sleep_index]);
> +	prox_index = isl29028_find_prox_sleep_index(chip->prox_sampling_int,
> +						    chip->prox_sampling_frac);
> +	if (prox_index < 0)
> +		return prox_index;
> +
> +	msleep(isl29028_prox_data[prox_index].sleep_time);
>  
>  	return 0;
>  }
> @@ -361,7 +389,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		ret = isl29028_set_proxim_sampling(chip, val);
> +		ret = isl29028_set_proxim_sampling(chip, val, val2);
>  		break;
>  	case IIO_LIGHT:
>  		if (mask != IIO_CHAN_INFO_SCALE) {
> @@ -439,7 +467,8 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_PROXIMITY)
>  			break;
>  
> -		*val = chip->prox_sampling;
> +		*val = chip->prox_sampling_int;
> +		*val2 = chip->prox_sampling_frac;
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> @@ -472,7 +501,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> -				"1 3 5 10 13 20 83 100");
> +				"1.25 2.5 5 10 13.3 20 80 100");
>  static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
>  
>  #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
> @@ -571,7 +600,8 @@ static int isl29028_probe(struct i2c_client *client,
>  	}
>  
>  	chip->enable_prox  = false;
> -	chip->prox_sampling = 20;
> +	chip->prox_sampling_int = 20;
> +	chip->prox_sampling_frac = 0;
>  	chip->lux_scale = 2000;
>  
>  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
> 

