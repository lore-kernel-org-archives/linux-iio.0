Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877247535B;
	Wed, 30 Sep 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759757; cv=none; b=fnT4RVDt24/yZq8VAPU/mkcC+L/ATZDz+q3PoDev0QmnGXRCRlkNUfsBOjwRYAHraZK/FDI+7ogtM6RMrScyDsyzO79mdDmJYTQaXOBp73BjiSdaYxj+xCVBFQYylVk7UfJPViim0WAe/iDuXYqICdq0BKoGJ2XfHwv+A5Z2aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759757; c=relaxed/simple;
	bh=IF35PdPECKD5mgAiOy8sgwHiIv4XL9uqn+W5LYJBUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpVwxKxz4M+Z4b5wFmnsVvVYaoiXpatq/PLYB4w71Kg+lGOpP5Pz83v+zpDcRxLUiOjgOkE8Fj+rdv/FIZGFFrdiXSmw1IPMiss3/D2eAVVEg8TGj4kx2W2V8UohIRnsBk1ljnGP0TLfsDW72BAaGYoxdDkxTIGy8WUJSCa0G9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwEWDiYN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwEWDiYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790759755; x=1822295755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IF35PdPECKD5mgAiOy8sgwHiIv4XL9uqn+W5LYJBUV8=;
  b=PwEWDiYN0IPWO8A3CWOAbVIAZwa8WN+SPIL9Xsa8nzc4wiTXGC4XWE3R
   nkxY+4HYCVemqrIx//aiupEDl169Quy+GXaeAD9vGpo5FhsuSFlRI/pR2
   h5QAFvTp94LRwvSktG+eIDBvBJSJqOylk3qnXqIYSOmx8cbqnd82YuNFi
   ueIQNFt+k6PSJoDBDI3LuqRKzr9j7Qes/W1eq6Y+2Nj9actuydCB33YNw
   GXy4Dxh+OtsnF67sm8a367Y/XYPia1gcbNqAuJ6O2lcmNmg74rT4DkV/X
   bd5WaF5MWsL54jTtXxWp+wWBNnYZVIh78NQIAPbF6vaPr62BpfJLup6wG
   Q==;
X-CSE-ConnectionGUID: CQoNuqYNTyCmScXjzwlGFw==
X-CSE-MsgGUID: yXFHaCF8RuG3k6LNTjMk4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90534367"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90534367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:15:54 -0700
X-CSE-ConnectionGUID: tVF3E/W+S+SCYYjTvS+U/Q==
X-CSE-MsgGUID: +7PfednwRfSEKtwjcm84ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313574737"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:15:51 -0700
Date: Wed, 30 Sep 2026 12:15:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <arzTRNa12TPIj__X@ashevche-desk.local>
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

Datasheet tag?

...

> +#include <linux/bitfield.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

Better to move this group...

> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +

...to be here (yes, delimited with a blank line).

...

> +struct max30210_state {
> +	struct regmap *regmap;
> +	u8 watermark;
> +	/* Raw FIFO byte buffer */
> +	u8 fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * MAX30210_FIFO_SIZE];

I would swap them so the fifo_buf gets aligned and it might help in some cases.

> +};

...

> +static const struct regmap_config max30210_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX30210_PART_ID_REG,

No cache?

> +};

...

> +static int max30210_read_temp(struct regmap *regmap, unsigned int reg,
> +			      int *temp)

I would go with a single line.

...

> +static int max30210_write_temp(struct regmap *regmap, unsigned int reg,
> +			       int temp)

Ditto.

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

No, please declare variable at the top of the scope.
Do you need casting? Why?

> +		iio_push_to_buffers(indio_dev, &temp);
> +	}
> +}

...

> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)

Wrap logically

			     struct iio_chan_spec const *chan,
			     int *val, int *val2, long mask)

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
> +
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

10 * USEC_PER_MSEC (and drop both comments).

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

> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
> +			     __stringify(MAX30210_FIFO_SIZE));

Make it a single line, it's fine in this case.

...

> +	if (!client->irq)
> +		return dev_err_probe(dev, -ENXIO, "Missing interrupt.\n");

Unneeded as the below will fail anyway.

> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					max30210_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;

...

> +static const struct i2c_device_id max30210_id[] = {
> +	{ "max30210" },

C99 initialisers.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


