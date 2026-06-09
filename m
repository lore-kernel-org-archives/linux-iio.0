Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAB2F1FD0;
	Tue,  9 Jun 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026292; cv=none; b=FrtPa8iHtMVoVkakiSaXfEAWkxcAKFveEWRwdx6x6YuXJhSHcMTjQ7ckMAn93U+CtSIsAp4BGtD7MRtZ9lgpkjJw+HpUBgiCLpj+15vcAyH9ExEWCZsE3jBNuO7VXvHSe19bQDT625guyGwGcN+LXFlqlhsLkO6cVDvw6NcUfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026292; c=relaxed/simple;
	bh=4k6t228FHZ7KhhSUsNxJu4taxxiH+bnOTu+2qmwaEp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDjw4DEq1sh6+PPEtwfqoDp42YLC28KZAgNHwFomiJ122SZa8SILoZcXQ5xYFWIApOt4JONsgd6YE81KSrPT9bUqG1vliWVJ782vqX3glWRWafQ5sv6L+dDqm8ID2AJgZtGUhY4urhNR3Jvfeob1MDLUkCBAtK6B/Q7Sr69fHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCeisuOF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCeisuOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781026291; x=1812562291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4k6t228FHZ7KhhSUsNxJu4taxxiH+bnOTu+2qmwaEp4=;
  b=LCeisuOF2+84JomxtUf6jZiCGk2O+JoplbuMDrL0zfnR8H2khVqj4klr
   EZjk90iLNaSwtcZE9tDrl1hlq98PgxWISC6vo6ivw5Ft6vWBdaxuiIPsS
   7dTJZcOPtQAlqNiW9bDSedqhHZgANRAt30pYO/Q0KnC/A4uqC4PYKzHik
   9i5Up4l6h0Vx4tK68hfZBpq2FAR1MJOwREi/wlpZDlpxeaPcw85VkHfb3
   JzP8Q4wsaQsKW4/EYM4fr+1dPg8swua/FVfeQRqCegnKlb/uWWMrM9Jch
   g5zoaao18alZTNU9vHjYgT0Z7o7mRKoypoUbszl4TQ7RJmm/LlDlVusAt
   A==;
X-CSE-ConnectionGUID: nqLMCO3eQfG9hFvUtvb47Q==
X-CSE-MsgGUID: lVE68ku5Rz+aX582O8IY1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85688661"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85688661"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:31:31 -0700
X-CSE-ConnectionGUID: RhMb42uOQWemvna3h+UkYw==
X-CSE-MsgGUID: 6tJRuYsjTMK1R6DSnCgurw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="243459705"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:31:27 -0700
Date: Tue, 9 Jun 2026 20:31:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <aihN7O9noqEa5PlA@ashevche-desk.local>
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-5-salih.erim@amd.com>
 <aiUeVs_FoI9vV1Hd@ashevche-desk.local>
 <0f8f431f-af21-4bad-bff2-e6cde078bd41@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f8f431f-af21-4bad-bff2-e6cde078bd41@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 10:02:47PM +0100, Erim, Salih wrote:
> On 07/06/2026 08:31, Andy Shevchenko wrote:
> > On Sat, Jun 06, 2026 at 06:17:06AM +0100, Salih Erim wrote:

...

> > > +     ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
> > > +     if (ret)
> > > +             return ret;
> > 
> > Half of the IO accessors have no error checks, these do.
> > Why is this inconsistency?
> 
> The regmap calls in sysmon_unmask_worker and sysmon_iio_irq
> have no error checks because they run in contexts where errors
> cannot be propagated (workqueue, hardirq). The init path checks
> errors because it can return them to the caller. Will add a
> comment explaining this.

But the error checks may be used to modify flow inside the respective functions.

-- 
With Best Regards,
Andy Shevchenko


