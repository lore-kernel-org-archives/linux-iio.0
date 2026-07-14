Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4F12C534;
	Tue, 14 Jul 2026 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991087; cv=none; b=RI9fs7sNIhkO2HltvZLQEhQFITwr2QhQL+i8x3zbbuaCDZRn1UPk8Fh9f7LuH4qN2lHoKsFD3P9IC7HeVOes9Gp8SRvVBiCZEDSFypEUAZ14nSbhHUciTgS3Nt0zIsIcPdydwppGByGsJ7A4n70NVtgR3neqQsDC8hFT8tiWSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991087; c=relaxed/simple;
	bh=ghnA79c0myfQmm1tLT8G1Q7k9znQt4izz53sCHLn+p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAf/HfAFftNCmWNHyBtarRTZeJ8m79Kbuu0Wc5Pxm777I4BKN6eywRBRk4dH7UfAe+UTaQu/ndA2eOLkPD5V9fxMweld7Eb3aUyZzN2leqbZL9AnA0CaPpLSJuMgYm8JrQIAI+g4gVi0lxx7ODNfPp4AyWNffYnEupcDfK03clU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMdvXX+Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMdvXX+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991086; x=1815527086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghnA79c0myfQmm1tLT8G1Q7k9znQt4izz53sCHLn+p4=;
  b=dMdvXX+Yu7q9MU11XxJWAWGl93F1tBQqv+1XRa4nVgnsdpkKX3mmEetR
   FQ9VP6HCWm5hUDBk48HDbHZGF70RVnypnH8uyj2M5SA0YN7qpWbsWVz8b
   /3jXPMsQysrNBqOyI7CzjBh8qb/CSfDcQPWoitkav4it9EDxzTufTMsQC
   5ETMQVdn83O4RB5xKWOcOy/mVRtNQAA0YDCAF0ma1MEz+0LDvUGuqzBjg
   bj8/f+wzWg3PV6HNt1Dz+anWhvSDdKP9trHqsJSe/J9JGT+PcXXFDhodK
   0RpVVvbO4U2jdUhzLNH1cIcoZrAtY8WwNeftAZGxNGxT2SPA/EmBlv4pZ
   A==;
X-CSE-ConnectionGUID: jKSAghVcTviplz2Hs07luA==
X-CSE-MsgGUID: GkJMRTblTsG1J5aPC/8zGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84701794"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84701794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:04:45 -0700
X-CSE-ConnectionGUID: JBWFPNJRTj2IGgrbVri1Gg==
X-CSE-MsgGUID: AQadaKAeS7mdjt78kRDGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252317728"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:04:41 -0700
Date: Tue, 14 Jul 2026 04:04:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <alWLJ8j-a7CtTbU3@ashevche-desk.local>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-8-746d52cbf1d0@baylibre.com>
 <alI-a6nkGvXp6sDo@ashevche-desk.local>
 <f8bb35a6-a898-497a-96eb-7a76a1fba16c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8bb35a6-a898-497a-96eb-7a76a1fba16c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 02:40:27PM -0500, David Lechner wrote:
> On 7/11/26 8:00 AM, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2026 at 05:50:41PM -0500, David Lechner (TI) wrote:

...

> >> +struct ads112c14_measurement {
> >> +	const char *label;
> >> +	u32 vref_source;
> >> +	u8 iunit;
> >> +	u8 idac1_mag;
> >> +	u8 idac2_mag;
> >> +	u8 idac1_mux;
> >> +	u8 idac2_mux;
> > 
> > I would group this slightly differently:
> > 
> > 	u8 idac1_mag;
> > 	u8 idac2_mag;
> > 	u8 idac1_mux;
> > 	u8 idac2_mux;
> > 	u8 iunit;
> > 
> > I haven't seen the code, but names suggest that most likely one would read
> > *[12] together or close enough, and less probably mixed with 'iunit' reads.
> > Current layout might lead to interesting code generation complications on
> > the unaligned-intolerable architectures.
> 
> iunit is scaling factor for *_mag, so logically gets grouped with
> those. (These are all datasheet register field names.)

Then it can be

	u8 idac1_mux;
	u8 idac2_mux;
	u8 idac1_mag;
	u8 idac2_mag;
	u8 iunit;


> >> +	u8 iadc_count;
> >> +	u8 gain_val;
> >> +	u8 burnout;
> >> +	bool global_chop;
> >> +	bool bipolar;
> > 
> >> +	s64 scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
> > 
> > Also this can be moved upper, but I think it won't save any bytes in this
> > layout.
> > 
> >> +};

-- 
With Best Regards,
Andy Shevchenko


