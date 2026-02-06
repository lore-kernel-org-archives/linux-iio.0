Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F763EDAAD;
	Fri,  6 Feb 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386268; cv=none; b=T4wIbq5Fpjf31OGclr24DefzNwATjZ3FYq2hI8AXYo1/ApHb6WIkuBdgNnv93aHGzQGIFsgDIYMiGrqPkyFOsWa+FtUu6N4HB/kryZU+vNypyVhij3A7BxF2BS4U07nUMpUGoVbVkzzwiicdJAAYJxdYGRXGOer1BS9za5dKEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386268; c=relaxed/simple;
	bh=vbLvarM6BGMLc0q1X/Be2uWKyobRHYvb8F4yHu6gjuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgGA7s1MwS6miZLvpi0LY3woT++u/sfnxXWSWPLXSPC2zT2E+6P34EqCwUcNl1HJaAdThND2jarsPML1MwrPP8Fku+SGf5ICwbX3q8o3g8RZGheGO2WhEMc5qpwhyveTkymrKll27oaCkSuzRVY729Pg4bPqcH8WO3U+QVIiYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQqADK1b; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQqADK1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770386267; x=1801922267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vbLvarM6BGMLc0q1X/Be2uWKyobRHYvb8F4yHu6gjuQ=;
  b=WQqADK1bc+nWWQoH05X2vzhedZVYc7XnphlTWdySLUbh7H4O3e8etjfR
   TRaaxe4mmf7v/fuPnaqKqQXCFV84mHDYq1MC4cnXnu0FjApLILbIjwdU7
   fx/MTKGi3WtrFdx2V2BYRBceiDOF3NES0O7ZHcwMNwiwNbRh9OIj/ds5o
   b6HkhhDkZ3KBdDzJxgomnQESlJ4jly6Hoqqqv9tkyRHMFbFzHCl+Jks1Y
   65Q6EW1WY8UQBQ2iJM8GSpJRZfaoIz/atPnFWLwgDdNQY/MOV/UFbyIAq
   IZJThTQ/qvT1mq4VVc0xE3VAJ1Mc7gKFZVGBUpPnOmireDW3dyMBJ10Hq
   g==;
X-CSE-ConnectionGUID: BJ3rqRdfS6ezsLCiVWgqdw==
X-CSE-MsgGUID: eGw6mm/cQVKFn5d/lTYyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75446438"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75446438"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:57:47 -0800
X-CSE-ConnectionGUID: tLUE9q1YQLao5D1qg2zUzQ==
X-CSE-MsgGUID: vxusJMgHTM6Epo0GGebWRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210922315"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:57:44 -0800
Date: Fri, 6 Feb 2026 15:57:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad4080: add support for AD4082
Message-ID: <aYXzVc2FfWnuWpGs@smile.fi.intel.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
 <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
 <aYXy-B-b9CpUKZ7C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXy-B-b9CpUKZ7C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 03:56:13PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 06, 2026 at 03:08:21PM +0200, Antoniu Miclaus wrote:
> > Add support for AD4082 20-bit SAR ADC. The AD4082 has the same
> > resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
> > maximum (8 vs 7).
> 
> > Changes:
> > - Add AD4082_CHIP_ID definition (0x0052)
> > - Create ad4082_channel with 20-bit resolution and 32-bit storage
> > - Add ad4082_chip_info with lvds_cnv_clk_cnt_max = 8
> > - Register AD4082 in device ID and OF match tables
> 
> TBH, I think this section is too much for the commit message...
> 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> 
> ...and just as good to be placed here.
> 
> Otherwise, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Same comments for the patches 4 & 6. With that being addressed,
feel free to add my Rb there as well.

-- 
With Best Regards,
Andy Shevchenko


