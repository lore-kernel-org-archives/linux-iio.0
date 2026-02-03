Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537039B4B7;
	Tue,  3 Feb 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113431; cv=none; b=bdyxbeEOmYIdsBfpac++jmJsYCzknjt3llWj9GvEJfuX+w9gtRNmHea2RZq6EvGJOYtBMsZDt64a9mgFRUm2e/7qCXjfFr51inupQM9w9BlTn2/o4xDcrcOATRt9O5hmZtxJ9QgnfAyh7USGCyngXh1zGq0FRzrp7xTXakXzOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113431; c=relaxed/simple;
	bh=ASQt567TmwDj0Kwqsfpa1jscAxuDRz2njZL/BXc7j0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrboNphuYpa9RSNZL+kLO4P7JSeJsbknFRSprqNCRV9yfUzKX/Jj93gaVwakzbacL15lPn5HjzqaIKgF7DbzZa5HKKOmL03BgBM+6JT23DvjZiNq8EYWENxkk5k0v28KvqLqHb5X+55IK6t0UYxthNlgm+8apjIbWchWbnGr8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPeKi/kC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPeKi/kC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770113430; x=1801649430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ASQt567TmwDj0Kwqsfpa1jscAxuDRz2njZL/BXc7j0I=;
  b=WPeKi/kCSnIBfd9PlNJFUUNqHqLHt9JovBWFYRkaEkgS9tEgj0IQqxma
   Fe6k7AWX0BYtjcESYyK7YSMzHBN5yfowQqWUa4boccqMma/AYZPQP9KMk
   2Xm/OPzHohTGjrPFXduSNlwnmSUs4x/2dTXhMB/Ka0t3F+iMPe9G4gDb5
   6NxIJVQeL5+zLF9QxFZVhA4MfDVmlR5+mz4FZvbGOvDYqhhhurTykWAGq
   wf6/EhJHAOJ6110t8xbw0OSto71HfvTsI5xPpa3CYjdFj668eg9JMi+zz
   /7Kp0ImAgyNMjJwQpJdo+rAujBVgFgdXUD4+hhwnjXXbzb8e5TyzX0Xl3
   g==;
X-CSE-ConnectionGUID: CJjTLA1lRRKtO6Pt6KTbkQ==
X-CSE-MsgGUID: tBEiZdwuTn6EysE/QTtlaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88702817"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88702817"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:10:29 -0800
X-CSE-ConnectionGUID: CUyOb+gGSvmMzaQG+nuLCA==
X-CSE-MsgGUID: ZsQpgSubSpGALXBjt4iGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="240476389"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:10:26 -0800
Date: Tue, 3 Feb 2026 12:10:23 +0200
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
Message-ID: <aYHJj5uSnrj2xp4b@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-6-o.rempel@pengutronix.de>
 <2cfd142fbaad3ddd3b3fb632c77a4e9f58d50f66.camel@svanheule.net>
 <aX98dbnCcFnFY3ks@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX98dbnCcFnFY3ks@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 01, 2026 at 05:16:53PM +0100, Oleksij Rempel wrote:
> On Sun, Feb 01, 2026 at 03:42:28PM +0100, Sander Vanheule wrote:
> > On Tue, 2026-01-27 at 07:09 +0100, Oleksij Rempel wrote:

...

> Which works mostly fine except of the cache initialisation. If I use
> num_reg_defaults_raw with REGCACHE_MAPLE as proposed by Andy
> Shevchenko, first access to regmap values over debugfs will explode with
> NULL pointer etc...

Yeah, this is known issue in regcache core. I don't remember how it was worked
around in pinctrl-cy8c95x0.c.

> If I remove num_reg_defaults_raw, I need to read register manually
> to init defaul values as implemented in v3.


-- 
With Best Regards,
Andy Shevchenko


