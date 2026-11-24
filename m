Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515251;
	b=HNPQU6gL8zZImLMcvbbYPEqriQNTWG/pV/hrL9401h7YdMvcQq/BrMfcXhkrm7SdUqlQ
	 CR19n4OXHgj27A7AEUUVFPoiYZFu9yWXcXCz78hA/sxXtpgbjX1l6GoYMIllb/2oXi0Sz
	 XI6Hi/wdn5xgUi07kEQ8hgt/KH2U5HnI2iGb+EhGYC6kS4XdtX8wFzB4N5eR7Lo5RJCJw
	 62PEfByRaJuld+yVTM1R9ULi20VrMhi1RxAJQ4EBI3y+Kp/TVUSknGW/utls5Q9c7vJdG
	 Oa8Wnd/iIgJGt++5qbYFO2uIoop4MTEs+1r7K6OQ4Y0vD+1Yv1AwdwTMjxoMauy9ZyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5n9UHdO2SBef0HNJ35aNuZvDO6VdtplwD/Dp/Y5vP2E=;
	b=48/UJspwBB1X2h98b8t5Pna7BnRr/EGR3hyP78mHxdFZR358x936P0yUullGD9Yo/2it
	 s2qFXbDvuZw+2L9MI+y+nt0jUgWE/35A28f+E7uR6drLdK4fQkAybgeoTwcCDVmd4NDzr
	 TyFvdgykN28xf/v6zS1/ZCD472LI+DsUDu6AZ4sbrqgXP05fI+NDxle2kGoBrIcER/MiP
	 Fi1mav6G76sFp3CiqenbLGbML+fCZrDXtC91QXRPMBW1L6a6PenoBqq/fdyc/XRFQIWAX
	 YRdybjTqnn8rjjhtBJxBo3r5yMqIXRCjvkdedufcqC/jeqIOWUFk+x9hXguCaUToJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GyGIJZVv;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E6606A692;
	Tue, 24 Nov 2026 10:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 838E6606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GyGIJZVv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795515249; x=1827051249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jkm3ngcj7xdNHx9OZUIZL2NkQ34Ja9eEvX69Wq2VKE=;
  b=GyGIJZVvSPKsxX3k67u9KKWtacrscC0DSMVCMpBXqR/PG06iLmslnF7M
   RxBQCPGKjzrKKC82ptwFJKBc5tOJLwihCurHAyclqQAMWdsa4G80gEBSP
   2XYByz2y2FoM5HGJkvD0n/sac5p1dLyXyIUY7qza9BvkBe5YyjrYp1cEC
   SLTRMkg6PgKg5BMAruK6j6JDSR0YJYWOGXlnQ6ZKi3MTiTxTWfjihybm5
   vSyNjGU6JVJ+i0wHxiP9oJsgYMxdcR7WjQa9vUcT2gJyAn1XqLEoTsd8e
   21eY5zHfDY9PmUNIPjBbyJiff9TOr0NRus6LpePRi7FvCfWXjQgcZ/rGk
   A==;
X-CSE-ConnectionGUID: oBmOH4m9QAmv+GS+v6si7w==
X-CSE-MsgGUID: /uDf02+hRAq6UL38/1sfKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4434027"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4434027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:47:42 -0800
X-CSE-ConnectionGUID: v0qbLzzJQmSYhG8etaXX/A==
X-CSE-MsgGUID: p3qLvHCDSym8v1JYijC2sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11621467"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:47:39 -0800
Date: Tue, 24 Nov 2026 11:47:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v7 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <awVdOHLZJqnY2NIB@ashevche-desk.local>
References: <20261123-topic-sm8x50-iio-max34417-adc-v7-0-d8f87edc5086@linaro.org>
 <20261123-topic-sm8x50-iio-max34417-adc-v7-3-d8f87edc5086@linaro.org>
 <awSWVMMYN2xsDH7u@ashevche-desk.local>
 <3f0bf2dc-02c4-45e8-ae06-feb669b6b234@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0bf2dc-02c4-45e8-ae06-feb669b6b234@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:30:52AM +0100, Neil Armstrong wrote:
> On 11/23/26 20:39, Andy Shevchenko wrote:
> > On Mon, Nov 23, 2026 at 06:47:46PM +0100, Neil Armstrong wrote:

...

> > > +#define MAX34417_MIN_RSENSE_UOHM		(1 * MILLI)
> > > +#define MAX34417_MAX_RSENSE_UOHM		(100 * MILLI)
> > > +#define MAX34417_DEFAULT_RSENSE_UOHM		(1 * MILLI)
> > 
> > Oh, it's micro, but you use MILLI. Also even in macros we nowadays want to see
> > the unit as defined in SI.
> > 
> > #define MAX34417_MIN_RSENSE_uOhm		(1 * (MICRO / MILLI))
> > #define MAX34417_MAX_RSENSE_uOhm		(100 * (MICRO / MILLI))
> > #define MAX34417_DEFAULT_RSENSE_uOhm		(1 * (MICRO / MILLI))
> > 
> > Alternatively add another patch to start Ohm multipliers in units.h
> > 
> > #define MICROOHM_PER_MILLIOHM		1000
> > 
> > I will Ack it.
> 
> Hmm, I want to express the min/max/default rsense in uOhm, minimum is 1000 uOhm,
> max is 100000 uOhm, so initially they were:
> #define MAX34417_MIN_RSENSE	(1000)
> #define MAX34417_MAX_RSENSE	(100000)
> 
> and the unit is uOhm, so how should I define them ?
> 
> with #define MICROOHM_PER_MILLIOHM		1000
> 
> #define MAX34417_MIN_RSENSE_uOhm	(1 * MICROOHM_PER_MILLIOHM)
> #define MAX34417_MAX_RSENSE_uOhm	(100 * MICROOHM_PER_MILLIOHM)
> 
> ?

Yes, precisely!

-- 
With Best Regards,
Andy Shevchenko


