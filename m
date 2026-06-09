Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F13C10B8;
	Tue,  9 Jun 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029390; cv=none; b=Q2Fe03cga8FFZ6WEnB5wosd34IzzMCkyt4Y+Ss7NSV8a9FmgpD4UT1AXLninQjsGvGjaDzX+92LAiGZeVxRRpuPnJ55Zb+FrUXabbINmD89rh5jrld7rfWYMDRRlPNVkdl8juGu2BQ5iLlbsFgw4EdA08KAzCfsQj/J83wjR94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029390; c=relaxed/simple;
	bh=I8n8T+qu3O2i8umTP3FI67aQhKtSu+uXdaXNmytJ6to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw2uzjfe31kcIivBV1IysirP4yEsza4hdml4snQIHfaBaK2nFNzT0wSnkEr8U3dAZVJeY7eJTFlEBa1HdZkEau3J1lqDx1a/ilAwIwxV6nVmxGsihdCRkDxDPtluS7MKPnrQbas5Crtc2JTzO0g3NYhw6vkuSQIAk9HqRtsKLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgO/LmqE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgO/LmqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781029389; x=1812565389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I8n8T+qu3O2i8umTP3FI67aQhKtSu+uXdaXNmytJ6to=;
  b=OgO/LmqEAdqhWDF4aIN+6fRKeghzv1U7wYct2HQ4/XR2uX8ZX6o1uqK5
   3on2n555/e+1vWQtUJDTJ2DJcfdHlE0/j9lGHEnXJZ+rTJePM6k8thskJ
   EjUEH3WeHDnwRMLFDo5wp4yPibUzvPqVJAJFPvpDG49QTzfckMHUGc6rC
   2rVH5e4jYpOJ4x8sRClhXMgkjsVG0BeHjoThzpNptrCt5X6XFjWBYr5Ym
   E7HnuuYoW6sumYyEBR1sYToWfBsClBkHJ3ufxmwtRzSBE4ZMHh/ZLcOtI
   SBshWq7Spfre/zczlSf83NUqFXhw1Sv0TlEOoeSxXgEAhHWKNQboVyWEG
   Q==;
X-CSE-ConnectionGUID: 6J8VdQubSCi8j5h92HZjPA==
X-CSE-MsgGUID: jWNB9kmATby+RKM1W11iiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81995125"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81995125"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:23:09 -0700
X-CSE-ConnectionGUID: UH4t9vsNThKSTblNAMmtCg==
X-CSE-MsgGUID: tIbHhGXpTqyKFjFjas5V7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241796638"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:23:06 -0700
Date: Tue, 9 Jun 2026 21:23:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <aihaCGx9oORj2X3J@ashevche-desk.local>
References: <20260609155515.1004545-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609155515.1004545-1-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 05:55:15PM +0200, Aldo Conte wrote:
> The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
> register and the WAIT register, with an additional WLONG bit in CONFIG
> that if set multiplies the wait step by 12. The driver previously
> defined TCS3472_WTIME but never used it leaving the TODO comment on
> the top of the source file.
> 
> Implement control of the wait time through IIO_CHAN_INFO_SAMP_FREQ:
> 
>   - Reading sampling_frequency returns the chip's current cycle time,
>     computed as the sum of ATIME, the fixed RGBC initialization time
>     and the wait time (which depends on WEN and WLONG).
> 
>   - Writing sampling_frequency programs WTIME so that the resulting
>     cycle period approximates the requested frequency. If the
>     requested frequency cannot be reached with any
>     non-zero wait time, WEN is disabled and the chip runs
>     back-to-back conversions at the maximum rate allowed by ATIME.
>     If the requested period exceeds the maximum WTIME range, WLONG
>     is enabled to extend the wait step from 2.4 ms to 28.8 ms.
> 
>   - The user's last requested frequency is stored in the driver's
>     private data so that subsequent changes to integration_time
>     recompute WTIME and preserve the requested sampling rate as
>     closely as possible.
> 
> Add TCS3472_ENABLE_WEN, TCS3472_ENABLE_RUN and TCS3472_CONFIG_WLONG
> bit definitions. TCS3472_ENABLE_RUN bundles the bits
> (AEN | PON | WEN) that are simultaneously set when the chip is in
> running state and cleared during powerdown, and is used by
> tcs3472_probe(), tcs3472_powerdown().
> 
> Add a u8 enable_pre_suspend field to struct tcs3472_data:
> tcs3472_powerdown() snapshots data->enable into it, and
> tcs3472_resume() restores enable register content from the snapshot.
> This preserves the user's WEN choice across suspend/resume.
> 
> Bound tcs3472_req_data() polling to the worst-case cycle time
> (~8 seconds with ATIME=0x00, WTIME=0x00, WLONG=1).
> 
> Fix the event period calculation in tcs3472_read_event() and
> tcs3472_write_event() to use tcs3472_cycle_time_us() instead of
> ATIME alone. With WEN enabled, the chip cycle includes the wait
> time now.
> 
> Remove the "TODO: wait time" comment at the top of the file.

Now LGTM (one nit-pick, no need to resend, Jonathan can tweak that
whilst applying, I think),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int __tcs3472_set_sampling_freq(struct tcs3472_data *data,
> +				       int val, int val2)
> +{
> +	unsigned int atime_us;
> +	unsigned int init_us = 2400;
> +	u64 cycle_us;
> +	s64 wait_us;
> +	int wtime;
> +	bool wlong = false;
> +	u8 config;
> +	int ret;
> +
> +	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))
> +		return -EINVAL;
> +
> +	atime_us = TCS3472_ATIME_TO_US(data->atime);
> +
> +	/*
> +	 * cycle_us = 1 / freq, expressed in microseconds.
> +	 * Numerator: 1 [s] = PSEC_PER_SEC [ps]
> +	 * Denominator: freq [Hz] * MICROHZ_PER_HZ + val2 [uHz] = freq in [uHz]
> +	 * Result: ps / uHz = us
> +	 */

> +	cycle_us = div64_u64(PSEC_PER_SEC,
> +			     (u64)val * MICROHZ_PER_HZ + val2);

It's perfectly a single line.


> +	/*
> +	 * wait_us can be negative when the requested frequency is too high
> +	 * to be reached, or very large when the requested frequency is
> +	 * close to zero. Use s64 to cover the full range:
> +	 *
> +	 *   cycle_us = PSEC_PER_SEC / (val * MICROHZ_PER_HZ + val2)
> +	 *
> +	 * The divisor of the formula above reaches its maximum when
> +	 * val = val2 = INT_MAX:
> +	 *  INT_MAX * MICROHZ_PER_HZ + INT_MAX = ~2.15e18
> +	 * so cycle_us_min = floor(1e12 / 2.15e18) = 0.
> +	 *
> +	 * The divisor reaches its minimum (1) when val = 0 and val2 = 1,
> +	 * so cycle_us_max = 1e12 / 1 = 1e12.
> +	 *
> +	 * Therefore:
> +	 *   wait_us_min = 0 - 2400 - 612000 = -616800
> +	 *   wait_us_max = 1e12 - 2400 - 2400 = 999999995200
> +	 *
> +	 * Both fit comfortably in s64.
> +	 */
> +	wait_us = (s64)cycle_us - init_us - atime_us;
> +	if (wait_us < 2400) {
> +		if (data->enable & TCS3472_ENABLE_WEN) {
> +			u8 enable = data->enable & ~TCS3472_ENABLE_WEN;
> +
> +			ret = i2c_smbus_write_byte_data(data->client,
> +							TCS3472_ENABLE, enable);
> +			if (ret)
> +				return ret;
> +
> +			data->enable = enable;
> +		}
> +
> +		data->target_freq_hz = val;
> +		data->target_freq_uhz = val2;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Wait state is needed: make sure WEN is active before programming
> +	 * WTIME (and possibly WLONG).
> +	 */
> +	if (!(data->enable & TCS3472_ENABLE_WEN)) {
> +		u8 enable = data->enable | TCS3472_ENABLE_WEN;
> +
> +		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
> +						enable);
> +		if (ret)
> +			return ret;
> +
> +		data->enable = enable;
> +	}
> +
> +	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
> +	if (wtime < 0) {
> +		/*
> +		 * If wait_us is too high (so the requested frequency is too
> +		 * low), the resulting wait exceeds what WTIME can represent
> +		 * (max 614 ms without WLONG). Enable WLONG, whose step is 12x
> +		 * longer (28.8 ms instead of 2.4 ms), and recompute.
> +		 */
> +		wlong = true;
> +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
> +	}
> +
> +	if (wlong != data->wlong) {
> +		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		config = ret;
> +		if (wlong)
> +			config |= TCS3472_CONFIG_WLONG;
> +		else
> +			config &= ~TCS3472_CONFIG_WLONG;
> +
> +		ret = i2c_smbus_write_byte_data(data->client, TCS3472_CONFIG,
> +						config);
> +		if (ret)
> +			return ret;
> +
> +		data->wlong = wlong;
> +	}
> +
> +	/*
> +	 * If the requested wait is so long that even WLONG cannot
> +	 * cover it, wtime may still be negative. Saturate to 0,
> +	 * which is the largest possible wait (256 * 28.8 ms = 7.37 s).
> +	 */
> +	wtime = clamp(wtime, 0, 255);
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
> +	if (ret)
> +		return ret;
> +
> +	data->wtime = wtime;
> +	data->target_freq_hz = val;
> +	data->target_freq_uhz = val2;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


