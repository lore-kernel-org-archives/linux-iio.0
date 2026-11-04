Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823735;
	b=snw1MxC+Y9Phu+FEmEEpyBNqRZpJci/oT6m/cFZjLRaht0Br+w78u+GVqq6K1BEymOZX
	 Pr1It1c28m/FsXxwh2mTlQHCT5Cp+HYp3afjQPX9Q6V2Ti4+KmCc2zT0lo2q4kPLQdZct
	 Vm/FIDbpvNsCxS66OeuzdonjM+aLsNMjkDwkVAScy+I5bqEOiJPTMJANmE4/SENJVrrYN
	 yCzDT+VNlOLmi9y3cJOtp6/CskR1V0alsjLCl6YgSZskdJhcP0Nm/P2z8YzsI0Ph75Bzv
	 L+Lzpq/CkQFT6kN6+tAaxJS4BHsyWAKfNd5+2udjARYEJoOjisnkDcLItiBC/tX+rZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823735;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1q6t4nFYUEkBz7z+xoP8zNbSPnKXpREiK7TaFNztaTo=;
	b=Eez26wAjAga7wURtg2c77IChf7yNGZK3vnyN/3qXbTqBZ3gZKfpE4P3RfdWEUVS60eIb
	 3jzegSF/adJ+PaR5TFzxEBv166N3zm323u7DSw0H+MgoZpZO5E6GwRku+zz9dXPA65h6X
	 nJZuIBweI2d77BE4hGoSpkL7Gb8+fjXG6AWpyOBwx95+/X3T8Oe9e3uueSIzLzbeRPk9B
	 Xy/NVLPw/5VMKfeMCwwFk8VnRv/blskkmNLs1nZWbr6AX3Rnqondi/32ehIyudg70Ke+r
	 oD1fJVsRQATC4nHYC8QAjGctQyUfG7dShOp/Ioh2x530pmk0ajpFWpmZWVaMjTLh5rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsG8D40s;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B39606EEB6;
	Wed,  4 Nov 2026 20:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32B39606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsG8D40s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823735; x=1825359735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FMIi+WxOIJkYfJDxyuNJSMRa8IbgzEpLC7IDMUiiy1k=;
  b=YsG8D40s2/oX+b3QxvcyuL5/ukIX1pF80hex6Qe11aBxcPQd9kGxCiN0
   dw143qIQxx4m7hDZK9q6VJz+9YNlBoi9/1q06aCfbeypH/rVLcZ5zk8Bx
   6Q0rcGxSPjuLLY1F805m7D1nipq5OULCI8cUDigh8c3Lc+zHVX1TeYS8+
   lV8E4YDCU6X3Zy3yJjAgcnUwRD8gbX9R16Sj2TvUeqAHAvhaLSXKVTgtw
   LaSTL1HzbR4B4yWKpjAlxB/U3z7mV5GBuJgCtB2irb0u0AxHX0ASirCuN
   u8wQq/vO0aIGZPsZGc3pNy0xCz6dz9FpJwh0yljXvuupRBQGUBtT0GDke
   w==;
X-CSE-ConnectionGUID: CteQ1Q+LTK6b8DWdvTrC0Q==
X-CSE-MsgGUID: SrSIdXVLSbG07R0HQbZzAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2478703"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2478703"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:22:14 -0800
X-CSE-ConnectionGUID: HM934INXTnu1L+MDYncFlw==
X-CSE-MsgGUID: 0wCh21S1QnKZTYVCTCWxzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7170684"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:22:10 -0800
Date: Wed, 4 Nov 2026 22:22:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Joshua Crofts <crofts@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: ad7625: add LTC2387 and ADAQ2387x
 support
Message-ID: <auuT754d-bwSeL1Z@ashevche-desk.local>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261104132143.215581-6-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104132143.215581-6-Nicolae-daniel.Deaconescu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:21:43PM +0200, Nicolae-Daniel Deaconescu wrote:
> 
> Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as
> chip data of this driver. They are read through the same two PWMs and
> IIO backend. They differ in a few ways that the chip data and a few
> quirks cover, see the binding patch for the list:
> 
> - Data is output at double data rate on one or two lanes, so the CLK
>   burst is the number of bits divided by 2 or by 4 pulses long.
> - The burst of one conversion starts at least t_FIRSTCLK after its CNV
>   and has to end at most t_LASTCLK after the next CNV, so at the maximum
>   rate it runs into the next conversion period.
> - They have no EN pins.
> - The ADAQ parts divide the scale by the gain of their front end.
> 
> The changes are:
> 
> - Add chip info for the five parts, with a maximum sampling frequency of
>   15 MSPS, and the OF and platform device ID entries for them.
> - Add struct ad7625_ddr_timing with t_CNVH, t_FIRSTCLK and t_LASTCLK, and
>   point the chip info of the new parts to it. A non-NULL pointer marks a
>   part with DDR output.
> - Add ad7625_set_sampling_freq_ddr(). Unlike for the AD762x and AD796x,
>   the sampling period is raised until the CLK burst fits t_LASTCLK, so the
>   maximum rate isn't limited to 10 MSPS by the period clamp.
> - Build the waveforms in whole steps of the PWMs, which are read with
>   pwm_get_waveform_step_might_sleep() when probing and each time the
>   sampling frequency changes.
> - Get the second PWM as "clk" for the new parts and "clk_gate" for the
>   existing ones, and don't get a reference clock for the new parts, as the
>   step already tells the clock rate of the PWM.
> - Add ad7625_parse_ddr() to read adi,use-two-lanes and adi,gain-milli. The
>   gain defaults to the fixed gain of the ADAQ23875 and to 1 for the
>   LTC2387, and is required for the ADAQ23876 and ADAQ23878, whose gain is
>   pin strapped and has to be one of the supported values.
> - Divide the scale by the gain of the front end for the new parts.
> - Enable the supplies of the new parts, and read their optional
>   ref-supply, using the internal reference when it is absent.
> - Set the number of lanes of the backend for the new parts. This can only
>   be skipped if the backend can't set it and one lane is used.
> - Limit the default sampling frequency of the new parts to the clock rate
>   of the PWMs.
> - Move the setup of the EN pin mode into ad7625_set_initial_mode(), which
>   does nothing for the parts without EN pins. The code that sets the pins
>   of the existing parts is unchanged.
> - Include math64.h and minmax.h for the helpers that the new code uses.
> - Add the new parts to the Kconfig help and Documentation/iio/ad7625.rst,
>   and new maintainer entries.

...

>  config AD7625
> -	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
> +	tristate "Analog Devices AD762x, AD796x, LTC2387 and ADAQ2387x ADC driver"

This does not scale. Please, make it more generic and make sure the text in the
top comment of the driver along with MODULE_DESCRIPTION() is quite similar to
this (maybe without "driver" word).

...

>  	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
>  	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
>  	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
> +	  * LTC2387-16 16-Bit, 15 MSPS SAR Analog-to-Digital Converter
> +	  * LTC2387-18 18-Bit, 15 MSPS SAR Analog-to-Digital Converter
> +	  * ADAQ23875 and ADAQ23876 16-Bit, 15 MSPS uModule Data Acquisition
> +	    Systems
> +	  * ADAQ23878 18-Bit, 15 MSPS uModule Data Acquisition System

Why not keep this list sorted by a part number?

...

>  struct ad7625_chip_info {
>  	const char *name;
>  	const unsigned int max_sample_freq_hz;

>  	const bool has_power_down_state;
>  	const bool has_bandwidth_control;
>  	const bool has_internal_vref;

Side note: What the point in const to these (plain booleans, integers)?
Chip info as a whole should be const, no?

...

> +	/*
> +	 * The LTC2387 and ADAQ2387x output data on one or two lanes at double
> +	 * data rate, have no EN pins and learn their timing from the PWMs.
> +	 * They are the parts with @ddr_timing set.
> +	 */
> +	const struct ad7625_ddr_timing *ddr_timing;
> +	const char * const *supplies;

Again, why the second const here...

> +	int num_supplies;
> +	/* Gain * 1000 of the ADAQ front end, 0 if the board has to provide it. */
> +	const u16 default_gain_milli;

...and the const here?

milli is multiplier and not a unit. But if you think it's better this way, I am
not going to object.

>  };

...

> +static const char * const adaq2387x_supplies[] = {
> +	"vdd", "vio", "vs-p", "vs-n"

When not on a single line, add a trailing comma.

> +};

...

> +static const struct ad7625_chip_info ltc2387_16_chip_info = {
> +	.name = "ltc2387-16",
> +	.max_sample_freq_hz = 15 * MEGA,

No, we have HZ_PER_MHZ for this.

> +	.chan_spec = AD7625_CHAN_SPEC(16),
> +	.has_internal_vref = true,
> +	.ddr_timing = &ltc2387_ddr_timing,
> +	.supplies = ltc2387_supplies,
> +	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
> +	.default_gain_milli = 1000,

As I mentioned above this multiplier without unit is confusing.
Simply

	.default_gain = 1 * MILLI,

?

> +};

Same comments to all added chip info:s.

...

> +	/*
> +	 * The waveforms are whole steps, so nothing should have to grow. If it
> +	 * did, a minimum time of the part is no longer met.
> +	 */
> +	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
> +	if (ret)
> +		return ret < 0 ? ret : -EINVAL;
> +
> +	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
> +	if (ret)
> +		return ret < 0 ? ret : -EINVAL;

Don't nest branches, you can just move ret == 0 check out of that in both cases.

...

> +static int ad7625_parse_ddr(struct device *dev, struct ad7625_state *st)
> +{
> +	int ret, i;

Why is 'i' signed and why can't it be defined inside for-loop?

> +	st->two_lanes = device_property_read_bool(dev, "adi,use-two-lanes");
> +
> +	/* A fixed gain part has no adi,gain-milli, the others are pin strapped. */
> +	st->gain_milli = st->info->default_gain_milli;
> +	if (st->gain_milli)
> +		return 0;
> +
> +	if (!device_property_present(dev, "adi,gain-milli"))
> +		return dev_err_probe(dev, -EINVAL, "adi,gain-milli must be set\n");
> +
> +	ret = device_property_read_u16(dev, "adi,gain-milli", &st->gain_milli);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read adi,gain-milli\n");

	const char *propname;
	...
	propname = "adi,gain-milli";

	// Why do we even need the presence check?
	if (!device_property_present(dev, propname))
		return dev_err_probe(dev, -EINVAL, "%s must be set\n", propname);

	ret = device_property_read_u16(dev, propname, &st->gain_milli);
	if (ret)
		return dev_err_probe(dev, ret, "failed to read %s\n", propname);


> +	/* The scale shifts the gain by up to 17 bits, so it has to stay small. */
> +	for (i = 0; i < ARRAY_SIZE(ad7625_gains_milli); i++)
> +		if (st->gain_milli == ad7625_gains_milli[i])
> +			return 0;
> +
> +	return dev_err_probe(dev, -EINVAL, "unsupported adi,gain-milli %u\n",
> +			     st->gain_milli);
> +}

...

> +static int devm_ad7625_ddr_regulator_setup(struct device *dev,
> +					   struct ad7625_state *st)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, st->info->num_supplies,
> +					     st->info->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable supplies\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0 && ret != -ENODEV)

Too many ENODEV checks, see below how to deduplicate.

> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> +	if (!ret)
> +		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");

	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
	if (ret == -ENODEV)
		/* Without ref-supply the internal reference is used. */
		st->vref_mv = AD7625_INTERNAL_REF_MV;
	else if (ret < 0)
		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
	else if (ret == 0)
		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");

	st->vref_mv = ret / (MICRO / MILLI);

> +	/* Without ref-supply the internal reference is used. */
> +	st->vref_mv = ret == -ENODEV ? AD7625_INTERNAL_REF_MV : ret / (MICRO / MILLI);
> +
> +	return 0;
> +}

...

> -		/*
> -		 * If neither sampling mode is available, then report an error,
> -		 * since the other modes are not useful defaults.
> -		 */
> -		if (st->can_wide_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> -					      st->have_refin, st->vref_mv);
> -		} else if (st->can_narrow_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> -					      st->have_refin, st->vref_mv);
> -		} else {
> -			return dev_err_probe(dev, -EINVAL,
> -				"couldn't set device to wide or narrow bandwidth modes\n");
> -		}
> -
> -		if (ret)
> -			return dev_err_probe(dev, -EINVAL,
> -					     "failed to set EN pins\n");

AFAICS the above can be moved to a helper in the separate patch and moved as a
couple of lines only in this patch.

...

> +	if (st->info->ddr_timing) {
> +		ret = iio_backend_num_lanes_set(st->back, st->two_lanes ? 2 : 1);
> +		/* Without the op, a backend can only be left on one lane. */
> +		if (ret && (ret != -EOPNOTSUPP || st->two_lanes))
> +			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
> +	}

Same problem, too many (hidden) branches makes code unreadable.

	if (st->info->ddr_timing) {
		if (st->two_lanes) {
			ret = iio_backend_num_lanes_set(st->back, 2);
		} else {
			ret = iio_backend_num_lanes_set(st->back, 1);
			/* Without the op, a backend can only be left on one lane. */
			if (ret == -EOPNOTSUPP)
				ret = 0;
		}
		if (ret)
			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
	}

...

> +	/* The DDR parts reject rates above the clock of the PWMs. */
> +	if (st->info->ddr_timing)
> +		default_sample_freq = min_t(u32, default_sample_freq, st->step.clk_rate_hz);

No min_t().

-- 
With Best Regards,
Andy Shevchenko


