Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0933B6C4;
	Sat,  3 Oct 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055618; cv=none; b=NE9WZEDDt//LNKjWXKx9ZOBXL278vN6wiQU2F4YTDp6BMuvYx5gWwnNmBm0wSfTCZ0+4BHXyFUQEedaU/EyIeRfii35wMACjpRyS+klIinemrOJ+z3LP+241bjdPqMHiyFmRet1Cw4ALms8+v0ZrBRuSQcKLbpaANSg37V9iQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055618; c=relaxed/simple;
	bh=xV6d1koFfM5m9rdRyW20nsERICuE43hApgH+Tu8v7gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9v3wDoiZX7H9kAy3CXSgcE1lyiiB7FHWQh+WsGqzi/JmmJnELE2L/aMaeK0htNSYDdxXLxPo7wWoMebnAEEv03FH/4wZrHQY78+FGOAKbIhpHzq0scGveUjAGloXefPBblYg3XJodWIxJS2LA6bLB0B4AuquGu4+steGLQoJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyOvRaeb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyOvRaeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791055617; x=1822591617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xV6d1koFfM5m9rdRyW20nsERICuE43hApgH+Tu8v7gk=;
  b=lyOvRaeb2dyLUW509d2ppPlsa03GVAHPsklJhvYyUau7YJP6o3KPN5v1
   ZHia1TbP0WBD0npypvnVJaaFf3DIXOs7wF1xd16eTEuIPcOfE17l34hIy
   idRk4fpicLN4RlFbAs9OwKyy0aLJzqaBXT6Kzio7mTyi1L3C0mgDBFFzO
   9LoaxWOex/iB662hUyiD8OpGCGqJu4K9jK5V7hHGV1GRRfcWI8fr+b0Za
   D2qf5vxYVhKz8hVnNY7hnvx+SBWgJswT9aFfR3VSyY3LK5S+7GPu+fUHa
   9+eTfMDScFUBXwuT8BdHsBomOGEwttX/mwvtszOvXLU0dKoZoxXEwcZtd
   A==;
X-CSE-ConnectionGUID: U/gEmS9dSguctwurId61WQ==
X-CSE-MsgGUID: 6eTVygivTMKdwfsuYk0mvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90841252"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90841252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:26:57 -0700
X-CSE-ConnectionGUID: KJOYt0q3TcWARKt3cehjoA==
X-CSE-MsgGUID: 1dVDB0a4Rz65JZJk6zfCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="281216667"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:26:53 -0700
Date: Sat, 3 Oct 2026 22:26:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: common: scmi_sensors: fix truncating 64-bit
 divisions
Message-ID: <asFW-3IPAgFIDViV@ashevche-desk.local>
References: <20261003055602.145118-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003055602.145118-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 11:25:55AM +0530, Arnav Kapoor wrote:
> do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
> stored in a uint32_t on all architectures. The driver passes 64-bit
> divisors to it in several places, so they are silently truncated:
> 
> - scmi_iio_set_odr_val() divides by uHz, which exceeds 32 bits for
>   sampling frequencies above ~4294 Hz.
> - convert_ns_to_freq() divides by interval_ns, which exceeds 32 bits
>   for update intervals of ~4.29 s and above. If its low 32 bits happen
>   to be zero, this is a division by zero.
> - scmi_iio_get_odr_val(), scmi_iio_convert_interval_to_ns(),
>   scmi_iio_sensor_update_cb() and scmi_iio_get_raw_available() divide
>   by int_pow(10, n), which returns u64 and exceeds 32 bits for n >= 10.
>   The SCMI exponent fields allow values down to -16.
> 
> Truncation results in wrong sampling frequency, timestamp and
> raw_available values being reported to userspace.
> 
> Use div64_u64() and div64_u64_rem(), which take a 64-bit divisor.

> Fixes: f774117c96f9 ("iio/scmi: Adding support for IIO SCMI Based Sensors")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606040245.XfmRpBhA-lkp@intel.com/
> Assisted-by: Claude:claude-opus-5-5 coccinelle

Assisted-by: LLM coccinelle

> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>

...

>  		tstamp_scale = sensor->sensor_info->tstamp_scale + 9;
>  		if (tstamp_scale < 0) {
> -			do_div(time, int_pow(10, abs(tstamp_scale)));
> -			time_ns = time;
> +			time_ns = div64_u64(time,
> +					    int_pow(10, abs(tstamp_scale)));

It's fine to have 82 character single line in this case.

>  		} else {
>  			time_ns = time * int_pow(10, tstamp_scale);
>  		}

...

>  static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
>  {
> -	u64 rem, freq;
> +	u64 rem;
>  
> -	freq = NSEC_PER_SEC;

Yeah... (see below)

> -	rem = do_div(freq, interval_ns);
> -	*hz = freq;
> -	*uhz = rem * 1000000UL;
> -	do_div(*uhz, interval_ns);
> +	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);

I would expect to see this be a frequency unit to help with left side of the
equation

	*hz = div64_u64_rem(HZ_PER_GHZ, interval_ns, &rem);

> +	*uhz = div64_u64(rem * 1000000UL, interval_ns);

And MICROHZ_PER_HZ here respectively.

>  }

-- 
With Best Regards,
Andy Shevchenko


