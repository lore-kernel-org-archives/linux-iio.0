Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A219D07A;
	Fri, 20 Feb 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583536; cv=none; b=YUXj4NCl7iSNNJXAvrP3E+867BpuGr5Rfx5Xhc7jVv31RCjJjwWnYAgG9hwtINR/OPlT9dGwl1Wcx4GVJBsEbZEPMQlsGt0x5VXEjvsWCSG5j0H1REjxW2TiHfgMpmgzRg+9qV+v6M8iLf8DzRrzQI3SP/TzMY4Fs0dKJTt2EhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583536; c=relaxed/simple;
	bh=izOszyZ0PL+gLuOygoLMHD/rSH5k99mu8J6k5Xqzz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYP3mG0vntnA0v/36yvociQXqXB7HQcIbD0bbi+y/SyzYL8bSEZEf6DU4T1xYZiXJ2z1a3AEPrB/LZoXVgtJ4g9PNWQFovWeZyyggb9StcbbQZi5KvlTXYHEMYMR1Ztp2YNvJKD+MMPLfMxJE3tj9+e8HQOF+42ZRcbqFzudNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8bj/pZp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8bj/pZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771583535; x=1803119535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izOszyZ0PL+gLuOygoLMHD/rSH5k99mu8J6k5Xqzz+o=;
  b=B8bj/pZpZ9uQp3vYweub9K1QB3AYR1pbA9m/EGnIPbnraEPqfqNYygn/
   hqRsYhEMOg79YvK8cnbjEvSWegugb26u7ZlQF3SBI4zSQY6vMlLutv+h+
   /I5gU59wVKZXcZE9nWPWe+WiJvDqrvGfYg/q13Zyk3CLIqpIYJNJmOGuM
   ULvdz8QkhphO7QVVVm5dTyVQSaYy4qDIyaLuy0MHNyygGOXnJNMm33hVv
   miTCWXEcojBMi3jMu1AZTnhpQq33XSgOpjp9r+uBSFou8vlgXMKJuNpx+
   YaXQdZc+1sQ79DVPQ/nJd87uLWq5zMiKWnACb0yjkwOkEkX6fEjPaQoy9
   w==;
X-CSE-ConnectionGUID: E+sToR/mRyC1bRUo4SyWLg==
X-CSE-MsgGUID: 7V/C4RFAQcejeoXobCHIfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71880941"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="71880941"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:32:14 -0800
X-CSE-ConnectionGUID: lG8QlSvFSpKVOIGzNWtxwQ==
X-CSE-MsgGUID: +TgXSV34QzGgSeZgymbLZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218949595"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:31:52 -0800
Date: Fri, 20 Feb 2026 12:31:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for AD5706R DAC
Message-ID: <aZg4FRx9z4ObwJ7q@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 04:02:55PM +0800, Alexis Czezar Torreno wrote:
> This series adds support for the Analog Devices AD5706R, a 4-channel
> 16-bit current output digital-to-analog converter with SPI interface.
> 
> The AD5706R features:
>   - 4 independent current output DAC channels
>   - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
>   - Hardware and software LDAC trigger with configurable edge selection
>   - Toggle and dither modes per channel
>   - Internal or external voltage reference selection
>   - PWM-controlled LDAC
>   - Dynamic change SPI speed

It's ~2300 LoC file, please split by features, so the first patch brings basics
and a few followups that add the rest.

> The driver exposes standard IIO raw/scale/offset channel attributes for
> DAC output control, sampling frequency for PWM-based LDAC timing, and
> extended attributes for device configuration including output range
> selection, trigger mode, and multiplexer output.
> 
> This driver is developed and tested on the Cora Z7S platform using
> the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
> enables dynamic SPI clock rate management via the CLKGEN.
> 
> Datasheet: https://www.analog.com/en/products/ad5706r.html

> 

No blank lines in the tag block.
(Not sure if `b4` can spread it over the series either way.)

> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


-- 
With Best Regards,
Andy Shevchenko


