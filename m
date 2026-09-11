Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CD45C719;
	Fri, 11 Sep 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113655; cv=none; b=PckSz1KEZelJSKurm7YgdNlSGEcMgaSATy+S7gtquarR90wTHSu+3tXD11ydYmhpM8um9tSXgQUziuzn2dN0gGIS6AoCd8eVjVFGg92dGof817NScgMulzgg7lsUFYScdMmNi9GnPXJYz5Dwq1PR0woeVf5En+hMej5+GByIRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113655; c=relaxed/simple;
	bh=LfYvR29VTy8mN7xftSEO5JWBU3bWn97hBdtJ2Xqsi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e93944DR2mOONzfy95qmsneTdTGgkZkJw4yfwLU9Uopt9dTb5ok/P9tnEhA+HvN5LRgK0B4q8Lrq4zJhyqLpPazn4a7hegJSmuzxNVwrC/p9M2iOlbHcRP6C3L8D7Vgf1SJzONDg6u+Q21xfAZOAno0IA814yhwG65VT98CRzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BApfalTH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BApfalTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789113654; x=1820649654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LfYvR29VTy8mN7xftSEO5JWBU3bWn97hBdtJ2Xqsi2g=;
  b=BApfalTHNAuEHn4yG7dQR5hUI4LVrN4p9w3RTAiBoeMSb/WAgNt2qZio
   CBMgmMWu93sgGTCvPTShfZIufEpvwekilyWbHMjqVBh9Uctg5j23mCjf5
   fzXRehGevSkXZYDwIPtbxDL7IUOxn/n49Xb14/XT3VMBMPkQuDlyorjs4
   XE4k8Q6/vjyrPeQoWOcjyhqnDY1cX3jaEIDOpAGOFg4bZ75aoarcYol9/
   XtfxL6xA4T1Drwj9GDIi5U8aSphhxnv25GHzw8WaRhmpsUgV2HHjmstNO
   V/S4qvOOTBbSKMbdYU+SvHA7NP9OeBcJi9L9ed/qRph+kplPWtR2Ij7RB
   g==;
X-CSE-ConnectionGUID: TN78N+hnTq2tuKidLoBHWA==
X-CSE-MsgGUID: WAwhSOoHQamcGyy6u+VDng==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="106942976"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="106942976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:00:53 -0700
X-CSE-ConnectionGUID: TfVD6kd3T6Gqs4uB4N1J+A==
X-CSE-MsgGUID: BrJjrAMPT3SDYqanNsBwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="296841626"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:00:50 -0700
Date: Fri, 11 Sep 2026 11:00:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <aqO1L748RVwHDLMU@ashevche-desk.local>
References: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
 <1d3cdd6163923b1c537b8db49b833863ee6bf545.1789032019.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d3cdd6163923b1c537b8db49b833863ee6bf545.1789032019.git.johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:12:17AM +0800, John Erasmus Mari Geronimo wrote:
> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
> 
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
> 
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
> 
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.

...

Shouldn't Kconfig select REGMAP_I2C?

...

The header block doesn't fully follow IWYU.

+ array_size.h // ARRAY_SIZE()
+ bitops.h // BIT(), sign_extend32(), et cetera

> +#include <linux/bitfield.h>

+ delay.h // fsleep()

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

It's better to group them out...

+ minmax.h // min*(), et cetera

> +#include <linux/regmap.h>

+ types.h // uXX, __le16, et cetera

> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +

...somewhere here.

...

> +struct max30210_state {
> +	struct regmap *regmap;

> +	u8 watermark;

I would swap to make it easier to read the array (which will be aligned).

> +	/* Raw FIFO byte buffer */
> +	u8 fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * MAX30210_FIFO_SIZE];
> +};

...

> +static const struct regmap_config max30210_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX30210_PART_ID_REG,

No cache? Why?

> +};

...

> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +			       st->fifo_buf,
> +			       MAX30210_FIFO_BYTES_PER_SAMPLE * st->watermark);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +		return;
> +	}
> +
> +	for (unsigned int i = 0; i < st->watermark; i++) {
> +		u32 raw = get_unaligned_be24(&st->fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * i]);
> +
> +		if (raw == MAX30210_FIFO_INVAL_DATA) {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		s16 temp = (s16)FIELD_GET(MAX30210_FIFO_TEMP_MASK, raw);

Defined variable at the proper space, also better to use sign_extend() instead
of casting.

> +
> +		iio_push_to_buffers(indio_dev, &temp);
> +	}
> +}

...

> +static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Status read failed\n");

Imagine if this is an intermittent issue, this will flood the logs very quickly.

> +		return IRQ_NONE;
> +	}
> +
> +	if (status & MAX30210_STATUS_A_FULL_MASK)
> +		max30210_fifo_read(indio_dev);
> +
> +	if (status & MAX30210_STATUS_TEMP_HI_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	if (status & MAX30210_STATUS_TEMP_LO_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 5;

> +		*val2 = 1000;

KILO? MILLI?

> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		uval = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +
> +		/*
> +		 * TEMP_PERIOD is an index into the sampling frequency lookup
> +		 * table. Clamp in case the register holds a reserved value.
> +		 */
> +		uval = min_t(unsigned int, uval, ARRAY_SIZE(max30210_samp_freq_avail) - 1);

No min_t(). Also add a new temporary variable for the value from the register,
so semantically uval wouldn't be overloaded.

> +		*val = max30210_samp_freq_avail[uval][0];
> +		*val2 = max30210_samp_freq_avail[uval][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW: {
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_CONV_T_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait until CONVERT_T auto-clears.
> +		 * Datasheet:
> +		 *   tBIAS_WU = 260 µs
> +		 *   tINT     = 8 ms
> +		 *
> +		 * Worst-case conversion ≈ 8.26 ms.
> +		 * Use 10 ms timeout for margin.
> +		 */
> +		ret = regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, uval,
> +					       !(uval & MAX30210_TEMPCONV_CONV_T_MASK),
> +					       500,          /* poll every 500 µs */
> +					       10000);       /* 10 ms timeout */

10 * USEC_PER_MSEC (will require time.h to be included).

> +		if (ret)
> +			return ret;
> +
> +		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)

Split logically...

			      struct iio_chan_spec const *chan,
			      int val, int val2, long mask)

(I am surprised that this is v3 and too many mistakes that linux-iio@ mailing
 list is full of. You may take your time and read the mailing list archives to
 understand the most common style and API mistakes in IIO contributions.)

> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i++) {
> +			if (val != max30210_samp_freq_avail[i][0] ||
> +			    val2 != max30210_samp_freq_avail[i][1])
> +				continue;
> +
> +			return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +					MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> +					FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
> +		}
> +
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static ssize_t hwfifo_watermark_show(struct device *dev,
> +				     struct device_attribute *devattr,
> +				     char *buf)
> +{
> +	struct max30210_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%d\n", st->watermark);
> +}

^^^ (here, see below)

> +
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
> +			     __stringify(MAX30210_FIFO_SIZE));

> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);

Move this closer to the callback.

...

> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");

It's fine to have it on a single line.

...

> +static const struct i2c_device_id max30210_id[] = {
> +	{ "max30210" },

C99 initialisers.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


