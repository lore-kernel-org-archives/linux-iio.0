Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C81374E42;
	Wed, 30 Sep 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760931; cv=none; b=USd1cuwmgIXjPBFlRapJjbbMa33Weg4qNvbKgjWreTRrwz/ff5qVeWZlHNKqTUS6emvHPn6tWaNTNtfIpfS2JLJjVaQ46GGdvM5BMfUvUgs0yxbqSxWU8NQfVg21pau/Gmc1tJ79k8V7ZNPw/GrmipwoInDTf8y+cgwkf9SoRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760931; c=relaxed/simple;
	bh=6sJ98yjfX7WtWEQfJyK5fHDmtw8r/Z53ygRus7vKeiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3UQbo9e5BkiT8DrgN8zaiaooDzseUEXKp1RMEJCnbxxbj0bAvftyPcI4qHzDDnou1eqX/kNnLcfvNPBXVRphQZIml3x6MNhvjH9Sw0LBT2VlAhwGdJMkrDV6qHVu/qssnz1wO3kDyg8slIwZ9LXgBiB6tAK7zz4nV+nLEUgZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6BBFMKM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6BBFMKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760930; x=1822296930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6sJ98yjfX7WtWEQfJyK5fHDmtw8r/Z53ygRus7vKeiE=;
  b=Q6BBFMKMsEhPeBI+RzzLSs5UJOJaCzJQqf2y7C9LdrdESO7mRLVimQu2
   b70oaYMrhcxNmHES7ivI6lbXwr7O9UHd/GxxXqr18+WHFJuEIE9UeRgZW
   zJ1MM4EUQWoiNXPZX4j8ryoCpDJ8vmxepPrgu0LhFlmONDN83QoLybf5I
   ICpk9e8q8WKxotvXcUfx63BfIUP7RqUK0RD1N9iTiSDX1CkRURt2bwN3t
   bQ0bDKyr1O+/yZik5bdT8x0PXKrQzeEM2Tw6bIUoZ3zb+0qH2p9f+MmhC
   Z+Cjd4jFVI/Q72xz7cdx9W2upsE1viMRyyRNX2t2O4MYXqNz6t7dpLQFV
   A==;
X-CSE-ConnectionGUID: /Y4liUaUR/OQHTLLDmbNPw==
X-CSE-MsgGUID: VQ8xGIjjSwOZ9cokDueBCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117024233"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="117024233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:35:29 -0700
X-CSE-ConnectionGUID: dLqXX60xTa6aFyjyQRdm5g==
X-CSE-MsgGUID: +5PdCRmSSV2cz9OIHlu/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303575625"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:35:24 -0700
Date: Wed, 30 Sep 2026 12:35:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <arzX2pzq_0JreVJe@ashevche-desk.local>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929124248.237032-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 01:42:48PM +0100, Prabhakar wrote:

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

>  	help
>  	  Say yes here to build support for the ADC found in Renesas
> -	  RZ/T2H / RZ/N2H SoCs.
> +	  RZ/T2H / RZ/N2H (and similar SoCs).

This wording is good for the summary above, but here please list what the
similar SoCs are. Something like

	in Renesas SoCs:
	- RZ/N2H
	- RZ/T2H
	- ...specify "similar SoCs" here...

>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rzt2h_adc.

...

> +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	unsigned int i;
> +	u64 scale;
> +	u32 rem;
> +
> +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> +		return -EINVAL;
> +
> +	for (i = 0; i < chan->num_ext_scan_type; i++) {
> +		scale = (u64)RZT2H_ADC_VREF_MV * NANO >>
> +			chan->ext_scan_type[i].realbits;
> +		if (div_u64_rem(scale, NANO, &rem) == val && rem == val2)
> +			break;
> +	}

> +

Blank line here is not needed.

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

...

> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = rzv2h_adc_scale_avail;
> +		*type = IIO_VAL_FRACTIONAL_LOG2;
> +		*length = ARRAY_SIZE(rzv2h_adc_scale_avail);

Check if array_size.h is included.

> +		return IIO_AVAIL_LIST;

-- 
With Best Regards,
Andy Shevchenko


