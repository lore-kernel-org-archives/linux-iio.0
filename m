Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428158;
	b=5IBjRD/FPqgqw/84aXnSDTtBElrsfIJ8U5A3T7jL/N8idKLNgKxSvTy9MaLCRdSo7i+k
	 ZtZRX6bX2mtvRiz461DD2TOJWsJsLYbknSePxxknABjOLL61lWZgsrGBL0rff81ND5ugF
	 /5Bl2wR67zrthPmRP/8Fx9tMBV6WlWWxwnKACWBG9o6IFlLb1Mj8Ppq8K/rHYFWxMKjxV
	 7OXt3O0S8iriBvOBjzc0/JGf3ptFKmBk1+hwA3oo55wX/6o0zWAqFhrq2DyrHtRh51v3N
	 msndJuzCwhhu29ZlGUBVbeCWxWaRv5/Ak2f0srZbDsbhTU+Yqm+oS0YndUth/jbRaXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J/cXEYX01AONgmSurv+omWY8dTLGH3bj9ApNRUcbnpI=;
	b=HWNhErpXk6hVT/z3y0rmtGszuH+Ba62sDTrtHnRx3edOcQ3wKTIdUxuxljAuKxUZ9ceV
	 egMGrJbUBGyqC/p596ym8NKVKgXbTGcmdR0oAzd7qCpamO5ZaDwR016XGKdWaa5rdf1LZ
	 ICJlPIg5GFi0MBH5/PJDr1WTRavvVJyD4oIAPLOA7oRYCbGj14T6hHaSiDKQ1JQDYt3vr
	 IXhgriZm3oeK5ac2jjHprNE3j+E/tvIpEd5a3B8dkIi1CYWv6ZNPoqECLiCb0F6WivcpL
	 pBhNlSvQaiL5MlSeg68dT8zHTUVsdgEiEx2Cvp8EarcjLTR6ye+Ktid3xOvr8ZwZ/Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nj6bSp1X;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD937606A31A;
	Mon, 23 Nov 2026 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD937606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nj6bSp1X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428157; x=1826964157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPqdy+dRE3PgCFAspbnDDU9RURqyA1USLeDDe/7BAh4=;
  b=nj6bSp1Xy+caoziS38G9b+FCVsEek9thgrUm/5xMs+zMm84oWhiK5s/G
   XnnumUbuqCK2ChH3bZ143tf37RBIABk2/QTArW6YfJS2D+3FUNlzGjbZ8
   nDgN7STbNLmldyqx1K3F/z2d1mPNrxzJ2i04aDQP5gyF1LyjWgwbNT79c
   C3DzqFNnbjJfDpB7fL8yP5e/vT4jfjtKcpsvi9mTEPRvQ7oBybPstrskJ
   nIjRyus66Ia6hOpMH/55KlfMsGp1ziNxnNlAfS9OUxSvBII1kiegaP0hu
   jaeOPriyZT2FEvgy41Zyroj2l9tnskFF55nE+niG8aPEHk2bfjgKXhhMY
   g==;
X-CSE-ConnectionGUID: Zid5EMF3TfCoHSi2sgA+eg==
X-CSE-MsgGUID: zK3mNKHVSFO8OZV+ou/zAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4280625"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4280625"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:02:36 -0800
X-CSE-ConnectionGUID: qOmC6S3jRZeE5XGOmuygyQ==
X-CSE-MsgGUID: gsenE3cgReeVze5YzA1Umw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11410041"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:02:32 -0800
Date: Mon, 23 Nov 2026 12:02:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] iio: adc: at91_adc: convert to
 device_property_*() APIs
Message-ID: <awQPNvotVh7cODYR@ashevche-desk.local>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:00:57AM +0200, Abdelnasser Hussein wrote:
> Use the firmware-agnostic device_property_*() helpers instead of the
> OF-specific property readers, so the driver does not depend on a device
> node being available in probe.
> 
> Update at91_adc_probe_dt_ts() to take a struct device and read its
> properties through device_property_read_u32() as well.  Since the helper
> no longer uses DT-specific APIs, rename it from at91_adc_probe_dt_ts() to
> at91_adc_probe_ts().  This removes the need for a struct device_node
> pointer in at91_adc_probe(); as a result, at91_adc_probe_ts() now logs
> against dev (&pdev->dev) instead of &idev->dev.
> 
> Drop the " in the DT" suffix from the missing property messages to match
> the firmware-agnostic property APIs.
> 
> With no OF APIs or struct device_node left in the file, drop the
> <linux/of.h> include and add <linux/mod_devicetable.h> for struct
> of_device_id.

...

>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
> -	struct device_node *node = pdev->dev.of_node;

	struct device *dev = &pdev->dev;
	const char *propname;

>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;

...

> -	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> +	st->use_external = device_property_read_bool(&pdev->dev,
> +						     "atmel,adc-use-external-triggers");

	propname = "atmel,adc-use-external-triggers";
	st->use_external = device_property_read_bool(dev, propname);

> -	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
> +	if (device_property_read_u32(&pdev->dev, "atmel,adc-channels-used", &prop))
>  		return dev_err_probe(&idev->dev, -EINVAL,
> -				     "Missing adc-channels-used property in the DT.\n");
> +				     "Missing adc-channels-used property.\n");

	propname = "atmel,adc-channels-used";
	if (device_property_read_u32(dev, propname, &prop))
		return dev_err_probe(&idev->dev, -EINVAL, "Missing %s property.\n", propname);

BUT... this needs to be fixed first to unshadow error code

	propname = "atmel,adc-channels-used";
	ret = device_property_read_u32(dev, propname, &prop);
	if (ret)
		return dev_err_probe(&idev->dev, ret, "Missing %s property.\n", propname);

AND... what the heck is idev->dev now? Please, fix that before even this patch,
use same device pointer in the call and in the message. In the end it should be

	propname = "atmel,adc-channels-used";
	ret = device_property_read_u32(dev, propname, &prop);
	if (ret)
		return dev_err_probe(dev, ret, "Missing %s property.\n", propname);

>  	st->channels_mask = prop;

All the same for other properties.

...

>  	st->res = st->caps->high_res_bits;
>  	if (st->caps->low_res_bits &&
> -	    !of_property_read_string(node, "atmel,adc-use-res", &s)

> +	    !device_property_read_string(&pdev->dev, "atmel,adc-use-res", &s)
>  	    && !strcmp(s, "lowres"))

This is device_property_match_string() I believe.

>  		st->res = st->caps->low_res_bits;

-- 
With Best Regards,
Andy Shevchenko


