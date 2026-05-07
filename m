Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C434DB72
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151971; cv=none; b=bVxyVQ7COg5xmXB1klrKOOyKicP8q4PyagIEVYIlYesnTRF2fVXh/Dblh/6sny1Gbe3KmDND4o24yrYQ4SbRGfLBI8+kp6kpH7Y6+wRhiy82IVmQnfxEnbB3oTrbLkxyv1PBp//NT/A6ix0K2VJxMUxZrIWSBZL7+vsCKkFmMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151971; c=relaxed/simple;
	bh=ti060PMT3q/3hquh1ttB+HGSdZG04BJxGRd4ywCRjj8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsvhRRC1lLTc8TFnn08ixJoNKIx6dwL9WAYb8qcxUZ7pg6PZ1wvVNtgm3RBstXw/WMZtoCofj9zRZ4d+2LhVvIBqNndjoPxsRPnvXtdZF1bQHkgEPmyxZBeaPL8q7L3vHGRY/j62t9zhjVZch3oMIuUwvLEaLIPG+wNmZPMNzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO7VkYJB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO7VkYJB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso7196255e9.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151967; x=1778756767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hpCLhJZC/H4Qpbk7kgqiRtwoNrU27R2wE4dKhhMn9lI=;
        b=NO7VkYJBKIgy1IeJmWBThnv8JDSJ7hHzHuET060Mhfh7uYvzNS+9CcZOUdF0aPRjU0
         sxKarq3rBeZN4ekPfUrTN4uGWQLRrHawWkzy5iahPo3cshZXLfcJQ/cDpxuRhXlkEzxK
         liuwY1buOQuoe5+0pQfXH6bYyYDFMgvqwN5CE6PWy+Au3tVqkohUyxXBs4wvF22ITpJ1
         wTkgYGffauCgKOeB8yZdNdBW03Cu7jSuVJ7DQ2GY7GkE+Y8ad5/+d+Cy9eMpXzG+HTq+
         pEhCj6Bn5VE5VAF4UDoWuri3P31Zfq1nvB+pVMT+NgeCQX/p6wWROKChod+Ab35NazWe
         z2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151967; x=1778756767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpCLhJZC/H4Qpbk7kgqiRtwoNrU27R2wE4dKhhMn9lI=;
        b=dD7hJxQFHfa3KaToZ0P+1Z/RGEgsUQ6nxAWZJh4l/CD2xM3lSQwxL6qHm/9OGcSuaS
         W8HyxB5GyucKGhETk7F1uM8xrDxCS0RHWgR5CzVkwNNdkogOlH5pKkpefDFq6x6FTe1N
         ebEXAi0wiYcbV2/fMPUa1eJGkWYhtRFrvGO8BZj2LWg067ZGYNJ2R24ehPA3L/y7rPUX
         VWw9vxNEc6a/t9+vMBXsJh7nSY2o3tOc6ZMjyc4igtLIblfxm3wTqgKsgNpr2L26AyUt
         qHfTHarxGTLjGodw9s0CLpA1yJMKfYhpP9zkkON/FV+puQD+xYG3nGDI6bCXGApXWyYP
         CKhg==
X-Forwarded-Encrypted: i=1; AFNElJ8x0/OYxM7Ta1VWQff9BQjWrWEFiiLIWeRcNdCxKHEOotimDQYG+ui4kIdfvfq35OogzWs7ioFzMLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3/5oqoOXIFSyShFjnwLq9+JbOjhe+FGgzmHTOUovB/vp7T1j
	C/amZ2z60xcS0JyqOYg+iQXmmW098dn1iiEZEoKdYbrRusw3oK4LGz80
X-Gm-Gg: AeBDieug7AxOjE7bfN8vFUF4JxN+5dK6JkTa33SMJesn3PzJEE54G8Yga5wnmj3NwKc
	B87xq9HxcC4H80lmNmGKSn+dzcjI+jAr/yhqfCnydg7QWqeyel+jzN1V7urJ0lHsV/857V5Y6F/
	BwrsBss5lmKoeQsV17zoDWd0DGbqXi/E817vsi8LniWbaMYSqnUfBfsMNT9xtsfyRydvdv9Z+Vw
	4K25KZYK5PuMhegK4NHVZao+Ypv42FwkCkylfrGkHaRUEAfvho0K/9kHmki/wB2IV4PSLwhXkG5
	vLzBxXTKY630ChDKCYD54H+5NMecrLkI49creKzAXtuls6qWH47tlM0yJSq7m9I94EVTn7FzY6H
	Ale5z9Kb5aYHvjUVTMprmhUMp7lHXGZ/9b78ag5dFTi58a1ADU5+fTlbptpjIOfEtmSNT431+XT
	9GLM3xDZqChPA4FHB7syc0h1B7SK0XpSsGwxFb4cRLtbJOGiCk5Ct+sW5A5n/HVK1v+0l5YDQ+n
	3/mzsY4D2nwW/+pBypbA8bbr8DTx6xlCkihjzSfYHREoFcsRupXXfib94hEuiGaXGliy5s=
X-Received: by 2002:a05:600c:3208:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48e51f46c07mr65693395e9.29.1778151965152;
        Thu, 07 May 2026 04:06:05 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5d299sm59664325e9.0.2026.05.07.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:06:04 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 7 May 2026 12:05:58 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v11 07/11] iio: frequency: adf41513: driver implementation
Message-ID: <5rzmlzst6m2ewcheblimqbv5c64umfhb4mlx34ak65sxpotqgy@jzzmw6cb2vyc>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
 <20260506-adf41513-iio-driver-v11-7-2b7e99cfe8f2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-adf41513-iio-driver-v11-7-2b7e99cfe8f2@analog.com>

On 26/05/06 03:08PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
> 
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> - High-resolution frequency calculations using microhertz (µHz) precision
>   to handle sub-Hz resolution across multi-GHz frequency ranges
> - IIO debugfs interface for direct register access
> - FW property parsing from devicetree including charge pump settings,
>   reference path configuration and muxout options
> - Power management support with suspend/resume callbacks
> - Lock detect GPIO monitoring

Sashiko's feedback:
https://sashiko.dev/#/patchset/20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2%40analog.com?part=7

There is a lot of stuff here, most of things are good points, but maybe it
was not that bad. It could've been worse with those fractional mode calculations.

...

> +static u64 adf41513_pll_get_rate(struct adf41513_state *st)
> +{
> +	struct adf41513_pll_settings *cfg = &st->settings;
> +
> +	if (cfg->mode != ADF41513_MODE_INVALID)
> +		return cfg->actual_frequency_uhz;
> +
> +	/* get pll settings from regs_hw */
> +	cfg->int_value = FIELD_GET(ADF41513_REG0_INT_MSK, st->regs_hw[ADF41513_REG0]);
> +	cfg->frac1 = FIELD_GET(ADF41513_REG1_FRAC1_MSK, st->regs_hw[ADF41513_REG1]);
> +	cfg->frac2 = FIELD_GET(ADF41513_REG3_FRAC2_MSK, st->regs_hw[ADF41513_REG3]);
> +	cfg->mod2 = FIELD_GET(ADF41513_REG4_MOD2_MSK, st->regs_hw[ADF41513_REG4]);
> +	cfg->r_counter = FIELD_GET(ADF41513_REG5_R_CNT_MSK, st->regs_hw[ADF41513_REG5]);
> +	cfg->ref_doubler = FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK, st->regs_hw[ADF41513_REG5]);
> +	cfg->ref_div2 = FIELD_GET(ADF41513_REG5_RDIV2_MSK, st->regs_hw[ADF41513_REG5]);
> +	cfg->prescaler = FIELD_GET(ADF41513_REG5_PRESCALER_MSK, st->regs_hw[ADF41513_REG5]);
> +
> +	/* calculate pfd frequency */
> +	cfg->pfd_frequency_uhz = (u64)st->ref_freq_hz * MICRO;
> +	if (cfg->ref_doubler)
> +		cfg->pfd_frequency_uhz <<= 1;
> +	if (cfg->ref_div2)
> +		cfg->pfd_frequency_uhz >>= 1;
> +	cfg->pfd_frequency_uhz = div_u64(cfg->pfd_frequency_uhz, cfg->r_counter);

	If a user writes 0 to the R_CNT field via debugfs direct register access, won't
	this cause a division by zero kernel panic?

The 0 value for R counter means 32, so this is a bug indeed.

> +	cfg->actual_frequency_uhz = (u64)cfg->int_value * cfg->pfd_frequency_uhz;
> +
> +	/* check if int mode is selected */
> +	if (FIELD_GET(ADF41513_REG6_INT_MODE_MSK, st->regs_hw[ADF41513_REG6])) {
> +		cfg->mode = ADF41513_MODE_INTEGER_N;
> +	} else {
> +		cfg->actual_frequency_uhz += mul_u64_u32_div(cfg->pfd_frequency_uhz,
> +							     cfg->frac1,
> +							     ADF41513_FIXED_MODULUS);
> +
> +		/* check if variable modulus is selected */
> +		if (FIELD_GET(ADF41513_REG0_VAR_MOD_MSK, st->regs_hw[ADF41513_REG0])) {
> +			cfg->actual_frequency_uhz +=
> +				mul_u64_u64_div_u64(cfg->frac2,
> +						    cfg->pfd_frequency_uhz,
> +						    (u64)cfg->mod2 * ADF41513_FIXED_MODULUS);

	Similarly, if the MOD2 field is written as 0 via debugfs, will this result in
	a division by zero panic?

I've just checked in hardware and it seems mod2 = 0 behave as mod2 = 1, so it does not fallback to
fixed modulus. Will adjust so that this is consistent.

...

> +static int adf41513_calc_integer_n(struct adf41513_state *st,
> +				   struct adf41513_pll_settings *result)
> +{
> +	u16 max_int = st->chip_info->has_prescaler_8_9 ?
> +		      ADF41513_MAX_INT_8_9 : ADF41513_MAX_INT_4_5;
> +	u64 freq_error_uhz;
> +	u16 int_value = div64_u64_rem(result->target_frequency_uhz, result->pfd_frequency_uhz,
> +				      &freq_error_uhz);

	If the target frequency is very high and the PFD frequency is very low, could
	the 64-bit quotient overflow the u16 int_value and silently truncate?
	This would bypass the subsequent bounds check on int_value and incorrectly
	program the hardware instead of returning -ERANGE.

That would be unusual as max_int is way less than U16_MAX, but maybe possible with very low
ref frequency and very high dividers, so will make int_value as u32.

> +
> +	/* check if freq error is within a tolerance of 1/2 resolution */
> +	if (freq_error_uhz > (result->pfd_frequency_uhz >> 1) && int_value < max_int) {
> +		int_value++;
> +		freq_error_uhz = result->pfd_frequency_uhz - freq_error_uhz;
> +	}
> +
> +	if (freq_error_uhz > st->data.freq_resolution_uhz)
> +		return -ERANGE;
> +
> +	/* set prescaler */
> +	if (st->chip_info->has_prescaler_8_9 && int_value >= ADF41513_MIN_INT_8_9 &&
> +	    int_value <= ADF41513_MAX_INT_8_9)
> +		result->prescaler = 1;
> +	else if (int_value >= ADF41513_MIN_INT_4_5 && int_value <= ADF41513_MAX_INT_4_5)
> +		result->prescaler = 0;
> +	else
> +		return -ERANGE;

...

> +static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 sync_mask)
> +{
> +	struct adf41513_pll_settings result;
> +	int ret;
> +
> +	ret = adf41513_calc_pll_settings(st, &result, freq_uhz);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* apply computed results to pll settings */
> +	st->settings = result;
> +
> +	dev_dbg(&st->spi->dev,
> +		"%s mode: int=%u, frac1=%u, frac2=%u, mod2=%u, fpdf=%llu Hz, prescaler=%s\n",
> +		(result.mode == ADF41513_MODE_INTEGER_N) ? "integer-n" :
> +		(result.mode == ADF41513_MODE_FIXED_MODULUS) ? "fixed-modulus" : "variable-modulus",
> +		result.int_value, result.frac1, result.frac2, result.mod2,
> +		div64_u64(result.pfd_frequency_uhz, MICRO),
> +		result.prescaler ? "8/9" : "4/5");
> +
> +	st->regs[ADF41513_REG0] = FIELD_PREP(ADF41513_REG0_INT_MSK,
> +					     st->settings.int_value);
> +	if (st->settings.mode == ADF41513_MODE_VARIABLE_MODULUS)
> +		st->regs[ADF41513_REG0] |= ADF41513_REG0_VAR_MOD_MSK;
> +
> +	st->regs[ADF41513_REG1] = FIELD_PREP(ADF41513_REG1_FRAC1_MSK,
> +					     st->settings.frac1);
> +	if (st->settings.mode != ADF41513_MODE_INTEGER_N)
> +		st->regs[ADF41513_REG1] |= ADF41513_REG1_DITHER2_MSK;
> +
> +	st->regs[ADF41513_REG3] = FIELD_PREP(ADF41513_REG3_FRAC2_MSK,
> +					     st->settings.frac2);
> +	FIELD_MODIFY(ADF41513_REG4_MOD2_MSK, &st->regs[ADF41513_REG4],
> +		     st->settings.mod2);
> +	FIELD_MODIFY(ADF41513_REG5_R_CNT_MSK, &st->regs[ADF41513_REG5],
> +		     st->settings.r_counter);

	The driver defines ADF41513_MAX_R_CNT as 32, but the ADF41513_REG5_R_CNT_MSK is
	only 5 bits wide (GENMASK(20, 16)). If r_counter is 32, will this FIELD_MODIFY
	silently truncate it to 0?
	If this is truncated to 0, and the device state is invalidated, a subsequent
	sysfs frequency read would call adf41513_pll_get_rate() and trigger a division
	by zero panic.

The bitfield with zero value behaves as R_CNT = 32, so this should not be a problem,
but I suppose that should be explicit and as pointed out above, it is not being taken
care in adf41513_pll_get_rate().

...

> +static int adf41513_resume(struct adf41513_state *st)
> +{
> +	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_POWER_DOWN_MSK;
> +	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
> +}

	If regulators are turned off during system suspend, the hardware registers will
	be wiped. However, since regs_hw isn't invalidated during suspend, won't
	ADF41513_SYNC_DIFF falsely assume the hardware is still configured and skip
	reprogramming it?

Indeed, I might need to use SYNC_ALL here when doing power management.

	Also, doesn't the unconditional clearing of ADF41513_REG6_POWER_DOWN_MSK clobber
	any prior explicit powerdown request made via sysfs?

Another good point, may need to have a powerdown field in the state struct to
track this.  

...

> +static int adf41513_parse_fw(struct adf41513_state *st)
> +{

...

> +	st->data.charge_pump_voltage_mv = ADF41513_DEFAULT_CP_VOLTAGE_mV;
> +	ret = device_property_read_u32(dev, "adi,charge-pump-current-microamp", &cp_current);
> +	if (!ret) {
> +		tmp = DIV_ROUND_CLOSEST(cp_current * cp_resistance, MILLI); /* convert to mV */

	Could cp_current * cp_resistance overflow the 32-bit boundary?
	If an abnormally large current is provided via devicetree, the overflow could
	pass the subsequent voltage range checks and configure the hardware with an
	incorrect charge pump setting. Should this use mul_u32_u32() or a 64-bit cast?

I can add a bound/max check for cp_current first, as it needs to be between 81 and 7200 micro amps.

> +		if (tmp < ADF41513_MIN_CP_VOLTAGE_mV || tmp > ADF41513_MAX_CP_VOLTAGE_mV)
> +			return dev_err_probe(dev, -ERANGE, "I_CP %u uA (%u Ohms) out of range\n",
> +					     cp_current, cp_resistance);
> +		st->data.charge_pump_voltage_mv = tmp;
> +	}

...

> +static int adf41513_pm_suspend(struct device *dev)
> +{
> +	return adf41513_suspend(dev_get_drvdata(dev));
> +}

	Is it safe to call adf41513_suspend() without acquiring st->lock?
	This function modifies the shared software register cache and executes SPI
	writes. It seems this could race concurrently with sysfs reads/writes or
	IIO core accesses.

Is this a real concern?

...

> +static int adf41513_probe(struct spi_device *spi)
> +{

...

> +	st->chip_enable = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->chip_enable))
> +		return dev_err_probe(dev, PTR_ERR(st->chip_enable),
> +				     "fail to request chip enable GPIO\n");

...

> +	ret = adf41513_setup(st);

	Is a delay needed between asserting the chip_enable GPIO and sending the first
	SPI command in adf41513_setup()?
	Hardware PLLs typically require a wake-up or stabilization time for internal
	regulators. Without a usleep_range(), could the initial SPI commands be
	dropped by the hardware?

I havent see the need for this, mostly because a lot seems to be happening before the
first SPI write and after the chip enable goes high, so I will ignore this.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to setup device\n");
> +
> +	ret = devm_add_action_or_reset(dev, adf41513_power_down, st);

	If adf41513_setup() returns an error, the probe function aborts before
	devm_add_action_or_reset() registers the adf41513_power_down action.
	Since chip_enable is acquired with GPIOD_OUT_HIGH, devres will disable the
	regulators but leave the GPIO high. Could this cause the host processor to
	backpower the unpowered synthesizer IC through its ESD diodes?

Another good point, will separate the reset actions for sw powerdown and chip enable
gpio.

-- 
Kind regards,

Rodrigo Alencar
