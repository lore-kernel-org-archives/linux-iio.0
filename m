Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC5199E89;
	Fri, 18 Sep 2026 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713744; cv=none; b=SZLPSGNNdoydsmajaUB/j6J1L3IFPfSUKZX3Y9Kh3/vxKQ3r3wnAJsVxi5RGggPjoigdDewPTnh4I4ptQpjXswlFAOGXXspDw8embvj7j7Hz28y+bSGnDWgt/2NgrJEmpifJ1jAhe2jvjFGbEZVV3OfcnkU4S9lW56E9LS++7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713744; c=relaxed/simple;
	bh=Q8qkLWFRIEs3LhO9JJsC9itRXPMawbI1tnHmSNR1qjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIm9jKkWTcUhZxGHxDqWO8mM7bEILxaG99+SkOAdiFEBo7pZ5jyms3H7L1iPFRvtu3esXSFaHXETJEhfzEaIE8mCRRuYdsBbhYCyE/TaoELFx9sJfjMFIAo11ZbAvaQ0AIYxzmp/2x4nLXmAb8Y7v12FehvM3PkZWZwwAV2d3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpGqt8CX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpGqt8CX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789713742; x=1821249742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8qkLWFRIEs3LhO9JJsC9itRXPMawbI1tnHmSNR1qjU=;
  b=FpGqt8CXtWKlt0YDM6BsZnxMl9dsdxlHtg2RdYqJFkK6oA7O6ZO/xjUS
   Oef3zJoIARQFFNA+sRMDh6HP4GVzQBibkjQASg+ao9G8OiYS3F2AE0UwY
   VjJLovinEd0uD2GpLnbK2xpsmg6lLWCulVIp2rWkJoDFgYipyZoq1ZzUX
   jPikc2pcmrhUf/PSSLmPqbp3JU2Dmv+ZyjsjlVwKATh1uUPOAVv/eT8X9
   GA+YaIZJyc7sT4E5OJ/I3bzXjP0akVUxlKs0KEBUaL4jBSBBF2rEf79hM
   LzeNN83EPDlrmhi9b7dq9j0VDxw0Jnl3tGVf0b8JWGY/WS2mZswOb+ccz
   g==;
X-CSE-ConnectionGUID: tv7826B0RJeWCPOA+fh9Dw==
X-CSE-MsgGUID: tKJYMWJvQL+oaqmklPGWQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90217380"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90217380"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:42:21 -0700
X-CSE-ConnectionGUID: XqPyq6tVQjmBYMsrb8i6uA==
X-CSE-MsgGUID: WKZRfvWWQ0ScMHejZX/UkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2433853"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:42:18 -0700
Date: Fri, 18 Sep 2026 09:42:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, mfd@lists.linux.dev,
	Roman Vivchar <rva333@protonmail.com>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <aqzdQ64Y_mkEdLZU@ashevche-desk.local>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
 <aqpmgliQW7FW53o5@ashevche-desk.local>
 <2d1b80f2-53f6-4ed6-81bf-e35c0a9efb26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1b80f2-53f6-4ed6-81bf-e35c0a9efb26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 03:24:05PM -0500, Ryan Brue wrote:
> On 9/16/26 4:50 AM, Andy Shevchenko wrote:
> > On Tue, Sep 15, 2026 at 11:15:25PM -0500, Ryan Brue wrote:
> > > The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> > > reach. On boards built around it that ADC is the only path to the battery:
> > > the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> > > boards use have no ADC at all, so without it there is no pack voltage and
> > > no state of charge.
> > This doesn't explain why a brand new driver? Perhaps we have existing code that
> > may be updated to support this device?
> I considered adding mt6397 support to either mt6323-auxadc or mt6359-auxadc,
> and both had problems.
> 
> Both mt6323-auxadc and mt6359-auxadc select channels through a request
> register (1 bit per channel), while mt6397 uses a 4-bit numeric field CHSEL
> in CON1 (10:7), and then pulses a START bit (CON1 bit 0). That was the
> biggest reason I made the new driver.
> 
> For mt6323-auxadc, which is the closest I could find to the mt6397
> (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14). It
> uses CON22 for its request register, and reads the result value from the
> same register as the ready bit. We don't do that - the mt6397 has a factory
> calibrated value for each channel at 0x16 higher than the raw value. mt6323
> also has a 1800 mV / 15 bit scale / resolution while we have 1200 mV / 10
> bits. We also have some per-channel preparation that we have to do before
> the burst, that the mt6323 doesn't have to do.
> 
> For mt6359-auxadc, it has a more generic framework for describing the
> AUXADC, but it assumes requests are channel-per-bit, and so we would have to
> basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.

> We also have our own software sampling, which the vendor does too (Amazon
> Fire OS based on Linux 3.18). We'd have to have our own sampling callback to
> do it.

If it's not an upstream, we do not care.

> I drafted two other versions of these patches adding mt6397 support to both
> of those drivers, but the differences meant I had to add a lot of extra
> boilerplate to each driver and to me it didn't make sense.
> 
> In v2 I will add the justification to the cover letter and commits for why I
> chose a new driver.

Yes, please. Always do that when submitting a brand new driver that might sound
like a (partially) compatible with something already existing.

> If you'd like me to instead send the exploratory patches I made adapting
> mt6323-auxadc or mt6359-auxadc, let me know. I'm fine if it ends up seeming
> like we should adapt one of the existing drivers, but I think the mechanism
> for controlling this AUXADC is unique and merits its own driver.
> 
> Thanks again for the review, I am going through each one, and sorry for the
> delay. I'm rather new to kernel development.

No problem, and welcome!

-- 
With Best Regards,
Andy Shevchenko


