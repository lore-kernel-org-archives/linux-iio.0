Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2340D58C;
	Mon, 29 Jun 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741064; cv=none; b=Bo9DK2bxWy/YyzkRIBGEbgkWZxhRNJde189/x5TuCxTn5iRUYRvhwJ4Skhq4kecA0/dlWz/SuT26ztJStujsGDXoGRNwRBx0zuJZXyWZW7f75N4kP/c7c7LUbIv74aNvB1uFc4vUCF+9V5PVfiLIdWj2vyiumTMvXxzEBs0GaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741064; c=relaxed/simple;
	bh=7aDJtASJ9hni+E01NvEcAX0fBC3PAtusqXbVZp3ROjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf0XYaNJlEmVFmNZJXYWVQzQxj+LNnIUh0vDtEsKqdBOQolq9aXr76sUX89McbhOm8y9Pt/jJU+HKDud9k+yq9cZ9VxxsQtuvC4LITaM8hX/n+V1KXaNYPZfxQWfnD0vCNHrPszC4HeeP1E1Z2QbUK68Zd9V34CY+QHNn1MG42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4r+4lJ/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4r+4lJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782741063; x=1814277063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7aDJtASJ9hni+E01NvEcAX0fBC3PAtusqXbVZp3ROjM=;
  b=S4r+4lJ/vTz3SbXISNiNOdpJiicBqNq9RfETwylmqcYuzw4jGG2ghQ57
   Eq47qbkJFhz0I4VHXXBhEDVmVdo4kD1zUFjAAdHbRvkAqN1V/UWnSDRs2
   ymyDPx5q2wsIHB60S39TvcRIO8XTXkxooWegTYfv3sNoBGform375+gdx
   vY9OhkmeFuqV/apPzk+wGJtylqYpumgUC1M9fhK0JABefDgBuXZv1tLfE
   1s0C3m6mbJI1MvCM1CM7RQN6PQXh44LCrqh02hheYSPmrm9YmHVoZG19e
   OvVwnzU7vapJZjyv9Zvn/x2n2b069OPc8LkExqtXLGO6KkiNL7+RiDWPb
   g==;
X-CSE-ConnectionGUID: g9rpF4HjSXOQOXW6euFj5w==
X-CSE-MsgGUID: iX+qW8qZTruuPCtOYGEEvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83199281"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83199281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:51:02 -0700
X-CSE-ConnectionGUID: Mf6KdHoBRkO/cx0M3rbehQ==
X-CSE-MsgGUID: PBk/+bnSSFOwNeNZz0JqRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290084403"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:50:58 -0700
Date: Mon, 29 Jun 2026 16:50:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <akJ4QCdhIKpfaNDD@ashevche-desk.local>
References: <20260627005843.7786-1-nikhilgtr@gmail.com>
 <20260627005843.7786-3-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627005843.7786-3-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 27, 2026 at 06:28:43AM +0530, Nikhil Gautam wrote:
> Add Industrial I/O subsystem support for the Melexis
> MLX90393 3-axis magnetometer and temperature sensor.
> 
> The driver currently supports:
> 
> raw magnetic field measurements
> raw temperature measurements
> configurable gain/scale selection
> configurable oversampling ratio
> direct mode operation

Can you add '-' or '*' in front of each item in the list?

> The MLX90393 supports both I2C and SPI interfaces. This
> initial implementation adds support for the I2C interface.
> 
> The device uses a command-based communication protocol
> rather than a conventional register-addressed interface.
> A small transport abstraction layer is therefore used
> instead of regmap to share the common sensor logic
> between the current I2C implementation and future SPI
> support without duplicating code.

The commit message seems wrapped around 56 characters. We have capacity up to
~72, please use it.

...

> + * Datasheet: https://media.melexis.com/-/media/files/documents/datasheets/mlx90393-datasheet-melexis.pdf

Also add this line as a tag in the commit message (before your SoB).

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>

+ dev_printk.h // dev_err_probe()

> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/types.h>
> +#include <linux/time64.h>

Please, keep them sorted alphabetically.

> +#include <linux/unaligned.h>
> +#include <linux/units.h>


...

> +struct mlx90393_data {
> +	/* Protects sensor configuration and measurement operations */
> +	struct mutex lock;
> +	struct device *dev;

You need a forward declaration for struct device.

> +	void *bus_context;
> +	const struct mlx90393_transfer_ops *ops;
> +	u8 gain_sel;
> +	u8 hallconf;
> +
> +	u8 res_xy;
> +	u8 res_z;
> +
> +	u8 dig_filt;
> +	u8 osr;
> +	u8 osr2;
> +};

...

> +/* Datasheet: Table no.17 */
> +static const int mlx90393_scale_table[MLX90393_AXIS_MAX][MLX90393_GAIN_MAX]
> +				      [MLX90393_RES_MAX] = {

Not good indentation. Just make it

static const int mlx90393_scale_table[][MLX90393_GAIN_MAX][MLX90393_RES_MAX] = {

which is precisely a single line.

> +	/* XY axis */
> +	{
> +		{ 751, 1502, 3004, 6009},
> +		{ 601, 1202, 2403, 4840},
> +		{ 451, 901, 1803, 3605},
> +		{ 376, 751, 1502, 3004},
> +		{ 300, 601, 1202, 2403},
> +		{ 250, 501, 1001, 2003},
> +		{ 200, 401, 801, 1602},
> +		{ 150, 300, 601, 1202},
> +	},
> +	/* Z axis */
> +	{
> +		{ 1210, 2420, 4840, 9680},
> +		{ 968, 1936, 3872, 7744},
> +		{ 726, 1452, 2904, 5808},
> +		{ 605, 1210, 2420, 4840},
> +		{ 484, 968, 1936, 3872},
> +		{ 403, 807, 1613, 3227},
> +		{ 323, 645, 1291, 2581},
> +		{ 242, 484, 968, 1936},
> +	}

Keep trailing comma(s) for non-terminator entries.

> +};

...

> +#define MLX90393_CHAN(idx, axis, addr) { \
> +	.type = IIO_MAGN, \
> +	.modified = 1, \
> +	.channel = idx, \
> +	.address = addr, \
> +	.channel2 = IIO_MOD_##axis, \

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_SCALE), \

It's harder to read, make it either

	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
			      BIT(IIO_CHAN_INFO_SCALE), \

or (which is also my preference)

	.info_mask_separate = \
		BIT(IIO_CHAN_INFO_RAW) |	\
		BIT(IIO_CHAN_INFO_SCALE), \

Do it for all such cases.

> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +	.info_mask_separate_available = \
> +		BIT(IIO_CHAN_INFO_SCALE),  \
> +	.info_mask_shared_by_type_available = \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +}

...

> + * Datasheet: Table 8, Page no. 12

If Table has a title, also mention it here

		Table 8 "...title of the table..."

in such a case the page reference most likely may be dropped.
Same comment for all the similar cases.

...

> +static int mlx90393_get_tconv_us(struct mlx90393_data *data)

Can it return negative? What will be the meaning?

> +{
> +	const int osr = data->osr;
> +	const int osr2 = data->osr2;
> +	const int df = data->dig_filt;

> +

No blank line in the definition block.

> +	int tconvm;
> +	int tconvt;
> +

Ditto, and why are tconv* signed?

> +	int m = 3; /* X,Y,Z */
> +
> +	/*
> +	 * TCONVM = 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)
> +	 */
> +	tconvm = 67 + (64 * BIT(osr) * (2 + BIT(df)));
> +
> +	/*
> +	 * TCONVT = 67 + 192 * 2^OSR2
> +	 */
> +	tconvt = 67 + (192 * BIT(osr2));
> +	/*
> +	 * Total conversion time:
> +	 * TSTBY + TACTIVE + m * TCONVM + TCONVT + TCONV_END
> +	 */
> +	return 220 + 360 + (m * tconvm) + tconvt + 120;
> +}

...

> +static int mlx90393_xfer(struct mlx90393_data *data,

> +			 const u8 *tx, int tx_len,
> +			 u8 *rx, int rx_len)

The last two lines may be joined.


> +{
> +	return data->ops->xfer(data->bus_context, tx, tx_len, rx, rx_len);
> +}

...

> +static int mlx90393_update_bits(struct mlx90393_data *data, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	u16 reg_val;
> +	int ret;
> +
> +	ret = mlx90393_read_reg(data, reg, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= ~mask;
> +	reg_val |= (val << __ffs(mask)) & mask;

Isn't it field_prep() reinvention? (Note small letters in the name!)

> +	return mlx90393_write_reg(data, reg, reg_val);
> +}

...

> +	/* Wait conversion */

	/* Wait for conversion to be done */

("wait for" is an English stanza that in great majority of the cases is used).

> +	fsleep(mlx90393_get_tconv_us(data));

...

> +static int mlx90393_find_scale(struct mlx90393_data *data, bool z_axis,
> +			       int val, int val2,
> +			       int *gain)
> +{
> +	u8 res;
> +	enum mlx90393_axis_type axis;

Prefer reversed xmas tree order.

> +	if (z_axis) {
> +		axis = MLX90393_AXIS_TYPE_Z;
> +		res = data->res_z;
> +	} else {
> +		axis = MLX90393_AXIS_TYPE_XY;
> +		res = data->res_xy;
> +	}

> +	if (val != 0)
> +		return -EINVAL;

This doesn't use res or axis, move it above.


> +	for (unsigned int i = 0; i < ARRAY_SIZE(mlx90393_scale_table[0]); i++) {

Use [axis] instead of [0] for the consistency's sake.

> +		if (mlx90393_scale_table[axis][i][res] == val2) {
> +			*gain = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}


> +static int mlx90393_set_scale(struct mlx90393_data *data,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2)
> +{
> +	bool z_axis;
> +	int gain;
> +	int ret;

> +	z_axis = chan->channel2 == IIO_MOD_Z;

Can we rather split _find_scale() to two and replace this with

	if (chan->channel2 == IIO_MOD_Z)
		ret = mlx90393_find_z_scale(data, val, val2, &gain);
	else
		ret = mlx90393_find_xy_scale(data, val, val2, &gain);

? I believe it will be less LoC.

> +	ret = mlx90393_find_scale(data, z_axis, val, val2, &gain);
> +	if (ret)
> +		return ret;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF1, MLX90393_CONF1_GAIN_SEL,
> +				   gain);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = gain;
> +	return 0;
> +}

...

> +static int mlx90393_find_osr(int val, int *osr)
> +{
> +	for (unsigned int i = 0; i < MLX90393_OSR_MAX;  i++) {

One space too many.

> +		if (mlx90393_osr_avail[i] == val) {
> +			*osr = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int mlx90393_set_osr(struct mlx90393_data *data, int val)
> +{
> +	int osr;
> +	int ret;
> +
> +	ret = mlx90393_find_osr(val, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (osr == data->osr)
> +		return 0;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3, MLX90393_CONF3_OSR,
> +				   osr);

Just make line longer, in this case it will be better to read in my opinion.

> +	if (ret)
> +		return ret;
> +
> +	data->osr = osr;
> +	return 0;
> +}

...

> +static int mlx90393_set_temp_osr2(struct mlx90393_data *data, int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val >= MLX90393_OSR2_MAX)
> +		return -EINVAL;
> +
> +	if (val == data->osr2)
> +		return 0;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3, MLX90393_CONF3_OSR2,
> +				   val);

Ditto.

> +	if (ret)
> +		return ret;
> +
> +	data->osr2 = val;
> +
> +	return 0;
> +}

...

> +static int mlx90393_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2,
> +			      long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		return mlx90393_set_scale(data, chan, val, val2);
> +	}

> +

Be consistent with the style of switch-case. Either add blank lines in all of
them in all cases, or drop everywhere.

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		guard(mutex)(&data->lock);
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return mlx90393_set_temp_osr2(data, val);
> +
> +		case IIO_MAGN:
> +			return mlx90393_set_osr(data, val);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int mlx90393_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
> +		ret = mlx90393_read_measurement(data, chan->address, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;

> +		}

Misindented.

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			return mlx90393_get_scale(data, chan, val, val2);
> +
> +		case IIO_TEMP:
> +			/*
> +			 * Datasheet Table 7: Thermal Specification
> +			 */
> +			*val = 0;
> +			*val2 = 22124;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;

> +		/*
> +		 * Datasheet Table 7: Thermal Specification
> +		 */

This is a single line comment.

> +

This blank line should be before the comment and not after.

> +		*val = -45114;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return mlx90393_get_temp_osr2(data, val);
> +		case IIO_MAGN:
> +			return mlx90393_get_osr(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int mlx90393_read_avail(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       const int **vals,
> +			       int *type,
> +			       int *length,
> +			       long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +	static int scale_avail[MLX90393_GAIN_MAX][MLX90393_AXIS_MAX];
> +	enum mlx90393_axis_type axis;
> +	u8 res;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		axis = chan->channel2 == IIO_MOD_Z;
> +		res = axis ? data->res_z : data->res_xy;

		res = chan->channel2 == IIO_MOD_Z ? data->res_z : data->res_xy;

This fits a single line, no axis variable is needed.

> +		for (unsigned int i = 0; i < MLX90393_GAIN_MAX; i++) {
> +			scale_avail[i][0] = 0;
> +			scale_avail[i][1] =
> +				mlx90393_scale_table[axis][i][res];
> +		}
> +
> +		*vals = &scale_avail[0][0];
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = MLX90393_GAIN_MAX * MLX90393_AXIS_MAX;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type == IIO_TEMP) {
> +			*vals = mlx90393_osr2_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR2_MAX;
> +		} else {
> +			*vals = mlx90393_osr_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR_MAX;
> +		}
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int mlx90393_init(struct mlx90393_data *data)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	/* Exit mode */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_EX);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Datasheet section 15.4.1.2 (RT command), Figure 16:
> +	 * Wait 1 ms after EX command before issuing RT.
> +	 */
> +	fsleep(1 * USEC_PER_MSEC);
> +
> +	/* Reset device */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_RT);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Datasheet section 15.4.1.2 (RT command), Figure 16:
> +	 * Wait 1.5 ms for the start-up sequence to complete.
> +	 */
> +	fsleep(1.5 * USEC_PER_MSEC);

He-he, this is a float number. While it might work, it's better to use integer
numbers. Yeah, for the sake of consistency the above also better with 1000.

> +
> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = FIELD_GET(MLX90393_CONF1_GAIN_SEL, reg);
> +	data->hallconf = FIELD_GET(MLX90393_CONF1_HALLCONF, reg);
> +
> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF3, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->res_xy = FIELD_GET(MLX90393_CONF3_RES_X, reg);
> +	data->res_z = FIELD_GET(MLX90393_CONF3_RES_Z, reg);
> +	data->dig_filt = FIELD_GET(MLX90393_CONF3_DIG_FILT, reg);
> +	data->osr = FIELD_GET(MLX90393_CONF3_OSR, reg);
> +	data->osr2 = FIELD_GET(MLX90393_CONF3_OSR2, reg);
> +
> +	return 0;
> +}

...

> +#include <linux/array_size.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

+ types.h // uXX

...

> +	struct i2c_client *client = context;
> +	int ret;
> +	struct i2c_msg msgs[2] = {

Keep reversed xmas tree order.

> +		[0] = {
> +			.addr = client->addr,
> +			.len = tx_len,
> +			.buf = (u8 *)tx,
> +		},
> +		[1] = {
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = rx_len,
> +			.buf = rx,
> +		},
> +	};

...

> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret != ARRAY_SIZE(msgs))
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;

Do it in a regular pattern

	if (ret < 0)
		return ret;
	if (ret != ARRAY_SIZE(msgs))
		return -EIO;

> +}

> +static struct i2c_driver mlx90393_i2c_driver = {
> +	.driver = {
> +		.name = "mlx90393",
> +		.of_match_table = mlx90393_of_match,
> +	},
> +	.probe = mlx90393_i2c_probe,
> +	.id_table = mlx90393_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(mlx90393_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko


