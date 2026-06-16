Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B723451AF;
	Tue, 16 Jun 2026 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595960; cv=none; b=S2HkC8tMJghUHBQaixS7F3emqPRGq/+kk+zz6ATHG8U2yo1H9/wG9vUJF0rWsh2MQiUuUO2b4g+UsB65k4uJKqqmmWhXXOomsxcUZp2F1pnKqh0pGX9NcsEtXlscpzcvsDLkMXGwx2zjXdfwrGTg43itL5UsCllMNM97I7hSbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595960; c=relaxed/simple;
	bh=cSpIO01dwoZkOcphBMbOJEH9iYkzihUlHXoiNLKwxTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqclTWJjKD/gVEGxqDJn7L9fdGg1AnHVfMEhA1iouGlSNZaYFv7MhHbKXVV06c11T1VdvqSY7jJMwEWS5d88qzcaCp5jtwFPODDik+oVC+34N3hYxRgpIqIx94EtK286xKHbbm96WjK0h4xYakpdotdCffvqVKiyz8ZEd3ISldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/G4UuI6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/G4UuI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595959; x=1813131959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cSpIO01dwoZkOcphBMbOJEH9iYkzihUlHXoiNLKwxTg=;
  b=C/G4UuI6khxpXOmPwvAHzNMw1PUY0Uk0aXgVAPguTDzNm8wN6NkI/hG5
   gGt6fJ1uEWJyAhUIcP5d6KiLZ+CtRbWkQyU+0O4P4g2ScYN0nhR3brt4T
   fsMIZzci/2bVJt6XqcXyGp/8r6/xKj7kGhNCSkB7Bjw0ObioGdqtvphQU
   2daUuIwvi9KNgtEwYTtdD+mC39995woIQ5Q4KpHUnZ07aTFkN6p6IlVmU
   YlgGdW3ecTcwnNY/kBgF68ZGGfhVzfEdnHAuvHj5NHcDiGCo4M6S8MC1m
   1RNiP5dBx4MS5t4liSPYPjRviigMIas7LnBzYQj1AfGTPlrdyZsFgEAqK
   w==;
X-CSE-ConnectionGUID: /udz+58CSc2tAJpVGj855A==
X-CSE-MsgGUID: XJgIoPV0THW+1a6RjkFMtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85987333"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="85987333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:45:58 -0700
X-CSE-ConnectionGUID: u0CiTTV8SWuIj7qysjQgew==
X-CSE-MsgGUID: 2d95d2CQRga/nNVNIRnjGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252001072"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:45:55 -0700
Date: Tue, 16 Jun 2026 10:45:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <ajD_MMpiVQIwtbV3@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-4-salih.erim@amd.com>
 <ajAMjZzfTqplts_B@ashevche-desk.local>
 <15d14eee-8384-4605-ad83-5aad774541ac@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d14eee-8384-4605-ad83-5aad774541ac@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:42:43PM +0100, Erim, Salih wrote:
> On 15/06/2026 15:30, Andy Shevchenko wrote:
> > On Mon, Jun 15, 2026 at 12:37:20AM +0100, Salih Erim wrote:

...

> > > +static const struct regmap_config sysmon_i2c_regmap_config = {
> > > +     .reg_bits = 32,
> > > +     .val_bits = 32,
> > > +     .reg_stride = SYSMON_REG_STRIDE,
> > > +     .max_register = SYSMON_MAX_REG,
> > > +     .reg_read = sysmon_i2c_reg_read,
> > > +     .reg_write = sysmon_i2c_reg_write,
> > > +};
> > 
> > No cache?
> 
> No, the registers are live ADC readings and interrupt status.
> Caching would return stale voltage and temperature data.

So, basically what you are saying is this:
  "All registers are volatile in this HW."
Or alternatively:
  "Almost all registers are volatile in this HW. The rest is not being accessed
   too often to cache."

Choose the one that fits and add on top of this regmap_config initialiser.

-- 
With Best Regards,
Andy Shevchenko


