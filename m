Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCA47043A;
	Thu, 15 Oct 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089896; cv=none; b=k4y0Yy0JCOtPR66vmQ93bo3RHlqHNNoV4V/HinnCtUmR4sJU0uT5obUJWiERpcGB4Ez2iWtAnmgg8VuYcUfdgRuA6+CfCmaSfjIkQKBzm3NnRB6aNcr9bTdyBk4XZpjlWLr7wmqnpZsbXfocqqpCzOU3ncZLPOyskbRm4FvlRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089896; c=relaxed/simple;
	bh=ihE4/ZnP5AmM4RIy/0ykwBUB3TeXDWlsPGLvMW2Q5y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm81hHRIfBAFzdQ+o4ah23DdGREpQmeTtdsSGEqmpA3TDRDmg9+kOEF0UIrS4FGp0p8HilEWY6HDG8rIV5Of8ukOMDOc/vnIG9vRG0a2qi9a8ztKBOFHkI0HZjLR0IsjY6FcSoBBfEell6Y3GprbhvqdJ5jwcBJL/nV2tqSY8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8HDAzwY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8HDAzwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792089894; x=1823625894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihE4/ZnP5AmM4RIy/0ykwBUB3TeXDWlsPGLvMW2Q5y4=;
  b=Q8HDAzwYJmXjMVQIVO20rscuEx3PWWFzg6xabvT6F2IxetWH1W/y3seN
   k2XLKDfLNjIdvwuscwKimKFzUcC5U0AQ8Zwee+gHgzHSt3j48YIvH1R9K
   u0IezMcZm8WhPrV3PRDP2SsGfLGLFFGdRP1CQXE8hsl8bbkWec/ptcHwi
   RAc8nGhgI0sqeHP7XiaPfjl0ch4RM4X0vHEdB+eDjzDIkZkZCqKOwS1Mm
   RacT/szz2eRehh6NVilIMzZul0ybM7FRBWbomNj74SjncEFZCFkMGVs7k
   OumtSsRBfjF9pxHMUEMOr4U4ME/YZMoatZI1vH7iBoP+T+vcz+Wivzsbo
   Q==;
X-CSE-ConnectionGUID: WJt6rRAFSbOUICym4pGg4Q==
X-CSE-MsgGUID: UMtTb67yS1WTfS2Z7o6lZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="883115"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="883115"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:44:53 -0700
X-CSE-ConnectionGUID: P8YLj7PrQ4CyMoDadET2XA==
X-CSE-MsgGUID: K6UqX+EnQji2y8RYAoMZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1680465"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:44:50 -0700
Date: Thu, 15 Oct 2026 21:44:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <atEfH31U5EFiYx0F@ashevche-desk.local>
References: <20261015151903.13613-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015151903.13613-1-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 06:19:03PM +0300, Abdelnasser Hussein wrote:
> Replace SIMPLE_DEV_PM_OPS() with EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
> and use pm_sleep_ptr() to wire up the power management operations.
> 
> This allows dropping the #ifdef CONFIG_PM_SLEEP guards, simplifying the
> code and improving compile test coverage of the suspend/resume callbacks
> while still allowing the compiler to optimize them out when
> CONFIG_PM_SLEEP is disabled.

...

> +EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume,
> +				IIO_AD7606);

Just make it a single line. In this case I think it's fine. Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


