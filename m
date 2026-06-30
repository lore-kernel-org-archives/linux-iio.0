Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F340B37A;
	Tue, 30 Jun 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822380; cv=none; b=IKpGWZ0MSqhll7Cwq8VtDk2DaVsxRKEriECvOIrUOZs9V+r2FBXNlAuQMVZCsPcTZ6mVCKAEfTLpPMgpWORdQOQGd6vMQwPpkpQlR2vTSjxb5lfs2GW21Y++OyjtPiSbpbe5yjVN5HFWCgI8m26BHsWtyaXoRp65KAFNrsxQA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822380; c=relaxed/simple;
	bh=jqluEbBWVcccGX43p7xRM26vmTqwW1h8FiHvNmMF8Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko/MmuvVkdstJ+rWF8D5w8mpRl5nu7+G6XjA4z05Gk05zjPfBAI+H5Vh7gayI661XjrL22LUcjdFPRn1kHXHkiocZjMKrDnCgWwIjkCufIk4vGuRadmzT9DEc3WBJq9dM3ZpgmfHusLAPWp3HoAjqvhweD3VQAb2pm079DdauZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koXfddh+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koXfddh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782822379; x=1814358379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqluEbBWVcccGX43p7xRM26vmTqwW1h8FiHvNmMF8Sg=;
  b=koXfddh+0MAu0w+MebtAM6RqridYPXx8EHyNRabdOjAGnz+NDw6SW1mf
   W4vB10rjfo98QnubKmd16fTO682crKAh7PoHGYGL+bKOXi8EgQvT3qVIG
   TEGHXyZ/rE7w9nUkVNmtWjr0109A2cURbvPX6RBSlZGdttvHYybDei8Qx
   kuZA2hws4oq/6uqnnjeXsHZVqpq2Z7tFtxSKNN3GIKBt+weKakTbr09lp
   OmyzQJ7VrpPN/5UPF1NCA+mYSxCfo++Lh8bwS8sfmUX88bX+NpHRimbww
   qNbF9/oe992bQAeGiqlBapycc0qokeem4K3DIC6hc58CR15CofvXQrH2b
   A==;
X-CSE-ConnectionGUID: wsNWysZzTAC04lc6THp2tA==
X-CSE-MsgGUID: 0lcbaytBS0+jLq6dNQtgkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94683733"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94683733"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:26:18 -0700
X-CSE-ConnectionGUID: RZhHf/tvR2eGBy5+X7UfMg==
X-CSE-MsgGUID: K6xQASOmQfqt9WB8oVIRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="254161440"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:26:13 -0700
Date: Tue, 30 Jun 2026 15:26:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, jorge.marques@analog.com,
	mazziesaccount@gmail.com, Jonathan.Santos@analog.com,
	jishnu.prakash@oss.qualcomm.com, antoniu.miclaus@analog.com,
	duje@dujemihanovic.xyz, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] nvmem: microchip-otpc: add tag-based packet
 lookup
Message-ID: <akO146b0WGkdPFpb@ashevche-desk.local>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-7-varshini.rajendran@microchip.com>
 <akO1Rgf4tibxbhfk@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akO1Rgf4tibxbhfk@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:23:42PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 30, 2026 at 03:05:56PM +0530, Varshini Rajendran wrote:
> > Add support for accessing OTP packets by their 4-byte ASCII tag while

Forgot to mention that widely the term is FourCC (that may or may not be
represented in ASCII) is used. But I don't know if documentation on these
chips uses "4-byte ASCII tag" everywhere. So, just for you to know.
And it's up to you if you want to use the common term instead.

https://en.wikipedia.org/wiki/FourCC

> > preserving backward compatibility with the existing ID-based lookup.
> > 
> > The OTP memory layout can vary across devices and may change over time,
> > making the packet ID approach unreliable when the memory map is not
> > known in advance. The packet tag provides a reliable way to identify
> > and access packets without prior knowledge of the OTP memory layout.
> > 
> > Two offset encoding are now supported:
> >   1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
> >      Used in DT as: reg = <OTP_PKT(1) 76>;
> >   2. TAG-based: offset = 4-byte ASCII packet tag
> >      Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> > 
> > The driver resolves offsets matching valid legacy selectors (multiples
> > of 4 within the packet count) through ID lookup, falling back to tag
> > lookup for other values. This ensures existing device trees continue
> > to work while enabling new tag-based access.
> > 
> > During probe, packet meta data including the tag is read and cached.
> > The driver also validates OTP memory accessibility and emulation mode
> > status. When the boot packet is not configured, emulation mode allows
> > access to the other packets. When both are not available an
> > informational message is logged.
> > 
> > The stride of the nvmem memory is set to 1 in order to support tag based
> > offsets, comment in the header file is updated accordingly.

-- 
With Best Regards,
Andy Shevchenko


