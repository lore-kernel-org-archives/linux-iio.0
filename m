Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15E39B955;
	Wed, 11 Mar 2026 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213061; cv=none; b=qclsP5Ji5qu6dy4vUCS5k6sqfznwCBj5+1CTWMOtCPm4c2/HN+umpQWCKdtVqFUPPb9HP70u2EnubIPy2pnD5pdlXCHkdMEw6ki69pLwd1ejx1kdzeEk8o3jAdifzbmN9S4xX44GS/heKDRpr9r+7Is4MdwJscgdjxqVz/b/IsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213061; c=relaxed/simple;
	bh=S6DCtOFxG9F6QSwwhCT2DfwAh3MaroX/4RxL/8YtxZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7sZ+qn8FACUln83C0i4DLTsbeI/cmXWfzQerQPfXqAhmOCJMfwtaknBQQiWgviKMIo2ejJ8IASnPme2/3LCh/i4bg1sVT5c8tgeLfUVUlKPc0mqoZiw3O9HS2m/vokARUhDDBIi7XCkmL+IJ3QcvYXRp1I09Y78ssANPk0noCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndCJQwuA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndCJQwuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773213059; x=1804749059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6DCtOFxG9F6QSwwhCT2DfwAh3MaroX/4RxL/8YtxZs=;
  b=ndCJQwuAK1HLorygklM13IOBi/9kGCHTx7R4NW+UGp/oBzOoMdsKsKwK
   iDRgra/P/2kvYRCHEqVTsn3Vs6I8/BHMcLh+loaWVDgxmcy992S5BsShT
   NTAj8FKwaQgO1+FttKMyEIeMymF6rpcU1NKdMs7vtScd0Y0WSIygQwWKw
   A3TYrV8nhtjKE3CH58YXzbouhWjmLiAmwG+q8a2XJ62LblDFmflXtBMvB
   +hKGczk4Ba0UgBj1bwitDpHPxWpHetS7G5WmpU1zcCsI9EnqYiI4M9877
   qBb33NlpVI7IpQxjuthGJnuloNwAZLQQYGGrS46PuvyCZcsLqaikeBJiu
   w==;
X-CSE-ConnectionGUID: vnXrTaZdQHyZIzvBP7Na6w==
X-CSE-MsgGUID: l/1Qq+aYSH6P3fSw8G3+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74171605"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74171605"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:10:58 -0700
X-CSE-ConnectionGUID: atYMevo4T8OUE7O98QHNmA==
X-CSE-MsgGUID: 1n+RXzXMQISQ9OfmBiYbrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219619872"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:10:54 -0700
Date: Wed, 11 Mar 2026 09:10:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ltc2309: add support for ltc2305
Message-ID: <abEVfIKYZSl-AnL8@ashevche-desk.local>
References: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
 <20260311-add_ltc2305_driver-v4-2-bc350d347f33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-add_ltc2305_driver-v4-2-bc350d347f33@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 09:43:02AM +0800, Kyle Hsieh wrote:
> Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
> The LTC2305 and LTC2309 share similar features: both are 12-bit,
> low-noise, low-power SAR ADCs with an I2C interface.
> The main difference is the number of channels: LTC2305 has 2 channels,
> while LTC2309 has 8 channels.

...

>  /* Order matches expected channel address, See datasheet Table 1. */

This comment now confusing, it should be kept at the initial enum, but the
better idea is...

> +enum ltc2305_channels {
> +	LTC2305_CH0_CH1 = 0x0,
> +	LTC2305_CH1_CH0 = 0x4,
> +	LTC2305_CH0     = 0x8,
> +	LTC2305_CH1     = 0xc,
> +};
> +
>  enum ltc2309_channels {
>  	LTC2309_CH0_CH1 = 0,
>  	LTC2309_CH2_CH3,

...to assign proper values (in necessary order) explicitly and adjust comment.
Then add this patch on top.

>  }

-- 
With Best Regards,
Andy Shevchenko


