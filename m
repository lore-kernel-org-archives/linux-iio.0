Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C240242D;
	Wed, 10 Jun 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088122; cv=none; b=na4WJPlcnhoC/45ENW+j+kOWO519eBwW8UOaPvPVQWuuhR4UkwVIrmAYCWLi7Yylnk98h3Mlkhx2Slst0eWoKW3SFkAiYh6GoBhrC1Z8S4R5P6euvQCs4Xw9x8JHo03IVlFqg2MoYGwHD5f681IPXJLmVblxG16jGt72XN6mXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088122; c=relaxed/simple;
	bh=GN4NPKhpbRidu/96/9fMscay/ZxmtABkfMuPhsLWfLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2D8mTGLp8umcppsa9ZpluhissmKXH9pMbodqlaKlFEdQBS/RQx+9dorV1ukhrz9xgM/AUmh+HdMvFzmUJ2Q2PtltCXPieQF+Q1n5jXKf0DB5qxBt/dID4xy7v2enIcVdqc1ILfpxm8M527FrN8+XegH8rECMv9EklnmNCPIlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdbPqYQ/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdbPqYQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088114; x=1812624114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GN4NPKhpbRidu/96/9fMscay/ZxmtABkfMuPhsLWfLw=;
  b=HdbPqYQ/Gdm4ONyUAY8QRGAbJDio30NMRMkbn9qKMepTRhPYH7bzTyRS
   WlPoaPYp/mgr5DcSCcltwPO5P3joQ2kw+eRUHlR4aEbPnxKQ43GDp8jbN
   Rz40oTs2v6HBaj6euWmNyrPMF4MC0lLirVUYwhaSHe9cz65fIrJj3p7m2
   Zgp7OECP9FQSdjUx6x2Gsrk6Nozmch8WCsXi5OXpIiE8e2BTTtayQJIVh
   nN/F7qRcXoiGeF4c02Lq1OZ3X7Fo4NKzYzv9PejNmiXlEYGtx/h+Szdrj
   Ls+/9VaZZfP8zgIL4bFsfjDgWJk+cq8xI6l47SOYo9oRx7IMFLAYpJ8Oz
   A==;
X-CSE-ConnectionGUID: vyMD1XbtRJaDgoS3rmd2gg==
X-CSE-MsgGUID: usdm/Tx7SLWDNg/97AZsNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81725825"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81725825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:41:53 -0700
X-CSE-ConnectionGUID: t5RMsotNRxieMr1fYnP6Xg==
X-CSE-MsgGUID: LXuPg+b5Shu63UjXQ3pW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="239800871"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:41:51 -0700
Date: Wed, 10 Jun 2026 13:41:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aik_bXUpVc90_eIy@ashevche-desk.local>
References: <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
 <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
 <aiewiqInppHKilw1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiewiqInppHKilw1@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 09:19:54AM +0300, Dan Carpenter wrote:
> On Fri, Jun 05, 2026 at 11:28:18AM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > >                              ^^^
> > > > > > Uninitialized variable.
> > > > > 
> > > > > s/variable/data/.
> > > > 
> > > > With what I asked in the previous reply and what you explained there
> > > > (thanks, btw!) I still think your patches are not fully correct. They
> > > > will require to atomically write all or nothing. If we want support
> > > > partial writes we need to go with that differently (reset ppos when
> > > > we got enough or more than enough data).
> > > 
> > > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > > works well in practice.  These are very small writes.
> > 
> > Perhaps. In any case your patch will break existing partial writes, right?
> 
> partial writes never worked

I don't get this. Does it mean it never worked at all, or in this particular case?
Also "never worked" means the same issue you pointed out (uninitialised buffer) or
something else?

> so this doesn't break anything that wasn't
> already broken.  Another option I considered was just initializing the
> buffer, but returning -EINVAL is the right fix.

-- 
With Best Regards,
Andy Shevchenko


