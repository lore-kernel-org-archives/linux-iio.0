Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05622173D;
	Thu,  5 Feb 2026 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311328; cv=none; b=YCDeeyh1GUNqgMXTZu1wsXFhWxMQQeCAoBEPcWkDKBme0Enb2Qk5MiRHrx1/2oGKe5+xtf8XkPrVeHILtBo+e2Q5BAjrDXOWS5WmdEbKUe1jo0AhPZlA4Z7grfom2qq/ZtAJL0NZT1xiOsT+LIjHxlTufRzumipRJZV/HUZjCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311328; c=relaxed/simple;
	bh=ltu0Hx38Kca1wTG0rkCr6pN7ooPnhl+fLiV+4t0XkeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLQtMVbhfzBmrEC3BJu88GcRygxQ0wKwkbH6qGoYhxy6U6mxmuSHW9YUJ6v+JOS0gyJ8divZnxQylgUY2bjRSaUHHPOmMWqr1vMVTNqyX42DDPGAOQ1WY2UJuvPCVNtaC1DH7cprrsw93PQm7ZFP9RxuIYVCKf77O5g2Fk25yVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvxCb5E8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvxCb5E8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770311328; x=1801847328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltu0Hx38Kca1wTG0rkCr6pN7ooPnhl+fLiV+4t0XkeY=;
  b=IvxCb5E8/jlmLLkxvSORHuxZFj+qWLs2BMygIy1hLVyM2NofxSpM79xk
   OEofoEKrAclyhBPLkoirXNf0ARNBgRq8aux0R1cJJf9NHnVDf/eovPGx2
   mwXt/CG8Inp/oR8/5teh1+9YYjVU7DEDw+v6psyuhReRrWNkKDgQFHyo6
   rV6GLkDTx2HqARRCQhys3hMbvb6qIvFWeIFZRhMJO0dxdrJ8Ivp9sme+7
   +a3MKILZ9/KgmBjVAXtH4gz3JbK04DorDZaaWBlQY510gka2o24ZEePFV
   Q6IrHOZlQf4VhtXE7iATUT7J93shNWfSIdJicPlbRA5Q/nJwUBVgUteEY
   g==;
X-CSE-ConnectionGUID: T1QMyHYYSma88wEYO9o6nA==
X-CSE-MsgGUID: wSY/nyKPQViUZURiNarUag==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82631302"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82631302"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:08:48 -0800
X-CSE-ConnectionGUID: JrrcSmkjQoO+1awxERq9Yw==
X-CSE-MsgGUID: VHEGX9m7TSO9oHGEDzd7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233538906"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:08:44 -0800
Date: Thu, 5 Feb 2026 19:08:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aYTOmc32Q4Iuv-Gi@smile.fi.intel.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
 <21652a067efac362c05f628d56b4880d07c51457.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21652a067efac362c05f628d56b4880d07c51457.1770309522.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 01:48:40PM -0300, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.

...

>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>

I would group out the linux/iio/* at some point as there are many of them here
and the driver belongs to IIO subsystem.

> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/unaligned.h>
>  #include <linux/units.h>
> +#include <linux/types.h>

...

> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq_hz, unsigned int avg_log2)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
> +	unsigned int cnv_rate_hz;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> +	 * signal needs to be N times faster than the offload trigger. Take that
> +	 * into account to correctly re-evaluate both the PWM waveform connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	cnv_rate_hz = freq_hz << avg_log2;
> +
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, cnv_rate_hz);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;
> +
> +	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_hz);
> +
> +	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							 offload_period_ns);

The point of having _ULL version here is...?

> +	/*
> +	 * The hardware does the capture on zone 2 (when SPI trigger PWM
> +	 * is used). This means that the SPI trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->cnv_wf = cnv_wf;
> +
> +	return 0;
> +}

...

> +	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");

No need to check ENODEV twice...

> +	/* Fall back to low speed usage when no SPI offload is available. */
> +	if (ret == -ENODEV) {
> +		/*
> +		 * One hardware channel is split in two software channels when
> +		 * using common byte mode. Add one more channel for the timestamp.
> +		 */
> +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
> +		indio_dev->channels = st->chip->channels;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      iio_pollfunc_store_time,
> +						      ad4030_trigger_handler,
> +						      &ad4030_buffer_setup_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup triggered buffer\n");

...just put it here as

	} else if (ret) {
		return dev_err_probe(...);

> +	} else {
> +		/*
> +		 * Offloaded SPI transfers can't support software timestamp so
> +		 * no additional timestamp channel is added.
> +		 */
> +		indio_dev->num_channels = st->chip->num_voltage_inputs;
> +		indio_dev->channels = st->chip->offload_channels;
> +		ret = ad4030_spi_offload_setup(indio_dev, st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup SPI offload\n");
> +
> +		ret = ad4030_pwm_get(st);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,

You have dev...

> +					     "Failed to get PWM: %d\n", ret);
> +
> +		/*
> +		 * Start with a slower sampling rate so there is some room for
> +		 * adjusting the sample averaging and the sampling frequency
> +		 * without hitting the maximum conversion rate.
> +		 */
> +		ret = ad4030_update_conversion_rate(st, st->chip->max_sample_rate_hz >> 4,
> +						    st->avg_log2);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,

Ditto.

> +					     "Failed to set offload samp freq\n");
> +	}

-- 
With Best Regards,
Andy Shevchenko


