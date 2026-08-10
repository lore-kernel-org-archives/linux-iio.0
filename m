Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D94353A60;
	Mon, 10 Aug 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347165; cv=none; b=mMcwC0NOUmQqJEOdY+2OksRjxmP5m5RS0yqBl6Y9hDCESGwutS1aMVBHutLkYVvh+oICVdkeGxL1/+GFHdKvOSgYoEH5Cq5JpPPW8mOn/+6hwPju5M0EZCGA46pgzAdRR0AxqH6s1+GAuGN7m5GKCIo53l4muzDahX3Paxp3oNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347165; c=relaxed/simple;
	bh=3TGFlPgAJB1XJ2S22zKpSve6oasatRD0oXn0iV6g3Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkyLavtcCIAyP3YPBsZW9M2XyF7eUF3GmYcZgjJf2fVmSU1tYXu34gHbrGCY24e5xVKKO33/J4nkFUHbVGEggs+Fs4qW1AH0HxEi0BdBFbvFoafRT+ms2A1udXzc1PCur1leJ80rblzNuT9/PC1fGQhhHrEO24JwjFyVqUjWhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFbrS3hG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFbrS3hG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786347164; x=1817883164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3TGFlPgAJB1XJ2S22zKpSve6oasatRD0oXn0iV6g3Io=;
  b=KFbrS3hGZEb7J0fhW/lzpE8yaWfdWiFDob4u1bIzAByMgtvx07jHFsTl
   Zj+iwJvj7t3lCgZOtwU6UsNKqOrWrSZO1oDN4mwJxmKxOz0XlNAq+3uSa
   knk3VNxieSJHcgPLxrnrOTm1D62QMOCnyx7zrW0AsNbvLJOlu1tO9Kogi
   YC8TTYAQ8x/w0PbI2/5M+f16gHzCCNmCrAKfFRG6Oks/6f3XloBiAVM1Y
   Ur3m5Z/Lg7TOH4auLn59EIoD2zS3zQUz/WFqMAewwAvXF/Q8Oc1Y2B2Ta
   3H35ylTm00rvC5OwsSdNuurMU+OqJFVsMD1zle2lzRsfK7yyGMzLD4Znu
   A==;
X-CSE-ConnectionGUID: LonsxN+ySmSdZNZHJogV7Q==
X-CSE-MsgGUID: 4GtsimJJQ2arSJHVst/6aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90738858"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="90738858"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:32:08 -0700
X-CSE-ConnectionGUID: qBB2uY2ORJCTa/sU/SP/CQ==
X-CSE-MsgGUID: 3y0qq3kGR1OUDo6Spn0cwg==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:32:03 -0700
Date: Mon, 10 Aug 2026 10:32:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <anl-cYX-wUQr_Pvb@ashevche-desk.local>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
 <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
 <alnpMFK6_ZkdWlLi@ashevche-desk.local>
 <de947dc3-6d02-43de-a9e5-7f1e950231b9@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de947dc3-6d02-43de-a9e5-7f1e950231b9@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 28, 2026 at 08:58:10AM +0200, Petar Stepanovic wrote:
> On 7/17/2026 10:34 AM, Andy Shevchenko wrote:

...

> >> +static const struct regmap_config axiado_saradc_regmap_config = {
> >> +     .reg_bits = 32,
> >> +     .val_bits = 32,
> >> +     .reg_stride = 4,
> >> +     .max_register = AX_SARADC_DOUT_REG,
> > No cache?
> 
> No cache is intentional. The registers represent transient control, status,
> and conversion data, so accesses should always go directly to the hardware.
> Since REGCACHE_NONE is the default, it is not specified explicitly.

Perhaps add a short comment here to summarise the above?

-- 
With Best Regards,
Andy Shevchenko


