Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FF3FBECE;
	Mon, 15 Jun 2026 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534607; cv=none; b=k2jBe19v8PKrmoOnTlcF1edZ7g9fyOh9h5OiUsqbA2ET2kRXFFfCK2jUXHaPO7dTODsQpSNUaP9ty8FjBgcEs5ctSDRTyxiaTwqo0Jku/0PQqGf5CMWrozZidRH7os7eUO6GneZeNrs7x5ijU9hgFHVwY+u92q6qW7V/HpGgg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534607; c=relaxed/simple;
	bh=KFhiv7ZY9NvifF6eaVaM6d2i696gChhNL8L7Sqi6BwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxfncB+8kAvfXOkoipTe0zYJyjMvc4etlGsmLXIBVIuK9u1NnhlfeIyAVdKQ3sPHgxdLOcR+zHTRIAlF+j66E01pNJGmD7MyxFofePvsYw51ipi/VJHVpEs1YTb5sCewAxjSyIDwXzbTJBqhfDLr6IWYU2ExFrjP5j0ATnO5ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjzfOp+G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjzfOp+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781534606; x=1813070606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KFhiv7ZY9NvifF6eaVaM6d2i696gChhNL8L7Sqi6BwA=;
  b=EjzfOp+GOSmpGfoHwX3XOZaA0mWIYVfygC8qs+AcRaiwFUHvTysPwj0g
   eJyVzV+PSAM6wTFVGi3pnNfYLRKPkRrVL4GlsRHPiXv1u/onXNXTpRAyS
   NqMAIeKYp/EmU4wdTg037F6tIKUHylBZQLudDMvSo79HrBggCRAvvuma1
   eSGX+yS3iBAT5wu+d4+eSnMyBJuYEYDuQaz1da+Q78TAVohdIpIHFzf/O
   SMlN7Wi9k6Vsot1XYGcx2D3QX8PEungTwi3TZI28ZXoUms1+304tflBok
   olwJ5FnlRcQ2ULhdPAFUGNw0OAN8QrIhv15TtKZjMkit1DiJvSMRGt+Gf
   Q==;
X-CSE-ConnectionGUID: X4sMJU/8RDqIJydfw6+tIA==
X-CSE-MsgGUID: nQsFH/B/SKy7OtY/srIlQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99851469"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99851469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:43:25 -0700
X-CSE-ConnectionGUID: DOj26RyoTMaML0W6xUW8fA==
X-CSE-MsgGUID: HVX23VVZQb+DqeKruw/o7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="247580409"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:43:22 -0700
Date: Mon, 15 Jun 2026 17:43:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <ajAPh4xKqxRyIpBe@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-5-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614233722.2603459-5-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:37:21AM +0100, Salih Erim wrote:
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

> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
> +{
> +	*val = (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;

MILLIDEGREE_PER_DEGREE is defined as int.

> +}
> +
> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
> +{
> +	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / (int)MILLI;

Ditto.

> +}

...

> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
> +{
> +	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
> +	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
> +	int scale, tmp;
> +
> +	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
> +	tmp = (val * scale) / (int)MILLI;

Due to agnosticism of this function, I dunno if the above can be applied here.

> +	if (format)
> +		tmp = clamp(tmp, S16_MIN, S16_MAX);
> +	else
> +		tmp = clamp(tmp, 0, U16_MAX);
> +
> +	*raw_data = (u16)tmp;
> +}

...

> +static int sysmon_read_alarm_config(struct sysmon *sysmon,
> +				    unsigned long address)
> +{
> +	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
> +	u32 offset = SYSMON_ALARM_OFFSET(address);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(reg_val & BIT(shift));

regmap_test_bits()?

> +}

...

> -static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
> +			   int irq)

I would leave one line (82 characters IIANM).

-- 
With Best Regards,
Andy Shevchenko


