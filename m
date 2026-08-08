Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49437F8C2;
	Sat,  8 Aug 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222351; cv=none; b=H3cmzoJ/j7YvIViSZJbGmRb3/KJD65LX6JnUrqvH6kQrxeEpOxRdiIoIwq5dATTVChMRaa8mPrQKzUaI1lPsINMP85CEETxuFROmKr6yRBahYXcMZcC6qVB75KOM7G9bLvg+3hMVT8wRFlwWTfCgdkx7EsNZ1K7BOgKT/BOzdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222351; c=relaxed/simple;
	bh=udPPUG7YUJ+eyh17qdQwjE9kRRrsNEriEz/GGK9oFgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMOF4oKaMTq8crKBq1LewYOxCC1J84R2lfSkywzp0rztmc77DrAly2eqDZWF21RMfANjw7MELckycQ3p7wyZbkMUC7PvlecnBglWJ4L7dwsUc8Y91Bx6VkPrJcLtkxMw1gCnzJVLZg5aWWFk7IzjMbkVQV3zpw5dIIJZUxK0lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=an/uot9c; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="an/uot9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786222347; x=1817758347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=udPPUG7YUJ+eyh17qdQwjE9kRRrsNEriEz/GGK9oFgA=;
  b=an/uot9c22hPborTwM1zNbK2CW7eTNJ5IIO3NV/ABWBXAusJ5ag4165m
   M40KdwS2TK2SBRZncYaPZe89pf6h27jgtTjeydggc+uwIdNAq/SINWXQk
   vDp233MM+MzAMSNJczD50GUvqEv7XwkjmBhsC7l5Z/ct1jOKjshYIZG7b
   KSo8gddjLIAmqUrDBNp+kQT1BIWiQXBbHhohSiNSC0nYA3PZ+m35HrOTt
   kSvrdxNe1xLzqsgPF2UvfacLkLokJMIyS3WTuP1z5k1q4/8wZSALa3yWS
   4d9PGJZzZZrDdXLayiA8upgCL6aECdpTwI8xmccTqh2E3qwJefyGaEER6
   g==;
X-CSE-ConnectionGUID: KXfRm1T5SMGydcSNB8hL+g==
X-CSE-MsgGUID: mFVt7YjlSDWTFPBVH8w2IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="112341512"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="112341512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:52:24 -0700
X-CSE-ConnectionGUID: qcZMscCWQk+11TuVWfxZow==
X-CSE-MsgGUID: o3UoJiz5RGmlvoWW3BCrhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="287378575"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:52:19 -0700
Date: Sat, 8 Aug 2026 23:52:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, radu.sabau@analog.com,
	joshua.crofts1@gmail.com, jorge.marques@analog.com,
	Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
	antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/17] nvmem: microchip-otpc: nvmem: microchip-otpc:
 add tag-based packet lookup
Message-ID: <aneXAPGifAS2PG9G@ashevche-desk.local>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-10-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806074024.531259-10-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 01:10:16PM +0530, Varshini Rajendran wrote:
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
> +
> +	for (i = 0; i < 4; i++) {

	for (unsigned int i = 0; i < sizeof(tag); i++) {

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


