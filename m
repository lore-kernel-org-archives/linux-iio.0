Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344005;
	b=TJKMD376XxN22I+d/tlQkF5zfYQnIcxVxbXE22Bg24gsXzE+NhDyeL09s11rrXxTwcTZ
	 fkPq5asY8StKRL15ani+0iy9cZZKqNxjNnM3vzBS6jcE3C7Xgu1olBF/bwl/rihogpeui
	 H3Lpk/L2lW/TTDVS90XjHC84X5flBtviALFSP41aHMyh+jeJEGOA6i2g7o9yuxnF46vKz
	 otL+MRwcvNlQ/YKkT6jzHh9dhKGqkjp1F6AiVB20Vhsq2jGz4R4fG3YTG1BKcxSoQCURn
	 tsQxdfcmLR00JGEU90BDqOnOY5rNO59DqDz/i+2COuoDHPpzxDz6+CHyMHmbDXmJFjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344005;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=EIaK17YQczWR3c0lrZalaK0eS/qz/HNl+rgA3afwJ4Q=;
	b=CEkiEqyrLCQjqQNbKcfwsz0J2ajxMhKIiCsm/ED67NLZZXlm0cWFoOaOk4FzKmQLO3Bc
	 GopgGBoU6JWb/LuDXv8p6l52I/27+xPHXLLh8ypfo6b6iqkMbpf525Kw85IqYrkZ5sB+2
	 mFfVJyCpbbOv26ZHFkLh7EFFod/davdvL+IZ7gPcxaE6IXERrHs9mrEoPyTE+/dtl70mw
	 4o51QZr2CYFDzxGtTXnIcq/jSvZssLgaoNfmlg65UsZ/djpfY37e6OoT/lWOnO+KejoFn
	 WSHbLLTNy71QKEncI2pJKnuXbhiM1btY579voaaldhBXY+EoxkQnvxEal90yl35PWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niLKlp4i;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F27606A320;
	Tue, 10 Nov 2026 20:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51F27606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niLKlp4i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794344005; x=1825880005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dvsuOXj9X68peu/AhyXR+DhZ0w75kjIt96Nt7etSiME=;
  b=niLKlp4iDOXZOLuNEveyrE1ZOdC2XBctkN6Bsp47VPeZqfKL62UZaE9z
   SOYryT3l7DUWOoVKT1OdD5eZTmkOVkYRA+80TVRMC/qd8VyHxug6WIood
   At5sBxU/ggXf5nNldmj7LsGFxyM2COCQqq8QWTT4rKKngVnciQG54Jtth
   aDY1E+4zte4V77M6LU0eCq14xjFT1uXn/OCdXl2HftZGRYt9SvnqzV4r1
   b/ZJTkHXKpxBq6gwHKtgIV2CXEBt7/HuUkBWXeOwRVgSnJsbjWGs6lBlt
   L8fRYQrpKUU81ep8qpZxBSE1uAIZC1J/Z+k4nDQ3SSRzxF6bFHDEoYM+G
   g==;
X-CSE-ConnectionGUID: A8WLAlNOQkuqqfA6Rmy35w==
X-CSE-MsgGUID: 7PREujA6SpGnqaSqy6vwYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3004612"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3004612"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:53:24 -0800
X-CSE-ConnectionGUID: mDz2KGjSQ8+b8Ig0N2yJVQ==
X-CSE-MsgGUID: 2EjV/cYTQAaan751quN40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8830301"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:53:21 -0800
Date: Tue, 10 Nov 2026 22:53:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <avOEPk_cwJSqxECQ@ashevche-desk.local>
References: <20261110021442.410-1-johnerasmusmari.geronimo@analog.com>
 <20261110021442.410-3-johnerasmusmari.geronimo@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110021442.410-3-johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:14:42AM +0800, John Erasmus Mari Geronimo wrote:
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

> +	/* Drop the reference even if the write fails; a later direct read clears AUTO anyway. */

It's a bit too long. Make it multi-line.

...

> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * FIFO_DATA_REG auto-increments in hardware; bulk_read would treat
> +	 * each subsequent byte as a separate cacheable register.
> +	 */
> +	ret = regmap_noinc_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +				st->fifo_buf,
> +				MAX30210_FIFO_BYTES_PER_SAMPLE * st->watermark);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +		return;
> +	}
> +
> +	for (unsigned int i = 0; i < st->watermark; i++) {
> +		u32 raw = get_unaligned_be24(&st->fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * i]);

		unsigned int idx = MAX30210_FIFO_BYTES_PER_SAMPLE * i;
		u32 raw = get_unaligned_be24(&st->fifo_buf[idx]);

> +		s16 temp;
> +
> +		if (raw == MAX30210_FIFO_INVAL_DATA) {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		temp = sign_extend32(FIELD_GET(MAX30210_FIFO_TEMP_MASK, raw), 15);
> +
> +		iio_push_to_buffers(indio_dev, &temp);
> +	}
> +}

...

> +static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int status, enabled;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Status read failed\n");

It's always recommended to have the messages to be ratelimited in IRQ handler,
that's in case of intermittent problems with reading this may flood the kernel
log.

> +		return IRQ_NONE;
> +	}
> +
> +	/* STATUS flags are set whether or not they are enabled in INT_EN. */
> +	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &enabled);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Interrupt enable read failed\n");
> +		return IRQ_NONE;
> +	}
> +
> +	status &= enabled;
> +	if (!(status & (MAX30210_STATUS_A_FULL_MASK |
> +			MAX30210_STATUS_TEMP_HI_MASK |
> +			MAX30210_STATUS_TEMP_LO_MASK)))
> +		return IRQ_NONE;
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

> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {

		struct regmap *map = st->regmap;

> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i++) {

			unsigned int mask = MAX30210_TEMPCONF2_TEMP_PERIOD_MASK;
			unsigned int value = field_prep(mask, i);

> +			if (val != max30210_samp_freq_avail[i][0] ||
> +			    val2 != max30210_samp_freq_avail[i][1])
> +				continue;
> +
> +			return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +					MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> +					FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));

			return regmap_update_bits(map, MAX30210_TEMP_CONF_2_REG,
						  mask, value);

> +		}
> +
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int max30210_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	val = min(val, MAX30210_FIFO_SIZE);

I would put check here to make it look more natural.

	val = min(val, MAX30210_FIFO_SIZE);
	if (!val)
		return -EINVAL;

> +	/*
> +	 * FIFO_A_FULL sets the number of empty FIFO slots remaining when
> +	 * the A_FULL interrupt fires. For a watermark of N samples, set
> +	 * FIFO_A_FULL = FIFO_SIZE - N.
> +	 */
> +	ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG,
> +			   FIELD_PREP(MAX30210_FIFOCONF1_A_FULL_MASK,
> +				      MAX30210_FIFO_SIZE - val));
> +	if (ret)
> +		return ret;
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}

...

> +static int max30210_setup(struct max30210_state *st, struct device *dev)
> +{
> +	struct gpio_desc *powerdown_gpio;
> +	unsigned int val;
> +	int ret;
> +
> +	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown", GPIOD_OUT_HIGH);
> +	if (IS_ERR(powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
> +				     "failed to request powerdown GPIO\n");
> +
> +	if (powerdown_gpio) {
> +		/* CVT/PDB needs a 5 us low pulse; hold it asserted for twice that. */

If I am not mistaken somewhere else you used Greek MU, why not here? Please,
check the comments for the consistency.

> +		fsleep(10);
> +
> +		/* Deassert powerdown to power up device */
> +		gpiod_set_value_cansleep(powerdown_gpio, 0);
> +
> +		ret = devm_add_action_or_reset(dev, max30210_powerdown, powerdown_gpio);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* The supply was just enabled; the device needs tPU before it accepts I2C. */
> +		fsleep(700);
> +
> +		ret = regmap_set_bits(st->regmap, MAX30210_SYS_CONF_REG,
> +				      MAX30210_SYSCONF_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Datasheet Figure 6:
> +	 * tPU max = 700 µs after power-up or reset before device is ready.
> +	 */
> +	fsleep(700);
> +
> +	/* Clear status byte */
> +	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
> +}

-- 
With Best Regards,
Andy Shevchenko


