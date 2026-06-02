Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DC3DA5CC;
	Tue,  2 Jun 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428308; cv=none; b=qUrqExUPjZa3qEolNPzbduXoEBFGZ4BgZtzK1YYp48EnrZBKR9zI2szOunwCwhKRKoH7iVKy0O4Zg41vUzt/zh81YKAVCMM0x2KWEZd+Bt/gzdiWfU+wVJQpSHbraEaC+Qg+qIv3rWCYH9DKwIpHs2P+cmCxpgSR4wKDNoK9TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428308; c=relaxed/simple;
	bh=CYbH0yVj2XfnWEyIk/a1RKj1wsS3rr33TvTrfpTAetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLvI+flZTOLFNrHFMqNO6coEqa7gAhxZL/qHSfWOOOMKxrLUuHj8hVslnmE1luUF4GW7eQl4l+VwiLHnu2uv3AEJY0PTuf39PuVKcjpcQtx2+QjHSo0yw78AYBOg6N8YKm3d7iC2PBN2GMHVaD3hXAIdW51w8IRNKiS9m9AoW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bs5oFGD0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bs5oFGD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780428307; x=1811964307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYbH0yVj2XfnWEyIk/a1RKj1wsS3rr33TvTrfpTAetg=;
  b=Bs5oFGD0F4w9QYoDEF42RSYGtJsHqAkVKGmWF46zlQ4EnSGyxIx5e0Zz
   GTRWoH+bCfpMIS0lhAZMUexMH4e0mjt9PS3X+M9DrhTH36hYEHvHiZAyZ
   g4QN4Cz4QdvUrfjDnp5syxcWKGA5z81IFdcTw9IQ/FW5m4WdLOihBFxk3
   xw8pHA3I68xstSRm9YUgRJQUt4v1vU/CLIEDZlhnnEutTrD0u7TEsWqrw
   PaZckrKPeC0ORNmHEagoK/PGgeTVKCeKqNAx/BeFcieiwLDiEtDFs8q+p
   Cy5SXNH0QSHnxslOsTkl1jkWmdzQoRGf3yrP+Z0Zdb0gMQYxrsVAbYgSk
   Q==;
X-CSE-ConnectionGUID: lV8itoXpTOunWKeLdfgEHg==
X-CSE-MsgGUID: 0f2etNluQZy9A6vzU63+dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81353541"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81353541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:25:06 -0700
X-CSE-ConnectionGUID: ZkoG3PvBRJeTB2PTqHF9NQ==
X-CSE-MsgGUID: J5ahwNB1RaO0O0C87NJXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="244082435"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:25:02 -0700
Date: Tue, 2 Jun 2026 22:25:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 12/12] iio: dac: ad5686: add gain control support
Message-ID: <ah8uDJJBq905oDx8@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-12-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-12-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:59PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in the
> control register. Some designs might have the GAIN pin hardwired to
> VDD/VLOGIC or GND, which would still be fine for this patch, that allows
> the scale property to be configurable with two available options.

...

> +	case IIO_CHAN_INFO_SCALE:
> +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> +			st->double_scale = false;
> +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> +			st->double_scale = true;
> +		else
> +			return -EINVAL;
> +
> +		switch (st->chip_info->regmap_type) {
> +		case AD5310_REGMAP:
> +			return ad5310_control_sync(st);
> +		case AD5683_REGMAP:
> +			return ad5683_control_sync(st);
> +		case AD5686_REGMAP:
> +			/*
> +			 * even if the gain pin is hardwired on the board, the

Even

> +			 * user is able to control the scale such that it
> +			 * matches the actual gain setting.
> +			 */
> +			gpiod_set_value_cansleep(st->gain_gpio,
> +						 st->double_scale ? 1 : 0);
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}

...

> @@ -138,9 +143,12 @@ struct ad5686_state {

Have you run `pahole`? It seems to me that those bools can be combined with
vref_mv to reduce 4 bytes gap.

>  	const struct ad5686_chip_info	*chip_info;
>  	const struct ad5686_bus_ops	*ops;
>  	struct gpio_desc		*ldac_gpio;
> +	struct gpio_desc		*gain_gpio;
>  	unsigned short			vref_mv;
>  	unsigned int			pwr_down_mask;
>  	unsigned int			pwr_down_mode;
> +	int				scale_avail[4];
> +	bool				double_scale;
>  	bool				use_internal_vref;
>  	struct mutex			lock;
>  	void				*bus_data;

-- 
With Best Regards,
Andy Shevchenko


