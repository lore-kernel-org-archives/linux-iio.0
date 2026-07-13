Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70D31E823;
	Mon, 13 Jul 2026 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958662; cv=none; b=NUAfJIr2VSzE3GBWTeiuVZAKtXUm3mm4LWcpvAA0frfL2vLg8UOOfWkjbS8DQeb2taBacgMJTJEUxTuGBZOqb5DS8fOgMT80MCYZdhk00QYlWFAHDwNEIwKGrkbWyUlHTb1sBWLn/mhHvzRJAc3TGThf3hf0g30fV0zmBnGYMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958662; c=relaxed/simple;
	bh=AQ6kRwFWlLHQFJShZ44mfxM8160cGsODfIThMj0Os3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvjKydPqlA4qsW6mUJS/M0ouKaSXAElwsehfe8g3sfHbfFqajF/h55TbjmgqZHPN8aV9q3p/MTbtrv8QH2GeqY6u1NWYsR/IfNXM0tJSSR2BcbRIIdVuHBoCng0K5BY5mSxt7IvXjLp/OLkdBiTt1OpPgWnlkdmov0A2alBrpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzw+3Muu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzw+3Muu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958661; x=1815494661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQ6kRwFWlLHQFJShZ44mfxM8160cGsODfIThMj0Os3M=;
  b=lzw+3Muu8N8uHaQJfPDEHG9VZAs7ppeGSsybeOBevwuEfP/CaIaYUI5H
   hO58QUDnfVBdt6aqaIrYkmxvClvwrYYNTob0VrmCoFR/wOnLA2UmU41mV
   7Q+VjgqFVLJXpFF5djfoZGZy/E8e/IyabKQYOUhwIDXPlGSPmmJEtXvXx
   EpfuteITIm7zuvt9RcR2kkWRcSz2ItcQV9yb46ugk8N5/L5c0TpD4c1wH
   Buc+w5mvtMBINC6STmmrdXpsREdpz+lKZV7mxWw7Bu2JqYNBH7qbyZpYC
   fUh/iQFTojqkuUvB7UO27MAIOiXI44nI9RvAECk+JvdVQ17AYICThLDtK
   A==;
X-CSE-ConnectionGUID: gN1C5y9nSRmTTblKmF+0Jw==
X-CSE-MsgGUID: gS3fNHt8Qhy59deuBkVxuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84687829"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84687829"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:04:20 -0700
X-CSE-ConnectionGUID: /42MMHaGReOvsuxIOuImdA==
X-CSE-MsgGUID: HgAmR3frT2KuXpcNrd1pCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259444898"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:04:16 -0700
Date: Mon, 13 Jul 2026 19:04:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <alUMfpXGVa9CYxlT@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260713120226.90303-1-stefan.popa@analog.com>
 <20260713120226.90303-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713120226.90303-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 03:02:26PM +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> No existing IIO driver covers this device or a register-compatible part.
> The closest relatives target different silicon with incompatible register
> maps and feature sets: max9611 is a unidirectional high-side sensor with a
> die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> device-specific register map with bidirectional 13-bit current, a 64-entry
> FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Command,
> and two selectable input ranges, so it warrants its own driver.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw and scale attributes, a configurable oversampling (digital
> averaging) ratio, and PEC-protected register access. The two selectable
> current-sense ranges are exposed through scale/scale_available; the
> current scale is derived from the shunt-resistor-micro-ohms device-tree
> property.

...

> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>

> +#include <linux/mod_devicetable.h>

Should be not used since Uwe's rework of this header.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +/* CFG.range field values */
> +#define MAX40080_CFG_RANGE_50mV		0
> +#define MAX40080_CFG_RANGE_10mV		1
> +
> +/* FIFO_CFG.store_iv field values */
> +#define MAX40080_FIFO_CFG_STORE_I_V	0x02
> +
> +#define MAX40080_ADC_RES		4096
> +#define MAX40080_INTER_VREF_MV		1250

Let's also use _mV here.

> +#define MAX40080_V_BUFF_GAIN		30
> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125

And here.

...

> +#define MAX40080_NUM_RANGES	ARRAY_SIZE(max40080_csa_gain)

I think I commented on this already. This hides the information, I think
the better way is to avoid using this macro.

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
> +				1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> +				false, st, iv);
> +	if (ret)
> +		return ret;

Even in case of error the value in iv will be updated. Is it deliberately?

> +	return io_ret;
> +}

...

> +static int max40080_get_oversampling_ratio(struct max40080_state *st, int *val)
> +{
> +	int tmp;
> +	u8 filter;

Keep reversed xmas tree order.

> +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	filter = FIELD_GET(MAX40080_CFG_FILTER_MSK, tmp);
> +	*val = max40080_oversampling_avail[filter];
> +
> +	return 0;
> +}

...

> +static int max40080_set_oversampling_ratio(struct max40080_state *st, int val)
> +{
> +	int ret, filter = max40080_oversampling_to_filter(val);

This style is discouraged. First of all, it's a mix of semantically different
variables. Second, the assignment of the variable that is going to be validated
might lead to subtle issues in the future.

> +	if (filter < 0)
> +		return filter;

So, Do just

	int filter;
	int ret;

	filter = max40080_oversampling_to_filter(val);
	if (filter < 0)
		return filter;

> +	ret = max40080_update_bits(st, MAX40080_REG_CFG, MAX40080_CFG_FILTER_MSK,
> +				   FIELD_PREP(MAX40080_CFG_FILTER_MSK, filter));
> +	if (ret)
> +		return ret;
> +
> +	st->oversampling_ratio = val;
> +
> +	return 0;
> +}

...

> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,

> +			     int *val,
> +			     int *val2,

At least these two may be on a single line.

> +			     long mask)

...

> +static int max40080_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)

You see, like here.

...

> +		*vals = (int *)st->current_scale;

Why not const int?

> +		*length = MAX40080_NUM_RANGES * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;

...

> +static int max40080_init(struct max40080_state *st)
> +{
> +	u16 fifo_cfg, cfg;
> +	int ret, filter;

Here is better, but see above.

> +	filter = max40080_oversampling_to_filter(st->oversampling_ratio);
> +	if (filter < 0)
> +		return filter;
> +
> +	/*
> +	 * Put the device in standby before (re)configuring the FIFO: the FIFO
> +	 * configuration register can only be written while the device is not
> +	 * converting.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_CFG_MODE_MSK, MAX40080_CFG_MODE_STDBY) |
> +	      FIELD_PREP(MAX40080_CFG_PEC_EN_MSK, 1);
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Store a matched current+voltage pair per conversion. */
> +	fifo_cfg = FIELD_PREP(MAX40080_FIFO_CFG_STORE_IV_MSK, MAX40080_FIFO_CFG_STORE_I_V);
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_FIFO_CFG,
> +					fifo_cfg);

Previous line is long enough to justify this one to be also a single line.

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Use single-measurement mode: the device stays idle and converts once
> +	 * per SMBus Quick Command (see max40080_trigger_measurement()), so each
> +	 * read returns a fresh sample rather than a queued FIFO entry.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_CFG_MODE_MSK, MAX40080_CFG_MODE_SINGLE) |
> +	      FIELD_PREP(MAX40080_CFG_PEC_EN_MSK, 1) |
> +	      FIELD_PREP(MAX40080_CFG_RANGE_MSK, st->range) |
> +	      FIELD_PREP(MAX40080_CFG_FILTER_MSK, filter);

> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Just

	return i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);

?

> +}

...

> +static int max40080_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max40080_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	/*
> +	 * The device powers up with PEC enabled (CFG POR = 0x0060) and rejects
> +	 * unprotected transactions, so PEC support is mandatory, along with word
> +	 * access, the I2C block read used for the current/voltage pair, and the
> +	 * Quick Command used to trigger a conversion.
> +	 */
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK |
> +				     I2C_FUNC_SMBUS_PEC))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;

> +	st->shunt_resistor_uohm = 1 * MICRO;
> +	device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				 &st->shunt_resistor_uohm);
> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "shunt-resistor-micro-ohms must be non-zero\n");

We now establish better approach for optional values

	const char *propname;

	propname = "shunt-resistor-micro-ohms";
	if (device_property_present(dev, propname)) {
		ret = device_property_read_u32(dev, propname, &st->shunt_resistor_uohm);
		if (ret)
			return dev_err_probe(dev, ret, "can't read %s\n", propname);
		if (!st->shunt_resistor_uohm)
			return dev_err_probe(dev, -EINVAL, "%s must be non-zero\n", propname);
	} else {
		st->shunt_resistor_uohm = 1 * MICRO;
	}

> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range (index 0), no averaging. */
> +	st->range = 0;
> +	st->oversampling_ratio = 1;
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	ret = max40080_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


