Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433373793BE;
	Tue,  9 Jun 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987499; cv=none; b=byX5nO5OxwLJaXLkkjilxxK9E42fN8X1bnXLqmUPKcMYceIB56n4Elz7o56AGBEpLjYE0Fe1B3Dhrv/hB/f74XHMSXT7I6nCn7be700FI3qLFx1XTIPATfPej005hlGcqCqaSCf+FE7+K5QGIDjFPi0Z3X5KqPbJuuR3A0teF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987499; c=relaxed/simple;
	bh=2d+e39/Gy9jM1q0Jzns3jhAkQpx9ju3ZplUzV8b/Pvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgg2cTtPkRyK65X3J2olzjUu9So/mN1e3v2K3tlb7vaW/oIvDwxyR48yU/yKF31Ue+TrdMQO7Mxmo0yrcS3z1aduUe8QPIGxNI4iave2K02Bgfdz6+G5sjisZl7zN1XUlYJO3qZPD7qu1f/092uGvbUDxvKIvqLBv9U3Z4+YfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeOkTerG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeOkTerG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780987496; x=1812523496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2d+e39/Gy9jM1q0Jzns3jhAkQpx9ju3ZplUzV8b/Pvg=;
  b=eeOkTerGt+YDU+hk8A9Xhw11qiffQVDmVpagsy4kbKe0vItwvxYSnVW/
   oC4oGpZKs65WS6qcDqwsiIWaJKk/87Kn8tdwiHhkjxz6ZT7Ujf7mlMIwR
   K6TSBD+2EjfpXben+ScA99GL28+HSWjUFLPp234PWNvjJWsUEzhtDJGo4
   IYiRo95u5+icWOYLy6DxxQADmORbSBC8MXbZEbaRYUiW1HvLGF14r1sai
   C0sBMjeMdwNiVpjOd9GUz1XpY9BSK2FFfYDqHstZZLT6AwDaapyi4fmBW
   gOSLgZx63sdKfW0p9oJ/LOvzkDf9aMOGe87zq5Y07gE+eVBh+wSuFtXE1
   w==;
X-CSE-ConnectionGUID: eJ+u7BLLT96Cii6VbH6fhg==
X-CSE-MsgGUID: h7oKKIDqQ/6c3d34iNqEPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81648410"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81648410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:44:56 -0700
X-CSE-ConnectionGUID: PbnfN6VZQY2Rvx7v5b/hTQ==
X-CSE-MsgGUID: 7nAbWZmpRDO3R9V+Hw3Clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="242830798"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:44:53 -0700
Date: Tue, 9 Jun 2026 09:44:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <aie2Y96Oylb5EEtM@ashevche-desk.local>
References: <20260607112713.299968-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607112713.299968-1-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 01:27:13PM +0200, Aldo Conte wrote:
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
> Remove the "TODO: wait time" comment at the top of the file.

In general LGTM, but I have a few nit-picks/questions below.
In any case
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
> +	atime_us = (256 - data->atime) * 2400;
> +	cycle_us = div64_u64(PSEC_PER_SEC,
> +			     (u64)val * USEC_PER_SEC + val2);

I'm a bit puzzled why cycle has "us" suffix. We divide seconds by seconds...

> +	/*
> +	 * wait_us can be negative when the requested frequency is too high
> +	 * to be reached, or very large when the requested frequency is
> +	 * close to zero. Use s64 to cover the full range:
> +	 *
> +	 *   cycle_us = PSEC_PER_SEC / (val * USEC_PER_SEC + val2)
> +	 *
> +	 * The divisor of the formula above reaches its maximum when
> +	 * val = val2 = INT_MAX:
> +	 *  INT_MAX * USEC_PER_SEC + INT_MAX = ~2.15e18
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

> +

Unneeded blank line.

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
> +		wlong = true;
> +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
> +	}
> +	wtime = clamp(wtime, 0, 255);

Seems like wtime calculation is not used in the below conditional.

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

Not sure, but we can move the

	wtime = clamp(wtime, 0, 255);

from the above to be here. It might also need a comment why wtime can be
negative and why we move that to 0.


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

...

> +			if (val2 != (256 - i) * 2400)

The same is used to calculate atime_us above. Can this be a helper
with a good name?

> +				continue;

-- 
With Best Regards,
Andy Shevchenko


