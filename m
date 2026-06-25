Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EEA1E7C18;
	Thu, 25 Jun 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396198; cv=none; b=mdSbRGzCGSXRgSRcqAmnDJakO8SWwHna5+yEBfA9wDUc9qSpiO9LBUTARMaRaWpbinxAgeQtZleK+vZYoWZpJWEIEVa7GJa89w5xlJ7+O+5iMh+V1kz3BVKt8VAlnGp7cXQKiTSMmC1GsjWAuu2fbcB++IkcIsTYZlANf5dj5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396198; c=relaxed/simple;
	bh=NTjm2rZQNAK1mt3eLcZFkiCD8MOMhvD6eb9E7jtWBHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+PbfueuGHOCXAeUIakS5WY9dW6+MR9Zn8hIiXUaWas4+V0f7NRdhsBezJZ7h6qspVlN0QsNms0pcg2ULBfUn44EDEhZAB3b8dKir0PNUmVjMvTQ6S+xixnY5rcA8XmjTJ5DoKYqyEu80pOrMSraXbtT1PB6YjxB5eXjFs4OPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbowL7cW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbowL7cW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782396197; x=1813932197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NTjm2rZQNAK1mt3eLcZFkiCD8MOMhvD6eb9E7jtWBHc=;
  b=EbowL7cWAQvIsa3VRLmNb/Rl8/X5kMtSsFeFWDyH6vRUOpKJWJObTAv3
   3U1WTVNckJywYXRm8AmWP1PKr1IQo2fvbmYhiTKOyZDL+s+Ptie0gSFoO
   d24pbBi7NHefhBNLU4n5h6KFmYsWNAZseUk3A41lSXz5N8fA51Q7qPhoP
   hxaJKo+/V+zcIWjfdlpZ0qvtiDBOZV/JWNA+z1ZCGqkC2Zq0GE97olg45
   mD9Uqco7Pex8CU8YRUN7903fW/GDBpabfRb/v17D3W6/mGKsz2gNrtXnO
   oGZ8Y9Gl3X42N12lGoR/n+Fosi6l6U6S+f0cKrRsaL4DL+doupQBmC7gl
   w==;
X-CSE-ConnectionGUID: ax8/kJhQSWm6wivrBq77oQ==
X-CSE-MsgGUID: ZLk8aCk0TiqetzbtGRZ2XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82293088"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82293088"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:03:16 -0700
X-CSE-ConnectionGUID: OIvGVlGkSDGrJj08jwoahg==
X-CSE-MsgGUID: eHufPe/+T7+BUOqr3Aif0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="274093988"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:03:14 -0700
Date: Thu, 25 Jun 2026 17:03:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Prashant Rahul <prashantrahul23@gmail.com>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure
 in probe
Message-ID: <aj01H48IHTyhn4ZR@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
 <aju-_HSz6jNkR_NM@ashevche-desk.local>
 <20260625120952.471ec21a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625120952.471ec21a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 12:09:52PM +0100, Jonathan Cameron wrote:
> On Wed, 24 Jun 2026 14:26:52 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jun 24, 2026 at 03:43:44PM +0530, Prashant Rahul wrote:
> > > On Wed Jun 24, 2026 at 1:06 AM IST, Jonathan Cameron wrote:  

...

> > > > Why this particular one but not the devm_iio_device_register() below it?
> > > > Both pretty much only fail on driver bugs.  Or out of memory for
> > > > which dev_err_probe() doesn't print anything anyway (on basis that
> > > > is normally pretty noisy).  
> > > 
> > > My apologies, I wasnt aware that dev_err_probe simply ignores `-ENOMEM`.
> > > Looking at drivers/base/core.c:5096, it is pretty evident that it does.
> > > 
> > > My goal with the patch series was to change dev_err into dev_err_probe,
> > > as my understanding of dev_err_probe was that it's a specialization of
> > > dev_err for probe contexts.  
> > 
> > Jonathan, actually the triggered buffer setup might return not -ENOMEM error
> > code for the surprise. After all this series does add not a dead code, but
> > a quite rare to be used one.
> > 
> > https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57
> 
> Agreed and I'm not even sure why that is there (lost to the mists of time
> / my failing memory ;)  However I think it's an obvious driver bug case
> that should be trivial to see in basic tests so to me it's marginal on
> whether a print on these is useful.
> 
> Maybe given that one is so rare we should just add a print in the core?
> I'm not particularly keen on mass patches to print errors from the core
> code but this one is perhaps a reasonable trade off vs series like this
> one adding prints to drivers for something we don't think realistically
> ever happens.

While the series ends up not adding a dead code, the rareness of the case
doesn't justify it, so I am still on the side of _not_ applying this series.

For the core printing, I think for devm_*() or other managed resource APIs
it makes a lot of sense (in general). Not sure about plain calls, though.

-- 
With Best Regards,
Andy Shevchenko


