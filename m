Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D8288C2C;
	Wed,  3 Jun 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483060; cv=none; b=EugY8tM508FQ3FF9QVVnvoB0ePOn4soAWvX1axyDHBqhIQFG5G0ndEoYn3Rsuw5nf5nH7YCn3vZaa1m3FmlndShcFAVYhlbMgbukmS/WZ2aqU30Wjqi9A+pnQtC4lm884N6UCxhrjE73qn4wmlI/YyEW0mCgLDoojWRP+rusBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483060; c=relaxed/simple;
	bh=X4mVxlxVth0msKWdz8364H+h5BSmScGEnRdk5r245Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEOorltCf2QqmTumHWhbXIBJRKRl2p2tBWwyTBTIV7Q2v05cINljSXxELlcaLtggAX4w1JW1ODFNAWZHWzbpBdwhJaNbBlLm9AXrPgZjmEhwbHJpYuaPivydvvSGLY3kZMdRu/KagbAg0z6lDoTb2od/hoPJQHRnd9DKc6Lm9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyPakE4W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyPakE4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780483059; x=1812019059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4mVxlxVth0msKWdz8364H+h5BSmScGEnRdk5r245Pk=;
  b=TyPakE4WynyU6CJmCFq6ZXXkWLRCTD3M0lVYLLxzH7YyM7vZDaYJbEns
   nYxGwltg35tBfmwXrpH23dzZSDG4Fav08Zabk+TTFCorHwElzCltCEmbu
   k+fdq+FVES6MgxacxeNNLpkVlIhbR9z6jaRnkD9YyDe2H/8nIko/gS5Ai
   UR6IWSrFcQ23aPjNyXM2zXg+qSXevWcsLt+hdp1fAxTg7QRvhhviBVnPP
   NHIXasiaWXzYzKXSaNLD71Vg1WhP3rBZhLEGoPCzdJWnjSWYL/OcTEeiB
   1HnLRwuhEllTVQhvzgQ0lB+goejAWhcQSsr1+4wA4yHMW3bDe4CjkBxxE
   w==;
X-CSE-ConnectionGUID: y56YoGlPQYme/YeucnQt5Q==
X-CSE-MsgGUID: KxPIlcKCQLCGASkP5VXqHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81282403"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81282403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:37:38 -0700
X-CSE-ConnectionGUID: CX1ZQQxcTRKSLFum56VQ/A==
X-CSE-MsgGUID: PWu7vRgoQzyXS297Z3ra6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244027258"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:37:35 -0700
Date: Wed, 3 Jun 2026 13:37:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <aiAD7HRnWmSJb738@ashevche-desk.local>
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
 <ah_zMybQBDHakXpX@ashevche-desk.local>
 <ah__2Fjf0MxIQLnh@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah__2Fjf0MxIQLnh@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 01:20:08PM +0300, Dan Carpenter wrote:
> On Wed, Jun 03, 2026 at 12:26:11PM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 12:33:33PM +0000, Taha Narimani wrote:

...

> > > -	if (chip->id == ID_AD7817) {
> > > +	if (chip->busy_pin) {
> > 
> > If we get GPIO optional, this check wouldn't be necessary anymore as the below
> > should return 0 IIRC in this case.
> 
> No, it's still necessary.  It can be NULL because of the CONFIG_
> in which case, sure, gpiod_get_value() is a no-op.  But it can
> also be NULL because of the device tree and in that case we need
> the check to avoid a NULL pointer dereference.

Can you elaborate on the latter more? I fail to see that.
What I see is that the function either implemented or not is NULL-aware.

> > >  		while (gpiod_get_value(chip->busy_pin))
> > >  			cpu_relax();
> > >  	}

-- 
With Best Regards,
Andy Shevchenko


