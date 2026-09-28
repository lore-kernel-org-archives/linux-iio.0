Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C81440A25;
	Mon, 28 Sep 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583264; cv=none; b=IwQdpkwN3eXxvwDJjd5X4uWJPsoQYYrCCRu9XloIzubh72WWKIbQ/b2pEwZ7ox9+qEnEg5KbOH7hc22w/HFBFoUM/HnRgol2DZYrbFG/8gPpZmnvnAwbeHmXFXk/KimZ2/3o7n7kdWxpgvUTFYX464J+zoGttTtceRCOEgDrN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583264; c=relaxed/simple;
	bh=7ybBn7ZdwlBlJ9WHyiY2r7WhsvHiPw4ssNpFoeZYcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyOjm47/IZuzFO++mu2EhMA303WNzG1cJ8ZfReia67v4dGOt9VZk3uUzpDoN2vvPkdM9njjVBZEToCbqudcFcTIV9Mp596NANRBh7bYTppslca096KJ7idupbx4kbMeFD2EcIKBk4jaBFmcoktgJp0NQfL2w+VqIIR9vnYcO0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbD+zQ1s; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbD+zQ1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790583262; x=1822119262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7ybBn7ZdwlBlJ9WHyiY2r7WhsvHiPw4ssNpFoeZYcAA=;
  b=lbD+zQ1spia+aw8H+QKWGVyWUsZVxwF7kl6PG8OO2lkZKRU4w/D27Zn5
   k6VSFdfL3AT5QQ0D80Bog3ASZ6QSVYsdL0VSjj1w7+rqfmtFJdjeXNmic
   Emshgsvik17j0Df2yupsCi3C6F6+5iwTnebCWJ/tRcvsP4mgyUBu4qHpa
   hN5w3OxUdBHsadVN2Jpwmkn8gIfVEDuY0JVAbVmRnzaebVwaqBio96Kip
   LWz+zL8nKsbsfWLnrWn4PeTRZ1LAO7d5XouZIWmElgnbN4xcvkuQcahp1
   nCrA6IYSD1aS2uHdM1O/6Gqm6K8oPncugUlGpf0xr4mByPu2985JlEQ4n
   w==;
X-CSE-ConnectionGUID: 5yLnnwS1SGWzhcTOw32ecQ==
X-CSE-MsgGUID: FGOP36HFQbKhetnzVSrdvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90403270"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90403270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:14:22 -0700
X-CSE-ConnectionGUID: 7I02WSn5Rj6DcHajdOBhGQ==
X-CSE-MsgGUID: u0YdxXt5RaCKv0QaYSR51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278805402"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:14:18 -0700
Date: Mon, 28 Sep 2026 11:14:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Jiale Yao <yaojiale02@163.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Anshul Dalal <anshulusr@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Shi Hao <i.shihao.999@gmail.com>, Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: validate SPI match data before use
Message-ID: <aroh125qBr1ZAXBI@ashevche-desk.local>
References: <20260925131738.2200612-1-yaojiale02@163.com>
 <20260926021143.478d5361@jic23-hlaptop>
 <ardhvKaSdYh2HiS6@monoceros>
 <20260927182001.10c331dd@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927182001.10c331dd@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 06:20:01PM +0100, Jonathan Cameron wrote:
> On Sat, 26 Sep 2026 08:13:13 +0200
> Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:
> > On Sat, Sep 26, 2026 at 02:11:43AM +0100, Jonathan Cameron wrote:
> > > On Fri, 25 Sep 2026 21:17:29 +0800
> > > Jiale Yao <yaojiale02@163.com> wrote:
> > >   
> > > > SPI driver_override can bind a device without a matching entry in the
> > > > driver's ID tables.  spi_get_device_match_data() then returns NULL.
> > > > 
> > > > These seven IIO drivers use that result without checking it, causing a
> > > > NULL pointer dereference during probe.  Add the missing checks before
> > > > the match data is used.  
> > > 
> > > I was hoping we'd close this finally by adding a flag to the
> > > drivers to say they should fail a match if driver_override is set.
> > > Given I thought maybe that would happen when Andy looked into this
> > > a while back I've been sitting on this problem for a while.

Sorry, I have had no time to continue...

> > > 
> > > Unfortunately seems we have to carry on papering over it in the
> > > drivers for now :(  
> > 
> > Note there is another effort:
> > https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com/

...but I like this effort, it looks great!

> Nice. I look forward to ripping all these checks out again
> if that lands. Obviously we won't backport doing that given the checks
> will remain harmless.

-- 
With Best Regards,
Andy Shevchenko


