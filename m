Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB73EFFA7;
	Mon, 24 Aug 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562257; cv=none; b=aLmjTysBXFLHWzp4BDha5bkR4LaiMd+s5vlcdPGrlIGPI712kQU15MvEEcglF0pOHlTGToLCKCUwy5PoXBRbM/3caw0fIcA4LUvtNIyujKE/ZAt2+Mtg76AX/OyhnuqWmw1eulYjy2zDhX1Y1KCo4X3CCyZFbjjcjs5Nowrf5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562257; c=relaxed/simple;
	bh=b9pKko9CvxoF/b1sibfNkNz2LKW6x4aiSyhToaxIcbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEHZj0cKu4mnwN5pADbDbX6qqxUpZOBhyZX3DPXp0fjCRuOOS27Vv47GxHkOlJOXXVUJ3XnlgWxA5agYtItu6eeqG/ZGwsYFM+Ok/LU8oAOa9lQZGTZhiZIFXso7mMNWIoekjVMA/IOhY29G3cOXTVp/38U6jFQDo8OcwHUURDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsrANEdr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsrANEdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787562256; x=1819098256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9pKko9CvxoF/b1sibfNkNz2LKW6x4aiSyhToaxIcbs=;
  b=HsrANEdriqqa202MOivXgnHToJcDEo8l1OIr1CTAdyo6Qc0R9GMOfHBE
   8ngAgp90FPEalaG8BldTvCS1VVldQxqDyrjFLDk/Rfa/1VWiS5gtUtY1A
   4HDx8EShbHrkVcxWaEUjFGog6WbAyCy2Bxofcek10oVxDFMZ+RDxsdSAW
   Cd2q13szsE1ZrLfDO6SEpMH2ddzRv8EDmiyTyE7aYKoYnyGMNmdFZMScV
   KBWJILA105aB+MBj6mPn09rIUlYN2U4OivGEIUbqSg9Muy1McqAkRbD+P
   V7VT8XhXZzBWhW+qZj2FGxkoMeh0QXtINwExAzpmM/XMfUgwMvFgI0iWJ
   A==;
X-CSE-ConnectionGUID: +cktQUZdSKSNOygSR0lV9A==
X-CSE-MsgGUID: LzEsn13ETuSKELmBg227Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="99535052"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="99535052"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:04:15 -0700
X-CSE-ConnectionGUID: vr7SUsRTT9qyG6a0hd04NQ==
X-CSE-MsgGUID: QKGmJSDiRy+suxdDeDSLTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="263670662"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:04:12 -0700
Date: Mon, 24 Aug 2026 12:04:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <aowJCrGMe0r7h6Wf@ashevche-desk.local>
References: <20260823045205.25554-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823045205.25554-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 23, 2026 at 05:52:05AM +0100, Salah Triki wrote:
> ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
> validating avg_val, and the subsequent range check only rejects
> negative values or values above the maximum supported OSR. It does
> not reject avg_val == 0, nor values that are not exact powers of 2.
> 
> - avg_val == 0 passes the check (0 is not < 0 and not > max), so
>   ilog2(0) is called with an undefined/garbage result.
> 
> - Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
>   silently get rounded down by ilog2() to the nearest lower power of
>   2, so userspace can write a value to the oversampling_ratio sysfs
>   attribute that does not match what actually gets programmed into
>   hardware, without any error being reported.
> 
> Only powers of 2 in [1, 65536] are valid OSR values, as listed in
> ad4030_average_modes[]. Validate avg_val fully before computing its
> log2, using is_power_of_2() and requiring avg_val > 0.

No need to repeat in the commit message what we can see in the code.
Use plain English to write the problem statement, the solution approach
and what might happen if patch is not applied.

> This issue was identified with assistance from Claude AI and manually
> verified against the code.

Assisted-by?

> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

...

>  	struct ad4030_state *st = iio_priv(dev);
> -	unsigned int avg_log2 = ilog2(avg_val);
> +	unsigned int avg_log2;
>  	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
>  	int freq_hz;
>  	int ret;

Reorder (only the line you touched) to follow the reversed xmas tree ordering.

...

> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx] || !is_power_of_2(avg_val))
>  		return -EINVAL;

Split it, the

	if (avg_val == 0 || !is_power_of_2(avg_val))
		return -EINVAL;

is idiomatic as the 0-check required for is_power_of_2(). Also it puts the line
in the limits.

-- 
With Best Regards,
Andy Shevchenko


