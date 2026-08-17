Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373B3BFE4D;
	Mon, 17 Aug 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954002; cv=none; b=oR63CunwQZDS3Ft03h75Y7x8WuLfrkJ1pUV9qM06+PfHQR4GD13AcFwmZ0T+aRq716P/bRe5WBcILm9bkhPoYXL/Vo4MNIQRKcbLtueQGT5qrT5zONC5C5vbXLOe0GRqEPSn9XkKBKwe5XzsRVkXaMbGQWR5TnsL28SIELpnCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954002; c=relaxed/simple;
	bh=mzaGcZVxUx976YhMqSBIHivWE/Zls46DVKY4my6nTVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtDWsvyh3RkywnYXXlljE42+N75pCrkpX06cbFIGHmtzXKo5xoHPPjdoThIIuPvEW2nU0Tabu3CkrzwB7ccDkiGPNeYBJvMFlrL7VqAvO0Rcny7KGBOwQOGblrgoIDuyoJyjsxrs7n+9APD5ysU8Npj12ca191ZL0dnzYg6t5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iO4dj0YL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO4dj0YL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786954001; x=1818490001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mzaGcZVxUx976YhMqSBIHivWE/Zls46DVKY4my6nTVo=;
  b=iO4dj0YLYs0VRyvTnxfxoUUtjgwqQr6wehhkGFccSh9wYcKTr0VbXBei
   kqXg3kNTeugZiVV8bjRqrifwvB43aOikrtkQDVsiFpc1fUzTCxxdVRje2
   xfXLNRX+CoF1vJ155+SS0RM59vVrYmNas8OKVBE30HYyFtjVn8oCrgGQS
   +kL2Z7uxoXnSixrWAA4cUZEv+cLJZ/BgoNFLejKiKtGWdfCFdaMnKTEoY
   G57zh0pozA5CiGk7WnOhhcsBzxfOX+r5gQxTJO19K96Dh+JtwvK4ttVSl
   IsYW/Gs84KVFgeFhB0yc2jSRVvy8xedPsnreRwQE+Ifu9phVW/4q8emD7
   Q==;
X-CSE-ConnectionGUID: RPP1YIs4RsKqhZzau8aLig==
X-CSE-MsgGUID: 8hwU0ITlTGaUV7ISGl/4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87183745"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87183745"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:06:40 -0700
X-CSE-ConnectionGUID: jiFMS9FXRw+NHhiJkBDC/w==
X-CSE-MsgGUID: e92Usf20S02rx4DZ7ioJOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="269116133"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:06:38 -0700
Date: Mon, 17 Aug 2026 11:06:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] minmax: Add in_range_inclusive() for inclusive
 range checks
Message-ID: <aoLBC2TBbwfZke-5@ashevche-desk.local>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
 <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 16, 2026 at 12:26:20PM -0700, Guru Das Srinagesh wrote:
> in_range(val, start, len) takes a start and a length, i.e. a half-open
> range. Callers that instead have an inclusive [start, end] bound have
> no ready helper to reach for and either hand-roll the comparison or
> convert it to in_range()'s (start, len) form themselves.
> 
> Add in_range_inclusive(val, start, end) as a direct comparison rather
> than a wrapper around in_range(): computing len as end - start + 1 and
> forwarding it to in_range() subverts in_range()'s 32-bit/64-bit dispatch
> for sub-32-bit types via integer promotion, and overflows to 0 when @end
> is the type's maximum value, silently rejecting every input instead of
> accepting all of them.
> 
> val, start and end are each assigned to a __UNIQUE_ID()-generated
> temporary before use, matching the __cmp_once()/__cmp_once_unique()
> pattern: each argument is evaluated exactly once, and the temporary
> can't be shadowed by a caller's own same-named local variable.

No new code to lib/ without test cases.
NAK (until the test cases are not provided).

...

> +/**
> + * in_range_inclusive - Determine if a value lies within an inclusive range.
> + * @val: Value to test.
> + * @start: First value in range.
> + * @end: Last value in range.
> + *
> + * @val, @start and @end are each evaluated exactly once.

This misses the return section (yes, this is not obvious, but needs to add it)

> + */
> +#define in_range_inclusive(val, start, end)				\
> +	__in_range_inclusive(val, start, end, __UNIQUE_ID(val_),	\
> +			     __UNIQUE_ID(start_), __UNIQUE_ID(end_))

Do you know what __UNIQUE_ID() does and how it will affect the preprocessed
size? It may or may not be needed depending on the (current) use cases.

-- 
With Best Regards,
Andy Shevchenko


