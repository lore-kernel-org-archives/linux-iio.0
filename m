Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468137C923;
	Wed, 22 Apr 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874900; cv=none; b=DPAS8Ls0OuZHQ8d9VB5aaGb+tLaifX9++2mJd2J3kxc16lHNinXTs/dvmFPPo5tVTm6ITmXTfO5rubjbYRjWrotmR7WG2VnNGm0G06+NG+PHw7tCoSs45hI6yKHwPWVZNLxBjayMUA5F4WHZjkqR6tG/R10RnnPnE+RlhF4li1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874900; c=relaxed/simple;
	bh=V1tDqrGZS1TI+8K8ETmPnL9bvUombmzGpYpvId8HqMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSiKr5ai0FkE1iLLy4yukijz/v2N5RL/Egesi5Th8N66aadvuEzARioFWuKdsOwEbZ43B0NM5QDF+YxIz+iJiaMwklBBSFNlVKZdL8NelTNR1AQE55Yxc9XZg3KhNvbjI9cnadm6gjb0U9szQdYCZjGJUfB3FMTjXaoIjldeEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOXG6oeF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOXG6oeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776874899; x=1808410899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1tDqrGZS1TI+8K8ETmPnL9bvUombmzGpYpvId8HqMo=;
  b=MOXG6oeFFbuoKrUFQsaC3Defk/A0uqo6tqvE/+wyFKR396zV/gzxrP4b
   WJliBfxiaawHbWQdbKmNtsWJ6y4svkI04aSYl/4CH7YETL+wr0LNjZjMA
   hh8xaB9lmkaDT71sVZRUEQvqaUJER8a2dLtEHcVOTfWb+MDdKvDNCshlu
   8MIEDWkJj4AeKKlmiexyi5f0/3+mY6vH0C86+OwKVvpRHP7njnFMjq/xq
   J/abuP4vQ7RByFWAbOp8LMks16Bvx8/QP6G3AyW1ByiUjAfCW+tYeCRMW
   VZOcz3jsoRTUOoHo7fu2gyiKU+lMS3kZTRyU5X2zXOqAWIIloM/25jCIn
   A==;
X-CSE-ConnectionGUID: dvkBWM8RT2ygXLUwxdLazA==
X-CSE-MsgGUID: Uh3NB8SnRSO7X2CDC1AP6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88909466"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88909466"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:21:38 -0700
X-CSE-ConnectionGUID: Yy8MZeb1SOCjtMbY9pctqQ==
X-CSE-MsgGUID: Z9PRjV5vSM+LihnXdpq7GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="229732214"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:21:36 -0700
Date: Wed, 22 Apr 2026 19:21:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7625: fix type mismatch in clamp() macro
Message-ID: <aej1jTYHP0tgJOcD@ashevche-desk.local>
References: <20260422142541.160365-2-giorgitchankvetadze1997@gmail.com>
 <aej1MTgpzToqxOXD@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aej1MTgpzToqxOXD@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 07:20:06PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 06:25:42PM +0400, Giorgi Tchankvetadze wrote:
> > Smatch reports a type mismatch warning in ad7625_set_sampling_freq()
> > where the clamp() macro is evaluating differing types:
> > - `target` is a u32
> > - `100` evaluates as a signed int
> > - `10 * KILO` evaluates as an unsigned long (due to KILO being 1000UL)
> 
> > Replace clamp() with clamp_t(u32, ...) to explicitly cast the bounds
> > to match the u32 target variable.
> 
> No. Try to avoid as much as possible use of _t variants of max(), clamp(),
> and min() (the list is sorted from the least critical to the most),
> 
> Also we have constant multipliers for frequency in units.h.

Reading again it seems like one from time.h actually fits better NSEC_PER_USEC.

-- 
With Best Regards,
Andy Shevchenko


