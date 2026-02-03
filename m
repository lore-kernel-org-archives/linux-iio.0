Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272D39C626;
	Tue,  3 Feb 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113632; cv=none; b=l8g39XuPeW8LssaSHUJgGUYC4MZuYUjLaUNjHa3iw07HK1g05jFCuV7z3S5BHramR6FSZBtEvXLNU0jF7bZL4AwNmjlo9ZIk4TGbP15yjgyI2GUKy9W71NJqVUF/8rUF3L0zD/x7qq0uCgUxIMzFm8TpiDXUGTD1H65tcFUNLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113632; c=relaxed/simple;
	bh=GQHUATgo3g+cVaXsYUl1ZEM+Z3+/BeppYcBJP5GiH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2SJlWrLZVCfV2PUgTxU4Aj+Ru2HRx2/XDojJhjoiHRQoocx/MkVFqlFacwUQvSNKhT/yZAwIrq203AAe8MZyNsQu0/sOiEYhNEfEQGIYgD36w1BVhFZUYzl7nl+cvU62yce3/g0r546Be08WoBoDHVUH+h71OEYJoDILAfvVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnnX9cHK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnnX9cHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770113631; x=1801649631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQHUATgo3g+cVaXsYUl1ZEM+Z3+/BeppYcBJP5GiH2w=;
  b=BnnX9cHKDGGQ/pgn5BPvPmONM6U1dEu+pz7Y/GTD/gf85p/T9byDP8g9
   k7HhnF9517PB9nhKYpCzRdSOnP9/5IOACW0+q0wyT+MEk3H8v3wWqjdnP
   hLVPENJAkkT0T9T4TL69cPtlhA+ohe3aX+7rC+tCifnURvyzOzyQWQipo
   X/HW4DEDxxqx6YyzLoPygdeV+T79L0FJKc+3q0+1TvMa56EdKglAunOjx
   hWnwsVzmuSbWdVdAZpYyTGtSTCi2U4qn0Gztf6g6LKQ8BNQsuT7spFBLl
   jkZdw5uQCklRmuQjFtLelSyWE1IzL4je6JFn5TkBkVsiBQMHFndTH/BWP
   Q==;
X-CSE-ConnectionGUID: jehW8zHHSvCjsBgeurKw4A==
X-CSE-MsgGUID: 6Yp0CHZvTK6UNUREgg9CkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82653312"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82653312"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:13:50 -0800
X-CSE-ConnectionGUID: v78IxdWLRLiGXUnD2lkJkw==
X-CSE-MsgGUID: CoDila0uRKWIm+AP0t5c3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209978221"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:13:47 -0800
Date: Tue, 3 Feb 2026 12:13:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sander Vanheule <sander@svanheule.net>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 5/8] iio: dac: ds4424: convert to regmap
Message-ID: <aYHKWGKAuaeYD4xh@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-6-o.rempel@pengutronix.de>
 <2cfd142fbaad3ddd3b3fb632c77a4e9f58d50f66.camel@svanheule.net>
 <aX98dbnCcFnFY3ks@pengutronix.de>
 <aYHJj5uSnrj2xp4b@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHJj5uSnrj2xp4b@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 12:10:29PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 01, 2026 at 05:16:53PM +0100, Oleksij Rempel wrote:
> > On Sun, Feb 01, 2026 at 03:42:28PM +0100, Sander Vanheule wrote:
> > > On Tue, 2026-01-27 at 07:09 +0100, Oleksij Rempel wrote:

...

> > Which works mostly fine except of the cache initialisation. If I use
> > num_reg_defaults_raw with REGCACHE_MAPLE as proposed by Andy
> > Shevchenko, first access to regmap values over debugfs will explode with
> > NULL pointer etc...
> 
> Yeah, this is known issue in regcache core. I don't remember how it was worked
> around in pinctrl-cy8c95x0.c.

That said, have you run the v6.19-rcX kernels? It should have some patches
related to the regcache, but I need to test and send the actual fix for that
NULL case.

> > If I remove num_reg_defaults_raw, I need to read register manually
> > to init defaul values as implemented in v3.

-- 
With Best Regards,
Andy Shevchenko


