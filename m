Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CD3C2779;
	Fri, 20 Mar 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018124; cv=none; b=HaH6syYTd4EQuPN8ajgM7/aQYyJPwUF9MwoHrZ8r0iX4M6zv9ttf17QzDZy4BHBKBC1a+xCWdqzPTkM7VGoWM4dFaeMau405mrg0YJr0+mDquD5tVugObSifZO28CQ1I7v7GHiR0nOcwZPFPzANn+0ZVUm4dFKAkdLpOigCWJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018124; c=relaxed/simple;
	bh=OG5ta8TNUJ0M6sD7PsAszRf+kOm3BqIKrdAoOVoMsOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr/hqQQU66AbGTZsRfDcCZ82Hizm+uy09Z0KkacC/y8lmnvjM0K8InzBFWPVSSSRx2qtKnTj4NxSnCss5xkzzuq2hZsoLGOEMFK7P5odSGCkoaJyo5SQEA43QV4WamubVjqKfOLa5B1QgzKVSi6/juJPjhq9oi9PbIzMiGXMOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE1+q819; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE1+q819"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774018123; x=1805554123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OG5ta8TNUJ0M6sD7PsAszRf+kOm3BqIKrdAoOVoMsOg=;
  b=RE1+q819pJM9v9i0UfSs4Y4+XKV+j1a65Ryt+BRLcKgM3g53rXHkzxC+
   9vhWMfG2B3lUgKLDF016D1U0d5dgOX6+jduNclNSxH9RRXWwGbiDrWzy3
   cdACvk92vsowG4PrEOoY8pj6d+kfpQKkLLA5x61iTmn+xYLB1xTR28XEI
   LOCx902Ry/UGUBbUm6i6QJywcylTsPAevlaNXrKiYmZc01ZcEAlFdeHIT
   FfjJKErEYiPjuaYz9NO6bKNnFpH5PoxWoQCCDD/yaCtSxr+Kh/0vz/KSv
   NLDWy0YO6//TDqIlykZFx2edaukfGPQBazguqCAIBLrj8mam/om2drHzO
   w==;
X-CSE-ConnectionGUID: P3m7lOdDQ7quptQjkSMqtA==
X-CSE-MsgGUID: L33SsF6gRYmpPOP5VThb9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="97722946"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="97722946"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:48:42 -0700
X-CSE-ConnectionGUID: VPKa9dnzTfKdyNT/LrgBCQ==
X-CSE-MsgGUID: RgKf8xR4TReXVqrXyEcUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223327699"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:48:38 -0700
Date: Fri, 20 Mar 2026 16:48:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Message-ID: <ab1eQ55b_8JiyAGA@ashevche-desk.local>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-4-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320140819.191700-4-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 10:08:19PM +0800, Carlos Jones Jr wrote:
> The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> compatible with the LTC2309 (which has 8 channels).
> 
> This patch adds support for the LTC2305 by using the chip_info
> structure to handle the different channel configurations between the
> two variants. The LTC2305 exposes 2 single-ended channels and 2
> differential combinations.
> 
> The LTC2305 requires a 1.6μs delay between I2C write and read
> operations, which is implemented using chip-specific timing to avoid
> affecting existing LTC2309 functionality.

...

>  config LTC2309
> -	tristate "Linear Technology LTC2309 ADC driver"
> +	tristate "Linear Technology LTC2309 and similar ADC driver"
>  	depends on I2C
>  	help
> -	  Say yes here to build support for Linear Technology LTC2309, a low
> -	  noise, low power, 8-channel, 12-bit SAR ADC
> +	  Say yes here to build support for Linear Technology LTC2309 and
> +	  similar low noise, low power SAR ADCs.

No, in Kconfig help text (and possibly title above) we have to be crystal
clear for user what IPs (chips, SoCs, et cetera) are being supported by
the driver. There is no go for 'and similar'.

...

> -	ltc2309->chip_info = &ltc2309_chip_info;
> +	ltc2309->chip_info = i2c_get_match_data(client);

Strictly speaking this change with the associated ID table changes should go
in a separate patch.

...

>  static const struct of_device_id ltc2309_of_match[] = {
> -	{ .compatible = "lltc,ltc2309" },
> +	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },


> +	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },

Keep it ordered by the value of compatible string.

>  	{ }
>  };

...

>  static const struct i2c_device_id ltc2309_id[] = {
> -	{ "ltc2309" },
> +	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
> +	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
>  	{ }

In the similar way as above.

>  };

-- 
With Best Regards,
Andy Shevchenko


