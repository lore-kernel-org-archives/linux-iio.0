Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB0518125;
	Tue, 13 Oct 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904589; cv=none; b=TPFesfHs5yJiDSN7iRuODplFNm6ZmNh4h/BEc2lCSBJLAqknQiRyAMZCFGjCc2+yq5BH4L3SHXJhx3cFLU8GmtPrmch4SWR1IjzPWJK70U9CaxTVhsU+Vkfb4BarKeRmQUZR4SPQI2Hu58uzpX/k6LwFLJlvKqvdsPNq51Y2LWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904589; c=relaxed/simple;
	bh=ekmIL7LjRSf3QW34G0hNCI8IUhuFbCGP3i3TBzqL1XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TopjsKQtQxbGeDqZLuVwmV2Rs8UpT6JzWI1PS8kOYmh+4HAcEin/TejxC+Fhz2V5io82T5MWHayU37QgIQ8xUSUiaGD7LBMBZTIcOOiCPnZNnZRH4nK/AOiQMsQSZvoWb9hWvmgScXPtfOFWVfpqDfC4ujm+Dw8XEQjS+M8kJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRvqTsjS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRvqTsjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791904588; x=1823440588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ekmIL7LjRSf3QW34G0hNCI8IUhuFbCGP3i3TBzqL1XM=;
  b=VRvqTsjS0a4MNzb+oK6B7YWsCIbpiQAw5XlqJK1Wx44O3IXXhNwQs0Qh
   5/ehF5s+gKFXm17CMNfFWYhHNxwu6dnFhmO9UCmGNTQNNd/7sEyBEUDcn
   h8NZeORoCSrEdBKF6Vf5ynIW/kOuBYgOPReIuI1YZ6bjkbUxs0/iRyRyl
   mNI1NPq0hpqKEiFmS6Rw/JvKXxURgFon1nuFhSWxnaB/Fiulxh6+KWkai
   HH3Zm+8kGEue5g7Dhi4COv38XUrrYyfOH+JRkuVKy4vxvZAvexnAle+vD
   UfJ4NOVrRz65gI44Zkltqta2XKuA+bCGP6iqcowwQVkzgHXQbMQJZkOyx
   Q==;
X-CSE-ConnectionGUID: yldZJ9vTREafa+7iQRQUZw==
X-CSE-MsgGUID: 8VWTTsUlS+GtROXkwhbtdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="506681"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="506681"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:16:28 -0700
X-CSE-ConnectionGUID: bgR5OwZoQOStBkyY7jDMJA==
X-CSE-MsgGUID: QE9sUGqmRlalTmFGgc6cKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1106742"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:16:22 -0700
Date: Tue, 13 Oct 2026 18:16:19 +0300
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
Subject: Re: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <as5LQ6zFzkft2zNJ@ashevche-desk.local>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 09, 2026 at 07:41:22PM +0100, Prabhakar wrote:

> Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares
> the RZ/T2H ADC IP but differs in channel count, sampling, calibration and
> resolution support.
> 
> The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> 20 ADCLK cycles, does not support calibration, and supports selectable
> 12-bit and 8-bit conversion resolution.

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
> +		scale = (u64)RZT2H_ADC_VREF_mV * NANO >>
> +			chan->ext_scan_type[i].realbits;
> +		if (div_u64_rem(scale, NANO, &rem) == val && rem == val2)
> +			break;

Hmm... AFAICT we can use multiplication as the result of the division is just
used to compare.

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

...

> +	ret = reset_control_assert(adc->rstc);
> +	if (ret)
> +		pwrseq_enable(adc->pwrseq);
>  
> -	return reset_control_assert(adc->rstc);
> +	return ret;

Hmm... If it was added in the previous patches, add with unfolded check and
explain in the comments that the code done this way to avoid churn in the
future changes.

-- 
With Best Regards,
Andy Shevchenko


