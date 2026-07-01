Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E838656D;
	Wed,  1 Jul 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897473; cv=none; b=baPJLhtPG3tKgJIeILAbWKq7fKreLe+8yp2ypo7rJKiFHnV8oyiG6bCBJr6XV1uxGeml6y6eH47NPKtgAyrTIgRlJINIGNUuUr+6x54VcClFDw0q7u3+n25jugfv5GycKFos6/NAfe8cE3PkvwHn3hf83JcQ/tYOfoSDDykzVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897473; c=relaxed/simple;
	bh=0Zlxg9qh6oluUCtOpDwy8bKgRYTStOYpmIO6zKZnn28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrf7gM6Jgtd0LGmBfECbZ8/vTlPPqxCIdnp3f97LvhJnKeMy9nI0repS14ffytWrDoQwwX+g9bWmR2AbCnOgthPEVCmL5UAXtErQodIAqKRVOR976fEJg9TNFUhSPORkZGblOCrbfP5iG5aECtz16xJcpiP38kI3A+N/LSGySd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxDbNzfB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxDbNzfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782897472; x=1814433472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Zlxg9qh6oluUCtOpDwy8bKgRYTStOYpmIO6zKZnn28=;
  b=SxDbNzfB+v8xCXNJYSEEFUPk1PcMpNIhYtcu8LNnlTZdEAJm+5KD9U+X
   KGb/X93+izS9QR4l561hK+lQYu/v3xBUW0+qXnaCbSNF5uDsIgEI0VgDo
   oDFwJkBOJ2+JzOZOLE7VMUMiEac92sqilm8rp1tsAbw1Onh0FsPk2pUtz
   cjRb0R/Aa9UFKSCwfLmPN8s0UjGKHdTTMl1JWkjyn87/G30YJs3P46xLs
   7fpKfvx9nAC2srxMYM/Dm7rBkQ8k83n4IVQCnqsftgwZzxdYflJdYhryl
   leHRxM5qx4FdeQqqf92lwK5jr0qL1nPJrzZUbBDr6MHnmWSpXZWZnBrM0
   w==;
X-CSE-ConnectionGUID: eQCa+XMlRRCD97zvXkJzsg==
X-CSE-MsgGUID: k/dadcPrSJqBUsLRIZL6ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83679502"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="83679502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:17:51 -0700
X-CSE-ConnectionGUID: WKxCTkw4S32nQXuttGwI9A==
X-CSE-MsgGUID: pJkqX2ZYR/il3iMGI09clA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="253156040"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:17:47 -0700
Date: Wed, 1 Jul 2026 12:17:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <akTbODssLM4UViF9@ashevche-desk.local>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-3-ed087900e642@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-ad5529r-driver-v5-3-ed087900e642@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 08:40:41AM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
A couple of nit-picks below.

...

> +static int ad5529r_find_output_range(const s32 *vals)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mV); i++) {
> +		if (vals[0] == ad5529r_output_ranges_mV[i][0] * 1000 &&
> +		    vals[1] == ad5529r_output_ranges_mV[i][1] * 1000)

So, the correct way is to have either defined constant in units.h or while now
(MICRO / MILLI). So, with a temporary pointer this can be achieved without
uglifying the code

		... *range = &ad5529r_output_ranges_mV[i];

		if (vals[0] == range[0] * (MICRO / MILLI) &&
		    vals[1] == range[1] * (MICRO / MILLI))

> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +	/*
> +	 * The datasheet mentions a 4.096V external reference for correct
> +	 * operation.
> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret == -ENODEV) {
> +		external_vref = false;
> +	} else if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +	} else {
> +		external_vref = true;
> +	}

All branches are single statement. No {} are needed.

-- 
With Best Regards,
Andy Shevchenko


