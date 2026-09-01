Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CA415B8F;
	Tue,  1 Sep 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246811; cv=none; b=eH7VSi57XpBSTpwV2xD533TJc1PhSRMmy1pxFQEh6TzCwrnqcfxeah1vzH4+7Q9HPSHdeRiqyk1VNwvLvqZFKU0atcm9/tXn7qu5Yb8XiQI7VELWoX6iWMWuvIE0am2L9X6jYrcPpZEXYuFv3itnUa6tL2tFQCU+LbTEk5oKRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246811; c=relaxed/simple;
	bh=lIbuJ1Tvy1SNjfie8kslSdQan8pkxnFTsDJhFrNDajw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhgC9IOr5RzZozqwBrBYEfplw1ct8FsYmZSYvjKiwen+tQ8i503/a+hAhPV9KqsJQd78VCtWQWHeO6m06nB69ICHn85GpS4znINkN4UBlSepR86KVcbVR3mqCw2Q4VmO76Tiq0mHNwezVuq3H3OEYs9H+kKMtGaTFgsVIkZNW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGpyXamx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGpyXamx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788246809; x=1819782809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIbuJ1Tvy1SNjfie8kslSdQan8pkxnFTsDJhFrNDajw=;
  b=TGpyXamxqi75H0g++JYFBUULrxQgzxpV+VGlqHV00VZS+EgCAe/d+5JI
   dOvpx8ENvLzG8FGFzevUpiAjCmkaKvX3K+t8YMbLFGATMF8I0F7yH2BjE
   1hKsH6gdVzLP5ThEupVu392K9ddeU4jU2lt+dzf7ALjtXFMmfJlktHff7
   2eSib1tt3bzmbm8qfn8kxc9JHQYASJYcjIEb7XLCg7wrG1Tt6pDfTQETr
   wzupvFPfpPgbl2+ijVyHYFChs4qgwn7xPU3hINycXCfvhPCfleY5soJGG
   GzkHjvIaIdJDUwhUHfpJxHbgfklLg48yOGaI8zZOFP7TkWE6AsOhwcoYj
   g==;
X-CSE-ConnectionGUID: 5x/9YsshRbindCqX2CSojQ==
X-CSE-MsgGUID: 8u126HA6SW2fpp0kOcNB0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88592464"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88592464"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:13:25 -0700
X-CSE-ConnectionGUID: xdSXeKOYTdatfy05Sqk8rQ==
X-CSE-MsgGUID: f7k/mDcfR4SH8WALBQSsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="268480641"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:13:21 -0700
Date: Tue, 1 Sep 2026 10:13:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] iio: accel: mma8452: Support interrupt sharing
Message-ID: <apZ7DpgQM6v7JbcS@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
 <20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
 <Ncm871ICTmFO0dGlJCPws8DbZwRNawMZGh74FyRieKxOU9C35zNksyV7FWkx97CU50ky9hYms5spg6SF8rATTQ==@protonmail.internalid>
 <apWIJfGoQLtDV4IB@ashevche-desk.local>
 <87ik4quwhh.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik4quwhh.fsf@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 05:43:06PM +0200, Esben Haabendal wrote:
> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > On Mon, Aug 31, 2026 at 02:17:07PM +0200, Esben Haabendal wrote:

...

> >> +	WRITE_ONCE(data->suspended, false);
> >> +
> >>  	ret = mma8452_active(data);
> >>  	if (ret < 0)
> >>  		goto runtime_resume_failed;
> >
> >>  	return 0;
> >>
> >>  runtime_resume_failed:
> >> +	WRITE_ONCE(data->suspended, true);
> >>  	regulator_disable(data->vddio_reg);
> >>  	regulator_disable(data->vdd_reg);
> >
> > But with this, what's the point in having WRITE_ONCE()? It can be read
> > just in the middle as true and be immediately changed afterwards. It
> > may be that I am missing something, but I think WRITE_ONCE() should be
> > done once in this function.
> 
> Yes, there does look like there is still a race condition after adding
> this data->suspended flag. An irq handler could just have read
> data->suspended, gotten false, and thereafter proceeeded with handling
> the irq, and then we write data->suspended=true and the irq handler
> would just continue with accessing the device, even though we are now
> (if possible) powering down the device.
> 
> I did go through all the pre-existing runtime pm and other race
> condition issues raised by sashiko-bot during this review, and worked
> through it all. The result is a quite a bit larger than what I would
> like to add on top of this series. Among other things, it converts the
> driver to use regmap for accessing the i2c registers, and after various
> fixes the data->suspended flag is removed again.
> 
> So I am a bit hesitant to pull all those changes into this series, the
> combined series would blow up quite a bit. But if required, I guess I
> can do that, although I fear that it will not make reviewing easier to
> mix things more than maybe needed.

Personally I would go with it, or as a compromise, publish somewhere in Git
(like on GitHub) and share the link to the repo (in a format that one can run
with `git fetch ...`).

> Could we find a way to merge this series first in some way, or should I
> post a new version with all the other fixes added on top?

It's a Q to Jonathan.

-- 
With Best Regards,
Andy Shevchenko


