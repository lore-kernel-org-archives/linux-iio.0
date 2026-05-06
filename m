Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6215E5DC;
	Wed,  6 May 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062807; cv=none; b=BywZPkHxdGT0GGiQIL6KTtBQ905NR58ZOjKalldNTMey/4LPu9n/8ZdMcRE3kXSEmWNo7DX8CYs314zeF5vip2GQgWIBeJK5nzkeff7Jdx8KkQD3CZmEHGP+hqlm8w2Vd5xmG3elk6swriLLEmYWweICrFNh2BmDzig/LN0o7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062807; c=relaxed/simple;
	bh=Zt9NvvKHnGvKw5r01Gh/WWjGIT86CShaDulVPtQKs/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfLMoFKQWQKfx17kQcKxtGt7ZrZru6UiJpbdt7cNcSaEhBgbpkTYTLkq83sy3IAge+5N+94pAx+iZLaGs+fKyDfXVG4sQ9lGqklPuCB2smpgc/PfwhmuzvGcTHzrOmaSolBeIJ++a6USz0bJZ5l6aZpByD5R8O3u89IC/RTHeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHTtXSsj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHTtXSsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778062804; x=1809598804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zt9NvvKHnGvKw5r01Gh/WWjGIT86CShaDulVPtQKs/A=;
  b=LHTtXSsjLhI5gofk5wkNGPVpOvZy4S7IihEPEg1v62EIQgbyImKnWJ61
   idEw74jewPq8EbPteC7A94gdwb0gcg8J3A6jrr81n96tS47TserwTeP6r
   FRCWNFGxXFKCwOxmQL3dlFY07vo33L6vqd2Osb5KYUQ52mY4CU6fbpNj7
   hMs497aqq1x+IA9SEX8s+UXmPeMdbJYQ/mNln5/XDAcRsdylOr5lfZAM9
   mdqBSlnvhTD4zXyM1lSFykptoTAq1A0VDggzU/kKYyVs0Jyci+CPouEH2
   dnMorRlcfnzF+YtVWoGTXnECeToWxZ2nbFuCtDmusx9wSJGfgOU/exDLZ
   A==;
X-CSE-ConnectionGUID: 8G3stUB3Tg+WKygLF2cD8g==
X-CSE-MsgGUID: KSltdRm6S2eAud5pZPfQCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78138270"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78138270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:20:02 -0700
X-CSE-ConnectionGUID: Mt/QWNBYR5GOFAX/hp4RUw==
X-CSE-MsgGUID: gBETY5CbRvOO1zTayYrRLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241078321"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:19:59 -0700
Date: Wed, 6 May 2026 13:19:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/3] iio: light: tcs3472: implement wait time and
 sampling frequency
Message-ID: <afsVzTytyLsNcAi0@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <20260506094311.222500-3-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094311.222500-3-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:43:10AM +0200, Aldo Conte wrote:
> The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
> register and the WAIT register, with ad additional WLONG bit in CONFIG
> that if set multiplies the wait step by 12. The driver previously
> defined TCS3472_WTIME but never used it leaving the TODO comment on
> the top of the source file.
> 
> Implement sampling frequency control via IIO_CHAN_INFO_SAMP_FREQ:
> 
> - Reading sampling_frequancy computes the chip's actual cycle time as
>   the sum of ATIME, RGBC initialization time (that is fixed) and the
>   WAIT time that depends on WLONG and WEN bits. WEN is used to enable
>   the chip to consider the WAIT state (without which it would proceed
>   directly to the rgbc init state).
> 
> - Writing sampling_frequency programs WTIME accordingly with current
>   ATIME in order to obtain a cycle period that approximates as close as
>   possible the requested frequency.
>    - If the requested frequency is too
>      low (and so the cycle is too large) the WLONG bit is asserted.
>    - If the requested frequency is too high to be reached with a
>      non-zero wait time, WEN is disabled so that wtime_us becomes 0 and
>      conversions run back-to-back at the maximum rate accordingly with
>      ATIME.
> 
> - The user's last requested frequency is saved in the driver's
>   private data in order to use it when a new integration time (ATIME)
>   is requested: when ATIME changes, the wait time is recalculated to
>   ensure that the previous requested frequency is ashered to as closely
>   as possible.
> 
> - The cycle time computation respects the WEN and WLONG for the
>   evaluation of wtime_us.
> 
> - Concurrent access to driver's private data into the
>   tcs3472_set_sampling_freq function is protected by the guard(mutex).

> Tested on a Raspberry Pi 3B with a TCS3472 breakout at I2C address
> 0x29, by writing values to `sampling_frequency` and veifying the
> reported value via `cat sampling_frequency`, and checking that changing
> `integration_time` preserves the previusly requested sampling frequency.

No noise in the commit message.

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/pm.h>
> +#include <linux/math64.h>
> +#include <linux/cleanup.h>

Please, add another patch that sorts headers alphabetically first.

...

>  struct tcs3472_data {
>  	struct i2c_client *client;

>  	u8 control;
>  	u8 atime;
>  	u8 apers;
> +	u8 wtime;
> +	bool wlong;
> +	int target_freq_hz;
> +	int target_freq_uhz;
>  };

Does `pahole` agree with the proposed layout?

...

> +static unsigned int tcs3472_cycle_time_us(struct tcs3472_data *data)
> +{
> +	unsigned int atime_us = (256 - data->atime) * 2400;
> +	unsigned int init_us = 2400;
> +	unsigned int wtime_us;
> +
> +	if (!(data->enable & TCS3472_ENABLE_WEN))
> +		wtime_us = 0;
> +	else if (data->wlong)
> +		wtime_us = (256 - data->wtime) * 28800;
> +	else
> +		wtime_us = (256 - data->wtime) * 2400;

This is the same as atime_us.

> +	return wtime_us + init_us + atime_us;
> +}

...

> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int cycle_us = tcs3472_cycle_time_us(data);
> +
> +		*val = USEC_PER_SEC / cycle_us;
> +		*val2 = (u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC / cycle_us;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
>  	}
>  	return -EINVAL;

To avoid confusion add another patch to move this kind of standalone return:s
to the default case of the respective switch-cases.

...

> +static int tcs3472_set_sampling_freq(struct tcs3472_data *data,
> +				     int val, int val2)
> +{
> +	unsigned int atime_us = (256 - data->atime) * 2400;
> +	unsigned int init_us = 2400;
> +	u64 cycle_us;
> +	s64 wait_us;
> +	int wtime;
> +	bool wlong = false;
> +	int ret;
> +
> +	if (val < 0 || (val == 0 && val2 <= 0))
> +		return -EINVAL;

What if val > 0 && val2 < 0?

> +	guard(mutex)(&data->lock);

> +	cycle_us = div_u64((u64)USEC_PER_SEC * USEC_PER_SEC,

This is strange. One of the multiplier either should be MEGA / MICRO or this to
be PSEC_PER_SEC.

> +			   (u64)val * USEC_PER_SEC + val2);

include/linux/math64.h:116: * div_u64 - unsigned 64bit divide with 32bit divisor

> +	wait_us = (s64)cycle_us - init_us - atime_us;

So how wait_us can be negative. Can you add a comment explaining the cases when
it's possible and what we are going to do about this?

> +	/* Wait state is not needed.
> +	 * Requested frequency is too high to be reached with any
> +	 * non-zero wait time. Disable WEN so the chip runs at the
> +	 * maximum rate allowed by ATIME alone.
> +	 */

/*
 * Wrong multi-line comment style. Use this
 * example on how to do correctly.
 */

> +	if (wait_us < 2400) {
> +		if (data->enable & TCS3472_ENABLE_WEN) {
> +			data->enable &= ~TCS3472_ENABLE_WEN;
> +			ret = i2c_smbus_write_byte_data(data->client,
> +							TCS3472_ENABLE,
> +							data->enable);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		data->target_freq_hz = val;
> +		data->target_freq_uhz = val2;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Wait state is needed: make sure WEN is active before
> +	 * programming WTIME (and possibly WLONG).
> +	 */
> +	if (!(data->enable & TCS3472_ENABLE_WEN)) {
> +		data->enable |= TCS3472_ENABLE_WEN;
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						TCS3472_ENABLE,
> +						data->enable);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	wtime = 256 - (int)DIV_ROUND_CLOSEST((unsigned long)wait_us, 2400);

Too many castings.

> +	if (wtime < 0) {
> +		wlong = true;
> +		wtime = 256 - (int)DIV_ROUND_CLOSEST((unsigned long)wait_us,
> +						     28800);

Ditto.

> +		if (wtime < 0)
> +			wtime = 0;
> +	}
> +	if (wtime > 255)
> +		wtime = 255;

These two is reinvention of clamp() from minmax.h.

> +	if (wlong != data->wlong) {
> +		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (wlong)
> +			ret |= TCS3472_CONFIG_WLONG;
> +		else
> +			ret &= ~TCS3472_CONFIG_WLONG;
> +
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						TCS3472_CONFIG, ret);

Use room up to 80 (inclusive) characters.
Also note the ret = foo(ret) is a bad style.

> +		if (ret < 0)
> +			return ret;
> +
> +		data->wlong = wlong;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->wtime = wtime;
> +	data->target_freq_hz = val;
> +	data->target_freq_uhz = val2;
> +
> +	return 0;
> +}

...

> -	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> +	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
> +			TCS3472_ENABLE_WEN;

It's used at least two times, define a new one that combines all three with
a meaningful name.

...

> +	data->target_freq_uhz = (u64)(USEC_PER_SEC % cycle_us) *
> +				USEC_PER_SEC / cycle_us;

This is wrong. It won't compile (on 32-bit architectures).

-- 
With Best Regards,
Andy Shevchenko


