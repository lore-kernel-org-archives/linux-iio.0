Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243D4156F0;
	Thu, 24 Sep 2026 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274134; cv=none; b=TItAoq5tDwIkQeAopUqbbt0tvZlzy2u4AfeamBizXHmAa+2p8tIxTATGD8kTaegB/5YCPWQSxEHKowM7ukK2ZKUmLvTVnfF3WSnZ1cNP918cjVxsrNB99zeJlC7wQYxGXa2bCQ/x2f1ATYJnR5MEGZVeixf74nzRXGEKdZihUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274134; c=relaxed/simple;
	bh=q0eaopFOAWSDHlYn5l7W04BqZZoq89xUqr5KKrSkYNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE4zM26JlNZOVCjN6KPhT8Hrku//NB8ABCSSNoq2JYaEdbojjjtdrU4nkSeDxk80px6lbuzVwu2Lq9IiW0MoDec2NJCW5YrW0QrEFtpZMjfw1dd2CEJhCBHk/EomjLjvn991gLRg9GKYO5hyBQVQaRWOidPPvd5rxukhqE/f/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMr+Qlgg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMr+Qlgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790274132; x=1821810132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0eaopFOAWSDHlYn5l7W04BqZZoq89xUqr5KKrSkYNU=;
  b=mMr+QlggIIIwPU46ryDcnyoGcNgQXviSUCsLRgSFOZkwUyCLbRVXpiBu
   N/kT8aVHLUJFkuPTsC3607VoA/m1VWlrpsMSIUv/HPBKapu7rcEuxvg5z
   TtDHdubn21VUv4jmdZCXHMzxQpHPRnxIO3dWMpwqRQVPemj8gglcDoIy1
   ZFcx2jo8nKr2DocNrzEQiDnmlabac6yLSP1Mw9p8N461WiG9tWwY7HBht
   vVJ834Ydffm1KwC+moUm6F2KX4rQYcMQa8wkKZGanfwTBtg3EuXI8Z9mr
   /jIDqmkHySGGVs9MiSrKaPPcC01qFoQ1WlD1Ptjp+hawKs22PDsQr5hyR
   w==;
X-CSE-ConnectionGUID: rdFYylGeT5OTvd8ZTzFf0g==
X-CSE-MsgGUID: q17vPr/PQguZAgwqQ0eOUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90120638"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="90120638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:22:12 -0700
X-CSE-ConnectionGUID: FqnfOOLOShCzeYC9VC7EYQ==
X-CSE-MsgGUID: Efw1IqdETSOW4aZzrApbKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="302034433"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:22:07 -0700
Date: Thu, 24 Sep 2026 21:22:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <arVqTWVw-eIZEcrR@ashevche-desk.local>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919235145.48273-3-marcus.yu.56@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 19, 2026 at 04:51:45PM -0700, Chang Yu wrote:
> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.

...

> +#include <linux/build_bug.h>

This is unusual to meet...

...

> +static inline u8 as7343_atime_steps(unsigned int step)
> +{
> +	BUILD_BUG_ON(step < 1 || step > 256);

How is this any useful? The step == 1 gives the result 0, the step 256,
255 respectively. This covers the whole range of the returned variable
(u8).

> +	return step - 1;
> +}
> +
> +static inline u16 as7343_astep_x2780ns(unsigned int n)
> +{
> +	BUILD_BUG_ON(n < 1 || n > 65535);
> +	return n - 1;
> +}

Ditto.

...

TL;DR: I do not see anything meaningful from these BUILD_BUG_ON():s.
It's not a problem if the result gives just wrapped-up value. Or is it?

...

> +static int as7343_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	int channel = chan->channel;

Why signed?
Also split assignment, it will make code more maintainable.

> +	if (channel < 0 || channel >= ARRAY_SIZE(as7343_channel_labels))
> +		return -EINVAL;
> +
> +	return sysfs_emit(label, "%s\n", as7343_channel_labels[channel]);
> +}

-- 
With Best Regards,
Andy Shevchenko


