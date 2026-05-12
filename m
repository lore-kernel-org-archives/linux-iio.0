Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B81DD525;
	Tue, 12 May 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601110; cv=none; b=bWqIrS+mwxETiN68IDR238C9LG6SuE8//6LEB0tOtedItDovo2PPanNkFUjV/434QKLAo0GGt6va9o2R0xa3wZrtE+D94//p7zYxlfLawXl0NSnVqxJZjr0rmsQB7AE1hYCSAIRMz8+9oH15XSPBcnJIzuVY+dJ8ZrvkCZYEyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601110; c=relaxed/simple;
	bh=4IYOMQE/ZWaLFhDMHilD38Qvr2N1Quf6utOPMQhXJhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKpPUOKwlasA92ea4ZUf7MFk/SaLQo4CS7/WQff4xksV4v7hJkSlG3tGA+79ksaRgRh8+Mfn10Tach8+dXxIdjXZv4JCNqyPtAZT0bpHL6ZZUHZznQBZxxjHvZEwekWqK7QYXZziA7C/HFWP20L/e6jHW7CYc7HB4FcpAZr84xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeeRSXc0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeeRSXc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778601109; x=1810137109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IYOMQE/ZWaLFhDMHilD38Qvr2N1Quf6utOPMQhXJhc=;
  b=OeeRSXc0/XsCqv5zd6rzogPY0DDRNTm4Zkb5Bnay95b8w2IOmkkpg0/a
   9ZXa6JymwgcNbJ8aoK5s+chKXskkEJxDfdwTxTa/lOPcZhyEUJow6hj5V
   kZ3/5mVy3qxTvKjPCVyDWpGMoeWPnrvVUaoZ9QS+VpH/Htd/8cA0cmoxF
   RFxvQtmF6jrsACEg6lhNzzxqi/Qu/tNUxxlmD8CYmsr9GyZ72uFBZUSQI
   ktIWf0TVoJPuatl02fVI2R1Iwl4b21Hj8M9s60LVH4Hha5mvfUJ+VTy3y
   SP8tA6KGmh+WTAVGlk10cy1EnBW/C9vf+uLEDfh5kPG0pRhTQfHNsZipy
   w==;
X-CSE-ConnectionGUID: 9p4wgLU1ReWrZeUBMx3t3g==
X-CSE-MsgGUID: 2EC7jiGHQYmDD9EFQd79Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="102179243"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="102179243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:51:49 -0700
X-CSE-ConnectionGUID: Hc6Wwd5IThm586G2XUcfpQ==
X-CSE-MsgGUID: aDngpPJNSTCxiQUCqXJYvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231395467"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:51:46 -0700
Date: Tue, 12 May 2026 18:51:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
Message-ID: <agNMkMgSIgQJZLex@ashevche-desk.local>
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 10:36:00AM -0500, David Lechner wrote:
> On 5/12/26 2:35 AM, Joshua Crofts wrote:
> > As promised, I'm sending my IWYU mapping file, based on Jonathan's
> > version with a few additional tweaks by me.
> > 
> > Other than adding support for more assembly file business, I've also
> > experimented with individual symbol definition (see BIT() and GENMASK()
> > in the following file) - this is to prevent issues such as the tool
> > wanting you to include <linux/bits.h> when you already have
> > <linux/bitops.h> in the source file (I agree, doing this symbol by
> > symbol is tedious, but BIT() and GENMASK() are symbols that especially
> > do this, and they're included in most, if not all drivers).
> 
> TBH, I would favor rules that are easy for machines over rules that
> follow existing human conventions. Is there really anything terribly
> wrong with including both bits.h and bitops.h other than "convention"?

But why? When one needs bitops APIs it includes BIT() and GENMASK() for bonus.
Same with (and especially) bitmap.h. The latter is rather a heavy header.
I do not see any point of having all three and even two out of the three
bits.h, bitops.h, bitmap.h. Also this is a type of unification that helps
scripting any further header reshuffling / cleanups / ... If we ever do
something with bits.h, let's do it on the files that really use only it.

So, all that being said, I prefer to follow guarantees and change them
if required once for all stakeholders, the mixing makes it harder to achieve.
Bonus is the compilation time (maybe negligible, though).


> > Feel free to improve this file and pass it on. I wouldn't really fully
> > rely on IWYU as even with the mapping file the results can be weird,
> > but it definitely serves as a good starting point when doing driver
> > cleanup.
> > 
> > I'm making this patch an RFC - this is not intended for merging.
> > 
> Sharing it is nice. Automating it would be amazing.
> 
> Not sure what the best way to do this would be though. I've considered
> the idea of having an IIO linting service that could run iwyu and some
> other checkers that catch common issues, like spaces in { }, where and
> where not to use trailing commas, etc.
> 
> At first, it could just post the results on a public page (like sashisko).
> And if it ends up working well, it could eventually automatically reply
> to patch emails.
> 
> The hardest part would be finding someone willing to host and maintain it.

Hmm... Where the media subsystem does that? They have their own validation.
Also VFS and maybe others (Ah, yes, net and bpf are also using their bots).

-- 
With Best Regards,
Andy Shevchenko


