Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D7379C20;
	Tue, 12 May 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573249; cv=none; b=nr1BzdFhBdwlfLIKlTIp+UX25khNzbt+ZhpLYydoAkB16xh0jZbfZehBadVaF/c09HObQbyBMDv1QFByi1f1mUtUZuhqoa0WgG8MFE9lNqBHwhtX3tI6fDpiRb/fSmiJ8Wn/Y7kU277Q05E+BUmY0j0fabWBHXG+ch+9wqd0MNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573249; c=relaxed/simple;
	bh=FZKzdla3viWXJzc83bWJjwXFCESyLGP6T3814RSABVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMKqGLXK9jVF1xhLHISDvSaY/tq6amZrl4pBrZWR2U/PlX01Jo7yLgsNqBjyvAoDlzyriAivo+kn/xDq0A6MBvEhzyF3c4y3vUsEv8MhCcuDTOsF21gbjlPcgmF1/ajUnTLhA3WilnARa6Iq5VFBt9Mb0gc7RTiQm7qv+pZGmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buAE0Bhm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buAE0Bhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778573249; x=1810109249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZKzdla3viWXJzc83bWJjwXFCESyLGP6T3814RSABVo=;
  b=buAE0BhmstnypwQ5nvQptQ8/IDzZkCmesUmra1+2Pi25Fx+Ee2PUnzGF
   4sx8qoyKLCbg4d8N6m7QLNIiRVhAnSQRb5bExxxfWNB6wo1yemsOw12tl
   8qKivaJfquh/FfSvmwpgaC2P5xAZaz3UuHW/IbLn9YqgmqPeQQjHq+Q0h
   9VpQaz+OGrSYJHraPpFdKv/30tRg4Wq5StO1ICJJxYQg04yVtbQnjDR2z
   s4POl5CozZBsmxak2Wg8bzGtDG30Dxz4Lj5g4gjFF+cwxOOM39VN5MQXh
   EavB9iYys8wrNzAjAFNIGHdt7SzZ4dTj3kgT3lp/3gDini+QvR59tnwK/
   Q==;
X-CSE-ConnectionGUID: TUFB1Di4RXa4Otv69rd/Ww==
X-CSE-MsgGUID: KQw33yu4QD69qKkfdef8Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79497835"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79497835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:07:29 -0700
X-CSE-ConnectionGUID: T2AQlK93R2aWh6Fj285LcQ==
X-CSE-MsgGUID: +UEyy3wTRkm5BwA+k5wcTg==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:07:26 -0700
Date: Tue, 12 May 2026 11:07:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
Message-ID: <agLfuwvEH3YTT2qV@ashevche-desk.local>
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <agLeEitdYsi5O2E1@ashevche-desk.local>
 <CALoEA-wOAY9fYuZdZZHQFj=+xN=WB=Z30g_iKJUVQHHiHHXxuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wOAY9fYuZdZZHQFj=+xN=WB=Z30g_iKJUVQHHiHHXxuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 10:04:51AM +0200, Joshua Crofts wrote:
> On Tue, 12 May 2026 at 10:00, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Tue, May 12, 2026 at 07:35:05AM +0000, Joshua Crofts wrote:
> > > As promised, I'm sending my IWYU mapping file, based on Jonathan's
> > > version with a few additional tweaks by me.
> >
> > Please, also add a link to Jonathan's version.
> 
> Good point, forgot to do that.

> > > Other than adding support for more assembly file business, I've also
> > > experimented with individual symbol definition (see BIT() and GENMASK()
> > > in the following file) - this is to prevent issues such as the tool
> > > wanting you to include <linux/bits.h> when you already have
> > > <linux/bitops.h> in the source file (I agree, doing this symbol by
> > > symbol is tedious, but BIT() and GENMASK() are symbols that especially
> > > do this, and they're included in most, if not all drivers).
> > >
> > > Feel free to improve this file and pass it on. I wouldn't really fully
> > > rely on IWYU as even with the mapping file the results can be weird,
> > > but it definitely serves as a good starting point when doing driver
> > > cleanup.
> > >
> > > I'm making this patch an RFC - this is not intended for merging.

...

> > > +    { "include": ["\"vdso/bits.h\"", "private", "<linux/bits.h>", "public"] },
> > > +    { "include": ["\"vdso/ktime.h\"", "private", "<linux/ktime.h>", "public"] },
> > > +    { "include": ["\"vdso/limits.h\"", "private", "<linux/limits.h>", "public"] },
> > > +    { "include": ["\"vdso/time64.h\"", "private", "<linux/time64.h>", "public"] },
> >
> > > +
> >
> > Trailing whitespaces.
> 
> Well, considering this is not intended to be an actual patch...

Still better to follow the common style.

-- 
With Best Regards,
Andy Shevchenko


