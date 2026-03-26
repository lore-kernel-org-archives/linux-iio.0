Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D93BA230;
	Thu, 26 Mar 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516473; cv=none; b=jZ5xiPrLDrKb5jdkAnsgN5pRlV/6Wr6DHepZMDG1L3AJtLxySHmlImbybKeRarWDLMR/tfoTDxGAEBQI5uf0mjuvi2OAvm7UTy5Qj7egij/gRvWGxEh4OXX9und7jRkhsfNjOgeFRwNAm47h/dBtRO4+yrBGzbPuK+mTN6KYS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516473; c=relaxed/simple;
	bh=ThvvV3ySpthnXcdq+Fgxo7UmllRIGxxX1k1RpxJI5hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGN4IYV9urM67Kh1Ze56t7pH/kSmxpR1q3gSe+WEZztAYhSnAaEYdE+DmAsn6NqJaBiZr6wYrFSfrf01YY4P3KWLCHFr9wAcnxIP9GBexX0KfkzlOsmDsY6FJQrqyyaNVLeLDHgCPiPlbs3Lz2zcSlir157W31CF0WuqnVFVVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmBRneNu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmBRneNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774516472; x=1806052472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ThvvV3ySpthnXcdq+Fgxo7UmllRIGxxX1k1RpxJI5hk=;
  b=bmBRneNu2N4WRRW+GQ1M+8VaxNtzD+Ltr1UM4OIXGZcJ2Bebh8V2uG0e
   4Ac8Y/Ob25ptS3+Glvxm+5UDo2JXpUX4Lqm0NLtNdhuoXIQwIk6TrZCk9
   j4MsZLKWbSMFZbSOo2YyyqieH2IAQ3Uow2WyUyea2pXOdu7O36momKSW0
   ulBU92lx+G+D5nJ2vvpKh9I6u+kDxQzy5OsCFPxH7yVx1NFuik9maj3zG
   QbEFLvNprChZUz+uGX1ZOtxLDFmV7e+NxP+7fYMPNFun/RJZCXUVHunwB
   sOTogasLApzaAq2bMkr0sp3cwaJhHifrEkhA0S1Ie1MZJnJ1a9ePUtN2z
   Q==;
X-CSE-ConnectionGUID: k38T4srsSjmjHml9HJFDNw==
X-CSE-MsgGUID: adKf7Dl8R+6uTMLQoeHHGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75590957"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75590957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:14:31 -0700
X-CSE-ConnectionGUID: GtmDVaf5T1um7S+NHmbTEQ==
X-CSE-MsgGUID: VKr4D/d5TpyKFy5KEY3JjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229717511"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:14:27 -0700
Date: Thu, 26 Mar 2026 11:14:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Siratul Islam <email@sirat.me>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <acT48bou7k15NTQD@ashevche-desk.local>
References: <20260325063254.18062-1-email@sirat.me>
 <20260325063254.18062-3-email@sirat.me>
 <20260325144719.00005a92@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325144719.00005a92@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 02:47:19PM +0000, Jonathan Cameron wrote:
> On Wed, 25 Mar 2026 12:32:23 +0600
> Siratul Islam <email@sirat.me> wrote:

...

> > +		trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > +					      iio_device_id(indio_dev));
> > +		if (!trig)
> > +			return -ENOMEM;
> > +
> > +		trig->ops = &vl53l1x_trigger_ops;
> > +		iio_trigger_set_drvdata(trig, indio_dev);
> > +		ret = devm_iio_trigger_register(dev, trig);
> > +		if (ret)
> > +			return ret;
> > +
> > +		indio_dev->trig = iio_trigger_get(trig);
> 
> So Sashiko had a comment on this that has me thinking.  Don't bother fixing it
> in this driver as it true it's a common bug (and leaks a trigger structure).
> I'll look into it.

This probably can be worked around by introducing a flag devm_allocated and set
it in devm_iio_trigger_alloc(). If set, the release might automatically put the
trigger at the error cases. BUT, do all drivers that allocate trigger actually
bump its reference count?

> > +		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +						      &vl53l1x_trigger_handler,
> > +						      NULL);
> > +		if (ret)
> > +			return ret;

-- 
With Best Regards,
Andy Shevchenko


