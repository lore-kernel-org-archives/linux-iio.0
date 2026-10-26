Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007841;
	b=YQhyUVSai2wffSmrPxdNe1T4eysSi2vpbrUistkPXkm2sLyUS6S7AzXlWGsu19gUN5wE
	 rBsUiHw9bg9MVSN4+2CrXMz/jAstFD97Rv0iccJZh/uAPAnwtasfjpRL6hLD+WelkmKY+
	 D4aFREzuyAmKVCi1mV/zhQ7vNnKQidWx755s7LE8lVsvgeUVjVsuhIFk2JopFRHe7gy4k
	 o8AgdxuECsAoWrhFCTWsqamwLDYz9lXrvq/JhkwP7Twy/OiFbp3+Ju59QRScVp1WpYyRn
	 bRRjWyiWNQoOC1BXg74F7DaU67bSB9ZH0XUjF7/QJfdmetzBJpZehRFGCCi+7R4XdWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007841;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QxxyiG9zam0Z8+EPXxamk+a03tNCPbuNLQlDij0eAwU=;
	b=lYScKM08L87EF3/ov17hyc/8RIxSb2qwQoi9itZsanaPYxqcH34f7uQVzRElgXZFLwmZ
	 ULoaMktu4SnH4Y5ab92pUbjyvU8D2r0VKsb8zAlNHV1uH2jfXiiyPiwYEYzS0s6pe9KF+
	 IhXc87V/tuIc6P7Yq7ETuVNbK6D+mXIJBQ/6q3J+/UeSoB/tzaASXAuvul2GZlxjzdfu/
	 82grmLvLhU7D2ISRnBr8cPWiYVt/89n/808X79cHbunpGtuZpPRv6QzHyrUe6vaLBeghr
	 uyzu2oPQIh+siNVQRbYRmSmaiWa1xQ3OIyAmQWp5CLN39eEZuqocuUIiEDl/GCFkFsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OSbXrnbA;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BC606A31A;
	Mon, 26 Oct 2026 09:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OSbXrnbA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793007840; x=1824543840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Yv5WGaZPX5FO8T2ZAb3XrmANBLDtt3gAxTj65wtlps=;
  b=OSbXrnbA2bBemi5WJeXm7hz6o3GqqFGvnw7UcNzv5/zXyS/4hP76cXLb
   TcmtTCUH1In24+jr1deKl98IevPRiYxrvoEgIzDwrvaZfEtVq7a+zeqfl
   lnXSu5uNRffZNcJddoFivrJiE7NHm6ZYbH9vZ70ie2s/aFZhYs++mvzC5
   mC4aMUd3seXn5Wbq0acEPMDIMMx8U9anXROsskegkz0uehGOthjs4x07w
   4EZFJjpneOi+ebKebuW5VGH7wD3eit8Qi5tIODuKFayg5nRSn+sRJnu7F
   YxclM0v083mHNkv0NOW8KxGu2MkEM4xDTgX27tuRIqyqc2P0N5bhIRWxm
   Q==;
X-CSE-ConnectionGUID: PscPpqW0SUm+ikUpojtj+A==
X-CSE-MsgGUID: 9MLrfZarRLWI8uIHkE5Chw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1662792"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1662792"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:43:59 -0700
X-CSE-ConnectionGUID: JVSXpI0vROCDsBXAtGOfzg==
X-CSE-MsgGUID: Yh/nRC+YTjqygLvLvM/wFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="5973915"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:43:58 -0700
Date: Mon, 26 Oct 2026 11:43:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at8g26_l5JVbqs2i@ashevche-desk.local>
References: <at5qzj89R8W4K5Zc@ashevche-desk.local>
 <SN1PR12MB252873B804429C58E090C563A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB252873B804429C58E090C563A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 05:26:37PM -0500, Victor Chernyakin wrote:

...

> > > +/*
> > > + * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
> > > + * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
> > > + */
> > > +static const s64 fdc1004_calibbias[] = {
> > > +	-0x8000 * 488281250UL, /* min */
> > > +	+0x0001 * 488281250UL, /* step */
> > > +	+0x7FFF * 488281250UL, /* max */
> > > +};
> > 
> > Can you explain the negative capacitance meaning? Does it mean some vector
> > (direction) in the physical world?
> 
> If a channel has a parasitic capacitance C, we can set a bias of -C to
> get rid of it.

I see, please add it into the comment above, so nobody will be surprised by
the values which we learnt should never be negative.

...

> > > +		/* The datasheet says to read MSB first, LSB second. */
> > > +		ret = regmap_bulk_read(data->regmap, FDC1004_REG_MEASn_MSB(0),
> > > +				       reg_vals, ARRAY_SIZE(reg_vals));
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
> > 
> > So, why the value is not marked as __be32 with the respective conversion?
> 
> regmap gives us the two 16-bit registers in native CPU endianness.

It's only if you specify endianess for the whole communication of regmap.
I'm too lazy now to check the original patch, but if it's not specified,
it means the device native endianess, whatever it is on per register basis.

> If the CPU is little endian, that means the overall 32 bits aren't in
> __be32 format (because the two bytes in each of the halves are swapped).
> 
> (Hopefully that makes sense? I'm not sure if I explained it poorly.)

But yes, even if you do it in the device native endianess, it will still be
a pair of 16-bit values with the halves being swapped in case of treating
them as a single 32-bit value. This is unfortunate... So, basically this
needs to be elaborated in the comment above (where you refer datasheet).

...

> > > +static const int fdc1004_calibbias_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > > +};
> > > +
> > > +static const int fdc1004_calibscale_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > > +};
> > 
> > Why do we need these tables while already having them just in different
> > format? Perhaps you can always keep the decomposed variant and otherwise
> > join them at run-time?
> 
> If we only have decomposed variants, the IIO_CHAN_INFO_CALIBBIAS
> and IIO_CHAN_INFO_CALIBSCALE branches in fdc1004_write_raw would become
> ugly and hard to read, e.g.:
> 
>     if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
>         return -EINVAL;
> 
>     return regmap_write(data->regmap,
>                         FDC1004_REG_GAIN_CAL_CINn(chan->channel),
>                         DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
> 
> versus

What I meant is to compare decomposed val64 as well.

>     if (val64 < iio_val_s64_compose(fdc1004_calibscale[0], fdc1004_calibscale[1]) ||
>         val64 > iio_val_s64_compose(fdc1004_calibscale[4], fdc1004_calibscale[5]))
>         return -EINVAL;
> 
>     return regmap_write(data->regmap, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
>                         DIV_ROUND_CLOSEST(val64,
>                                           iio_val_s64_compose(fdc1004_calibscale[2],
>                                                               fdc1004_calibscale[3])));

You also need to make decomposed arrays to be double dimension arrays.
Otherwise this [2]/[3] is confusing in comparison to [1][0]/[1][1].

-- 
With Best Regards,
Andy Shevchenko


