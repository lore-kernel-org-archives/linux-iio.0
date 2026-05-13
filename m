Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AC38C2A7;
	Wed, 13 May 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671061; cv=none; b=Ls2rEf3g1We5abGGHG+Y9VG2wfXrNfz0EJ8FieU3HVtjfH1Php72KnG62D1FZOvbctUAHr8rtbo18I7iFSNG7WGEE+N6YPHPociG9w0+E4utgnas/JgYqSgLpoZDm4bcU0A2csDpo2BjgVXTAr42EZ89WH2y4+DvNS56GZDsb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671061; c=relaxed/simple;
	bh=ysb4oz45D7z4bWqYq/Yu/DhNeaPAggsx7lAcT4uxlr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrnvMypijDHmrjDDeZfVBN/92vz5kGhc0ILk+B4Q2hDppQfhVV4dAFAjSw8lxhfwIgeJhdr97/vKymHYx7LKbLsBrfTcYSk7/4qeYt/VuO2waN12YPbH57mqUgPLbbbjvU6dEATKQbWV+V83DJrLQl5N3QwaSXl2QIlilO6vhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VD9nL2oj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VD9nL2oj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778671059; x=1810207059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysb4oz45D7z4bWqYq/Yu/DhNeaPAggsx7lAcT4uxlr8=;
  b=VD9nL2ojEh7PfB+gFA8BAY08Aas8mN69fpEhrmXcJPsqFY/iKgIzJ/PW
   7qDxbypNgc0ikyKXESAqmNJJaGVJS8HnWmOUda0/SEI2kPYbaJAU9vwJw
   FGb38ACQxQ4HwL5fJrMKPQ30biYOJAL4GBf9x45cHmw1b/6RwePG9MfP8
   eSyspaD9nyTZ6euhAA/04bM2NDEMnobb39C1Rb0Nbqq+5gkZItVaTkncm
   KWmJVBviouLWVwow4EZfCH90iytQ8UB2klXMcwzq7k4MAfptcGiAkaWhq
   fByVpCe88GANRXxBRTIu1QhkP6qpHfQUCd8HXLmm/X+puNpTufI9/Jr5/
   g==;
X-CSE-ConnectionGUID: BWL6B0dKT+aJeP0qw6VZvw==
X-CSE-MsgGUID: lmsQqdFDRWG6GvoZ1oVsKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79616881"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79616881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:17:39 -0700
X-CSE-ConnectionGUID: MIKs9zb2RImPDT65eRls+A==
X-CSE-MsgGUID: dJLiDY3WTc6CdviyULpbFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="242408835"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:17:37 -0700
Date: Wed, 13 May 2026 14:17:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 4/5] iio: light: tcs3472: implement wait time and
 sampling frequency
Message-ID: <agRdzneWb2RIidIp@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-5-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512223215.25596-5-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 12:32:14AM +0200, Aldo Conte wrote:
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
> tcs3472_probe(), tcs3472_powerdown() and tcs3472_resume().
> 
> Remove the "TODO: wait time" comment at the top of the file.

> Suggested-by: Andy Shevchenko <andy@kernel.org>

Inappropriate tag.
You must not put tags on your own, if in doubt, ask first!

...

> +#define TCS3472_ENABLE_RUN (TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON | \
> +			    TCS3472_ENABLE_WEN)

Better style is

#define TCS3472_ENABLE_RUN						\
	(TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON | TCS3472_ENABLE_WEN)

...

> +	cycle_us = div_u64((u64)PSEC_PER_SEC,
> +			   (u64)val * USEC_PER_SEC + val2);

First of all, it's one line. Second, the divisor for this function is 32-bit.
And at last the castings are not needed. I think I already told these...

...

> +	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
> +	if (wtime < 0) {
> +		wlong = true;
> +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
> +	}

Why 64-bit divisions? Do you expect the wait_us be outside INT_MIN/INT_MAX range?
This will need a comment and/or dropping the 64-bit arithmetics.

> +	wtime = clamp(wtime, 0, 255);

...

> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
> +	if (ret < 0)

What's the meaning of positive returned values? I think this function never
does that. If I'm right, drop ' < 0' parts in all similar cases.

> +		return ret;

...

> +		*val = USEC_PER_SEC / cycle_us;
> +		*val2 = div_u64((u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC,
> +				cycle_us);

Is this even correct? We take modulo of cycle_us to get under the MICRO range,
then multiply to MICRO (seconds) and divide by full cycle_us. I'm lost here.

...

> +	cycle_us = tcs3472_cycle_time_us(data);
> +	data->target_freq_hz = USEC_PER_SEC / cycle_us;
> +	data->target_freq_uhz = div_u64((u64)(USEC_PER_SEC % cycle_us) *
> +					USEC_PER_SEC, cycle_us);

Okay, this might help with the above... Can you deduplicate this division to
a helper with a comment that explains the calculations behind?

-- 
With Best Regards,
Andy Shevchenko


