Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8413C2BB9;
	Thu,  4 Jun 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606739; cv=none; b=VncU80Dc8mE/mb7b4yg7CTCj8z0qf29h3A0QCcrIZba8ElJujWTW5xGznXYsr3ROFrp7ME7gvbVaGGg3MsA8iFdIjUBjJiinkEzkhPVv7N1SxU/xrX7KHpY/NyUw8HJogAoolLG+P6SuYBNF9x7ij0t661h1IGw5TSctBSOoXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606739; c=relaxed/simple;
	bh=+z2sKmIwTwWXLXQRx9zq/u1YXJAEuoV+LMu48fgDntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGl3FufXEF0aNT/bfr6yNoLYwkTMWIu9E8LImqFBn+D8qmhUFmtaxLVLKEA4xKTEk/mLs/ptptEVkTnHGmMz6AcscFAla0ZNFztXHY+cSa5XRJIbbKx1yNlOShQM2eI7ZBf+YhIfWm+6rSurqOt1vopsl/64zgMfvKJ3HLnLi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgAAxeOO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgAAxeOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780606738; x=1812142738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+z2sKmIwTwWXLXQRx9zq/u1YXJAEuoV+LMu48fgDntI=;
  b=LgAAxeOOMsFqrcst7rgV1bRL/eq1DXK4K463/8GWu5IXX5X/KtjCU6xo
   kBcFwkVxQfL15/5rLC/WYbiyLOlPufMKhEupgD8ia20VE+vnx6AZPGsEo
   gH1pxxnr/9R2nj8fPsTnwuTWkReAUgsvgJxWkC30AQjNDJjV2QX6d5Mvb
   ihKfTEhDJ7fh58V9bUvvW5fCvI+eCH9y+iXsms9HO57s7KZVRRSfJZ/bs
   ZQsB8QbO3rUV9qsvGp6+NRT/jNZmSauM9zzN9tiPqJiEzhwiMxlqe4EEK
   anV5pZPXCtw8jPJm2yX2ckbk+/PUo14Fl717/xzMfE62o3B1ujPbCS0qO
   Q==;
X-CSE-ConnectionGUID: xOi3ZX/fSK+BFkCwfiI2rA==
X-CSE-MsgGUID: Wy6kXdkhR8Wc2pZDPcBFLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85332664"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85332664"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:58:57 -0700
X-CSE-ConnectionGUID: UpKptyvRTnee2G8GRy/sZQ==
X-CSE-MsgGUID: 35zG4xGcTSeprVsr9S41Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240461408"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:58:54 -0700
Date: Thu, 4 Jun 2026 23:58:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <aiHnDI4Cmr06-L1T@ashevche-desk.local>
References: <20260604131518.27323-2-m32285159@gmail.com>
 <CAMknhBGKHdUV10mLz3P_eH3mg9WU5kHw-pGqoRWfVGyvD2HwOA@mail.gmail.com>
 <CAKqfh0FU5g96PjcXcz_hPafZR2uLq3xX2V-yyraHqPXX8RBRDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0FU5g96PjcXcz_hPafZR2uLq3xX2V-yyraHqPXX8RBRDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 11:21:07AM -0500, Maxwell Doose wrote:
> On Thu, Jun 4, 2026 at 11:20 AM David Lechner <dlechner@baylibre.com> wrote:
> > On Thu, Jun 4, 2026 at 3:17 PM Maxwell Doose <m32285159@gmail.com> wrote:

...

> > > +       ret = devm_mutex_init(dev, &state->lock);
> > > +       if (ret)
> > > +               return -ENOMEM;
> >
> > Why are we ignoring ret?
> >
> > I would expect:
> >
> >               return ret;
> 
> Gah, I must've Jonathan's + Andy's comments get to my head (He said it
> should likely only return -ENOMEM) :(
> I don't know if he'll want to tweak while applying or if I should just
> go back and resubmit.

What we meant is that:

- devm_mutex_init() may return only -ENOMEM as of today
- dev_err_probe() will ignore (print nothing) when err == -ENOMEM

It has nothing to do with the caller, we explained how callee do.
TL;DR: it should be simple return ret; as Jonathan said already.

-- 
With Best Regards,
Andy Shevchenko


