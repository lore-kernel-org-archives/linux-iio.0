Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6247DFAA;
	Tue, 12 May 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572826; cv=none; b=MRWFXhXfG43B8oFZDSZ+kMEYW5RmERwC7BqQeQf08u8FDH7Rpj1t3ASqNxOkiUDjK6Ux20CHuHGclVxBk5/vpdxT3eJ4K79bO6dKkOb2W/p6n/cY0Jeefwsh2enaJDbEfQlj9poiIEYwbRr1c3wfGPCjFVmVDTbxt5G2il9NLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572826; c=relaxed/simple;
	bh=l6n7MTypCXxXh8tJkFzk6gIN7NPzMBFnpmx7S4JGuyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE85WVNORMA1fr8htm4X/v3c16Y4PNadOYFf7DPAX0urPqRkckFnbTkNxN5+MiDgQSQOVuFJoIHAZhjGKjMsdkr/ZnDzw+xTq+dq5rGXfU6mjnC4BFzh4t7JOMTR7qZKvw9mJCMC/LXTt7H2+lSSJ13Bn6j7Amom7IrQ1b2B2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wnq5yJOy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wnq5yJOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778572825; x=1810108825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6n7MTypCXxXh8tJkFzk6gIN7NPzMBFnpmx7S4JGuyc=;
  b=Wnq5yJOyW5vCEPrKLQo53dxCXUi34n5ulkDsb7ToVE3NZHXTAYpwUFTh
   kOc6gF1LwWQdZWF/4C3O6ZdChBje4B0EqsWGxcWJ8JqQ6gWlRGT0qmScq
   +Fuq1P/NZv+xibJW3d7RP6EEoEpDFKa6+koLzYPojVg35xUM+u03uOwIT
   4Y5FJ3FA9xMbsLdbQn7nFj8Kai4s4bolES3Vh3UIcvFgdDHZ71Yk6f+Ny
   iSzxGYMNMEmZzr1/k0MrtdHcf1dHaUIHHLbZ/mmIJupwpCrOc0UGhjYU1
   EF7Jlhs6Aia01yVa3W9Qzi+SU1DGDNIbs8AhDz9Y6vzCpdP/aekA5CTr8
   A==;
X-CSE-ConnectionGUID: ZC6Z15UCRai+pi5n9/wxVA==
X-CSE-MsgGUID: 1L5oV5TWRfCxdRVs3Xu50Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90173156"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90173156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:00:22 -0700
X-CSE-ConnectionGUID: 6dhz+k5SSKmWRMIAHLq2+g==
X-CSE-MsgGUID: JN3nvq+qRLi5YVPDUUAwzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231302051"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:00:20 -0700
Date: Tue, 12 May 2026 11:00:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
Message-ID: <agLeEitdYsi5O2E1@ashevche-desk.local>
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512073505.1310-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 07:35:05AM +0000, Joshua Crofts wrote:
> As promised, I'm sending my IWYU mapping file, based on Jonathan's
> version with a few additional tweaks by me.

Please, also add a link to Jonathan's version.

> Other than adding support for more assembly file business, I've also
> experimented with individual symbol definition (see BIT() and GENMASK()
> in the following file) - this is to prevent issues such as the tool
> wanting you to include <linux/bits.h> when you already have
> <linux/bitops.h> in the source file (I agree, doing this symbol by
> symbol is tedious, but BIT() and GENMASK() are symbols that especially
> do this, and they're included in most, if not all drivers).
> 
> Feel free to improve this file and pass it on. I wouldn't really fully
> rely on IWYU as even with the mapping file the results can be weird,
> but it definitely serves as a good starting point when doing driver
> cleanup.
> 
> I'm making this patch an RFC - this is not intended for merging.

...


> +    { "include": ["\"vdso/bits.h\"", "private", "<linux/bits.h>", "public"] },
> +    { "include": ["\"vdso/ktime.h\"", "private", "<linux/ktime.h>", "public"] },
> +    { "include": ["\"vdso/limits.h\"", "private", "<linux/limits.h>", "public"] },
> +    { "include": ["\"vdso/time64.h\"", "private", "<linux/time64.h>", "public"] },

> +    

Trailing whitespaces.

> +    { "include": ["\"asm-generic/div64.h\"", "private", "<linux/math64.h>", "public"] },
> +    { "include": ["\"asm-generic/errno.h\"", "private", "<linux/errno.h>", "public"] },
> +    { "include": ["\"asm-generic/errno-base.h\"", "private", "<linux/errno.h>", "public"] },
> +    { "include": ["\"asm-generic/int-ll64.h\"", "private", "<linux/types.h>", "public"] },

-- 
With Best Regards,
Andy Shevchenko


