Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52988 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3BCMMr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 07:12:47 -0500
Message-ID: <510E543D.50201@kernel.org>
Date: Sun, 03 Feb 2013 12:12:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 2/4] iio/adc: (max1363) Add support for external reference
 voltage
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net> <1359853180-5664-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359853180-5664-3-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/2013 12:59 AM, Guenter Roeck wrote:
> Implement external reference voltage as regulator named "vref".
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of iio.git.
Thanks,

The remaining two patches will have sit a while.
Patch 3 effects stuff outside IIO so I'll wait to see if anyone
screams that it is going to cause merge nightmares!

Patch 4 is clearly still under discussion though a consensus seems
to have more or less been reached.

Thanks again for this work Guenter. I like the way one of my oldest
drivers is getting cleaned up along the way without me having to
do anything much ;)

> ---
> v2: Use regulator API to specify vref instead of creating new devicetree
>     bindings.
>     Keep reference voltage internally in uV, as this is the scale provided
>     by the regulator subsystem. We need the value in uV anyway, so that does
>     make some sense.
> 
>  drivers/iio/adc/max1363.c |   52 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 1353fda..cac73d7 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -163,6 +163,8 @@ struct max1363_chip_info {
>   * @mask_low:		bitmask for enabled low thresholds
>   * @thresh_high:	high threshold values
>   * @thresh_low:		low threshold values
> + * @vref:		Reference voltage regulator
> + * @vref_uv:		Actual (external or internal) reference voltage
>   */
>  struct max1363_state {
>  	struct i2c_client		*client;
> @@ -182,6 +184,8 @@ struct max1363_state {
>  	/* 4x unipolar first then the fours bipolar ones */
>  	s16				thresh_high[8];
>  	s16				thresh_low[8];
> +	struct regulator		*vref;
> +	u32				vref_uv;
>  };
>  
>  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> @@ -393,6 +397,8 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	int ret;
> +	unsigned long scale_uv;
> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = max1363_read_single_chan(indio_dev, chan, val, m);
> @@ -400,16 +406,10 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if ((1 << (st->chip_info->bits + 1)) >
> -		    st->chip_info->int_vref_mv) {
> -			*val = 0;
> -			*val2 = 500000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		} else {
> -			*val = (st->chip_info->int_vref_mv)
> -				>> st->chip_info->bits;
> -			return IIO_VAL_INT;
> -		}
> +		scale_uv = st->vref_uv >> st->chip_info->bits;
> +		*val = scale_uv / 1000;
> +		*val2 = (scale_uv % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1390,12 +1390,16 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  
>  static int max1363_initial_setup(struct max1363_state *st)
>  {
> -	st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
> -		| MAX1363_SETUP_POWER_UP_INT_REF
> -		| MAX1363_SETUP_INT_CLOCK
> +	st->setupbyte = MAX1363_SETUP_INT_CLOCK
>  		| MAX1363_SETUP_UNIPOLAR
>  		| MAX1363_SETUP_NORESET;
>  
> +	if (st->vref)
> +		st->setupbyte |= MAX1363_SETUP_AIN3_IS_REF_EXT_TO_REF;
> +	else
> +		st->setupbyte |= MAX1363_SETUP_POWER_UP_INT_REF
> +		  | MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_INT;
> +
>  	/* Set scan mode writes the config anyway so wait until then */
>  	st->setupbyte = MAX1363_SETUP_BYTE(st->setupbyte);
>  	st->current_mode = &max1363_mode_table[st->chip_info->default_mode];
> @@ -1533,6 +1537,7 @@ static int max1363_probe(struct i2c_client *client,
>  	int ret;
>  	struct max1363_state *st;
>  	struct iio_dev *indio_dev;
> +	struct regulator *vref;
>  
>  	indio_dev = iio_device_alloc(sizeof(struct max1363_state));
>  	if (indio_dev == NULL) {
> @@ -1563,6 +1568,23 @@ static int max1363_probe(struct i2c_client *client,
>  	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
>  	st->client = client;
>  
> +	st->vref_uv = st->chip_info->int_vref_mv * 1000;
> +	vref = devm_regulator_get(&client->dev, "vref");
> +	if (!IS_ERR(vref)) {
> +		int vref_uv;
> +
> +		ret = regulator_enable(vref);
> +		if (ret)
> +			goto error_disable_reg;
> +		st->vref = vref;
> +		vref_uv = regulator_get_voltage(vref);
> +		if (vref_uv <= 0) {
> +			ret = -EINVAL;
> +			goto error_disable_reg;
> +		}
> +		st->vref_uv = vref_uv;
> +	}
> +
>  	ret = max1363_alloc_scan_masks(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
> @@ -1604,6 +1626,8 @@ static int max1363_probe(struct i2c_client *client,
>  error_uninit_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_reg:
> +	if (st->vref)
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  error_unregister_map:
>  	iio_map_array_unregister(indio_dev);
> @@ -1620,6 +1644,8 @@ static int max1363_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	if (st->vref)
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  	iio_map_array_unregister(indio_dev);
>  	iio_device_free(indio_dev);
> 
