Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424337D131;
	Fri, 21 Aug 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309976; cv=none; b=DvWdY7Gi+Cr1ysNPu5y7CI1wqipXZa2A1yjGBtsO9+WPG7oKVBnp4YSxH80353hLzqBXcUTdziih2Txrlsk27IN/BWFlkocaesQ8//56Ei/Su4zxANBOIT2QpewK7XR7DWHCbeypOv6ZSLE3fojsD724Zwln8RfuD3LjdqNk6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309976; c=relaxed/simple;
	bh=NiBNZoot0de2KAeSBx05PmnzQzJovpDqdEg2ZGzwpVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2B70WgyahnJqYVarme0exxq1g94tSYhbJtqN1B1TMZKRm7IIMPd3pYfSChnG8CcmDSmTiUJ91FwklME3T2NiBgFhN13rUO8iVDdMruqcqgEBvOQO/Kb5kae0bnsVKiYetI41/SPmFxHNZ+Xn3qmQ5p87rthb9fV6Zx6DTv9iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS3RIcKh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS3RIcKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787309974; x=1818845974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NiBNZoot0de2KAeSBx05PmnzQzJovpDqdEg2ZGzwpVM=;
  b=fS3RIcKh7SXrh10z+A4+f/GqhJEDfKtGJ6zaRDV7iOYA+D5SjkfqoD/j
   /+ao+KOXwAAcIeDJ0rwAgGd+9heeyFZef0ML8QrIhPlvcmw23SWSpVIlU
   facrNNSBzvuiGkPhADsEFYkrEonR0dOfnOQwNzN2Dhaz97BWDLBg6bstY
   JYLTjLr2K+9YLykGH028ZnsFrqUoQUOPtUdgJCtYf4QoG1WRPOrfoJ59E
   SF2e3GAop9hMIiLeSjoBganoKF8ydNlvCRpIFo1TZYt2q/fE8/pFjYjit
   dcaUVaFNbsjo1jLGPdGw1awwUnIYOH1SEKYLy2R0tT9or/dBpNDfQAsut
   Q==;
X-CSE-ConnectionGUID: uXkErbtsQ1eikuHuw9VtdA==
X-CSE-MsgGUID: JjALSGN4TiGx8Uz0gK0Y+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105237079"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="105237079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:59:34 -0700
X-CSE-ConnectionGUID: VF39M+zFRK+ZkD3lIWv/rQ==
X-CSE-MsgGUID: r8neqL0MTaiwbEfytr0idA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="296219044"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:59:29 -0700
Date: Fri, 21 Aug 2026 13:59:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <aogvjsjOatTpiw7j@ashevche-desk.local>
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
 <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 20, 2026 at 03:51:52PM +0800, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Per-channel reference source selection (internal 2.048V, external
>   REFP/REFN, or AVDD) via the reference-sources device tree property.
>   refn-supply is not yet supported.
> - Hardware reset via the reset controller framework, falling back to
>   the RESET command when no reset controller is present.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	/*
> +	 * Datasheet: td(RSSTA), the delay from the RESET rising edge to the
> +	 * first I2C START, is 100ns minimum.

This is order of magnitude delay. Do you mean 100 µs? (Actually would be good to
use Greek letter in the units, looks much cleaner in the comments.)

> +	 */
> +	fsleep(1 * USEC_PER_MSEC);

Otherwise this should be simply 1 (no multiplier).

-- 
With Best Regards,
Andy Shevchenko


