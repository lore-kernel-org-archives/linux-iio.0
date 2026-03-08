Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240D34C14C;
	Sun,  8 Mar 2026 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004375; cv=none; b=h0isqeKf73aWwZ1ypBYQuAH4k/q/Sh9Yj4A+q17kvtnwOGCkMpW2HT17ZfrtTU6DolmLFsmWTMk1e5UaJxIhtFDsU7QJaIpXayoNMmtciKDa59FPZrpIZmAYyrSAEt/Imj7iLyWUnEGkMMR68LQ8QlJ5bP7AUguobjImOZsrjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004375; c=relaxed/simple;
	bh=8DXwqtzfogfwXeUJb7oAeCpsWLKYNC4mrJBoKOr9vpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYmvCW/b0u3Oju1PgDC2Lt72n9BE8/uujPZ/wSFjp8WzcBu2g1qUetkTkcoKWMKOmljeXeh5u6TFQ6q1nc+4LIMuVx2Bdw+ROsV+Voh/3gUuI2M8WP9qhToOFuu95q3Q2vY8xVnCt2pRtDR4kRSUmDq7AvsdFa5jN4nl/m/QTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCDe3j5B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCDe3j5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773004374; x=1804540374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DXwqtzfogfwXeUJb7oAeCpsWLKYNC4mrJBoKOr9vpQ=;
  b=FCDe3j5BoQTrBbfFO7JX301xZ4NmKKalEggU5W77xSxeKL5GV3Wj/Okw
   ZuGHVl/PydUiWxwcZjUoyuCtvM4V3pRm3UTaWKcRRjZ6CUniU1uoxc1hS
   TM8cpUwylsDAHpqkWdgkTVuRBL80qbJXYA3834v+QX8ipu8k62o19CcCu
   guOwwNeArZfdqzCwqedHyeSV/u1SHoON8xUG7VmRQwxJ7d5j2Lain2WVG
   HLC5/rRMrWPodzpiMCRysAju1osPRlXR3iGYUaazhUcPKnXfbsrr0qOY1
   e++irFplgPliECXikwItFwSSUJFiel2yKDpx8d9XviL1SsILoHEWedMSl
   A==;
X-CSE-ConnectionGUID: dFZRqsU2THKKWRc428nDuQ==
X-CSE-MsgGUID: 21wjPk1jQLWNck6ZKS4GbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77911244"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77911244"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:12:53 -0700
X-CSE-ConnectionGUID: mk8t0ErWQGWLoaHho7RfFg==
X-CSE-MsgGUID: iw3/rm9tSc23d5gSScIy1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="257485002"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:12:51 -0700
Date: Sun, 8 Mar 2026 23:12:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: adc: ad799x: cache regulator voltage during
 probe
Message-ID: <aa3mUMKPaVY_t3G4@ashevche-desk.local>
References: <20260308182811.33471-1-architanant5@gmail.com>
 <20260308182811.33471-3-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308182811.33471-3-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 08, 2026 at 11:58:09PM +0530, Archit Anant wrote:
> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation. Since the reference voltage for this ADC is not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Determine the active reference voltage (either VREF or VCC) during
> probe() and cache it in a single variable in the state structure.
> This improves the performance of ad799x_read_raw(), removes the
> dependency on the regulator pointers during fast-path reads, and
> allows the removal of a redundant negative-value check.

...

> +		*val = st->vref_uV / 1000;

Perhaps "(MICRO / MILLI)" instead of "1000" until we have a dedicate constant?

-- 
With Best Regards,
Andy Shevchenko


