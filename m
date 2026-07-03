Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8B339714;
	Fri,  3 Jul 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080529; cv=none; b=XzMUFjUfg+OY9AjtO5So6hGv7z293qD/JGYS8rzMxtsEFxSh74U37wwInOmyzzvcuXXSsMKLJpHlQfXoofB3+MzgB7rFbb9aQRjHMW9h+mTpf3e6p7kwa4N/atw8ja0HpEzoXPqmTn1cq2B0Fdq8a+SbQ2CTlzc4ZompD7vGvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080529; c=relaxed/simple;
	bh=qYoCgl+AsfOa/RPajeRVVLKhD2BIVaRarKjhhntISk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZUblztBhpYMy8RT6h94QWrAP38SzrmA7IixiW7gn2HznukvcV1ZnEZWvLD8xydJ9YGPvS2SCa6z8kbu5CjAkeFOHUsP7faUGNueK5nAGARhJW2jxn6dvo6vxdJdcjneUSx82clVqnMqG5CPdqoyI7X0WE0GyPERNYGQtOv/8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoWJe8AV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoWJe8AV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783080528; x=1814616528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qYoCgl+AsfOa/RPajeRVVLKhD2BIVaRarKjhhntISk4=;
  b=CoWJe8AVkzrp7A6PQBMTd4dSLy+lPQcO74WgTIlgtbAk3ebBWKcKVO4A
   /u74PZtHenLTZDG3ak35l8aA02AJtj3r0Xm9FrwwpkZIycE/ao1+XFh3d
   1MXj4AT77VHhJ8f6RVaUWz8uPNgp5ctuKTGmSDU7Bt9x4r0t42XvMrHfY
   DHg5ZvOgt0oe6w6w5M6PEPO8ZPHSTdG1GU2Htov0oq1h1O7OZufaFFPRm
   XttYFlpBCov9ZRb0pDsCNJdPaXA+RzS7AC0JgMfDZpSoaJfQUrSRdbncp
   9g71a3fBHQ50nmCnDBV7np444LCJ1izKMVI2eDCdT4Q3Wpnvy2a8+uAtM
   w==;
X-CSE-ConnectionGUID: jNzC8pZiToKRWjR6ASQGOw==
X-CSE-MsgGUID: 6dE2Q9a3Sb+X1c2BrmO7Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87662171"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87662171"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:08:47 -0700
X-CSE-ConnectionGUID: a1D2nDeITBmUJfY4ylDlUg==
X-CSE-MsgGUID: vXPcJPouTYOdKviFUTOzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253246129"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:08:44 -0700
Date: Fri, 3 Jul 2026 15:08:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <akemSbFS7o-Y6qw6@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703102941.1141341-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 01:29:32PM +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.

> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Who is Ciprian? Messed up with tags?
(Missing Co-developed-by? Originally-by? Et cetera?)

...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>

> +#include <linux/mod_devicetable.h>

There is a new development to use something else in the future for this.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>

+ types.h // uXX

> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +#define MAX40080_ADC_RES		4096

RES is to odd: Resource? Result? Ah, resolution!

...


> +#define MAX40080_INTER_VREF_MV		1250

_mV


...

> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125

50mV
10mV

> +/*
> + * The RANGE field (CFG bit 6) selects one of two current-sense full-scale
> + * ranges (the MAX40080 supports exactly two: +/-50 mV and +/-10 mV). Ordered
> + * so that the array index equals the RANGE field value: index 0 = 50 mV range
> + * (gain 25 V/V), index 1 = 10 mV range (gain 125 V/V).
> + */
> +static const int max40080_csa_gain[] = {
> +	MAX40080_CSA_50MV_GAIN, MAX40080_CSA_10MV_GAIN,
> +};

With a given comment and one time use of those definitions, do we need them
at all?  I leave it to Jonathan, because my memory is weak on his preference
in the cases like this.

...

> +#define MAX40080_NUM_RANGES	ARRAY_SIZE(max40080_csa_gain)

Hmm... It's just a bit shorter, but one may argue that having ARRAY_SIZE()
inline makes it better to understand. And I rarely see definitions that
actually just a wrapper on ARRAY_SIZE() with hardcoded name.

...

> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	int ret;
> +	int tmp;
> +
> +	guard(mutex)(&st->lock);
> +
> +	tmp = i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;

> +	tmp &= ~mask;
> +	tmp |= val & mask;

Standard pattern is one liner

	tmp = (tmp & ~mask) | (val & mask);

> +	ret = i2c_smbus_write_word_data(st->client, reg, tmp);
> +	if (ret < 0)

Do you need '< 0' for _write_word_data() cases?

> +		return ret;
> +
> +	return 0;

I think the

	return _write_word_data(...);

suffice.

> +}

...

> +/*
> + * In single-measurement mode the device sits idle until it receives an SMBus
> + * Quick Command, then performs exactly one current and one voltage conversion
> + * and returns to idle. Triggering on demand this way (rather than running the
> + * FIFO continuously in active mode) means each read returns a fresh, coherent
> + * current/voltage pair instead of the oldest queued FIFO entry.
> + */
> +static int max40080_trigger_measurement(struct max40080_state *st)
> +{

Even with

	struct i2c_cliend *client = st->client;

> +	return i2c_smbus_xfer(st->client->adapter, st->client->addr,
> +			      st->client->flags, I2C_SMBUS_WRITE, 0,
> +			      I2C_SMBUS_QUICK, NULL);

this becomes slightly better

	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
			      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);

> +}

...

> +static int max40080_read_iv(struct max40080_state *st, u32 *iv)
> +{
> +	int ret, io_ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = max40080_trigger_measurement(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Wait for the conversion to complete by polling the FIFO valid bit
> +	 * (or bail out on an I2C error). Polling the device's own status makes
> +	 * this independent of the actual conversion time, which varies with the
> +	 * oversampling ratio and the bus speed. The timeout is only a safety
> +	 * ceiling: the worst case is the maximum 128x averaging on both the
> +	 * current and voltage channels at the slowest 15 ksps base rate plus the
> +	 * inter-channel switching time, i.e. roughly 20 ms; 50 ms leaves ample
> +	 * margin.
> +	 */
> +	ret = read_poll_timeout(max40080_read_iv_once, io_ret,
> +				io_ret || (*iv & MAX40080_IV_VALID_MSK),
> +				500, 50000, false, st, iv);

I would use

				1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
				false, st, iv);

Yes, this doubles the minimum threshold. So, up to you, and in case of taking
the suggestion, include time.h.

> +	if (ret)
> +		return ret;
> +
> +	return io_ret;
> +}

...

> +static void max40080_calc_current_scale(struct max40080_state *st)
> +{
> +	unsigned int i;
> +	u32 rem;
> +	u64 tmp;

> +	for (i = 0; i < MAX40080_NUM_RANGES; i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(...); i++) {

> +		tmp = (u64)MAX40080_INTER_VREF_MV * NANO * MICRO;
> +		tmp = div64_u64(tmp, (u64)MAX40080_ADC_RES * max40080_csa_gain[i] *
> +				st->shunt_resistor_uohm);

I would do in one statement

		tmp = div64_u64((u64)MAX40080_INTER_VREF_MV * NANO * MICRO,
				(u64)MAX40080_ADC_RES * max40080_csa_gain[i] *
				st->shunt_resistor_uohm);

> +		st->current_scale[i][0] = div_u64_rem(tmp, NANO, &rem);
> +		st->current_scale[i][1] = rem;
> +	}
> +}

...

> +static int max40080_get_oversampling_ratio(struct max40080_state *st, int *val)
> +{
> +	int tmp;
> +	u8 filter;
> +
> +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	filter = FIELD_GET(MAX40080_FILTER_MSK, tmp);
> +	*val = (filter == 0) ? 1 : (8 << (filter - 1));

Can we use max40080_oversampling_avail[] here?

> +	return 0;
> +}

...

> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,

> +			     int *val,
> +			     int *val2,

These two can occupy a single line.

> +			     long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	unsigned int range;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

> +		if (chan->type == IIO_CURRENT) {
> +			ret = max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type == IIO_VOLTAGE) {
> +			ret = max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}

Hmm... Why not

		if (chan->type == IIO_CURRENT)
			ret = max40080_get_current(st, val);
		else if (chan->type == IIO_VOLTAGE)
			ret = max40080_get_voltage(st, val);
		else
			ret = 0; // Shouldn't we return an error?
		if (ret)
			return ret;

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 */
> +			ret = max40080_get_range(st, &range);
> +			if (ret)
> +				return ret;
> +
> +			*val = st->current_scale[range][0];
> +			*val2 = st->current_scale[range][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		/* voltage[mV] = raw * Vref[mV] * buffer_gain / ADC_RES */
> +		*val = MAX40080_INTER_VREF_MV * MAX40080_V_BUFF_GAIN;
> +		*val2 = MAX40080_ADC_RES;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = max40080_get_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int max40080_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Only the current channel has a selectable range/scale. */
> +		if (chan->type != IIO_CURRENT)
> +			return -EINVAL;

> +		for (i = 0; i < MAX40080_NUM_RANGES; i++)

		for (unsigned int i = 0; i < ARRAY_SIZE(...); i++)

> +			if (val == st->current_scale[i][0] &&
> +			    val2 == st->current_scale[i][1])
> +				return max40080_set_range(st, i);
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = max40080_set_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

Return directly, it seems only one time use.

> +}

...

> +static int max40080_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);

> +	if (read_val) {

Hmm... In this case perhaps

	if (!read_val)
		return i2c_smbus_write_word_data(st->client, reg, write_val);

makes code cleaner.

> +		int val = i2c_smbus_read_word_data(st->client, reg);
> +
> +		if (val < 0)
> +			return val;

The desired pattern is to have assignment separated from the definition.
The rationale is maintenance overhead and possibility of subtle mistakes.

> +		*read_val = val;
> +		return 0;
> +	}
> +
> +	return i2c_smbus_write_word_data(st->client, reg, write_val);
> +}

...

> +static int max40080_init(struct max40080_state *st, int oversampling_ratio)
> +{
> +	u16 fifo_cfg, cfg;
> +	int ret, filter;
> +
> +	filter = max40080_oversampling_to_filter(oversampling_ratio);
> +	if (filter < 0)
> +		return filter;
> +
> +	/*
> +	 * Put the device in standby before (re)configuring the FIFO: the FIFO
> +	 * configuration register can only be written while the device is not
> +	 * converting (e.g. after a probe following a warm reset). PEC is enabled
> +	 * here and remains enabled for all later transactions.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_MODE_MSK, MAX40080_STDBY_MODE) |
> +	      FIELD_PREP(MAX40080_PEC_EN_MSK, 1);
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Store a matched current+voltage pair per conversion. */
> +	fifo_cfg = FIELD_PREP(MAX40080_STORE_IV_MSK, MAX40080_STORE_I_V);

> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_FIFO_CFG,
> +					fifo_cfg);

I would dare to make this a single line.

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Use single-measurement mode: the device stays idle and converts once
> +	 * per SMBus Quick Command (see max40080_trigger_measurement()), so each
> +	 * read returns a fresh sample rather than a queued FIFO entry.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_MODE_MSK, MAX40080_SINGLE_MODE) |
> +	      FIELD_PREP(MAX40080_PEC_EN_MSK, 1) |
> +	      FIELD_PREP(MAX40080_FILTER_MSK, filter);

> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Same as per above,

	return i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);

> +}

...

> +static int max40080_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max40080_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;

> +	i2c_set_clientdata(client, indio_dev);

Is it used?

> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &st->shunt_resistor_uohm))
> +		st->shunt_resistor_uohm = 1000000; /* default 1 ohm */

1 * MICRO

> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "shunt-resistor-micro-ohms must be non-zero\n");
> +
> +	max40080_calc_current_scale(st);
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	/* No averaging by default; configurable at runtime via sysfs. */
> +	ret = max40080_init(st, 1);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static const struct i2c_device_id max40080_i2c_ids[] = {
> +	{ "max40080" },

Use C99 initialisers.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


