Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334E3AEF4B
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132277; cv=none; b=jkXI21NV919EMZzDk/jjpHqYPFfJSYhTY9k5q8/IgxuKEsPUbN7KpabgH+AYRKnMkZA99DUXWae1AjPSbhNy5OLST4ule29Dnigkd/5OOI1nSJMJGO7/X8xzgEXY44B7TIGcCaLFFg4FrDlYwpAuAh3uakrgE4jjT8K626DsPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132277; c=relaxed/simple;
	bh=2GVFBhWdGXmF6xLRYo78EB0AVKJhYr7hYu/84slwB7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFpppGifs6gyntXPHwSoz1u7GbPrUyzHqp+1/bh42xFuk7OPhO5V1eq+Qpj1+7C1xnyzQE77GWk5oz1P7U4Nwr7TOm3oZlIF3W4IUeUgvjqAQ64XEwNt7r6BISqXm3+WG5avTx3N8SFT0rdFlDgW/nmgxhgKlDqiqrDjXXSE+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfA2umyY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfA2umyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784132274; x=1815668274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GVFBhWdGXmF6xLRYo78EB0AVKJhYr7hYu/84slwB7Y=;
  b=WfA2umyYXkxEjXPhpcOKuiP01Z2sGXeSFSiSym6hEmnDSDDZx/X+DvJ2
   hdcSOKuhpaQKYQjnuQ2GgdVrdZ/J8E9G1ODmQApbw0gVkxLW+qUwrlrvK
   qPs+sbiZs56V9uPECxP1kz6SfSsckUFHcfwH42d14S3eJ8inxh8mfeYnj
   ToZHMIVGhirHgKPDTV9rYYD7ZsLwrTHWqsYwGfiarJ/sIVENMxB2xKiMn
   aB1ax32VXFUXow2jZONLLKMpRseOwinLGwrDJpCTPH8aCmopnqbluv08r
   BxbybH4ICtSUgcg1UtXn8JI/+6eDgLIzBiNdwirumuVSl3RV6izg2fwoZ
   g==;
X-CSE-ConnectionGUID: 3MSwIliISlegvGo4ZxGZXg==
X-CSE-MsgGUID: Xw9KJIPVRuej3ELCuehapA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88679190"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88679190"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:17:52 -0700
X-CSE-ConnectionGUID: gLjcdzkATNujKcX8STms6Q==
X-CSE-MsgGUID: hTCVmTLCQEy675cqgBrjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="251814088"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:17:50 -0700
Date: Wed, 15 Jul 2026 19:17:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] iio: buffer: Make IIO DMA fence release RCU-safe
Message-ID: <aleyq2J6tVWYA6pC@ashevche-desk.local>
References: <20260715154245.3814378-1-lars@metafoo.de>
 <20260715154245.3814378-3-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715154245.3814378-3-lars@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 08:42:45AM -0700, Lars-Peter Clausen wrote:
> The `dma_fence` documentation states that if a custom release
> implementation is provided, the `dma_fence` object must be freed in an
> RCU-safe way. The current `iio_dma_fence` implementation uses `kfree()`,
> which might result in a use-after-free.
> 
> Remove the custom `release` implementation. This makes the DMA fence core
> fall back to `dma_fence_free()`, which calls `kfree_rcu()` on the fence.
> This requires that the fence be the first member of `struct iio_dma_fence`.
> 
> Using the default release method for extended DMA fence structures is a
> common pattern.

...

> +	/*
> +	 * Must remain the first member so the default release callback can pass
> +	 * the fence directly to dma_fence_free().
> +	 */
>  	struct dma_fence base;

TBH, I don't like this trick. container_of() is there for a reason. Even if
it's the first member in the structure. Can we simply switch to RCU version?
Would it require big changes?

> -static void iio_buffer_dma_fence_release(struct dma_fence *fence)
> -{
> -	struct iio_dma_fence *iio_fence =
> -		container_of(fence, struct iio_dma_fence, base);
> -
> -	kfree(iio_fence);

So, we can't use dma_fence_free() here, because without above guarantee it will
get a wrong address. Maybe (maybe!) as a quick fix this is fine, but in long
term can we also have a refactoring patch that drops above comment at the end?

> -}

-- 
With Best Regards,
Andy Shevchenko


