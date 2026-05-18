Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96813CCFD9;
	Mon, 18 May 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088832; cv=none; b=a2ESLw/S7BhKY25wD/qfuAwiBGNTk/p5YTJdfeIo6ZjlLffJ9AcNZdn0FnmGQZLub4q8OWFBgHeCiPduTcF/eNS6BH7YHxZVNlYTquWlLCVFaVn2sFYr+QTY6bEOmoGvLsV4CDQpudgPMUMT3BNytD4B8jfdrIQ+EKvyrs4iWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088832; c=relaxed/simple;
	bh=WUE3azwpwSGDLLidCfoDQaRKQ+FYHIdX6WG4G173qK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX0g1x9ZDcs0bnQOLwQ5M1gEWVurPj/TEM08iZCsY4FCft+aL+ouQwSDUouVWqI0mj8GO/TeBCIp4ZaOqm2ieWmpKg5xEr4eDNdHjugrKGH9zufov6kC2g+NrbZm//p7HmY1RK1GxZPFOke5ah8+QjCUnykGoFkcIeJTpc5HSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhsMWycA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhsMWycA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779088831; x=1810624831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WUE3azwpwSGDLLidCfoDQaRKQ+FYHIdX6WG4G173qK8=;
  b=FhsMWycAfru4pG4kwxPio7SAT4xulhjm2QaBqnlHo6Sgb58i1gpgMj9Q
   0IexDhsVLnqZOYVd+1OnYouQm3gRYSGsrNAKdYYy2mtv8PPkcwDjLPtGe
   VCExd9+DtCbHkd2mnQQD1LNaRjtHmYjlzEJ5gl43/2vvVJ4Q2GzjZPptq
   RoeT1RYtjq8x0gHAixbtzOFW/0C2lPLwjjZVkSubclaUtrEmGmo69DKdA
   TNpjbQonFL0W4EHIatO2xCTUkLvd/i1DSxhFLso47/+x5B3hSwxzT1Y7K
   vXfGo2uzsQfdXRHMzbVQGVDyFzAoygXtejgIk+VUv3eZBM0tpGymTmMWk
   g==;
X-CSE-ConnectionGUID: WNDEg7qKQJakcQPTnO4kAA==
X-CSE-MsgGUID: 4mddbOZySoS3IRAC0AX8xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="102608170"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="102608170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:20:30 -0700
X-CSE-ConnectionGUID: vYnfhBkGQy6WQzx56fXtWw==
X-CSE-MsgGUID: gsEImEB4T82fL5MkSN206Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="236711247"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:20:27 -0700
Date: Mon, 18 May 2026 10:20:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: accel: mma8452: improve coding style, pm
 and resource cleanup
Message-ID: <agq9uWCrS3txgO5B@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <agogfypMDl6dS9D6@hu-ckantibh-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agogfypMDl6dS9D6@hu-ckantibh-hyd.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 01:39:35AM +0530, Sanjay Chitroda wrote:
> On Tue, May 05, 2026 at 11:16:30PM +0530, Sanjay Chitroda wrote:
> > 
> > This series contains a small fixes, cleanup and improvements to use
> > modern kernel helper API and coding style for mma8452 accel driver.
> > 
> > The changes modernize mutex with guard(), dev_err_probe usage,
> > resolve checkpatch CHECKS and pm_ptr macro usage.
> > 
> > Changes in v3:
> > - Following input from Andy and Jonathan added new changes as following
> >   0001: handle return value to have proper error propagation
> >   0002: use non-devm API to maintain resource management LIFO order
> >   0006: convert individual regulator using bulk regulator API
> >   0009: use IIO cleanup helper for DIRECT_MODE
> > - Address kernel coding stype specific review comment
> > - Reorder local struct device and dev_err_probe change
> > v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
> > Changes in v2:
> > - 0005: address review comment from Andy and Geert
> >   and use DEFINE_RUNTIME_DEV_PM_OPS macro
> > - Added new cleanup channges in mma8452 driver
> > 
> > No functional behavior changes are intended.
> > 
> > Testing:
> >   - Compiled with W=1
> >   - Build-tested on QEMU x86_64
> > 
> > Feedback and reviews are very welcome.

> It's been about two weeks since the latest posting, and it looks like
> there haven't been any major comments so far atleast on initial changes
> of series. I also don't see any progress on the iio/tesing branch yet.
> 
> Could you please guide me on how you'd like me to take this series forward?
> I'm happy to rework/resend partial/full if needed or wait further.

The recent flood of the patches in IIO makes maintainers and reviewers
overloaded. If you want to help, be a good citizen, start reviewing others'
work. Otherwise, wait when we have time (it make take a few weeks or more).

-- 
With Best Regards,
Andy Shevchenko


