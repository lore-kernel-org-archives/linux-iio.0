Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ECF7262E;
	Wed,  6 May 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048371; cv=none; b=CewpB4kptUd7IN/pMbaMUVSIf38pCGLTgINhcLxNra2GYzy8NR207gmqJo0KlA2CakdfSIGX2KWKM3dMScSCvzmchBbodkpBqZT8mNOSo3QQWBiVrdY5PTjQxClx0JvwInNFU92zLwhhdRu1iZMRc/m1O0s6me2Lz8Is0xDB2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048371; c=relaxed/simple;
	bh=DR9fZ3oGj6GeeB5Do1nfWee/Qi0geXdjcx6Al2z2im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYoEBcObvSlc+AXGYCYbeH96sPRKDOH2Dli5z0klA9bvkaVA4vCafzhdJCIl/Nebayy0NVkledjlnyIPO5K6lTjPWZifTkynCkQMYKbWfQrVefnHL3g4X8BCXkPItVU89MxKY46CfRC+JcPoO8epgmsLIU9CtoW1LnrRcDn/Iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc6l7uud; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc6l7uud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778048370; x=1809584370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DR9fZ3oGj6GeeB5Do1nfWee/Qi0geXdjcx6Al2z2im8=;
  b=Bc6l7uudqgyY5yORaCNzsT6T9PcZxlCv7vDaq6XEaSGCbIjZdnitQWry
   hOMbShBnMGxIwBKjR0xJTvDY4+FxPHJ6TRboY8NmCvN2TdoNTVn2OnsZ3
   s50co02lJmjLxk5swk8yDIlBDOiKYy2xYCL+GE6wWkpzq7zRshXTZWJkO
   yfP2WCzaN8o+tKUbM8SwYTmvNgStK09aIrGJD6xx2QHt4xuCmXTp03InF
   lXOZjSb+Ox90gXiwkANtI8dzpg8jAX1RGcu+dYu7ILDAE3ChQOZMrzqWA
   9Wuu0kAu1CTpssi7DWGTesZszBqpvHc/jFpk+JzXaYNeV7qGD6tyWSWjg
   A==;
X-CSE-ConnectionGUID: 7/6ruuM2TZq9VsA4gR/Isg==
X-CSE-MsgGUID: xoVVDr6+R66yW6i5D6YjEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89533275"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89533275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:19:29 -0700
X-CSE-ConnectionGUID: aUL5I1YTRH23vYlakaXYAw==
X-CSE-MsgGUID: ZPdnQYTZQy2yXjw2bdsNhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236108381"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:19:27 -0700
Date: Wed, 6 May 2026 09:19:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
Message-ID: <afrdalgL3rEvYCEV@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com>
 <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
 <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:26:08PM +0200, Joshua Crofts wrote:
> On Tue, 5 May 2026 at 22:30, Maxwell Doose <m32285159@gmail.com> wrote:
> > On Tue, May 5, 2026 at 6:53 AM Joshua Crofts via B4 Relay
> > <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> > >
> > > Replace usleep_range() calls with fsleep(), passing the minimum value
> > > required by the sensor for hardware delays.
> > >
> > > fsleep() automatically selects the optimal sleep mechanism, simplifying
> > > driver code and time management.

[snip]

> > Looks fine overall but has this been tested on actual hardware? Just
> > want to double check since this touches the set_mode and power_on
> > logic.
> 
> Fair enough, this series mostly concerned code cleanup and moving
> away from older driver programming practices, so it shouldn't mess
> with the functioning logic as much - however it would be more than
> welcome if someone had the hardware to test it.

This simple patch doesn't change the minimum time to sleep, assuming the driver
was tested previously (and it had to be), the given change is very unlikely to
introduce regressions. Also note that the similar changes have been done all
around the kernel in the past few month and I haven't heard it brought a
regression to the users (but if you, Maxwell, have some pointers to otherwise,
please share, I would really like to see such a report!).

> > Also I will say it may be better to keep usleep_range() since
> > it's more explicit, which will likely be better for the future to make
> > it obvious. Also, I was taking a look at the docs for fsleep() and it
> > provides "maximum 25% slack", which means we're stripping away almost
> > 375us on one of these calls. And besides, it would eventually just
> > call usleep_range() anyways.
> 
> I disagree here. If you look at the documentation for msleep(), you can see
> that "slack" is actually an addition to the delay time, not a
> subtraction. fsleep()
> will always guarantee a delay of at least what's supplied as the parameter.
> 
> About fsleep() translating to usleep_range() - yes, you're correct about that,
> however not only it's more modern practice, it also doesn't require the
> programmer to add an additional arbitrary max value, fsleep() just
> adds it itself.
> As for explicitness, I think fsleep(500) is explicit enough, as described above.

Yes, fsleep() is recommended way of non-atomic sleeps with a microsecond
granularity.

-- 
With Best Regards,
Andy Shevchenko


