Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821901;
	b=3PdbV0eq/Q7/uyYzYCK54mMhXb26+PFqPtb8qkS+fAYM2LXtzNzuKLR4zegCmTUn/piw
	 qMi1O+g5r5bjdFHSSjio2rUZF1wNd/I9AtpMPtVqNn/jcibpIDQdxl7jHt/6oDpFCIPa5
	 KYUgEI4g5VJ9di+he/PQOpJ2mwnCo1P5u8MMpphTaWao45EM7hzUa1SHB4P0Lw+dLzku3
	 p05m5LhWaRflVB4/mvqu/klLVW0lU/SmqfY8Pt1hAXrfpSwC5i+tVf52+N8V8eWmEroVN
	 rAKWa/zeSHtLWUqu9IR3K4uv0074QN2ncKlw4MOr03EyGVn1HW7pSvFDWYmGV/gNRgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821901;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Jo6LUuSRpij3XruLJxd10qKw5M+aELp0/drD1Vsxzoo=;
	b=3rWPqC9stZnlxkOuHXYAqw3wsEHbQw8Ml2ugJ7rhP7b4HUTizTj4icIaZReNpKY2nEmf
	 LN9+sZUiv2u92A3Rc/rZqYE6sxOq5JPAhcK9+bxjj/3pu8YOnqNCvqyLSBIPCN5RfMxPn
	 VJoD3bqoAkOyBPUg2j87t8RdDFeacCUOqUXaXmV+obqfpx55BWfMCFVwnHcWUP8Dv+shM
	 mEdQ2jpGxOph07rdRVFzKlSuqNkTTrg8USZQlnjVnkmJAE3FvdWYeJOb9JxuvGOFx4+GT
	 PEjZg5ck2LsopY9/TTRdP/1vEopFAPkep7pzV1Wt9ZesYKtdK75uZ+vbEZVAbSEZkcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPJsetu8;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AE6094217;
	Wed,  4 Nov 2026 19:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103AE6094217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPJsetu8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793821899; x=1825357899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vw6wfWuQFg8TuBapyurRLVHhY0f29ONkPajEuId3aA4=;
  b=nPJsetu8F+fSFMEK7vr/2XTMFnqHhVvTC9LkLucCdg5zTtASUVSDi+cn
   O+JaoJpLVFmgbkQL5mCIEjONfhjicqSy9p/9mIVW6Cj1Srz4vMfDPh59g
   dI8beuj5fgiITxjJ4PLkJdLZ3tzhh27VyDNEBBmSdP0qtTdAsImH3Bk9g
   gvVFsMWx7T8WMMHzjWEAnT59upW2hW497ganBvlTjGRvWjDDTbw8GB9dA
   z1WKZ9JfDWwA13+luPjCFsWRuccLqb+PemJLzcTFMB124VzAFHPuL370U
   nXXC4qqSydvI6i0YCu4XV5k4OogxCWNYF409Powc7mrTDjq+2FadPwXwy
   A==;
X-CSE-ConnectionGUID: UHKgvokfTsGDzAv3oNuzyw==
X-CSE-MsgGUID: zpOX2XSqRFy/0/WnBrYeLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2471383"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2471383"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 11:51:38 -0800
X-CSE-ConnectionGUID: aeSZwbVjQWuALIH+TorRGw==
X-CSE-MsgGUID: PH89EB/PSSag23IZdZvlwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7348819"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 11:51:34 -0800
Date: Wed, 4 Nov 2026 21:51:31 +0200
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
Subject: Re: [PATCH v2 1/5] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <auuMw8tKvGynTKsr@ashevche-desk.local>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261104132143.215581-2-Nicolae-daniel.Deaconescu@analog.com>
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
In-Reply-To: <20261104132143.215581-2-Nicolae-daniel.Deaconescu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:21:39PM +0200, Nicolae-Daniel Deaconescu wrote:
> A consumer that has to meet minimum times, or place an edge relative to
> the cycles of a clock that a PWM gates, cannot do that with the waveform
> API alone. The rounding functions round down, so a minimum has to be
> requested with some margin, and the size of that margin is the step of
> the PWM, which only the provider knows.
> 
> A provider can report the rate of the clock its timing is derived from
> and how many cycles of that clock one step lasts. A consumer can then
> work in whole steps, convert them to nanoseconds rounding up, and get
> that waveform back from the hardware. Without this, a consumer has to
> read the rate from a clock it gets on its own, which describes
> a relationship the hardware doesn't have, and is wrong if
> PWM divides the clock.

...

> +/**
> + * pwm_get_waveform_step_might_sleep - Query the granularity of the waveforms
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @step: output parameter
> + *
> + * Stores in @step the clock rate the timing of @pwm is derived from and how
> + * many cycles of that clock one step lasts. Period, duty length and duty
> + * offset are multiples of that step, so a waveform asked for in whole steps
> + * is not changed by rounding. Compute the length in nanoseconds of n steps
> + * as n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_hz and
> + * round it up, because pwm_round_waveform_might_sleep() and
> + * pwm_set_waveform_might_sleep() round down.
> + *
> + * The values can change when a clock changes its rate, so they are only valid
> + * as long as the provider's input clocks are not reconfigured.
> + *
> + * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
> + * negative errno

> + * Context: May sleep.

This is incorrect. The Returns section has to be the last one in the
kernel-doc. It's documented.

> + */

> +int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm,
> +				      struct pwm_waveform_step *step)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret;
> +
> +	if (!pwmchip_supports_waveform(chip) || !ops->get_waveform_step)
> +		return -EOPNOTSUPP;
> +
> +	might_sleep();
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		ret = ops->get_waveform_step(chip, pwm, step);
> +		non_block_end();
> +	} else {
> +		ret = ops->get_waveform_step(chip, pwm, step);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	if (!step->clk_rate_hz || !step->clk_cycles_per_step ||

The second check is unneeded, the third one covers it.

> +	    step->clk_rate_hz > (u64)step->clk_cycles_per_step * NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	return 0;
> +}

...

> +/**
> + * struct pwm_waveform_step - granularity of the waveforms a PWM can generate
> + * @clk_rate_hz: rate of the clock the PWM's timing is derived from
> + * @clk_cycles_per_step: number of those clock cycles one step lasts
> + *
> + * The period, the duty length and the duty offset of a waveform are multiples
> + * of one step, which lasts @clk_cycles_per_step / @clk_rate_hz seconds. A PWM
> + * that divides its input clock in hardware has @clk_cycles_per_step > 1.
> + *
> + * The step is the same for every waveform and for the period, the duty length
> + * and the duty offset, so a provider whose granularity depends on the
> + * requested period (for example through a prescaler) can't describe itself
> + * with it. One step also has to last at least 1 ns, otherwise rounding a
> + * length in nanoseconds up can add a whole step.
> + *
> + * A consumer that needs a minimum time, or that has to place an edge relative
> + * to the cycles of the clock a PWM channel gates, can use this to ask for
> + * the next possible value instead of one that is rounded down, and to compute
> + * the frequency a rounded period results in without the error of the
> + * nanosecond resolution of struct pwm_waveform.
> + */
> +struct pwm_waveform_step {
> +	unsigned long clk_rate_hz;

_Hz ?

> +	unsigned int clk_cycles_per_step;
> +};

-- 
With Best Regards,
Andy Shevchenko


