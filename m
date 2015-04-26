Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbDZRXR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 13:23:17 -0400
Message-ID: <553D1F03.3010708@kernel.org>
Date: Sun, 26 Apr 2015 18:23:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 4/4] iio: magn: bmc150_magn: add oversampling ratio
References: <1429814048-22808-1-git-send-email-irina.tirdea@intel.com> <1429814048-22808-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1429814048-22808-5-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/04/15 19:34, Irina Tirdea wrote:
> Export the oversampling ratio so that the user can change the
> number of repetions for x/y/z axis.
> 
> The sampling frequency is limited by the oversampling ratio.
> The available sampling frequencies might change depending
> on the values of oversampling_ratio.
> 
> The specification can be downloaded from:
> http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Also looks good to me.   As it's new ABI I'm keen to let this sit
a while longer and see if anyone objects (doubt they will, but you never
know).

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 133 ++++++++++++++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index b8e4c90..c3f9447 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -146,6 +146,7 @@ struct bmc150_magn_data {
>  	s32 buffer[6];
>  	struct iio_trigger *dready_trig;
>  	bool dready_trigger_on;
> +	int max_odr;
>  };
>  
>  static const struct {
> @@ -323,6 +324,43 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
>  	return -EINVAL;
>  }
>  
> +static int bmc150_magn_set_max_odr(struct bmc150_magn_data *data, int rep_xy,
> +				   int rep_z, int odr)
> +{
> +	int ret, reg_val, max_odr;
> +
> +	if (rep_xy <= 0) {
> +		ret = regmap_read(data->regmap, BMC150_MAGN_REG_REP_XY,
> +				  &reg_val);
> +		if (ret < 0)
> +			return ret;
> +		rep_xy = BMC150_MAGN_REGVAL_TO_REPXY(reg_val);
> +	}
> +	if (rep_z <= 0) {
> +		ret = regmap_read(data->regmap, BMC150_MAGN_REG_REP_Z,
> +				  &reg_val);
> +		if (ret < 0)
> +			return ret;
> +		rep_z = BMC150_MAGN_REGVAL_TO_REPZ(reg_val);
> +	}
> +	if (odr <= 0) {
> +		ret = bmc150_magn_get_odr(data, &odr);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	/* the maximum selectable read-out frequency from datasheet */
> +	max_odr = 1000000 / (145 * rep_xy + 500 * rep_z + 980);
> +	if (odr > max_odr) {
> +		dev_err(&data->client->dev,
> +			"Can't set oversampling with sampling freq %d\n",
> +			odr);
> +		return -EINVAL;
> +	}
> +	data->max_odr = max_odr;
> +
> +	return 0;
> +}
> +
>  static s32 bmc150_magn_compensate_x(struct bmc150_magn_trim_regs *tregs, s16 x,
>  				    u16 rhall)
>  {
> @@ -422,7 +460,7 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -	int ret;
> +	int ret, tmp;
>  	s32 values[AXIS_XYZ_MAX];
>  
>  	switch (mask) {
> @@ -467,6 +505,26 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +		case IIO_MOD_Y:
> +			ret = regmap_read(data->regmap, BMC150_MAGN_REG_REP_XY,
> +					  &tmp);
> +			if (ret < 0)
> +				return ret;
> +			*val = BMC150_MAGN_REGVAL_TO_REPXY(tmp);
> +			return IIO_VAL_INT;
> +		case IIO_MOD_Z:
> +			ret = regmap_read(data->regmap, BMC150_MAGN_REG_REP_Z,
> +					  &tmp);
> +			if (ret < 0)
> +				return ret;
> +			*val = BMC150_MAGN_REGVAL_TO_REPZ(tmp);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -481,10 +539,50 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val > data->max_odr)
> +			return -EINVAL;
>  		mutex_lock(&data->mutex);
>  		ret = bmc150_magn_set_odr(data, val);
>  		mutex_unlock(&data->mutex);
>  		return ret;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +		case IIO_MOD_Y:
> +			if (val < 1 || val > 511)
> +				return -EINVAL;
> +			mutex_lock(&data->mutex);
> +			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
> +			if (ret < 0) {
> +				mutex_unlock(&data->mutex);
> +				return ret;
> +			}
> +			ret = regmap_update_bits(data->regmap,
> +						 BMC150_MAGN_REG_REP_XY,
> +						 0xFF,
> +						 BMC150_MAGN_REPXY_TO_REGVAL
> +						 (val));
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		case IIO_MOD_Z:
> +			if (val < 1 || val > 256)
> +				return -EINVAL;
> +			mutex_lock(&data->mutex);
> +			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
> +			if (ret < 0) {
> +				mutex_unlock(&data->mutex);
> +				return ret;
> +			}
> +			ret = regmap_update_bits(data->regmap,
> +						 BMC150_MAGN_REG_REP_Z,
> +						 0xFF,
> +						 BMC150_MAGN_REPZ_TO_REGVAL
> +						 (val));
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -501,10 +599,31 @@ static int bmc150_magn_validate_trigger(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("2 6 8 10 15 20 25 30");
> +static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmc150_magn_data *data = iio_priv(indio_dev);
> +	size_t len = 0;
> +	u8 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
> +		if (bmc150_magn_samp_freq_table[i].freq > data->max_odr)
> +			break;
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +				 bmc150_magn_samp_freq_table[i].freq);
> +	}
> +	/* replace last space with a newline */
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
>  
>  static struct attribute *bmc150_magn_attributes[] = {
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -516,7 +635,8 @@ static const struct attribute_group bmc150_magn_attrs_group = {
>  	.type = IIO_MAGN,						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##_axis,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
>  				    BIT(IIO_CHAN_INFO_SCALE),		\
>  	.scan_index = AXIS_##_axis,					\
> @@ -617,6 +737,11 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
>  		goto err_poweroff;
>  	}
>  
> +	ret = bmc150_magn_set_max_odr(data, preset.rep_xy, preset.rep_z,
> +				      preset.odr);
> +	if (ret < 0)
> +		goto err_poweroff;
> +
>  	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
>  					 true);
>  	if (ret < 0) {
> 

