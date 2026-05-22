Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4823630AD;
	Fri, 22 May 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460651; cv=none; b=ngP37lCslA7yODmr294j/TuHZqh40sYWdmmtRL93zHwOdaW4JBQ1onXlJ641F4c+wrJSxqZKOQVfGCB9EGud9KaZKKVNqvoX5FsLUcRcZAbu/WK+F5ePMVbPBLQBgggfLGRt7rc5MlawflqfPOlQmYNVFCxuo2p1E9NBuxUPe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460651; c=relaxed/simple;
	bh=7LRvogyE2DbiqEqreTDiXtNf9rIpO8JT1auuOTSw3t4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6h4+Mv0Baexe/VQx93umBr+r2047DiTa2POPlUfsMcjv6rn3BxQxI8TaiRTiZB5nLrg16h2rpg4lg0MMdLSd4Ng0OQr1lSpejfrZbnh4tzKWs4T/TJO7TftX7pEaGXbn2L4heTmfHosegKx2b0LE9f/2Cc0efVnidjvgSEAk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ5SfAZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ5SfAZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210FF1F000E9;
	Fri, 22 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779460649;
	bh=ZkBxG7dAs5Dbu50nlO3YiIMXGT1N8myPKjIk5UYE76k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iJ5SfAZdKty5IpIOZD2nGQLELfwOgcAW3IHmcg8zAs/vWdIUUVvUAW3WRNM+NoaYt
	 SnCDtSC9bdujxY4UfImzASP8wKrcqALG9B3a7NrfWt85JRU7VpIZ9VGgfa1L8MKM6J
	 prMI0zQRB7BAoP8bxYuMh9Flxz51jSdsPFb9CSq+qTOk/iS/4J1hSsZSsddU4YduGl
	 HevrpKYRVFB8ZTsyQTSioKOtgHxiNg9HfeBkXJUCeTV1yToO7406Y5e6SqvbnfJO37
	 X+SRnavR6QHOzOuODj91I+2zo7J4Gw1q6tXoe/uLHCuoZ4yspOEe3S34HgaI1BN39y
	 QvAXoY8otH5MQ==
Date: Fri, 22 May 2026 15:37:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260522153719.4fc1d932@jic23-huawei>
In-Reply-To: <20260520-veml3328-v2-2-a57f0d9e28d4@gmail.com>
References: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
	<20260520-veml3328-v2-2-a57f0d9e28d4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 23:15:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> via I2C (SMBus compatible).
> 
> Also add a new entry for said driver into Kconfig and Makefile.
> 
> Assisted-by: Gemini:3.1-Pro
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Hi Joshua,

Sashiko did a really good job on this. I'm always amazed at how much it
understands of how these attributes are used.

https://sashiko.dev/#/patchset/20260520-veml3328-v2-0-a57f0d9e28d4%40gmail.com

My biggest comment is I'd look at making the scale from integration / gain
calculations something that is precomputed that you just look up.
You can have separate ones for light and intensity channels or be a little
cheeky and just use the light one for everything - given intensity doesn't
have fixed units as such we can scale by the extra factors in the illuminance
calculation and not worry about what they are.


> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> new file mode 100644
> index 000000000000..fdfa8fd1666b
> --- /dev/null
> +++ b/drivers/iio/light/veml3328.c
> @@ -0,0 +1,416 @@

> +
> +#define VEML3328_CHAN_SPEC(_color, _addr) { \
> +	.type = IIO_INTENSITY, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_LIGHT_##_color, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +				   BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +					     BIT(IIO_CHAN_INFO_SCALE), \
> +	.address = _addr, \
> +}
> +
> +static const struct iio_chan_spec veml3328_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),

Sashiko is kind of right and kind of wrong on this.
As it is shared by all, BIT(IIO_CHAN_INFO_SCALE)
should be here.  It won't have a function affect as we don't verify
they all have it and as long as one does the file will get created.
So this is more about consistency than correctness.

Raises more questions though.  Is it correct scale? I think not.
Looks like you have scaling for the intensity channels returning
different values from the light one. 

So I think the above INTENSITY should move IIO_CHAN_INFO_SCALE
to .info_mask_shared_by_type and equivalent for the available.




> +		.address = VEML3328_REG_DATA_G,
> +	},
> +	VEML3328_CHAN_SPEC(CLEAR, VEML3328_REG_DATA_C),
> +	VEML3328_CHAN_SPEC(RED, VEML3328_REG_DATA_R),
> +	VEML3328_CHAN_SPEC(GREEN, VEML3328_REG_DATA_G),
> +	VEML3328_CHAN_SPEC(BLUE, VEML3328_REG_DATA_B),
> +	VEML3328_CHAN_SPEC(IR, VEML3328_REG_DATA_IR),
> +};
> +
> +/* scale values per datasheet */
> +static const int veml3328_scale_vals[][2] = {
Sashiko wins again. Whilst we don't get a nice standard unit for
IIO_INTENSITY channels for _raw * _scale, the expectation is that
for the same input light intensity this should remain constant.
I.e. If _scale value double _raw should halve.

I assume these are x0.5 x1 x2 and x4 gains applied. Those will
result in _raw changing by those factors, therefore to get a stable
output these should be inverted.  

	{ 2, 0 },
	{ 1, 0 },
	{ 0, 500000 },
	{ 0, 250000 },

Make sure you test _raw * _scale is stable as a result.

> +	{ 0, 500000 },
> +	{ 1, 0 },
> +	{ 2, 0 },
> +	{ 4, 0 },
> +};
> +
> +/* integration times in microseconds */
> +static const int veml3328_it_times[][2] = {
> +	{ 0, 50 * USEC_PER_MSEC },
> +	{ 0, 100 * USEC_PER_MSEC },
> +	{ 0, 200 * USEC_PER_MSEC },
> +	{ 0, 400 * USEC_PER_MSEC },
> +};
> +

> +
> +static int veml3328_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	unsigned int reg_val;
> +	int ret;
> +	int reg;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(regmap, chan->address, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		reg = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +		if (reg >= ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		*val = veml3328_it_times[reg][0];
> +		*val2 = veml3328_it_times[reg][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->type == IIO_LIGHT) {
> +			int it_inx, gain_inx;
> +			int it_us, scale_u;
> +
> +			it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +			gain_inx = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
> +
> +			if (it_inx >= ARRAY_SIZE(veml3328_it_times) ||
> +			    gain_inx >= ARRAY_SIZE(veml3328_scale_vals))
> +				return -EINVAL;
> +
> +			it_us = veml3328_it_times[it_inx][1];
> +
> +			/*
> +			 * Equation for calculating ambient light scale:
> +			 * Scale = 0.384 * (50000 / Current_IT) * (1x / Current_Gain)

Good. This has the inverses missing for the intensity channels.

As I note below, there are quite a few accesses to what is basically a 4x4 array
of values based on selection of gain and selection of integration time.

I'd be tempted to precompute them and make all these paths look ups.


> +			 */
> +			scale_u = 384 * USEC_PER_MSEC;
> +			scale_u = scale_u  * 50000 / it_us;
> +
> +			switch (gain_inx) {
> +			case 0:
> +				scale_u *= 2;
> +				break;
> +			case 1:
> +				break;
> +			case 2:
> +				scale_u /= 2;
> +				break;
> +			case 3:
> +				scale_u /= 4;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			*val = 0;
> +			*val2 = scale_u;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +
> +		reg = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
> +		if (reg >= ARRAY_SIZE(veml3328_scale_vals))
> +			return -EINVAL;
> +
> +		*val = veml3328_scale_vals[reg][0];
> +		*val2 = veml3328_scale_vals[reg][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
I would  flip the logic and do this one out of line.  It's shorter!

Mind you it should still be taking integration time into account to
achieve a stable value whatever the integration time (assuming we don't
hit limits).


> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml3328_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(veml3328_it_times) * 2;
> +		*vals = (const int *)veml3328_it_times;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:
As mentioned else where this needs to work for both light and intensity
channels and incorporate the affect of integration time.

> +		*length = ARRAY_SIZE(veml3328_scale_vals) * 2;
> +		*vals = (const int *)veml3328_scale_vals;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml3328_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	int ret;
> +	int i;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
> +			if (veml3328_it_times[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		return regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					  VEML3328_CONF_IT_MASK,
> +					  FIELD_PREP(VEML3328_CONF_IT_MASK, i));
> +
> +	case IIO_CHAN_INFO_SCALE:

So this is always a bit of a pain to handle, but you need to take the
integration time into account.

Also this currently applies to the IIO_LIGHT channel as well so you need
to handle that as well which means reversing the maths above to find the
right gain for the current integration time.  There are only 16 options so
I'd be tempted to precompute them all. 



> +		for (i = 0; i < ARRAY_SIZE(veml3328_scale_vals); i++) {
> +			if (val == veml3328_scale_vals[i][0] &&
> +			    val2 == veml3328_scale_vals[i][1])
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(veml3328_scale_vals))
> +			return -EINVAL;
> +
> +		return regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					  VEML3328_CONF_GAIN_MASK,
> +					  FIELD_PREP(VEML3328_CONF_GAIN_MASK, i));
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> 

