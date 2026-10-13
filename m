Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F155208A9;
	Tue, 13 Oct 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910762; cv=none; b=I/vKKP0eRkneUfZOOGK4h0F0Svl04Bfru6T6/69BmAapg34WPn2iPE70JeuH7E+HCz8ZA9AFf4Yc+aaRs3MHrMyEVwhdFyNRZl4SoJganT2zs0BDHyuS/plDsXT+75zgdjIgrqsWFebnxGJD052owgpn03S8g5vODVidmuGCy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910762; c=relaxed/simple;
	bh=iZwcWXW9P1s2FGcBHBY8OWwVOV8yIE8tuCxLW32Qpjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVeQFOHkwxHuMVkHXSRxCrR7qWV3Jo0wxdoRohYMF7MoZ4glldzfcna78KHQO7SGYE0aCNRiT4ootrHwbr4vQH75GUhipqLfbPurmtzu29RHgHExXcA4znVPMVEItlQKChePp4LdcQaSu6vNewffB9N/Cd+rYxsVIMgZyCgCMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyP4vueB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyP4vueB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791910760; x=1823446760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZwcWXW9P1s2FGcBHBY8OWwVOV8yIE8tuCxLW32Qpjs=;
  b=QyP4vueBtRk8GlsW04Q1R3IuC3NQR8wjk8dkO3NE0HE9K6CXeK+JXsxt
   rC9OLnGR950H86Q2PGyuLUADHlr+PC7TEgH0nWZB/SMPh+DUudzNVsr+2
   XWs5B8QmaiZCceEfc2yr4DAfHXA50sYTHmdDcSY2iOoCCmLFv83N5E9LM
   N4pZEzsjy4UH6i9dFyYd9L+MRnxt7j5mQUD2HSNOuMsDZ27weh+QtMjod
   WhumKMq16wc4MC+j1hVsq/MeX+4uQqZW/QzdJrF4+1VW4KFVXkqNd/wBc
   Xg1t0ec3bxU3f7f1Eg1Yc4CWrh93uOkbcszrhSiN1vqT4jvEbOxmA8EIm
   g==;
X-CSE-ConnectionGUID: DHPhrAPMR7Cs++BxpH10zg==
X-CSE-MsgGUID: IjsXISVeQi2CqRjCnnLF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="530703"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="530703"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:59:19 -0700
X-CSE-ConnectionGUID: yeQrbO5FQVaXF7XDvrw0MA==
X-CSE-MsgGUID: MYBPdhK7RtCYBfQ6CPBcVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1551482"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:59:15 -0700
Date: Tue, 13 Oct 2026 19:59:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: dps310: add Zilltek ZTS8032 support
Message-ID: <as5jYcTlEuOzD6go@ashevche-desk.local>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
 <20261013112124.1878296-7-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013112124.1878296-7-paulius.zaleckas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 02:21:24PM +0300, Paulius Zaleckas wrote:
> The Zilltek ZTS8032 has the DPS310 register map, scale factors and
> compensation, with these differences:
> 
> - two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
>   c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
> - TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
>   the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
>   bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
>   25/16 Hz background rate instead of the external sensor.
> - product ID 0x11 instead of 0x10, the driver does not check it
> 
> Add its chip data, reading 22 coefficient bytes and leaving TMP_CFG at
> 0, and the I2C and OF IDs.
> 
> Tested on a ZTS8032 at 0x76 over I2C: in_pressure_input is within 1 Pa
> of the datasheet formula evaluated from the raw and coefficient
> registers at every oversampling rate from 1 to 128, and TMP_CFG reads
> 0x00 after probe.

...

>  	help
> -	  Support for the Infineon DPS310 digital barometric pressure sensor.
> -	  It can be accessed over I2C bus.
> +	  Support for the Infineon DPS310 and Zilltek ZTS8032 digital
> +	  barometric pressure sensors. They can be accessed over I2C bus.

Please, format it to be scalable:

	  Support for the following digital barometric pressure sensors:
	  - Infineon DPS310
	  - Zilltek ZTS8032
	  They can be accessed over I2C bus.

>  	  This driver can also be built as a module.  If so, the module will be
>  	  called dps310.

...

>   * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
>   *
> + * The Zilltek ZTS8032 is register compatible, with two more pressure
> + * calibration coefficients (c31, c40) and temperature calibrated against
> + * the internal sensor.

Any datasheet link?

...

> -	u8 coef[DPS310_COEF_LEN];
> +	u8 coef[ZTS8032_COEF_LEN];

I would add

#define MAX_COEF_LEN	18

to the first patch along with the HW specific define and use here (in that patch)

	u8 coef[MAX_COEF_LEN];

so, in this patch you will just add a new HW definition and bump

#define MAX_COEF_LEN	22

...

> +	if (data->info->coef_len == ZTS8032_COEF_LEN) {

This is a bit fragile. What if it will be HW in the future that has 22+ size
but incompatible with ZTS case?

> +		data->c31 = sign_extend32((coef[18] << 8) | coef[19], 15);
> +		data->c40 = sign_extend32((coef[20] << 8) | coef[21], 15);
> +	}

-- 
With Best Regards,
Andy Shevchenko


