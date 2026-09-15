Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C943CC303;
	Tue, 15 Sep 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457661; cv=none; b=GspY7CiT4TIs+NPNCX6oVPcQ0lfdmL8zlECh/0G6NPSZii69m3vS4wvnd+dccIcs+TBk9ECZ/3HmPATKdXArZRQU3DD0bH/T1KnXqZbM+zQnGK3hA2GB++FZg0CoNhF0Ara0ppeQW0vNNQY3vtiFW2+PLRb+Omqy20go33eRFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457661; c=relaxed/simple;
	bh=yqXh3wBBDWPC71mN/8FPaKt8dm8okOjefQD0eCpqUxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTUsQyr11ctyY9SF9PO1GTJ6EFQzFNcStKY3pqMv0bC5XJn11hII+l25jZYsn4iR3FfAaOcBsWYa9jsqyhjBEKUc8BLd9dzdPfQbSkFYm9U05VCv3nOPnRPkPEKji7LhEiYppZKuRriHivuSmXk7KiHSW3VvX2SneUp4UIS8b08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSVf8EDl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSVf8EDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789457660; x=1820993660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yqXh3wBBDWPC71mN/8FPaKt8dm8okOjefQD0eCpqUxA=;
  b=iSVf8EDlkqKQ0bfQgzRsf0Bw3XgBicw3jyo9V0Xg4Cztkma/J1J2nqNl
   SGBPx89ZAzd4DaLF8zNr3C8gGNxlN74fppCWdkNl74yV7lrD4BDTr4TgN
   PY7gUK4BRn1lgloIEIIBU7ODr87XWkBJPEpDldRhOxVzTagwpZXarRe14
   xO1nyW4N5udQ91cEtM7QJIspfzZEi1rHI2/Eh508EgjuUDnnY7GPCl4WY
   0DsVOp0gV8o3qjNrMO4+2Irwy0p87ZhP+nD6UmfWtXDv6vHIFtEAz8Zyi
   7eV/f9vNAQTdrJ2U01AmT9Nf1QcX8NzIobhpyuIthYHw+TUUi8CGqLb8t
   w==;
X-CSE-ConnectionGUID: 7ZbaFh0/T1CEzOK1/8qJ8g==
X-CSE-MsgGUID: 6vwL1LNhSN+fPgEAr03T/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90019070"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90019070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:34:12 -0700
X-CSE-ConnectionGUID: Rb6xTnV3RxuXF+Xgp+x06A==
X-CSE-MsgGUID: 0U/a7lm6QhCutLRD6UVCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272386890"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:34:08 -0700
Date: Tue, 15 Sep 2026 10:34:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aqj07iI_KFTDrjPR@ashevche-desk.local>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-3-marcus.yu.56@gmail.com>
 <aqepkmQS_p6K1Bd6@ashevche-desk.local>
 <aqiyQOMGGIzu-91z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqiyQOMGGIzu-91z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 14, 2026 at 07:49:36PM -0700, Chang Yu wrote:
> On Mon, Sep 14, 2026 at 11:00:18AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:

...

> > > +	if (val != 0x81)
> > > +		dev_info(dev, "Unknown device ID: %x\n", val);
> > 
> > Wouldn't be better to define 0x81 with meaningful name?
> 
> If I remeber correctly Jonathan prefers just putting 0x81 inline. I'm
> OK with either style so I'll defer to the judgement to Jonathan here.

OK!

...

> > > +static int as7343_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct as7343_data *data = iio_priv(indio_dev);
> > > +	struct regmap *map = data->regmap;
> > 
> > > +	return regmap_clear_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
> > 
> > Can this mess up the raw read? If so, also needs a mutex to be held.
> 
> People familiar with runtime PM correct me if I'm wrong, but I believe
> PM_RUNTIME_ACQUIRE waits for any ongoing suspend callback to finish
> before returning? If so I think there is no risk of a race here. In
> the case of system suspend, worst case scenario SP_EN gets cleared
> before we read ASTATUS or the data register, which for my use case
> at least is OK since the entire system is suspending anyway.

Yes, if the raw read is guarded. What about _setup()? Is it guaranteed
to be free from races? If so, we are okay.

-- 
With Best Regards,
Andy Shevchenko


