Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792838317;
	b=EOplBcaglWPi+YB7tKe7bTdn72ainNg1f59K+nWCl0syfijddI7QqiDtcc3KGmDimXPK
	 22GvU+Z967yFC0QzY+/0d62gFTXdfnLMoxWixr40hogD3lTSRsPqnES80gZkH1BtAdrJ8
	 Ypl5ngX5bI4gA/vSIQYiLKcAf11iWCXiBJQMepzgLNQqfFQvN4KQ0Pm1tBR1vjubLa28F
	 eB11enu0Vvz5wXnP4YC5Jr3TxLJKu9dmWlQ7dbrGkVWduLottyxGC2tcqYFdbP+vTZ/0l
	 mp4kvu0s5eOkbV7Jes/mrxw/OpdMNblfXtJ1O3ybzCt3CpNjw+PaO5hsi9V2wU/KGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792838317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qAQjYYDYYKT+pQI95I063wXWoy76Y7CUBOwu7TGf1IY=;
	b=pnGlllCIFCps6S3b5oI1qu2527BSu9aoKMGHxYKFFhJUIW/r8NMB0f6JwqV0h1jmAoW5
	 u9niXzwT8PcKfhc/YB/diR47C54TQ8GalahmEfVq61UHdsEvKKNGoQEA/r1gGgXV+97Cl
	 RkTEpBGO5ChuC39CPjs2vYxcQDd/oCslcgNDg4G4jwtJKWjS+9WVzmRLEPydO5ABFC+l7
	 KpPCdN0IjXbUGZrnJZLoFzRshxjPJVuZ4HrZCM3C00CtX5fmfeVgzNnCbnUuBZNpb8lBp
	 BZj2Qp/us4wJBoJIUdglWRdSUoDRjfrepyGOPZcDHrP4vvgOEHlrkUAXmN8zylTEC3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aU0E1De+;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBE606A31A;
	Sat, 24 Oct 2026 10:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25EBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aU0E1De+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792838315; x=1824374315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZxGAs6w37sgIAZ5tR3Pk9MNEYp0l0AYRzOBPoS71Bmc=;
  b=aU0E1De+gd7THqGkSNHOleBl4PyDu+oqdw9qRbqJgl9b0PiC/gLnr6WQ
   0qTmr+CD0JME/vyi9uXgMcSe7i6YIpY54vdRREYfXwNy6z9j6axnTJVVH
   2SkVXj5rzynmZqPJFEyem3Wuy1OQmClBK9nrbFE4rtoE66zBrbrum6u0y
   F9njXrytprQj97klB8KF8LlVEP1CFSWRjWIszQMO/m/XQEoaTnqjhWWWU
   IKXDhhnijkT7SBRXuc+TnH9Po6W4kQyJsars3qD2loSdUbuHksrK1QND5
   x6KzaglV/d6zOmhgwWn4nbQ2cVJ4uXtBgny09ivQFug/880fUvDwte9X/
   A==;
X-CSE-ConnectionGUID: +tyEyAoSQI+dJrM6L+s6Lw==
X-CSE-MsgGUID: amuvo9khRweyFKhZrthVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1592048"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1592048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:38:34 -0700
X-CSE-ConnectionGUID: w9T+kWYHQNGD7VXGJP/KAA==
X-CSE-MsgGUID: AvxYF/CPSgGNMkzOFLK6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3854300"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:38:30 -0700
Date: Sat, 24 Oct 2026 13:38:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <atyKo0pTYZyt5XJc@ashevche-desk.local>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:

> Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares
> the RZ/T2H ADC IP but differs in channel count, sampling, calibration and
> resolution support.
> 
> The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> 20 ADCLK cycles, does not support calibration, and supports selectable
> 12-bit and 8-bit conversion resolution.
> 
> Expose the fixed sampling frequency as a read-only attribute and allow
> the conversion resolution to be changed through the scale attribute.
> Use extended scan types so the reported scan type follows the selected
> resolution, and prevent resolution changes while buffered capture is
> active.

...

> +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	u64 req_scale, scale;
> +	unsigned int i;
> +
> +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> +		return -EINVAL;
> +
> +	req_scale = mul_u32_u32(val, NANO) + val2;

But what's wrong with the simple 1ULL * val * NANO?

> +	for (i = 0; i < chan->num_ext_scan_type; i++) {
> +		scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>

Similar Q.

> +			chan->ext_scan_type[i].realbits;
> +		if (scale == req_scale)
> +			break;
> +	}
> +	if (i == chan->num_ext_scan_type)
> +		return -EINVAL;
> +
> +	/* The scan type changes with the resolution. */
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	adc->resolution = i;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


