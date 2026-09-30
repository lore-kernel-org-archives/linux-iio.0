Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBA3BA225;
	Wed, 30 Sep 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761371; cv=none; b=LDqxGRqvaMasZEhADgLzzIQ8/MmSojIcLAan58ZUnw9JXw97gNA4rLAJapUBiumXGHp0yjAegoODT6+obYKJZvhUvsqmEB3wW+FvGXAYfL3mT2ftPkPmmNG6ZTFRTwYJF7UuSZ7yK+WBsCQ+3HEowBMXVf/JwINT1AOVHnBKjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761371; c=relaxed/simple;
	bh=UpVo/9oo+I+cdDKADG6LHHYGYOhnAQ/JXOF5dFeJPis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWMx1gEdEvi//aO1AJONCVdT5fLxlFXMwt2M6HLlf61X6+/JWF8h/HZmBX7afl0Wb75iCDSHdO1bbc+HNLzgPELbsdEIPnILtcxigby4wxvqUfX4ghCkWz5MPntvO8k0QUU6d+eADffG2Fi2RCcM4qXDK8ZIGEayC9oGh7242+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ826Yrt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ826Yrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790761368; x=1822297368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpVo/9oo+I+cdDKADG6LHHYGYOhnAQ/JXOF5dFeJPis=;
  b=RJ826YrttEj9jYxyS+jrDDS57zhlcwxpIgB4SvQwl1KYujJsYbOhIoiz
   TybHCtclFw8cYI8u/FNsR/5HtVfByzxOYfZ3GsfAXOjc/CF68m1OTowcQ
   gVbOxccuK07shmNTeFCrsV/s3OCpDJ4q1/E6hMS7lgoIIf7dCR9E8tRPw
   RzOQSFWK7d3qXKb2CSLXN1eM6J3QvHklsRw6WBNkprTFS0uwIMISTOZqt
   MMkhw6AkVLrXtSbUVjsZbWubxXXBUcpP1Ccv0xjqr0Keri3fpgLf+xiyM
   8JesKNc0CwZmCrLuPK3WSpfxqG+RnWVn+wTDOXJmv3izfN2qT8bj/M62B
   A==;
X-CSE-ConnectionGUID: 25QRJAFuRHi08VuNmL5bHw==
X-CSE-MsgGUID: BolMD3DFQ6+L9Gqm8RZuYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90448846"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90448846"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:42:46 -0700
X-CSE-ConnectionGUID: A4/Osl6JQ+Ch0ChbQgDO3g==
X-CSE-MsgGUID: ZDrpq4erS7yLIduP0E5LKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275683263"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:42:43 -0700
Date: Wed, 30 Sep 2026 12:42:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 12/13] iio: adc: ad4134: Support high-speed data
 capture
Message-ID: <arzZkKZcOlL05ucG@ashevche-desk.local>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <60682dd6c61806bf0d024d242c62b39a349db4f1.1790719425.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60682dd6c61806bf0d024d242c62b39a349db4f1.1790719425.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 07:45:40PM -0300, Marcelo Schmitt wrote:
> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 1.496 MSPS).

...

> +	odr_wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq_Hz);
> +	/*
> +	 * Set the PWM duty cycle to keep ODR high for at least minimum required
> +	 * time. If the rounded PWM's value is less than the minimum required,
> +	 * increase the target value by 10 and attempt to round the waveform
> +	 * again, until the minimum (or try count limit) is reached.
> +	 */
> +	odr_high_time_ns = div64_ul(6ULL * NSEC_PER_SEC, st->sys_clk_hz);
> +	target_ns = 0;
> +	count = 100;
> +	do {
> +		target_ns += 10; /* Increment by PWM duty cycle period */
> +		odr_wf.duty_length_ns = target_ns;
> +		ret = pwm_round_waveform_might_sleep(st->odr_pwm, &odr_wf);
> +		if (ret)
> +			return ret;
> +	} while (count-- && odr_wf.duty_length_ns < odr_high_time_ns);

In do {} while () cases the counter check should be --count, otherwise it's
off-by-one (non-critical) mistake, you will have 101 iterations instead of 100.

> +	/* Check the minimum ODR high time is met */
> +	if (odr_wf.duty_length_ns < odr_high_time_ns)
> +		return -EDOM;
> +
> +	if (odr_wf.period_length_ns < 2 * odr_high_time_ns)
> +		return -EDOM;
> +
> +	/*
> +	 * Configure SPI offload PWM trigger.
> +	 * For gated DCLK, the minimum required time between ODR rising edge
> +	 * and DCLK rising edge is the sum of ODR high time and ODR falling
> +	 * edge to DCLK rising edge time. Delay the offload trigger for at least
> +	 * that amount of time so the ADC sample data will be available when the
> +	 * SPI transfer begin.
> +	 *
> +	 * Use the same period as ODR PWM to avoid timing issues.
> +	 * Convert back from period to frequency for the SPI offload API.
> +	 */
> +	offload_period_ns = odr_wf.period_length_ns;
> +	config.periodic.frequency_hz = DIV_ROUND_UP_ULL(HZ_PER_GHZ, offload_period_ns);
> +	offload_offset_ns = odr_high_time_ns + AD4134_DCLK_RISING_OFFSET_NS;
> +	count = 100;
> +	do {
> +		config.periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
> +		if (ret)
> +			return ret;
> +
> +		offload_offset_ns += 10;
> +	} while (count-- && config.periodic.offset_ns < odr_high_time_ns +
> +							AD4134_DCLK_RISING_OFFSET_NS);

Ditto.

...

> +	if (!st->sys_clk_hz)
> +		return dev_err_probe(dev, -EINVAL, "0 Hz external clock\n");

Perhaps -ERANGE?


...

Address the above only if you need a new version, otherwise they are not a big
deal.

-- 
With Best Regards,
Andy Shevchenko


