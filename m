Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904033;
	b=oUtinbFmwjC/xKM4p88InPvxMbLRfiBs98AZ7AOb3VTYFhDgfTWcz1oVTawDbTKkx9jP
	 o0rngSowoDMCwxGcO1oXOp/ML3JGTf3y6GKEecUvIJlSe5GnL5lrz4UGVTc/uGzfYcxXE
	 AcC+lhD+E87nUVrT0ag1huL7oB9qHItUhfmvwEuOja/YToH6FdAXq8DERoyjD0FPSAwj9
	 7G8NNuyftIiDYuudcAcRPbhzsX551Ac5jxWFRw0i7Rsrkp7PIHT+gnf0dbj03pt24YsVh
	 tOAcGH3ZzGY/DLjvw/PB1ZQSsWx8Ub1LX29E6CgQU/XQb2O6mS5UaMQ8xcGytLhLOsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904033;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Ed7iUS0U5CnvPsuOYpamrbAR5C5+fE6nd2B780j81oU=;
	b=Bqniaa3CwGSGU0u7RNkoFaWMtZccdJyeUsf8BziCw9q7tsa+viYQ2pbZpxHIvNQorL52
	 I8uF54meSMhiBo9ippPMygBFP5qfo495U1KZZWBDyJv1a0JxzeROPsPOHWNyBtWaKDKaB
	 hs186NzD2hbRFSA+oQlcNsnR60kUfV5rHK60nDCBCL6ZdRqD+e7pcNhkpUL2e51tKfzjU
	 IAVjWeq2GmnU4mbJv/v404icajFRf0aICJpeOIOKM52fPfsE/BWa5JcDdq0f2vqse+eMd
	 n7GlqLVgesrmbrajIEt1vPuHDu33pp7XvUigFvTWRxpkLzoqPbapyPglJuj1/wcxPnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h+zXrz95;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57830606A31C;
	Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57830606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h+zXrz95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794904032; x=1826440032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMXD8ZD8ryDSCMyt3FwGmokXKv5XQH3eCmXH6aPFcug=;
  b=h+zXrz95/JDaFfvlTL7OWpMdQoxG1nt0xmRHXWSnOmWtuUGn08aPCotl
   l05Wi/XBf4zMYu8yYH9G0IE7dEO5akVbkk3CZps1VAx4u/M1cDilKvjpZ
   m3aziIXNi2G/1gdHi2tm/+tzy+v86i6I0rmiuGvEejwx7MEb7UwQfBynd
   HQLQR3sLq+/4YcIS2e05C6HqWkeGjw2mER/v5U56LW58xS1iKD4xpleAI
   iuY4g0SU8FfvrA8y3Wm087QAXay9Df7UowHQ7CZVrX51M8CbputzWllRK
   fXTAgzuFYHsjnEuh8X6bsFniR9pRlLdnoK0Yv1B/ZKecRGIObNcuhenIc
   g==;
X-CSE-ConnectionGUID: G9Eka+AAQeudJIrRTAz3yw==
X-CSE-MsgGUID: cKmJJYiASriiFHovMqCxyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3774903"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3774903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:27:11 -0800
X-CSE-ConnectionGUID: Jk00HV35TASG//wsHNBoJA==
X-CSE-MsgGUID: xt88/7hFRkKbVtmnzqxi7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9853008"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:27:07 -0800
Date: Tue, 17 Nov 2026 10:27:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Message-ID: <avwP2P1zTgFteODM@ashevche-desk.local>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
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
In-Reply-To: <20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 05:59:54PM -0500, Joseph Telaak wrote:
> The AD5246 is a 128-position digital rheostat with the same I2C
> interface as the MCP4017/18/19: a single data byte writes the 7-bit
> wiper and a single-byte read returns it, with no command byte. Add its
> four resistance options.
> 
> Its resistance is D/128 of the end-to-end value, where the MCP401x's is
> D/127, so the scale divisor moves into the per-part config.
> 
> The misc ad525x_dpot driver also knows the AD5246, by I2C id only and
> through its own sysfs files. It can't provide an IIO channel, which a
> consumer such as dpot-dac needs. The AD5272 is likewise in both drivers.
> 
> Tested on an AD5246 at 0x2e that sets a fan's speed, described as
> adi,ad5246-010 with a vdd-supply. It probes, out_resistance0_raw_available
> reads [0 1 127] and out_resistance_scale reads 78.125000000. Raw writes
> of 0, 64, 100 and 127 read back the same value, and 128 is rejected.
> Writes through iio_write_channel_raw() from an in-kernel consumer of the
> channel read back as well (127, 38, 0 and 76).

...

>  config MCP4018
> -	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
> +	tristate "Microchip MCP4017/18/19 and Analog Devices AD5246 Digital Potentiometer driver"

Make it shorter and more generic, in this way you spread the same text to the
top comment in the file

- * Industrial I/O driver for Microchip digital potentiometers
+ * Industrial I/O driver for $SAME_TEXT_AS_PER_ABOVE

and to MODULE_DESCRIPTION().

For example,

	tristate "Microchip MCP4018 and compatible Digital Potentiometer driver"

 * Industrial I/O driver for Microchip MCP4018 and compatible Digital Potentiometer

MODULE_DESCRIPTION("Microchip MCP4018 and compatible Digital Potentiometer driver").

>  	depends on I2C
>  	help
>  	  Say yes here to build support for the Microchip
> -	  MCP4017, MCP4018, MCP4019
> -	  digital potentiometer chips.
> +	  MCP4017, MCP4018, MCP4019 digital potentiometer chips
> +	  and the Analog Devices AD5246 digital rheostat.

And here make it list that is scalable to expand

	  Say yes here to build support for the Microchip
	  digital potentiometer chips:

	  - MCP4017, MCP4018, MCP4019

	  and Analog Devices digital rheostats:

	  - AD5246

>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mcp4018.

...

>   * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
>   * mcp4017	1	128		5, 10, 50, 100
>   * mcp4018	1	128		5, 10, 50, 100
>   * mcp4019	1	128		5, 10, 50, 100
> + * ad5246	1	128		5, 10, 50, 100

Keep it sorted.

...

>  struct mcp4018_cfg {
>  	int kohms;
> +	/* Wiper position divisor: R = raw * kohms / div. */
> +	int div;

Why signed? Can the HW return something negative?

>  };

...

>  enum mcp4018_type {

>  	MCP4018_103,
>  	MCP4018_503,
>  	MCP4018_104,
> +	AD5246_005,
> +	AD5246_010,
> +	AD5246_050,
> +	AD5246_100,

Keep it sorted.

>  };

...

>  static const struct mcp4018_cfg mcp4018_cfg[] = {
> -	[MCP4018_502] = { .kohms =   5, },
> -	[MCP4018_103] = { .kohms =  10, },
> -	[MCP4018_503] = { .kohms =  50, },
> -	[MCP4018_104] = { .kohms = 100, },
> +	[MCP4018_502] = { .kohms =   5, .div = MCP4018_WIPER_MAX, },
> +	[MCP4018_103] = { .kohms =  10, .div = MCP4018_WIPER_MAX, },
> +	[MCP4018_503] = { .kohms =  50, .div = MCP4018_WIPER_MAX, },
> +	[MCP4018_104] = { .kohms = 100, .div = MCP4018_WIPER_MAX, },

Strictly speaking this patch can be split to two:
- adding 'div' member and providing it for the existing chips
- adding new chip support

> +	/* The AD5246's resistance is D / 128 of the end-to-end value. */
> +	[AD5246_005] = { .kohms =   5, .div = 128, },
> +	[AD5246_010] = { .kohms =  10, .div = 128, },
> +	[AD5246_050] = { .kohms =  50, .div = 128, },
> +	[AD5246_100] = { .kohms = 100, .div = 128, },

Keep it sorted.

>  };

-- 
With Best Regards,
Andy Shevchenko


