Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B53E5EFA;
	Thu,  3 Sep 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418824; cv=none; b=mYoXa3JPXzOcg4MerVSYKy4qRY9iPzOP6VtnFgjo7xVhx1UOWVLRqdeOOw2k2UmflG7XIrk1jHZnZMCLZm8tnleva5xHR1606dSre3n7NQWBhROXnXAnM52sjR3m1d9rlIOvDgCdfj6GH08zFpzprTSN0GE3yDMSo8LYZkmKs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418824; c=relaxed/simple;
	bh=QOYufKxH+f3YmteiwiPOwFOBIKX7A7dTy+IgOo6PyDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfzhRWS2G2m5hcDep71rcshvs7I5vqgufcNmqU68WDgwRtknv3zJOj0WIngldHCqSFaqMj8NMisC/TBBgf8r5ru7BS8wdS9YzEM7KZKlMIm4hF6wCxz4f+Wit8iYVK1vk35eBZrGJMP7Pxsk88JsWVFvFM/VRr8DqozkzJhFQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMQAqH82; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMQAqH82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788418823; x=1819954823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QOYufKxH+f3YmteiwiPOwFOBIKX7A7dTy+IgOo6PyDI=;
  b=fMQAqH82Wyc3CCC5ab1dEYKRgiOSrdK9wnBY1YIYdRqb4lYImet92gjo
   OcRwRmRYqB3zh4FpUVpDAs9XYtZ+JJBBSA/+RGsHELMWJAdfWZrjsLHpM
   +fvah+G7oFtrB3/QudHVnSOHy61+c+FKEXCzBR/DxhDSDjpQtcpWgGwP4
   tWzawJ0cI/qOF3eo0zJaQbOuZUojY/QlVvgSc+tjxwz7ywFx0B/QOhdLr
   4i7d4J73HgBvS4++iOITAyWiZyRy8y5pMVT/70CQ3KHp7mbc2q0wt2nDy
   xjNt34SIw1FU/kTZKJbPHHNCWT/FEVTvN1Nb8bblC1rcgwabiLTUUQqWI
   g==;
X-CSE-ConnectionGUID: twhwRkbYQlq1Y9ZfkCEJYQ==
X-CSE-MsgGUID: NsUtAu5aTMaVvtZ9H9GqdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111663389"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="111663389"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:00:22 -0700
X-CSE-ConnectionGUID: GDejSu/6T5GxuGFpNnwcmw==
X-CSE-MsgGUID: 8O6qrlUKSkeMsw66MPn5jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267874393"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:00:19 -0700
Date: Thu, 3 Sep 2026 10:00:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 12/13] iio: adc: ad4134: Support high-speed data
 capture
Message-ID: <apkbAMQ0J2_wJRTv@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <53d79eed25795db5076d7c591f6dd8cf4feedfec.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d79eed25795db5076d7c591f6dd8cf4feedfec.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:25:26PM -0300, Marcelo Schmitt wrote:
> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 1.496 MSPS).

...

> +static int ad4134_update_conversion_rate(struct ad4134_state *st,
> +					 unsigned int freq_Hz)
> +{
> +	struct spi_offload_trigger_config config = st->offload_trigger_config;
> +	struct pwm_waveform odr_wf = { };
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	u64 odr_high_time_ns;
> +	unsigned int count;
> +	u64 target = 10;

Split assignment and move it closer to its first user.

> +	int ret;
> +
> +	if (!in_range(freq_Hz, AD4134_MIN_ODR_FREQ_HZ, AD4134_MAX_ODR_FREQ_HZ))
> +		return -ERANGE;
> +
> +	odr_wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq_Hz);
> +	/*
> +	 * Set the PWM duty cycle to keep ODR high for at least minimum required
> +	 * time. If the rounded PWM's value is less than the minimum required,
> +	 * increase the target value by 10 and attempt to round the waveform
> +	 * again, until the minimum (or try count limit) is reached.
> +	 */
> +	odr_high_time_ns = div64_ul(6ULL * NSEC_PER_SEC, st->sys_clk_hz);

	target = 0;

> +	count = 100;
> +	do {

		target += 10; /* Increment by PWM duty cycle period */

> +		odr_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->odr_pwm, &odr_wf);
> +		if (ret)
> +			return ret;

> +		target += 10; /* Increment by PWM duty cycle period */

In the above way I think it clarifies the initial setting to 10.

Shouldn't be target named as target_ns? Can we use odr_wf.duty_length_ns
directly?

> +	} while (count-- && odr_wf.duty_length_ns < odr_high_time_ns);
> +
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

Does this need the similar comment as per above?

> +	} while (count-- && config.periodic.offset_ns < odr_high_time_ns +
> +							AD4134_DCLK_RISING_OFFSET_NS);
> +
> +	/* Check the minimum ODR to DCLK delay is met */
> +	if (config.periodic.offset_ns < odr_high_time_ns + AD4134_DCLK_RISING_OFFSET_NS)
> +		return -EDOM;
> +
> +	/* Check the PWM periods remain the same */
> +	offload_period_ns = DIV_ROUND_UP_ULL(HZ_PER_GHZ, config.periodic.frequency_hz);
> +	if (odr_wf.period_length_ns != offload_period_ns)
> +		return -EDOM;
> +
> +	ret = pwm_set_waveform_might_sleep(st->odr_pwm, &odr_wf, false);
> +	if (ret)
> +		return ret;
> +
> +	st->offload_trigger_config = config;
> +	st->odr_wf = odr_wf;
> +	st->odr_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, odr_wf.period_length_ns);
> +
> +	return 0;
> +}

...

> +static int ad4134_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4134_state *st = iio_priv(indio_dev);
> +	int ret, ret2;

These ret2:s in the cases of _set_register_() can be named accordingly.

> +	if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
> +		ret = ad4134_set_sample_access(st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ad4134_prepare_offload_msg(indio_dev);
> +	st->msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		goto out_set_register_input;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	return 0;
> +
> +out_unoptimize:
> +	spi_unoptimize_message(&st->msg);
> +
> +out_set_register_input:
> +	ret2 = ad4134_set_register_access(st);
> +	if (ret2)
> +		dev_err(&st->spi->dev, "reg input select error: %d\n", ret2);
> +
> +	return ret;
> +}

...

> +/* The chip converts and outputs all 4 channels on each sample request */
> +static const unsigned long ad4134_scan_masks[] = {
> +	GENMASK(3, 0),

IIRC Jonathan wants to see this as BIT(x) | BIT(y) | ... to clarify that each
bit is semantically independent.

> +	0
> +};

-- 
With Best Regards,
Andy Shevchenko


