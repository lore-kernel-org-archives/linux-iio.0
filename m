Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F3480973;
	Wed, 17 Jun 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710758; cv=none; b=Xl15u1E7e+F8Cr838YSEq5iYCKc4YfkwSqbho//cyrAn1jXnnsyADiOq/c4rWgMYmrbfobDWEapWkHk8w1SI8NGanPR2zJs5q616Vd/Nm4uGA9RY7UUUptUYjiAM5glzUHOmD/niADsDm57tFYjPtuMuPezY2r0YcD4rzkgBx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710758; c=relaxed/simple;
	bh=5Ne2IzmX4N2pGsaBBbFlwgcFdWdkG1Fk1KCdoIFLauI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2uDIyPxmwZqL5JZad7oJtxJJR6LrMxa5O9cORReIE6ZD/g2JhzuEDNxDKqn8EEV/uAUNaxPn14dvmgPkKm/n0SfreXPiKdE22EoFUfIOMYNA+0Ev2ASl2wxJjg9OpJ3PUd9a+82Pepb+zGY5cbwPQ+7/nmWTdCWE2EoqGHcaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNy5X2ae; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNy5X2ae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781710746; x=1813246746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ne2IzmX4N2pGsaBBbFlwgcFdWdkG1Fk1KCdoIFLauI=;
  b=QNy5X2aeRDqWgBdiicvooPIw3rJW7hpTpd5WEpRTDxaXlywX3NIkOAZk
   6qh1usPiWUjbtHfM5fSKQBlCB5XqMMMBqkFIgw+keivSCXq9/pNUj0Qio
   FsiywQuLB2ciHJCmlFcXA/TjHGMw7aS4kNukxXvDPa1f/yes8VBz8ZAlH
   mPUmRfNu7468s+rh+9TXEYHgGNcOc09yls/gtpstcFD5ZjQrevLjVJHiM
   Oend37l43MsJwmp/JxIssGsS+HIhQCWrs/s1VgSj+Ci8TENVSf5powBaG
   /cmr5KWgKqOENCZPGhgKi2YypRSh8Pib7qMi4AMv4gag9BozEgGxZzlu7
   w==;
X-CSE-ConnectionGUID: f7VY3kqIQsyzR5Ku4CSO1Q==
X-CSE-MsgGUID: 7+z+ie/7RE6KQ/+0MucD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86351133"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="86351133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:39:04 -0700
X-CSE-ConnectionGUID: F7r+UYOfQLupqjyMxr5ScQ==
X-CSE-MsgGUID: d5p2UhCdT6iWnAsNqYanzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="253206765"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:39:01 -0700
Date: Wed, 17 Jun 2026 18:38:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <ajK_kmZMfdLaVyIj@ashevche-desk.local>
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-5-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616131559.3029543-5-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 02:15:58PM +0100, Salih Erim wrote:
> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising threshold with configurable value on the device
>     temperature channel (current max across all satellites)
>   - Per-channel hysteresis as a millicelsius value
>   - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The hardware also provides a separate over-temperature (OT)
> threshold, but it is not exposed through IIO as it serves as a
> hardware safety mechanism for platform shutdown. OT will be
> exposed through the thermal framework in a follow-up series.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> specs are not attached and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> A devm cleanup action masks all interrupts on driver unbind to
> prevent unhandled interrupt storms after the IRQ handler is freed.

...

> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
> +{
> +	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
> +	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
> +	int scale, tmp;
> +
> +	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
> +	tmp = (val * scale) / (int)MILLI;
> +
> +	if (format)
> +		tmp = clamp(tmp, S16_MIN, S16_MAX);
> +	else
> +		tmp = clamp(tmp, 0, U16_MAX);

Double check that minmax.h is included.

> +	*raw_data = (u16)tmp;
> +}

...

> +static int sysmon_supply_thresh_offset(int address,
> +				       enum iio_event_direction dir)

Make it a single line. OTOH why is 'address' signed? Perhaps u32?
Or for some reason unsigned long as per _alarm_config()?

> +{
> +	if (dir == IIO_EV_DIR_RISING)
> +		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_UP;
> +	if (dir == IIO_EV_DIR_FALLING)
> +		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_LOW;
> +
> +	return -EINVAL;
> +}

...

> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int imr;
> +	int config_value;

> +	u32 mask;
> +	int ret;
> +
> +	mask = sysmon_get_event_mask(chan);

Just make it together, as we don't validate the value of 'mask'.

	struct sysmon *sysmon = iio_priv(indio_dev);
	u32 mask = sysmon_get_event_mask(chan);
	...
	int ret;

> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +
> +	/* IMR bits are 1=masked, invert to get 1=enabled */
> +	imr = ~imr;
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		config_value = sysmon_read_alarm_config(sysmon, chan->address);
> +		if (config_value < 0)
> +			return config_value;
> +		return config_value && (imr & mask);
> +
> +	case IIO_TEMP:
> +		/*
> +		 * Return the administrative state, not the hardware IMR.
> +		 * The IRQ handler temporarily masks the interrupt during
> +		 * the polling window; reading IMR would show it as disabled.
> +		 * temp_mask bit is set when administratively disabled.
> +		 */
> +		return !(sysmon->temp_mask & mask);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	u32 ier = sysmon_get_event_mask(chan);

Here you call the variable 'ier'. Please, make this consistent in the related
APIs (see above).

> +	unsigned int alarm_config;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		ret = sysmon_write_alarm_config(sysmon, chan->address, state);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &alarm_config);
> +		if (ret)
> +			return ret;
> +
> +		if (alarm_config)
> +			return regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +
> +		return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> +
> +	case IIO_TEMP:
> +		if (state) {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask &= ~ier;
> +		} else {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask |= ier;
> +		}
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int sysmon_update_temp_lower(struct sysmon *sysmon)
> +{
> +	unsigned int upper_reg;
> +	int upper_mc, lower_mc;
> +	u32 raw_val;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
> +	if (ret)
> +		return ret;
> +
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);

> +

^^^

> +	lower_mc = upper_mc - sysmon->temp_hysteresis;

Either add a blank line here, or remove the one above as these three is kinda
semantically coupled.

> +	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
> +
> +	return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
> +}

...

> +static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
> +{
> +	unsigned int unmask, status;

As per above perhaps name 'unmask' as 'u32 ier'? Or did I miss the use case?

> +	status = isr & SYSMON_TEMP_INTR_MASK;
> +
> +	unmask = ~status & sysmon->masked_temp;
> +	sysmon->masked_temp &= status;
> +
> +	/* Only unmask if not administratively disabled by userspace */
> +	unmask &= ~sysmon->temp_mask;
> +
> +	regmap_write(sysmon->regmap, SYSMON_IER, unmask);
> +}

Also looking at all this, please double check variable names in all functions
and make types and names consistent across the whole driver code.

> +	}

...

> -	num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));
> +	num_static = ARRAY_SIZE(temp_channels);
> +	num_chan = size_add(num_temp, size_add(num_static, num_supply));

At glance I don't see any additional arguments, can we introduce num_static in
the previous patch to reduce a churn here?

-- 
With Best Regards,
Andy Shevchenko


