Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39B3F6C56;
	Wed, 10 Jun 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099426; cv=none; b=rKBLOoaR6V9zUJOEk7CjjjnROfqOsNoOSi09zyCdSSCbZB+suCG2X9HR23svThAyXQnnXuvEUq5SybbbA7evVW2cIUI/uvFrHYP+HsHovRjFPD5PKMn83Ab4dm1DNw7If6aq+7eY6ybhZl9qttoMPZUif+fHZv0QzsKJY81WGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099426; c=relaxed/simple;
	bh=YfOsFpE9E+ipgsJSCYYvh/HSKr18FxABdqARWwySwkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4K8TO8CD06LAnGJh68vtnH9F8JyDS1K+gKH1Y5N0q6+1dzIhWmnWKHhSXa3W9IZcU4HtqeoAjbb6xn3SloVvjVmzJUthpTHYaph12sxEtmJ+GAbr58XBFdqWx0niE+uoVG7aHIUFCZrpuuSTy19n9WvuI2n/0WuG4CeFgZgDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giAdZy/Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giAdZy/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781099425; x=1812635425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YfOsFpE9E+ipgsJSCYYvh/HSKr18FxABdqARWwySwkQ=;
  b=giAdZy/YVBvE9vJnuhG0+fLQ9l36zczxe5QbIq6kY3a7sLhjmOXP7Jb3
   H4xT7HwlPY5PGLGRkzNm3UQQp7nVPJHanCOmY0TAp+3otITHuNOdUpKGD
   YwuCpchMd83sptFqHgHxpN+2J4MLCxevqXEX57nrm4iDUH7pL3zD4Md8m
   F2IkZMIV0IrMmcqmfmaT1OzmqqADHgGvshViRg++rzyDXM+ZTQopCe52b
   SbBWJivWX0L6YLQDRSgDD21T1DRJ2Lj3AWeLsmn7JY8ei8aa1+RcItOvT
   g9nVLPWW42d6KdXYxX+uX8R1ZuyGzUfuJ0VKtPOGpnYpXhvCfYVRdlcTp
   g==;
X-CSE-ConnectionGUID: XmVi74uCSveZ9nGEwtpYMg==
X-CSE-MsgGUID: mIjfILV7QtG/nZAoPNf2FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84462237"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84462237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:50:24 -0700
X-CSE-ConnectionGUID: DbaCraTaR5K94vdrh6AaNg==
X-CSE-MsgGUID: IH3fSS2uSKyVac0Bv13ODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242044347"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:50:20 -0700
Date: Wed, 10 Jun 2026 16:50:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <ailrmin5zEZE0H6m@ashevche-desk.local>
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-5-salih.erim@amd.com>
 <aihTVQIedgsFKeM7@ashevche-desk.local>
 <6378c39f-f368-4fd6-a51d-6fe057fd38c0@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6378c39f-f368-4fd6-a51d-6fe057fd38c0@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 01:10:05PM +0100, Erim, Salih wrote:
> On 09/06/2026 18:54, Andy Shevchenko wrote:
> > On Mon, Jun 08, 2026 at 07:38:00PM +0100, Salih Erim wrote:

...

> > > +     /*
> > > +      * regmap errors are not checked here because the worker and IRQ
> > > +      * handler cannot propagate errors. The MMIO regmap uses fast_io
> > > +      * with direct readl/writel which cannot fail.
> > 
> > OK (but they can fail on HW level to the point of bus errors or so :).
> 
> Accepted. Will add error checks to modify flow on failure
> instead of just documenting why they're absent.

> > > +      */

I put smiley in the reply as I don't think it's practical. MMIO failing on HW
level is sign of something much bigger (usually) than just a random neutrino.

So, it's up to you, if you want to add error handling and skip, for example,
write-back of ISR.

-- 
With Best Regards,
Andy Shevchenko


