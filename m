Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659762857F0;
	Fri, 13 Mar 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394545; cv=none; b=HIhQfJlCyAPOEefF/Pe6NAC1c4avdsCrGC0NCxRSblzidn7sc8giLeZyJdekKUQyo+oMOQrzSGuePHoSMEz27YdMbnx0KgSfPzKga9C/hYibnDszfaYjIsDXuGwKOKmnA7KwlmiFHSTZfEKqXcF28yii2NFg8Ce5x6rMXOpNu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394545; c=relaxed/simple;
	bh=lVl3///eTb2cGGF3U38r8Jo4k6Yf5x1ljy9i9HMp18Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ+kbp8xZlC5kBhlW+MFIBIgawpvSrsBT8oOY5iuNO/+TmgscQ5NE9RktkzkggiqQ1FZzvQPXyHOoWREnFRK8yc89sLisi1XDokjor/8d8K1C/FrcNNbe0SE1pu0z6/SgtIV9PnlM0od/5CKF+y90aNsu+luB23Gwy1CyLbPR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhBeCIN6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhBeCIN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394543; x=1804930543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lVl3///eTb2cGGF3U38r8Jo4k6Yf5x1ljy9i9HMp18Q=;
  b=hhBeCIN6OU5QN/sTJM3+t0J9XWJbDiqtHWy3MktvgGhocn1HENEEap6r
   1gqNzDILCJ+sDmJ9KtezLpPCy2HGkJ6A4zy80jo2w6VA7STtaYRpAp+cp
   /GoSz1HZfLnf/L9GTFnW4XxFzh7uKLCmJwutlcHyrvBnIDnvF7kdCncfE
   hvcsILQ/DpxVlD/ynqDjZIzd9y5rOTrVBUJ4zjz4krFNhGG52H6MKj6aI
   JbevkA/TXEVGGSEzCHnre7i+DpY/mm4ndKMdcdBVeGdjAF4Z7uoMTTWxn
   OqjIu3VJ+i1Nh1SHyBIkbDalk4J964s70zI7dbvqY5gU8UgUdKac8efd3
   A==;
X-CSE-ConnectionGUID: IyJKBRH8TnyOciKQiHaEtA==
X-CSE-MsgGUID: 4YTov4nIQi+notIdM1z+Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74467376"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74467376"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:35:43 -0700
X-CSE-ConnectionGUID: 30Me4919TtGu5YAeP01qgg==
X-CSE-MsgGUID: N8VEyAjFQwutqSFa8sPueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217555302"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:35:40 -0700
Date: Fri, 13 Mar 2026 11:35:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <abPaaSgJi6m6mch9@ashevche-desk.local>
References: <20260311224044.21480-1-email@sirat.me>
 <20260311224044.21480-3-email@sirat.me>
 <abLUgxivQnz2ISeY@ashevche-desk.local>
 <CANn+LW+mg9Ridm3aMrVhy7cgvmJO0JNV_s_myfRCW8gPv7Ggkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn+LW+mg9Ridm3aMrVhy7cgvmJO0JNV_s_myfRCW8gPv7Ggkg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 11:37:26PM +0600, Sirat wrote:
> On Thu, Mar 12, 2026 at 8:58 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Mar 12, 2026 at 04:40:37AM +0600, Siratul Islam wrote:

...

> > > +static const struct regmap_config vl53l1x_regmap_config = {
> > > +     .reg_bits = 16,
> > > +     .val_bits = 8,
> >
> > No cache?
> >
> The result registers change on every measurement, so caching doesn't
> apply well here.
> Will add .cache_type = REGCACHE_NONE  with a comment to clarify.

OK!

> > > +};

...

> > > +     reinit_completion(&data->completion);
> >
> > > +     wait_for_completion_timeout(&data->completion, HZ / 10);
> >
> > No error condition check?
> >
> This is only a short drain to make sure any pending IRQ has been
> handled before we stop
> the device and clear the interrupt line. A timeout here is not treated
> as a failure and the device
> is being shut down anyway, so I intentionally do not check the return value.

Based on the above experience, you know how to improve this.

...

> > > +     data->xshut_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(data->xshut_gpio))
> > > +             return dev_err_probe(dev, PTR_ERR(data->xshut_gpio),
> > > +                                  "Cannot get reset GPIO\n");
> >
> > If it's a reset (semantically), use reset-gpio driver and reset APIs here.
> >
> The XSHUT pin is a shutdown/enable pin rather than a true reset line,
> and the existing shared st,vl53l0x.yaml
> binding already defines it as reset-gpios. So I am keeping the GPIO
> consumer API here.

And? reset-gpio driver is exactly for those cases. Please, move your driver
code accordingly.

> Sending v4 with all other fixes from your review, shortly.

Please, take care of the comments first.

-- 
With Best Regards,
Andy Shevchenko


