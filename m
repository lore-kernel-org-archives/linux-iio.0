Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4032B131;
	Sun,  6 Sep 2026 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658913; cv=none; b=WJ+/2voLMFrW7bjXBTl5M/QVDcLzguBoDek+ovI1SgrLJ7/CxeME7AStuCRO+Exk8TGtCUIaW40a8wBvF7Ew/ppOV0fotTf2y8/z3a1tiMBaIt/yXJb6f72S3qBNsavQKs08d7y+Tm/mr+U/ebaORJKP2eq3gIX357foM7LQ/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658913; c=relaxed/simple;
	bh=QQyM34WgkiWRNXoiDYA8yedz4oD6pVw0d1Gun+LPTXg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=bKvOtjNhC7Hmeo3B1Ish8YxtC639ffY3DdJIk5AC4sNqwz6C8Pg1pLKcHpnziGaNKu6I9DlFayUaMX9/17ozU+e8yNhyZcTM80FvLXCxv/lTtUhIRkIZkPRMc1NP6VyvTcoCBPuvl5nB6R0Zo98fRpDG5YEC8Ew+kPP5Oh8+u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASJBWFjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASJBWFjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966BF1F00A3D;
	Sun,  6 Sep 2026 01:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788658910;
	bh=guPJD3TcNLGoGUpBSPvZqbFAYF1p7mGtB9Q0DJroJ3c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ASJBWFjtV+gmB/m2mmbh3c3aUrGtTzJM+dwJBGYGwsCViF8I8r/T3o+wXUK0xdHu6
	 qpoxjo58NtEPw5/TDuoo0Vg2eCFs+GVWI2WSjQchLyeelvJCCEBeaiKkLXiw3GXkPt
	 3tk+zrIY1FgehhRUKcAc4j2w5hx1LB6WKqrgJUSfjCdRkBnfQqYoTTGxP0Uszh5J+v
	 d3bzjjCzNJPobBNRhXKbHTarp3n2Vq3Mx7XlKIBBnhGxTXwUf6L7aa1NHJRfhmK8XG
	 moRugY6nBRUmphZ8iw8U2/haXkL8ZwOBlbKBJJuDQ4XqheouT8r9jfnDSA8L+UdkqQ
	 3QE+virhd1hdQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 07/10] iio: adc: ti-ads112c14: add filter support
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-7-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
 <20260904-iio-adc-ti-ads112c14-filter-support-v2-7-f86592360658@baylibre.com>
Date: Sun, 06 Sep 2026 02:41:33 +0100
Message-Id: <178865889327.3402141.1350211330326487182.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15355;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=QQyM34WgkiWRNXoiDYA8yedz4oD6pVw0d1Gun+LPTXg=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnMTc83I93J1Yy2cKWKor9JOOjCsDvhadaatkd
 9lI43kYaTSJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzE3BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiA0tD/9gbJ8ydI4uC9v6slGwxgw4uEv6+kz9ClaSlW0qYG03vo1
 EL6gMY0pdZy2z20wZF+cZ6WPELdUNQ2o3o1yfFHtHtZH3oWVARBbgTf1w825AhXlhNbUZTDmFvy
 wL96igiuv40ZYp4buvKN+qBJV1GqdTSy0AcVOOMUqiuGYCAUseHLiozwV47GYeTBMq5pU4xucXP
 RognBBM7+hqVxp1sjCmFg8pu/NFkmlyyG/zUe2yVXMAfGnD+nKvTriQatemLBiXPt3O5dAgbSU3
 cfp4UQh0qTgKwNYZuQ/NxsVnMDuQJ9FQsCcU279JJzO138B7ICHh+8vF732lGEgFfm3rqYvJwAB
 0Cc0fZz7Pcb7VwOpXZlFCxJR8EihGu2bArazkOUkZiyJLB2qdO+RlZe1r838nCs6CAOteEsDxMr
 8zn89Ruu55+g/n8oj8mxbdzl/EHzoCOYQKeloTg+LvxNhEcV3vxNRwRiVDbTHovPlI9mHswd0H0
 bnohgSW74HryFlhnuDl5+W/4X123NC+827AKO4JxU1XPlQYHBDuKlp4UIiw/gGQlCWFIU984bdA
 w2FYk9n0MeWzbSevaQSu6wVCc4rRKAqkfIu33BMFHUdUgBddWfz2CFoYjXR5ejrqsoGv3sFI+aX
 KbJrTBEuA45lAXLlch5L//b8QomwD8wgOtdpxKQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for filter_type, oversampling_ratio and sampling_frequency
> attributes to the ti-ads112c14 driver.
> 
> On these chips, these three controls are interdependent and the
> SPEED_MODE register value has a different meaning depending on the
> filter type, which makes the interactions a bit complex. As such, the
> expectation is that the user will set the filter type first, then
> depending on the filter type, either set the oversampling ratio or the
> sampling frequency and finally the other of these two.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

As you probably saw already, sashiko had views.

A few other things from me.

Thanks

Jonathan

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 55462fc57752..85e926184b6e 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -92,6 +92,14 @@
>  #define   ADS112C14_DATA_RATE_CFG_DELAY			GENMASK(7, 4)
>  #define   ADS112C14_DATA_RATE_CFG_GC_EN			BIT(3)
>  #define   ADS112C14_DATA_RATE_CFG_FLTR_OSR		GENMASK(2, 0)
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_16		  0
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_32		  1
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_128	  2
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_256	  3
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_512	  4
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024	  5
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS	  6
> +#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS	  7
>  
>  #define ADS112C14_REG_MUX_CFG				0x07
>  #define   ADS112C14_MUX_CFG_AINP			GENMASK(7, 4)
> @@ -181,6 +189,43 @@ static const u32 ads112c14_pga_gains_x10[] = {
>  
>  #define ADS112C14_INTERNAL_CLK_Hz 4096000
>  
> +/* Index corresponds to first 2 ADS112C14_DATA_RATE_CFG_FLTR_OSR values. */
> +static const int ads112c14_sinc4_osr_available[] = {
> +	16, 32
> +};
> +
> +/* Index corresponds to next 4 ADS112C14_DATA_RATE_CFG_FLTR_OSR values. */
> +static const int ads112c14_sinc4_sinc1_osr_available[] = {
> +	128, 256, 512, 1024
> +};

You 'could' do the comment as maths in the [] =
but maybe it isn't worth it.  Up to you.

> +
> +/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
> +static const int ads112c14_sinc4_sinc1_pf1_20sps_osr_available[] = {
> +	1600, 12800, 25600, 51200
> +};
> +
> +/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
> +static const int ads112c14_sinc4_sinc1_pf1_25sps_osr_available[] = {
> +	1280, 10240, 20480, 40960
> +};
> +
> +/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
> +static const int ads112c14_fmod_div[] = {
> +	128, 16, 8, 4
> +};

Would be nice to index all these [] = ...
but given the 4 speed modes are called 0, 1, 2, 3
I'm not sure it would actually help much beyond maybe removing need
for the comments.

> +
> +enum ads112c14_filter_type {
> +	ADS112C14_FILTER_TYPE_SINC4,
> +	ADS112C14_FILTER_TYPE_SINC4_SINC1,
> +	ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1,
> +};
> +
> +static const char * const ads112c14_filter_type_names[] = {
> +	[ADS112C14_FILTER_TYPE_SINC4] = "sinc4",
> +	[ADS112C14_FILTER_TYPE_SINC4_SINC1] = "sinc4+sinc1",
> +	[ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1] = "sinc4+sinc1+pf1",
> +};
> +
>  #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
>  DECLARE_CRC8_TABLE(ads112c14_crc8_table);
>  


> @@ -880,6 +1109,7 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  	const int (*scale_avail)[2];
>  	u8 *gain_val;
> +	u32 i;

Similar to below, I'm not seeing a reason for this to be specifically
32 bits.

>  
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
> @@ -912,6 +1142,99 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
>  
>  		return -EINVAL;
>  	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		struct ads112c14_channel_state *channel_state;
> +		const int (*available)[2];
> +
> +		guard(mutex)(&data->lock);
> +
> +		channel_state = &data->channel_states[chan->scan_index];
> +
> +		switch (channel_state->filter_osr) {
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
> +			if (channel_state->filter_osr < ADS112C14_DATA_RATE_CFG_FLTR_OSR_128) {
> +				u8 idx = channel_state->filter_osr;
> +
> +				available = data->sinc4_sample_rate_available[idx];
> +			} else {
> +				u8 idx = channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
> +
> +				available = data->sinc4_sinc1_sample_rate_available[idx];

Sashiko:

[Severity: Low]
Can this assignment cause a build failure when compiling with
-Werror=incompatible-pointer-types?

The variable available is declared as const int (*)[2], but the array indexing
of data->sinc4_sinc1_sample_rate_available[idx] yields an array that decays to
int (*)[2]. In C, assigning int (*)[2] to const int (*)[2] is an incompatible
pointer type mismatch without an explicit cast.

-

Seems correct that a cast is needed here or maybe drop the const
marking on the local variable?

> +			}
> +
> +			for (i = 0; i < ARRAY_SIZE(ads112c14_fmod_div); i++) {
> +				if (val == available[i][0] && val2 == available[i][1]) {
> +					channel_state->speed_mode = i;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS: {
> +			available = data->sinc4_sinc1_pf1_sample_rate_available;
> +
> +			for (i = 0; i < ARRAY_SIZE(data->sinc4_sinc1_pf1_sample_rate_available); i++) {
> +				if (val == available[i][0] && val2 == available[i][1]) {
> +					channel_state->filter_osr = i + ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		struct ads112c14_channel_state *channel_state;
> +
> +		guard(mutex)(&data->lock);
> +
> +		channel_state = &data->channel_states[chan->scan_index];
> +
> +		switch (channel_state->filter_osr) {
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
> +			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
> +				if (val == ads112c14_sinc4_osr_available[i]) {
> +					channel_state->filter_osr = i;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
> +			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available); i++) {
> +				if (val == ads112c14_sinc4_sinc1_osr_available[i]) {
> +					channel_state->filter_osr = i + ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
> +			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_25sps_osr_available); i++) {
> +				if (val == ads112c14_sinc4_sinc1_pf1_25sps_osr_available[i]) {
> +					channel_state->speed_mode = i;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
> +			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_20sps_osr_available); i++) {
> +				if (val == ads112c14_sinc4_sinc1_pf1_20sps_osr_available[i]) {
> +					channel_state->speed_mode = i;
> +					return 0;
> +				}
> +			}
> +
> +			return -EINVAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1200,11 +1523,98 @@ static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
>  	return sysfs_emit(buf, "%d\n", val);
>  }
>  
> +static int ads112c14_get_filter_type_from_state(struct ads112c14_channel_state *channel_state)
> +{
> +	switch (channel_state->filter_osr) {
> +	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
> +		return ADS112C14_FILTER_TYPE_SINC4;
> +	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
> +		return ADS112C14_FILTER_TYPE_SINC4_SINC1;
> +	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS...ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
> +		return ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads112c14_set_filter_type(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     unsigned int val)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct ads112c14_channel_state *channel_state;
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&data->lock);
> +
> +	channel_state = &data->channel_states[chan->scan_index];
> +
> +	ret = ads112c14_get_filter_type_from_state(channel_state);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * channel_state->filter_osr affects multiple attributes, so don't modify
> +	 * it if the filter type is already set to the requested value.
> +	 */
> +	if (ret == val)
> +		return 0;
> +
> +	/* Otherwise, pick an arbitrary default for each type. */
> +	switch (val) {
> +	case ADS112C14_FILTER_TYPE_SINC4:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
> +		break;
> +	case ADS112C14_FILTER_TYPE_SINC4_SINC1:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
> +		break;
> +	case ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads112c14_get_filter_type(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct ads112c14_channel_state *channel_state;
> +
> +	guard(mutex)(&data->lock);
> +
> +	channel_state = &data->channel_states[chan->scan_index];
> +
> +	return ads112c14_get_filter_type_from_state(channel_state);
> +}
> +
> +static const struct iio_enum ads112c14_filter_type_enum = {
> +	.items = ads112c14_filter_type_names,
> +	.num_items = ARRAY_SIZE(ads112c14_filter_type_names),
> +	.set = ads112c14_set_filter_type,
> +	.get = ads112c14_get_filter_type,
> +};
> +
> +static const struct iio_chan_spec_ext_info ads112c14_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
> +	{ }
> +};
> +
>  static const struct iio_chan_spec_ext_info ads112c14_ext_info_burnout[] = {
>  	{
>  		.name = "burnoutraw",
>  		.read = ads112c14_read_burnout_raw,
>  	},
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
>  	{ }
>  };
>  
> @@ -1230,7 +1640,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
>  	struct iio_chan_spec *channels;
> -	u32 num_child_nodes, i, pair[2];
> +	u32 num_child_nodes, num_data_chans, i, pair[2];
>  	int ret;
>  
>  	*need_avdd_ref = false;
> @@ -1243,8 +1653,15 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  	if (!data->measurements)
>  		return -ENOMEM;
>  
> -	channels = devm_kcalloc(dev, num_child_nodes +
> -				ARRAY_SIZE(ads112c14_sys_mon_channels) + 1,
> +	num_data_chans = num_child_nodes + ARRAY_SIZE(ads112c14_sys_mon_channels);
> +
> +	data->channel_states = devm_kcalloc(dev, num_data_chans,
> +					    sizeof(*data->channel_states),
> +					    GFP_KERNEL);
> +	if (!data->channel_states)
> +		return -ENOMEM;
> +
> +	channels = devm_kcalloc(dev, num_data_chans + 1,
>  				sizeof(*channels), GFP_KERNEL);
>  	if (!channels)
>  		return -ENOMEM;
> @@ -1257,7 +1674,9 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  
>  		spec->indexed = 1;
>  		spec->scan_index = i;
> +		spec->ext_info = ads112c14_ext_info;
>  		measurement->gain_val = 1;
> +		data->channel_states[i].filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
>  
>  		if (fwnode_property_present(child, "label")) {
>  			ret = fwnode_property_read_string(child, "label", &measurement->label);
> @@ -1422,8 +1841,13 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
>  			*need_ext_ref = true;
>  
> -		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> -		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					   BIT(IIO_CHAN_INFO_SCALE) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +						     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
>  
>  		/*
>  		 * If reference source is resistor rather than voltage supply,
> @@ -1457,6 +1881,10 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  
>  	for (u32 j = 0; j < ARRAY_SIZE(ads112c14_sys_mon_channels); j++) {
>  		struct iio_chan_spec *spec = &channels[i];
> +		struct ads112c14_channel_state *channel_state;
> +
> +		channel_state = &data->channel_states[i];
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
>  
>  		/* Update the template that was already copied with dynamic values. */
>  		spec->scan_index = i;
> @@ -1495,6 +1923,44 @@ static void ads112c14_populate_scale_available(int (*scale_avail)[2],
>  	}
>  }
>  
> +static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
> +{
> +	int *available;
> +	u32 osr, fmod_Hz;
> +	u64 odr_uHz;
> +	u32 i, j;

For these I'd use a bare unsigned int as no particular
reason I can see for forcing 32 bit nature.  Even though it would be
duplication I'd probably declare the each time as local loop
iterators as well.


> +
> +	for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
> +		osr = ads112c14_sinc4_osr_available[i];
> +
> +		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
> +			fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
> +			odr_uHz = div_u64((u64)fmod_Hz * MICRO, osr);
> +			available = data->sinc4_sample_rate_available[i][j];
> +			available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);

Sashiko: (b4 review emacs stuff eats source of coments when I adopt
them - I should figure out how fix that and send a patch!)
[Severity: Low]
Will this call to div_u64_rem() cause a compiler warning or error for
incompatible pointer types?

The local variable available is an int pointer, so &available[1] is also of type
int pointer. However, the third argument of div_u64_rem() expects a u32 pointer
for the remainder. Passing an int pointer to a u32 pointer will trigger a
pointer type mismatch warning.

-

Use a local variable here and in all other places this applies.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
