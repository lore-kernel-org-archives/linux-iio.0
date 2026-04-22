Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC39367F2F;
	Wed, 22 Apr 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888409; cv=none; b=XW8EFiVGcc+9wuOTY2LNBqkgoqcyo3zCQGB6EGDsW938tnelE0DsyUK19/tYCM7ucSm2islxOO/T+1C1s5wEFwRuQE07df+DU9IkU+HZ5n/ZGsOJMFsDA+eK5KfLJLD2YxfVVMuw029wDsrSp2KQVplXnOLwmyEsCCCQ/oNsuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888409; c=relaxed/simple;
	bh=ZIT81DlZ37wtYqn1aWQS5RIPAmNIvyXQ9LiCSNe+AQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFCNY54JRhfBnBGXF4fJoLYd8IYi1Qv3OpnzSmbkFgT7rTwsDAse+KmuiqWqjqR4NDZxVmYdiARHrH2+NUlQ83hITrOy93RTtGZoPimFl0JZItVz/KuG78Fpbi1urBAeFfYLJe/RSkPv3cFvsbaSEwjvFRu9+WWI4e3h6fMOVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzwOor9+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzwOor9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776888407; x=1808424407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZIT81DlZ37wtYqn1aWQS5RIPAmNIvyXQ9LiCSNe+AQA=;
  b=KzwOor9+Gs0IRQ+sLJeBfpNnBro9/fYFN84pRBlFp0uSVOtk8RRStv6f
   gwfE4bKa3+Yp8EXVwTTsFHAmAfKg3PwKPXq6eG70VDwP5vUDwBCAt8LNz
   C6DJ8HSFZcMTeC0PAJb6CvZBkS3fU8rqa2qibpjDDzQcZJnJTZobMXJf8
   REzSZRDcFNdh+6dGNxIavUZ/8DqHpRK+BVVz5oGBb4P2Mtim565kUBB57
   tsUXa618TB6dQKWZMcWGHVne9/qi41OqgD6fFQYthJgolnJ6kQGfj2IPx
   AnH86Z2AZxSKPjXo00+UOg2vD+RD3fFx2u/QaWcXlkfsD6OIHrS+qcrNh
   Q==;
X-CSE-ConnectionGUID: kEFBrbvMTNCuk3ta12e3Gg==
X-CSE-MsgGUID: p/4RmfJpQ8ekJNxH7ic9Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95267366"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="95267366"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:06:47 -0700
X-CSE-ConnectionGUID: tcFLxd7bRouv2J6+oEoLSw==
X-CSE-MsgGUID: yeoioPuOTLeu9f7RhZcchw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228108545"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:06:43 -0700
Date: Wed, 22 Apr 2026 23:06:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 17/22] iio: dac: ad5686: update device list description
Message-ID: <aekqUXej04Dg8wk2@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-17-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-ad5313r-iio-support-v1-17-ed7dca001d1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 03:45:51PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Update device list entries from comment headers for both SPI and I2C
> driver files and under Kconfig help text. Adjust comment header for the
> core file as supported devices are listed elsewhere. Also update Copyright
> notice in comment file headers with the current year.

...

> -	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
> -	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
> -	  AD5686R Voltage Output Digital to Analog Converter.
> +	  Say yes here to build support for Analog Devices AD5310R, AD5313R,
> +	  AD5317R, AD5672R, AD5674, AD5674R, AD5676, AD5676R, AD5679, AD5679R,
> +	  AD5681R, AD5682R, AD5683, AD5683R, AD5684, AD5684R, AD5685R, AD5686,
> +	  AD5686R, AD5687, AD5687R, AD5689, AD5689R Voltage Output
> +	  Digital to Analog Converter.

Still unscalable and not much readable.
Can we rather make it groups like by channels, or just by a few numbers?
(Like the below example, but I am pretty much sure it's still far from the
 better alternatives)

	  - AD5310R, AD5313R, AD5317R
	  - AD5672R, AD5674, AD5674R, AD5676, AD5676R, AD5679, AD5679R
	  - AD5681R, AD5682R, AD5683, AD5683R, AD5684, AD5684R, AD5685R
	  - AD5686

...

>  /*
> - * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
> - * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> - * AD5684R, AD5685R, AD5686, AD5686R
> + * AD5310R, AD5313R, AD5317R, AD5672R, AD5674, AD5674R, AD5676, AD5676R,
> + * AD5679, AD5679R, AD5681R, AD5682R, AD5683, AD5683R, AD5684, AD5684R,
> + * AD5685R, AD5686, AD5686R, AD5687, AD5687R, AD5689, AD5689R

In the same way.

>   * Digital to analog converters driver
>   *
> - * Copyright 2018 Analog Devices Inc.
> + * Copyright 2018-2026 Analog Devices Inc.
>   */

...

>  /*
> - * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
> + * Core driver for AD5686R and similar Digital to analog converters
>   *
> - * Copyright 2011 Analog Devices Inc.
> + * Copyright 2011-2026 Analog Devices Inc.
>   */

...

>  /*
> - * AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
> - * AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> + * AD5311R, AD5316R, AD5338R, AD5671R, AD5673R, AD5675, AD5675R, AD5677R,
> + * AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R, AD5695R, AD5696,
> + * AD5696R, AD5697R
>   * Digital to analog converters driver

Looking at the core description it let me think that that has to be in i2c and
spi cases as well. One may deduct the list of supported devices from the ID
table(s). This also increases a lot readability — instead of searaching in the
monolithic list, the ID tables are ordered and one per line. Much easier to
find if user's device is supported or not.

>   *
> - * Copyright 2018 Analog Devices Inc.
> + * Copyright 2018-2026 Analog Devices Inc.
>   */

-- 
With Best Regards,
Andy Shevchenko


