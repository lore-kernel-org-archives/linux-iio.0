Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A7279903;
	Fri,  7 Aug 2026 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064686; cv=none; b=oAYy/18aaGHhdc67vf8Kku5ab+tst2CRoQJcnhD/lELOAtHDgprDlbz6PRq4NNOofpV4suefKDwDF7AgPmdupZJKVsQzNPfufx2tLLGg3+C5Xn6e7HBNWdFc7mn7aZYs1KqehyPb0UFr+okUmbNqyKNIsOGaaU122e90M5ZuAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064686; c=relaxed/simple;
	bh=1TDGJ8xLMlQRc6WuVobqlf19ekTKvIbqQe4pL8uXtI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw8BwSlsKXcOSWb20b0HJDBEzs6s8awc0gsZrB4H3hWv+fKrRC+NHWZ915bU1Mdlgm8CS8VBRTy11KOiqvhKkp0/k5Y1GklVCptzGyyo10KBOzsA2S3KFnBFhDk7KDn4Yz03zUv5TqbY4imRsoysTCaEftJ7+4sb+XUIr430HHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfqNFeqX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfqNFeqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786064683; x=1817600683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1TDGJ8xLMlQRc6WuVobqlf19ekTKvIbqQe4pL8uXtI0=;
  b=lfqNFeqXxJzB+X1oUbcFC/ouc3/v7i8AZncRz7iWGwTuX2tC9MZzakCK
   FXm7fmapDayHDjGEQV7ZXTtBykKVB9hn9S2W78K+n3StayMVeTIVPoiut
   L2Xn3DMKI8XRZjbQIeA0PQamr2u0a5QNYJTIusNZEDjZR3QpZr1CyljZB
   tO63M354rUWgk/TVOzyfbNR0z1V6fkNk8hb+ofwyNiQjZ+mpFCLCBm1+M
   CE2cv+xx6jgGKxsbjaUMI/x1f7T0gDuzM1aKe+26NEmdOpuaTLhKaPG5b
   5Piid0hTC0Gg6OHl01fxQkj02Srzd01BqITAvisUxAs390wNwOYhmzg84
   g==;
X-CSE-ConnectionGUID: Cc7ti/9wSkCK8YpwNFmE6A==
X-CSE-MsgGUID: j7btvPYiQnShpGdLCR9niQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86524139"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86524139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:04:42 -0700
X-CSE-ConnectionGUID: oqw5d/kFQ4Cx6+1qU/2lCw==
X-CSE-MsgGUID: 1RzVVBy2R0S1ycLIoc+apQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286933851"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:04:37 -0700
Date: Fri, 7 Aug 2026 04:04:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, radu.sabau@analog.com,
	Jonathan.Santos@analog.com, jorge.marques@analog.com,
	joshua.crofts1@gmail.com, jishnu.prakash@oss.qualcomm.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] nvmem: microchip-otpc: nvmem: microchip-otpc:
 add tag-based packet lookup
Message-ID: <anUvI309X_TVQbi1@ashevche-desk.local>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
 <20260727122633.117435-9-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727122633.117435-9-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 05:56:25PM +0530, Varshini Rajendran wrote:
> Add support for accessing OTP packets by their tag which is a FourCC
> while preserving backward compatibility with the existing ID-based
> lookup.
> 
> The OTP memory layout can vary across devices and may change over time,
> making the packet ID approach unreliable when the memory map is not
> known in advance. The packet tag provides a reliable way to identify
> and access packets without prior knowledge of the OTP memory layout.
> 
> Two offset encodings are now supported:
>   1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>      Used in DT as: reg = <OTP_PKT(1) 76>;
>   2. TAG-based: offset = 4-byte ASCII packet tag (FourCC)
>      Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> 
> The driver resolves offsets matching valid legacy selectors (multiples
> of 4 within the packet count) through ID lookup, falling back to tag
> lookup for other valid values. This ensures existing device trees
> continue to work while enabling new tag-based access. During probe,
> packet meta data including the tag is read and cached.
> 
> The stride of the nvmem memory is set to 1 in order to support tag based
> offsets, comment in the header file is updated accordingly.

...

> +static bool mchp_otpc_is_valid_fourcc(u32 tag)
> +{
> +	int i;
> +	u8 c;

> +	for (i = 0; i < 4; i++) {

	for (unsigned int i = 0; i < 4; i++) {

> +		c = (tag >> (i * 8)) & 0xff;
> +		if (c < 0x20 || c > 0x7e)
> +			return false;
> +	}
> +
> +	return true;
> +}

-- 
With Best Regards,
Andy Shevchenko


