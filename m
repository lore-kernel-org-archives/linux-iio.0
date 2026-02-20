Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE2275B03;
	Fri, 20 Feb 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595923; cv=none; b=a3PJ9oycr+DC4XUBHLb8rbBa0i3GZqd/JFX2KvyrsiDfRn1x1OPtf8bwUtKa3PePGuSbo9c8J1mWKobRmWJoXXGD6KSumWuZoIQzcKGETTaQpatnoczOw5fEeCe/eYlrgDlMxgO63pvJFHcNuXLC2GbW3rt0tG5poxgW8Qq91JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595923; c=relaxed/simple;
	bh=jk/VuiGzDbaajKfZ+uYrPNojehmUmxAUmrEuO6teO/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF9o92oRL78KtYXg+dUCyv3B4ZkzR2WNwoyeWf4M5pVDJxRHq2QT1pjD3klZNS8LTXg92FmZuKKy5ZSiq30Sn2qoMefF0GNuQ1W9UDRnya6JWKDTNj8BBXtTJ1l2D8jvUuSSe7uvyA0syn+t5psPjQE2lF/Espwv6X6FkPk1SMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh8k6DI/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh8k6DI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771595922; x=1803131922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jk/VuiGzDbaajKfZ+uYrPNojehmUmxAUmrEuO6teO/4=;
  b=Rh8k6DI/UCpnF0S9J1FQEbJ6wWaw9UoMsy7uDJSbTHcymwFz8U7hIEMj
   tyzwYVQS9x3icT9102qE8Nmr+BexLKC0Yzj0h7DUnFP5BJWzy2csH6f+k
   ew7m0pZ9DzMt8JeWbXPxvH/avKfIj5POmD/IM6OXr81jlZ6Ox2ixqntd6
   NBpV8iqGV5MnuFkIThWlPtCVcb1+aXE47UziVV9Hjl1naV8FrceC1Ag8L
   eDNiB/EaZuBPV59NMvbaURzKtfBVWoRk2nEqjk3gIr1lNmrNo1GbcEosr
   rkKKOU4S4qBPbEOctJC16boYnnzWQfkpyDnAvOEoXGoaRRDl1fopzFmm2
   A==;
X-CSE-ConnectionGUID: dLLlkkWkQASwl4JPn230GA==
X-CSE-MsgGUID: v7mjd4DjSSGzTcibIuW7qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72730179"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72730179"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:58:41 -0800
X-CSE-ConnectionGUID: wdO8NBleTOuIdtGRjm598A==
X-CSE-MsgGUID: IjJH6xSGSKOzQBarwlCNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="218990585"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:58:39 -0800
Date: Fri, 20 Feb 2026 15:58:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe
 path
Message-ID: <aZhojCK9R_iPFcLi@smile.fi.intel.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
 <20260220131151.74329-2-antoniu.miclaus@analog.com>
 <aZhoJlYUzuHXSGXL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhoJlYUzuHXSGXL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:56:58PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 03:11:39PM +0200, Antoniu Miclaus wrote:

...

> >  	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> >  					 ADRF6780_SOFT_RESET_MSK,
> >  					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> > -	if (ret) {
> > -		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret,
> > +				     "ADRF6780 SPI software reset failed.\n");
> 
> Consider adding
> 
> 	struct device *dev = &spi->dev;
> 
> at the top, so this line becomes
> 
> 		return dev_err_probe(dev, ret, "ADRF6780 SPI software reset failed.\n");
> 
> (while at it, I would dare to drop 'SPI' from the message as is easy to derive that
>  the device in question is connected to SPI bus.)
> 
> 		return dev_err_probe(dev, ret, "ADRF6780 software reset failed.\n");

...

> Ditto for the rest.

And also for the entire series (except patch 5 where it seems already
the case).

-- 
With Best Regards,
Andy Shevchenko


