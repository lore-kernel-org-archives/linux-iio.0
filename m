Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEE3321DE;
	Tue,  1 Sep 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245828; cv=none; b=mStfGR+A+XYVwyWvvzTjCUTwQHF3PCKGiC70iQ5ZEiS8o/rlnAx6etDpIlaKUrRKhwXWT/f9D5wFnlntjncc5qGiJsnh5ZPi7fakibcHd346ifxf98ms2xgDvqoxXIYUZdcgbuYWw5VrUSHLs+728PeFrnE3UUCEeuxE/cenP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245828; c=relaxed/simple;
	bh=Z8iSOtQQ5N/Zb04KDBa6B08g8AitxJSoe7kabS6P2yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ/VNdU7cN96ztcRixch/9Fk/nsurYAb3ak4A6ouV6uKsQthEz3T8l6uiVPMDZeW6R+7S+aqzf1TbKAhXl0CKCqT5DP/lp2aPmBX7YpXHOmkx8WMpJihOHjPN9jgGHiEoiojaL6pv906+PyneUm7qLg/JxFrA562IxdDc85KlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UC9YZcV8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UC9YZcV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245826; x=1819781826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8iSOtQQ5N/Zb04KDBa6B08g8AitxJSoe7kabS6P2yg=;
  b=UC9YZcV8yNCyFfo51g6Qtl45Bnx5LcokTNiOxZnuSoPlGgwiJ7dOVSQ1
   orYvfPc3825+tJgozkBqCJMtwMka/Wf1xP6pDlMlTpCNunh4msZeNMpsn
   bibtkSNibrc6TCbP+p755GGjY6eb+OhYh5uQ5tqMYUT2yd7av/FBUzMcB
   FbvDtVCCoYM6xWBczytnaIPthsXjSF/p2EllCAwmc9u3IA3EwatGKbnf5
   czhEgxvhxb7PxR5Y2+jcH8B0EevA/8sjO8iK7JYiBZDFxHOrjXktJNZ0w
   A3u97ORNIBd6I3pC4hxsE49vh7x3ObcKaJJg30fKulfMjmFc0DmuOfl5v
   g==;
X-CSE-ConnectionGUID: 2wkdz+vKTmSfJMsoOaWmzw==
X-CSE-MsgGUID: 0JR/jsl9ReS7RCDF4aCsWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="111435564"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="111435564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:57:06 -0700
X-CSE-ConnectionGUID: 0dRf2eKMQ6mUUxunvfbtVA==
X-CSE-MsgGUID: /rACxs7dTwis/6NrTuKXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269060856"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:57:02 -0700
Date: Tue, 1 Sep 2026 09:57:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: mdshahid03@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: bcm_iproc_adc: fix include dependencies
Message-ID: <apZ3PBOrxn9sLjKD@ashevche-desk.local>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260830170919.470974-3-mdshahid03@gmail.com>
 <apY4GY-0_XMSfE9B@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apY4GY-0_XMSfE9B@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 11:27:37PM -0300, Marcelo Schmitt wrote:
> On 08/30, mdshahid03@gmail.com wrote:

> > Add the headers required directly by the driver for completion and
> > mutex APIs.
> > 
> > Remove the unused `linux/io.h` header now that register access is
> > handled through regmap APIs.

...

> >  #include <linux/clk.h>
> > +#include <linux/completion.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/io.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> 
> I think that's okay. Though, if you go for a v3, you may also add 
> #include <linux/bits.h>
> #include <linux/types.h>
> #include <linux/array_size.h>

> #include <linux/device-id/of.h>

This one is covered by platform_device.h.

> #include <linux/iio/types.h>

This one is covered by iio/iio.h.

> which mostly completes the list of includes iwyu tool reports to be missing.

The rest is indeed needs to be added. Thanks for spotting that!

-- 
With Best Regards,
Andy Shevchenko


