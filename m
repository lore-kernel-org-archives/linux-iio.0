Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA840DFDE;
	Wed, 10 Jun 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099101; cv=none; b=MIyR7qARQhKaWOrdHhfimUXWUH2+QpAm/6RNJEQWLQsFMyCT7LZFPIi81AhyyJtdXUA6iBNJ6aVZNgRb+FA5Has9u7VvElqjtxBgagx3Ae9V9RcvzcT+gHf397CWLE73fN41JxwLS2y+FOMcAnk4Zd7Ie0I6iegSSNdLnwScQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099101; c=relaxed/simple;
	bh=JWdh/JmClR11NyXpjCWwx0d2V5ZBz9B66Qvj5kfvU+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYdsAAxOwUe4p9co2JTqgoi2NJ0q9xvLEEQxRFTzGkQWBfhvbBD+5KdUgWbqnA9OdSagnPxu7Ar2Zp7jJdTvUw9g2QPQWUJIWBFA///bJUCDQl/TjsIIbGhENS09/j2Dfw2wMRtIsgaccRaZgkA+CclJlOeicCNTl6xfpOy64s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSAbhYXS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSAbhYXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781099099; x=1812635099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JWdh/JmClR11NyXpjCWwx0d2V5ZBz9B66Qvj5kfvU+Y=;
  b=aSAbhYXSNF86FodDLdR4dfDkOls7PPXp+O583DuspNnw/bsrU/nnXuQW
   y4y3lHZ9GKNE/yv5EzzA++b2/TrNdupnfUEmFISgKfAxXngahW5jssUOz
   gJlg2Qs2U1P0ODnicLoOh/3mwkKdmE0b1Bx/wEmljQ/CLLCbN8Jl//FIT
   Dwb9Bm+fy9AOGSRszlcqYpl+ugJtucdy4RN6kANiYXUiWEwq/c9sMITQE
   qYxjl70DsU2wmQe6A25sgsRkws7fZPaJANF9lzDWfIBXnMK8kscbPUK5v
   ml6O9lhcuplB58O/ysUIJF2tsc1Cxd2CQXNYAcrzTAyMdi++gtZoGYp/t
   Q==;
X-CSE-ConnectionGUID: rauG9dOeRKeR5yvKOV0DaA==
X-CSE-MsgGUID: 7iYW1rtuS2mlDSBrXvrlIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84461787"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84461787"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:44:59 -0700
X-CSE-ConnectionGUID: nvKBqN0pSOqEeJtQ67NZuQ==
X-CSE-MsgGUID: XDhS6DEiR12XRaWf8bBRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242043297"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:44:57 -0700
Date: Wed, 10 Jun 2026 16:44:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <ailqVhzMh1zLBujf@ashevche-desk.local>
References: <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
 <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
 <aiewiqInppHKilw1@stanley.mountain>
 <aik_bXUpVc90_eIy@ashevche-desk.local>
 <ailWP0rNKbVAn4kG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ailWP0rNKbVAn4kG@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 03:19:11PM +0300, Dan Carpenter wrote:
> On Wed, Jun 10, 2026 at 01:41:49PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 09, 2026 at 09:19:54AM +0300, Dan Carpenter wrote:
> > > On Fri, Jun 05, 2026 at 11:28:18AM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > > > > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > > > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > > > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > > > >                              ^^^
> > > > > > > > Uninitialized variable.
> > > > > > > 
> > > > > > > s/variable/data/.
> > > > > > 
> > > > > > With what I asked in the previous reply and what you explained there
> > > > > > (thanks, btw!) I still think your patches are not fully correct. They
> > > > > > will require to atomically write all or nothing. If we want support
> > > > > > partial writes we need to go with that differently (reset ppos when
> > > > > > we got enough or more than enough data).
> > > > > 
> > > > > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > > > > works well in practice.  These are very small writes.
> > > > 
> > > > Perhaps. In any case your patch will break existing partial writes, right?
> > > 
> > > partial writes never worked
> > 
> > I don't get this. Does it mean it never worked at all, or in this particular case?
> > Also "never worked" means the same issue you pointed out (uninitialised buffer) or
> > something else?
> 
> I mean in this case.  The patch doesn't introduce a regression because
> partial writes were already broken.

OK, now clear.

-- 
With Best Regards,
Andy Shevchenko


