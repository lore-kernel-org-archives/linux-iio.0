Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834B286415;
	Fri, 20 Feb 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599107; cv=none; b=CndqUP4RL+4i2dShHCkhcfYs2qmNOYh1yn6mDJWJr996bQuLvi8flU4KQMXzpm2gIpafkdp7oV+W/CB+EixsBrLyzxAkGp+S+YnrUEbA7RyqP8REyrZcIgDFF/nEIN/OD106KZR1WyZBRmkH8imHxBL0qwB0qTtfecIe+zOZiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599107; c=relaxed/simple;
	bh=x5OcLMWcRDkirMy+8Y/yzNyJU3LQA/qLPq8w/Ia7IdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oati3ZgAQ5UyU62TumL83GftIxd/7KXRbMP2fcqlcU4Zks9btvMxBfDe1UYPbtL3cSOc6V9F9a+kHnY/TSLPY9eBvHJ2uv4JTivg7+/Rgrnu6kbgMNkb+cYea8uYLyngmIkMxY0G0mvnmryHVgjcwf4qvA1ip5DgtPa4atkMJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds/nF0tu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds/nF0tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771599105; x=1803135105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x5OcLMWcRDkirMy+8Y/yzNyJU3LQA/qLPq8w/Ia7IdY=;
  b=ds/nF0tuZrhPYjGTDP6EB4G8JeTKgYTzkVCBEO5/E7ELH/B1/NdcbaGK
   mTy9L63v0MqyyMUOnABDQd1obp1mq7lMrdcTHR5f0rabx0wsj8eJx8N+8
   rsRO8MiZ9GQ2bNKh8+jG9qMLI3pIxNPdKdthzZ5x7croYx6Ian7fxyxCX
   E5qhdwhWjb71LIjAcrozUMoDm9aXuUhaU5MtFZvxCdeksHnpBZ+FC8nSL
   NaQVolmxqgWcmRuBZxygF6UeaT3nKg4fjyZRcJU1racX1vDxNGehTWAUZ
   k/1pA1GH1UdAaAlYHcQgkJtQZ5BnjDWkzRWONA3SDN2jc9SMr8aVG9FdW
   g==;
X-CSE-ConnectionGUID: 70qM9iczSxyAfRlR9gcQcA==
X-CSE-MsgGUID: cqy1oMMvRraEQxaXgptdlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="98153116"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="98153116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:51:45 -0800
X-CSE-ConnectionGUID: oEx5nvG5T6OmgHD+6mx9gQ==
X-CSE-MsgGUID: gE3QI/ajT1u5d7N+zX23Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219004235"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:51:42 -0800
Date: Fri, 20 Feb 2026 16:51:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe
 path
Message-ID: <aZh0_JOn4-3_f6TV@smile.fi.intel.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
 <20260220131151.74329-2-antoniu.miclaus@analog.com>
 <aZhoJlYUzuHXSGXL@smile.fi.intel.com>
 <aZhojCK9R_iPFcLi@smile.fi.intel.com>
 <CY4PR03MB3399D11BD9FC75E3A71CDD999B68A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399D11BD9FC75E3A71CDD999B68A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:41:41PM +0000, Miclaus, Antoniu wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, February 20, 2026 3:59 PM
> > On Fri, Feb 20, 2026 at 03:56:58PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 20, 2026 at 03:11:39PM +0200, Antoniu Miclaus wrote:

...

> > > >  	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> > > >  					 ADRF6780_SOFT_RESET_MSK,
> > > >
> > FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> > > > -	if (ret) {
> > > > -		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
> > > > -		return ret;
> > > > -	}
> > > > +	if (ret)
> > > > +		return dev_err_probe(&spi->dev, ret,
> > > > +				     "ADRF6780 SPI software reset failed.\n");
> > >
> > > Consider adding
> > >
> > > 	struct device *dev = &spi->dev;
> 
> Definitely makes sense, but for me feels a bit out of the scope of this series. 

I would use it as ad-hoc material and wouldn't bother of a separate series.
Otherwise it will be a churn of modifying the same line twice.

That's why I consider this as a good compromise (we modify 3 cases here
if I'm not mistaken).

> Want me to add the *dev = &spi->dev; here or in a separate patchseries?
> 
> > > at the top, so this line becomes
> > >
> > > 		return dev_err_probe(dev, ret, "ADRF6780 SPI software reset
> > failed.\n");
> > >
> > > (while at it, I would dare to drop 'SPI' from the message as is easy to derive
> > that
> > >  the device in question is connected to SPI bus.)
> > >
> > > 		return dev_err_probe(dev, ret, "ADRF6780 software reset
> > failed.\n");

...

> > > Ditto for the rest.
> > 
> > And also for the entire series (except patch 5 where it seems already
> > the case).

-- 
With Best Regards,
Andy Shevchenko


