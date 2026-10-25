Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961235;
	b=cyiXqmf1YBrCCVZ+hpTPu2VfAszxOEJ8l72juJcgN6DN/zUEZSPP+Wp5ImRqu5jV8g6n
	 cNo3wxnLAljz5GF2Ldyp+GEaw5Ib19Ue/40WLOQy3pNbpU+X32iWUjmpVtIsF/P5DuAVX
	 XbO9/dvV5MjRuWxN+MxGIPkhYIJj+urirTwpinGvfKWsVdtTa2zh+xgzqgWpwv023+7RR
	 V6e0Akblpc/xcEheR8Dcr6IgizYE2J6RwLMJrDLGxJD8Z+E6f4HcL0TuS+qCOVkobVrRd
	 JT/wpEHzneGEqtbb+69eORbS5wPK3zjdqXc3xm+jrxDaygpeCoXTyPog9bKwCXYUM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=TcZnZKaR9ysza8xKdIiYLwHgnKAw2hgm+VgHOZg3UVw=;
	b=j837bayxa+P4+83KQXKTyYeCOtajAA60pi5BUSw9cBYrSTj2evrJEsMuGlznKwoAmjl7
	 S5OhzVM/Xoy4K4Mf2r15pKQ21EeMzbTvhskX9RQX10MiauzSw4YhinHWYXy77HLWFd3DJ
	 JjDCogVDNTf45r1eUrJlosAFyuytn2lZWz7LZwlXW6UQQrmHroXZnRGbS9ZniX0VBmYC7
	 kkLVSUn7vB03s+UZJXErlSC+9UxsrrKSK4byHQ044PhvvrcaybT5sEzNxoxMM0VXdSSd/
	 HzrfsLTyD/YMBp6ATuyG7VUI2kiXgjaDxFrEIq3zwNTB0ecWLgUM0t47UwyVSscyo+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="U/zhjynY";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC9606A31A;
	Sun, 25 Oct 2026 20:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U/zhjynY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792961235; x=1824497235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXWHHc8AmL9VEAoDrqhvjrszlgg3CIbz7djjmHYY2NE=;
  b=U/zhjynYTUniHtRI/xnfEvZHuXbIuZAh3y6WtWjX6AH3QXtRQwjhTS9b
   wZTtHWn4ijSNz3oNHBM0HEaGEyMN7VaDx5zmQMEr3jywWns4jqW+I5Z7A
   Mn0TrrQ+gKKVsghL+gKig4WkqOBDYSUAF8EDH+7Ds8IK5lCMw/5vgnMCI
   6hm6ZiEUB8Af6wTIzuRFTMjXC6hNBnZyRiXflZ3hTSJ+LTu0DsoHUqcZW
   CM27ggah597pkAziM2rZn5exjjZL2vUlGSmcbJrpPfLYbyx0oBEET563n
   z/nk9bmY49Q92BCKM88MRyrUUcbtsh65YAhpYmAmPCNZrMt5/rfCyOtpt
   w==;
X-CSE-ConnectionGUID: Tsy2rG3+TMO/wGW/ULW4eg==
X-CSE-MsgGUID: rsUymKg3RrWUV29Pl0PvmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1734653"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1734653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:47:14 -0700
X-CSE-ConnectionGUID: 2gd0P2VZQ/K9UNclv1iNWA==
X-CSE-MsgGUID: sq1wCVKXQsaekuxMs0wvjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4439075"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:47:13 -0700
Date: Sun, 25 Oct 2026 22:47:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at5qzj89R8W4K5Zc@ashevche-desk.local>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 12:48:03AM -0500, Victor Chernyakin wrote:
> This series adds support for the FDC1004 4-channel I2C capacitive sensor.
> This sensor can report single-ended measurements of any one of its
> channels, as well as differential measurements between any pair
> of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.
> 
> Patch 1 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
> in the driver.
> Patch 2 adds the devicetree bindings.
> Patch 3 adds the driver itself.
> 
> Tested with the sensor connected over an i2c-tiny-usb adapter.
> 
> ---
> Changes in v2:
> - Patch 1
>   - Added tests

>   - Added a fix in iio_format_value

If it's about abs(), it should go  in a separate patch.

> - Patch 2
>   - Made the power supply mandatory
> - Patch 3
>   - Switched from direct I2C calls to regmap
>   - Added of device table
>   - Removed scan indexes
>   - Build up complex values incrementally
>   - Adjusted list of includes
>   - More designed initializers
>   - Various style/whitespace tweaks

-- 
With Best Regards,
Andy Shevchenko


