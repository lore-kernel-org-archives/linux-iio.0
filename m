Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B713957E;
	Sun,  8 Feb 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558987; cv=none; b=uf/FEQL6tu3UWbUh9BeVWFVXLEYWQevkaxKSsspZsEmzq8yCpoJmQMEM+R1VotuHg/MNmEyBFccCKBFegOOUyqYVqJKyiHHbPodXaGj07XQNWWkivI7rpXfKPJjDrLy/rZmFemDnVQntKq34EHS9bXW5p1+HgGiz21ANsphtKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558987; c=relaxed/simple;
	bh=cW/XNst2/Ps79cbEvwwrzDAqpH60Upk+bWn7mYI4iKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAYkKRXGTQyFwtNWe0T5qdnPhHuJBkq5nuhlQWbcC/WdF8HOkxmPuFOpgb/JStUjLwXHq2+DIqPXl3T6BF0dmWvWK6c7GYJx9uR8IhH/sZq5BAOFnPbwBPChQQQ/1Tn7mwmbkn/u1AI7Snokadi/Til90Q5s8PsHuqPAIwldbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzBqHEIi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzBqHEIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770558987; x=1802094987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cW/XNst2/Ps79cbEvwwrzDAqpH60Upk+bWn7mYI4iKM=;
  b=AzBqHEIiES4VWDTGyi8jNBGB0t7lOM4UL09vRHlG1utR+OQDcq5g9ZoI
   1TrZFwuKaxmUGPUqZwncuWtXYnBaF8kwl4IWXElScayrdq4re8fAjB0lO
   6DDQXa9UdkF4QlHm0C2thYQMq/PGKk9aGJAvI5SEn3A4+RCuo/fqgCxEr
   abCNoZf8/Vpxkv7C/QF3fVtmGqxmlGmz1hDszb6OEdx8ViOIOV02NQrR3
   3+uM55G5T0NXnxADt9Ac9M8YrUs62svmGKrvMAWwdlggVL+8KSPbA9TEi
   zvAfoJqCNW+d96cGPLiMwxIIcLDSTNb399tV5C3S/kbNWKbTFy4KkZ6WO
   w==;
X-CSE-ConnectionGUID: jSVFOcM8ROujJjGs4tUAZA==
X-CSE-MsgGUID: MVka5JnySsyxn3eKKhbY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="59258926"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="59258926"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:56:26 -0800
X-CSE-ConnectionGUID: KF7RPxSKRbCxdZRTMaXBSA==
X-CSE-MsgGUID: NBXjenl1SOWWucB+iRJ93g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="210640017"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:56:21 -0800
Date: Sun, 8 Feb 2026 15:56:19 +0200
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
Subject: Re: [PATCH v8 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aYiWA5ev2nPF8UxU@smile.fi.intel.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
 <315c614e65e40634251e624d73d83fdea4c51c78.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315c614e65e40634251e624d73d83fdea4c51c78.1770403407.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 04:01:33PM -0300, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.

...

> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq_hz, unsigned int avg_log2)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	unsigned int offload_period_ns, cnv_rate_hz;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
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

See below.

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

Does the above have a side-effect on period_length_ns? If not, the below check
should be moved up, otherwise here should be a short comment explaining the
side-effect(s).

> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;

> +	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_hz);
> +
> +	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
> +
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

-- 
With Best Regards,
Andy Shevchenko


