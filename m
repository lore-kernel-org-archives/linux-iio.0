Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02E19FA93;
	Wed, 25 Feb 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018960; cv=none; b=IwAv5EJ6b3WQ9GQNH/41s33vemO/qlO9Vs8fOw4NhrJPKH2BlMb3/3wDPD6DzOzsFtB1DmTau3Fj97TS2f33SeyHKK0abFAxZz06MyuJdehurnFqohcvBWB/uAE3ZrHnjgHGjp0OL1gis8bD4bV2kA0gwWbF/hYziID8g8T8zH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018960; c=relaxed/simple;
	bh=nmpB2c/65klhd1mwJ54wHKaWRCDRETjbp8RuXBnKG98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OINobcFvMxYFkqQUAFEpj8G7H++G8s7dO8Jfuq26OFcyotFgyUKQ63ZhyNqsqL16rgyPoQi2bJchPGYHmNFGPjkxGsjUuMOQSpubBRMGfazaA5klVNubuIemn5NbnidtNmfZA33owMQEdXc5qBzGFZ6PtDz3XtHcHqY7IZfl9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtaXSFpn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtaXSFpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772018959; x=1803554959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmpB2c/65klhd1mwJ54wHKaWRCDRETjbp8RuXBnKG98=;
  b=QtaXSFpnn6JDY6FH1UKfp3xquKC/lOnQOnOhltrRuUjCgCq71K6rBew7
   8JyUTBtg1m2QlWLphJ8p37UUsyxfZVE4iZHC1azl4HzutNQQnbXxXyII/
   uPIvBh7h1TqkdEXBjtC5ZweiXxl/6QSRuwQSbk0RVBbuudjVmZEKxbA2b
   XjZoFJ9M2EEBna4Z5dCvlNEcAo9sheiW8BUyUKBkw72qde1RmAknkqOkB
   TtTOSRgp6tGa3rUsE74uTR2rwV9m/ldt9hG5EYF/7aAUrpkDQyPSmBzsC
   TV6JR50EATnMEugde1HGAqPBXBoPaaQ3QJX3a0hScdth0kOxNyVRZqTbc
   g==;
X-CSE-ConnectionGUID: +kvarfD+RDONamebA3COFg==
X-CSE-MsgGUID: F90VH5pwRxG0eiPZXpp6TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72929088"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72929088"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:29:18 -0800
X-CSE-ConnectionGUID: 7wwAt+ZuQyCeia1hedJC3w==
X-CSE-MsgGUID: 2hX6jd1WTkGG2Ot5F4b7Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220332687"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:29:16 -0800
Date: Wed, 25 Feb 2026 13:29:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 5/7] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
Message-ID: <aZ7dCdLs5xcJ4UGW@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101748.2368295-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225101748.2368295-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 11:17:47AM +0100, Francesco Lavra wrote:
> In the data storage description of a scan element, the first character
> after the colon can have the values 's' and 'u' to specify signed and
> unsigned integers, respectively.
> Add 'f' as an allowed value to specify floating-point numbers formatted
> according to the IEEE 754 standard.

Main Q here: How will behave iio-tools and other existing user space when
it sees this? Shouldn't you prepare the user space first for such a change?

...

> -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
> +  Format is [be|le]:[s|u|f]bits/storagebits[Xrepeat][>>shift] .

I would probably keep order as [f|s|u] and...

> -  * *s* or *u*, specifies if signed (2's complement) or unsigned.
> +  * *s* or *u* or *f*, specifies if signed (2's complement) or unsigned or
> +    floating-point.

  * *f*, specifies if floating-point.
  * *s* or *u*, specifies if signed (2's complement) or unsigned.

...

>  - **be** or **le** specifies big or little-endian.
> -- **s** or **u** specifies if signed (2's complement) or unsigned.
> +- **s** or **u** or **f** specifies if signed (2's complement) or unsigned or
> +  floating-point.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


