Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751949E14F;
	Fri, 11 Sep 2026 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105724; cv=none; b=FjR68LJ5anML0mh2MJaeH298oSEdtspNeGUpNom9QzYTfNCeI5TyYCbj7wxzAON+nn4wGzFr+TYRs5ZZpA+78v4NO6R351uIHjMM3iNMoGAJfwdb0K75IqUYbxuG4vJ8j7LiMwNvRGp06kmzrc6kZ5dp8BIdMsKt6pIMeT4DB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105724; c=relaxed/simple;
	bh=jcMOyec8Bz6tWsyLWroUzHbUPOg0GXNA/06fZb8KQpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5ScUbNTsJX8HeVA2f29uO1h4kQkKdxE6FTL4t+Rnh5AMsA0NCloQ+fLfup7oKdkb0eifi71JHM9jjZY9Yn23aR0iDZOmc+aUvEedsK3hgHCO9KR4MRjCET014yHESQbe5naHgB7pLtY4rHj4fHGU5jzoS1gcQGB1snAfFK/3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8wHSF1F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8wHSF1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789105722; x=1820641722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcMOyec8Bz6tWsyLWroUzHbUPOg0GXNA/06fZb8KQpI=;
  b=k8wHSF1FY8CdXhEXW90oKZ/RotEJYvbo8xiIRAPreNuUyP2LfCfNeka8
   lwBeEV6c+WALzS3IjsL2YPX5DGg/PaQt7DJipjHvC2Bdf0UlsEOxdh5zo
   qGXFDJv6xRSJ2HAvTyGHk4YRG/7NOFIMRWGxWWNwcHqcvOsmMCU06tQkY
   09kIMhhxK9IV+TxEGNHkP1FdS+X4lThI2f6GmtH3Ra1l+RCMAqKR2WZRD
   2PE3xJL7SSaIJROPRxDaNXOlGQvlZ/N92UIDytHpmkLWvYOzyfF3tuGVB
   MNmcLqoV5TKdmtc0MOJixIL3eugqnYXmxBpZ+yYvMsfdwAqnVavhNbaWT
   Q==;
X-CSE-ConnectionGUID: oUtFHxpvTi2dFof5WZCHhg==
X-CSE-MsgGUID: dFxgE6PJRmOYmDSoURK5aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93256962"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93256962"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 22:48:42 -0700
X-CSE-ConnectionGUID: UzDlqS48Tq64bgHfHI5JyA==
X-CSE-MsgGUID: Mruj16DSQKygugToBk+B8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="136805"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 22:48:39 -0700
Date: Fri, 11 Sep 2026 08:48:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aqOWNJhnBRNQfexD@ashevche-desk.local>
References: <20260910063813.56419-1-marcus.yu.56@gmail.com>
 <20260910063813.56419-3-marcus.yu.56@gmail.com>
 <aqJzXvxHEWi2Ny1g@ashevche-desk.local>
 <aqMDWRRKMW7uYoGa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqMDWRRKMW7uYoGa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 12:22:01PM -0700, Chang Yu wrote:
> On Thu, Sep 10, 2026 at 12:07:42PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 09, 2026 at 11:38:13PM -0700, Chang Yu wrote:

...

> > > +	name = as7343_channel_label(chan);
> > > +	if (!name)
> > > +		return -EINVAL;
> > 
> > Why? Can't it be taken from DT?
> 
> These channel labels correspond to the physical optical channel
> names defined by the datasheet. Each name corresponds to a
> pre-defined range of wavelengths. They are fixed internal properties
> of the chip, so IMO hardcoding them in the driver is more
> approriate.

Please, make a comment on top of the string array, with probably citing the
datasheet table with the wavelength ranges.

/*
 * Channel names as defined in the datasheet:
 * // hypothetical example // ... - 200-300 nm
 * ...
 */
static const char * const ..._names[] = {
	...names...
};

-- 
With Best Regards,
Andy Shevchenko


