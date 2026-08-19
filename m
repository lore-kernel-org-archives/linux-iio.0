Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122D35C1A9;
	Wed, 19 Aug 2026 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122271; cv=none; b=khwpVIQ5zPIj+Cq2FHtwtnnvt0qFeO3QDo6HNO+yy3YikMQ0KVhpdH6rOl9+cor/1ZtXCJkTVKnHcVxxTYbNEZ4EsCnN2E1EpcXUstv6KpXKXjbclC2NET8Qby8ItwWnWbvunwEOxRuw4uTkahNHhsqptNMBuOEPtkPk+/iHI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122271; c=relaxed/simple;
	bh=kJp8TFu+JRNAhAkCPHLWxHH70xVm6+y+izJn/pddPKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCSXobA5ljhxjjEeTUhvGtz1wKx2996lrlQcivN6g9mzUgtbllE3oYH1/cBoM1f8dYVndcH9eZ7ylPVxeO+4vfqTUrpJzNF/uDoSqWm5cPpYRyBomRpng2dMGyb3JSBRhWatzrmymqVLEaqmfo0K3Fc0JT0dojekQ2upMLRPdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G25c7ayu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G25c7ayu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787122270; x=1818658270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kJp8TFu+JRNAhAkCPHLWxHH70xVm6+y+izJn/pddPKs=;
  b=G25c7ayu9T0/1sMSg9Gfs7A/MVY1ntePti2f36OmMejqb4TDm44PMJom
   rTfikVqiDIMjsIdz45cH5SPSmMXWNiMIaJALH5uLqylEnvnDjzyiogji1
   uuuaEZKU3NuN642d782i5cTUCiGcspLWv6Ov0kYkNFJE2ESh3/avDqsKv
   8OTjm8XsmaVMk/r22BSgyA0q8DBjeuMx8XU6ylTBJJNpKw31la6iw5f1h
   A3WYybo3jD2YLwFmg9YBt4s8MTiX/bGgZDvJuDAsqBxgB33szYQGQ+tP0
   KXWqvAOA5GXaQvDyDL1Ne851mdZ0lw6YKhG3RNb3q7QzIi+NVImvWGj1M
   w==;
X-CSE-ConnectionGUID: wjuBvBvESw+8nnmeYWUF/A==
X-CSE-MsgGUID: cZClWK/STZ+XVJmx2cX9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87542111"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87542111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:51:10 -0700
X-CSE-ConnectionGUID: DsJl3UMARvCpwnwsDJXk4Q==
X-CSE-MsgGUID: 7hVlIwkHSOy4ITL5gcAgew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="265488694"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:51:05 -0700
Date: Wed, 19 Aug 2026 09:51:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, siratul.islam@linux.dev,
	u.kleine-koenig@baylibre.com, linux@roeck-us.net,
	joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <aoVSVy60_U2mNEjv@ashevche-desk.local>
References: <20260818142928.8244-1-stefan.popa@analog.com>
 <20260818142928.8244-3-stefan.popa@analog.com>
 <aoR94S2qknBVQrT3@ashevche-desk.local>
 <20260818171953.4dd76b83@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818171953.4dd76b83@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 05:19:53PM +0100, Jonathan Cameron wrote:

...

> > > +static const struct iio_chan_spec max40080_channels[] = {
> > > +	{
> > > +		.type = IIO_CURRENT,
> > > +		.indexed = 1,  
> > 
> > > +		.channel = 0,  
> > 
> > No need
> 
> True, but I'd keep it because it is paired with indexed and looking
> for both together is common.

No objections then!

> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE),
> > > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> > > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > > +		.info_mask_shared_by_all_available =
> > > +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > > +	},
> > > +	{
> > > +		.type = IIO_VOLTAGE,
> > > +		.indexed = 1,  
> > 
> > > +		.channel = 0,  
> > 
> > Same, it's default.
> > 
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE),
> > > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > > +		.info_mask_shared_by_all_available =
> > > +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > > +	},
> > > +};  

-- 
With Best Regards,
Andy Shevchenko


