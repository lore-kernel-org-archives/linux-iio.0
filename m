Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42845 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424AbcDYTcB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 15:32:01 -0400
Subject: Re: [PATCH] iio: bmg160: add callbacks for the filter frequency
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
References: <1461235740-18710-1-git-send-email-s.trumtrar@pengutronix.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <59d35d82-8ca8-646b-8629-c2bba666286b@kernel.org>
Date: Mon, 25 Apr 2016 20:31:58 +0100
MIME-Version: 1.0
In-Reply-To: <1461235740-18710-1-git-send-email-s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/04/16 11:49, Steffen Trumtrar wrote:
> The filter frequency and sample rate have a fixed relationship.
> Only the filter frequency is unique, however.
> Currently the driver ignores the filter settings for 32 Hz and
> 64 Hz.
> 
> This patch adds the necessary callbacks to be able to configure
> and read the filter setting from sysfs.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

cc'd Srinivas as it's his driver...  Looks superficially fine to me.

Jonathan
> ---
> 
> Changing the sample rate will result in using the first match
> and therefore selecting the filter accordingly. Is this a misuse
> of the ABI and should be handled differently or is this okay?
> 
>  drivers/iio/gyro/bmg160_core.c | 105 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 93 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index bbce3b09ac45..ea0243eb393a 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -52,6 +52,7 @@
>  #define BMG160_REG_PMU_BW		0x10
>  #define BMG160_NO_FILTER		0
>  #define BMG160_DEF_BW			100
> +#define BMG160_REG_PMU_BW_RES		BIT(7)
>  
>  #define BMG160_REG_INT_MAP_0		0x17
>  #define BMG160_INT_MAP_0_BIT_ANY	BIT(1)
> @@ -103,7 +104,6 @@ struct bmg160_data {
>  	struct iio_trigger *motion_trig;
>  	struct mutex mutex;
>  	s16 buffer[8];
> -	u8 bw_bits;
>  	u32 dps_range;
>  	int ev_enable_state;
>  	int slope_thres;
> @@ -119,13 +119,16 @@ enum bmg160_axis {
>  };
>  
>  static const struct {
> -	int val;
> +	int odr;
> +	int filter;
>  	int bw_bits;
> -} bmg160_samp_freq_table[] = { {100, 0x07},
> -			       {200, 0x06},
> -			       {400, 0x03},
> -			       {1000, 0x02},
> -			       {2000, 0x01} };
> +} bmg160_samp_freq_table[] = { {100, 32, 0x07},
> +			       {200, 64, 0x06},
> +			       {100, 12, 0x05},
> +			       {200, 23, 0x04},
> +			       {400, 47, 0x03},
> +			       {1000, 116, 0x02},
> +			       {2000, 230, 0x01} };
>  
>  static const struct {
>  	int scale;
> @@ -154,7 +157,7 @@ static int bmg160_convert_freq_to_bit(int val)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> -		if (bmg160_samp_freq_table[i].val == val)
> +		if (bmg160_samp_freq_table[i].odr == val)
>  			return bmg160_samp_freq_table[i].bw_bits;
>  	}
>  
> @@ -176,7 +179,51 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
>  		return ret;
>  	}
>  
> -	data->bw_bits = bw_bits;
> +	return 0;
> +}
> +
> +static int bmg160_get_filter(struct bmg160_data *data, int *val)
> +{
> +	int ret;
> +	int i;
> +	unsigned int bw_bits;
> +
> +	ret = regmap_read(data->regmap, BMG160_REG_PMU_BW, &bw_bits);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Error reading reg_pmu_bw\n");
> +		return ret;
> +	}
> +
> +	/* Ignore the readonly reserved bit. */
> +	bw_bits &= ~BMG160_REG_PMU_BW_RES;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> +		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
> +			break;
> +	}
> +
> +	*val = bmg160_samp_freq_table[i].filter;
> +
> +	return ret ? ret : IIO_VAL_INT;
> +}
> +
> +
> +static int bmg160_set_filter(struct bmg160_data *data, int val)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> +		if (bmg160_samp_freq_table[i].filter == val)
> +			break;
> +	}
> +
> +	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
> +			   bmg160_samp_freq_table[i].bw_bits);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Error writing reg_pmu_bw\n");
> +		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -388,10 +435,21 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
>  static int bmg160_get_bw(struct bmg160_data *data, int *val)
>  {
>  	int i;
> +	unsigned int bw_bits;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, BMG160_REG_PMU_BW, &bw_bits);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Error reading reg_pmu_bw\n");
> +		return ret;
> +	}
> +
> +	/* Ignore the readonly reserved bit. */
> +	bw_bits &= ~BMG160_REG_PMU_BW_RES;
>  
>  	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> -		if (bmg160_samp_freq_table[i].bw_bits == data->bw_bits) {
> -			*val = bmg160_samp_freq_table[i].val;
> +		if (bmg160_samp_freq_table[i].bw_bits == bw_bits) {
> +			*val = bmg160_samp_freq_table[i].odr;
>  			return IIO_VAL_INT;
>  		}
>  	}
> @@ -506,6 +564,8 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT;
>  		} else
>  			return -EINVAL;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return bmg160_get_filter(data, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		switch (chan->type) {
> @@ -570,6 +630,26 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
>  		ret = bmg160_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);
>  		return ret;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (val2)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->mutex);
> +		ret = bmg160_set_power_state(data, true);
> +		if (ret < 0) {
> +			bmg160_set_power_state(data, false);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +		ret = bmg160_set_filter(data, val);
> +		if (ret < 0) {
> +			bmg160_set_power_state(data, false);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +		ret = bmg160_set_power_state(data, false);
> +		mutex_unlock(&data->mutex);
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (val)
>  			return -EINVAL;
> @@ -727,7 +807,8 @@ static const struct iio_event_spec bmg160_event = {
>  	.channel2 = IIO_MOD_##_axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> -				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
>  	.scan_index = AXIS_##_axis,					\
>  	.scan_type = {							\
>  		.sign = 's',						\
> 

