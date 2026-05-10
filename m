Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169E2DE70D;
	Sun, 10 May 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437216; cv=none; b=Dt+nC9Mku7nNelrhi9jyixhMmZEsfHJ4dLQ2eph853cN5qapyFvK/ZeXWeecHGrmVjilJYkQenwxT0//giCWWPxd8A6xjSsb4DSTKPy7zcD6YL3dIvnEX2ynldx59C+uI2St+Oo7Od7Ko4xOM1yydrxx/rhVyAnbFTR3XuIhces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437216; c=relaxed/simple;
	bh=E8ppbuZt4N1nON1sTQimhlSqJa/zeS+VNylMN584xf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMWhtVGby/9c12Iwq210D2vGMtLTIdFYQ3gIQZDstjuF04Lz0QAsBTn/VXPZlzvYhLyYaTjfYqF1pj0jkzQttqPbh/cVEGvdJ1DVODRIXbt6ib1563/rhQxBj0qWTl1Ai5H4oDEbLhylFBE/7Z1B/gCt7HBUjMne9iswFA9jnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoieQq3q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoieQq3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778437215; x=1809973215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8ppbuZt4N1nON1sTQimhlSqJa/zeS+VNylMN584xf4=;
  b=GoieQq3qj3W9PhjDml14Gr0ehNKaTo70jsvbUqe7H3ZTMSECIjpBmIyn
   holOioEBfIUIfhiby7wthInRxLGEjslZRGAf64O/ddaxr2n9vOieHj4Q0
   CR7sJqJ6eoEQBta8Hc5ssluwBPUW4FjmYzH4Ku8P8MVK5BQfGN8IRD3gJ
   qNHT60utoCgjXeGJbHITqo0dTiwfIlToBVjrKJIU5K4dfuTY3bcN2ROMT
   A0jYBaikmPXDjsDWIdZH+uxtsfMEGG1unuBYAxp+DL9swo+7vYK2ntowJ
   FYmQgcWb4U/QuI4P/CxmnUYEB5THdA5B7xtQVtUs/ItU14tmmwUSxU/ZE
   g==;
X-CSE-ConnectionGUID: 907B0bluTS2z/nNQgkjmnw==
X-CSE-MsgGUID: XwWPILd8Ro2eGCxdK/Et+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="78366194"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="78366194"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:20:14 -0700
X-CSE-ConnectionGUID: QqqwtE87T1aI+SclKIGOXQ==
X-CSE-MsgGUID: HqmcqqcdTKOBFOIsc9vbcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="242230279"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:20:11 -0700
Date: Sun, 10 May 2026 21:20:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: azkali.limited@gmail.com, Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
Message-ID: <agDMWcCYLCvX8vy_@ashevche-desk.local>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
 <agDMAiBUtXLamFHY@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agDMAiBUtXLamFHY@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 09:18:48PM +0300, Andy Shevchenko wrote:
> On Mon, May 11, 2026 at 01:09:50AM +0700, Alexandre Hamamdjian via B4 Relay wrote:
> 
> > Add a driver for the ROHM BH1730FVC ambient light sensor. The device
> > is a 16-bit I2C digital sensor with separate visible and infrared
> > photodiodes, four selectable gains (1x/2x/64x/128x) and a programmable
> > integration time.
> > 
> > The driver exposes illuminance via IIO, performs runtime gain and
> > integration-time tracking to keep the ADC in range, and supports
> > optional als-vdd / als-vid regulators. Per-board lux calibration data
> > (integration cycles, lux multiplier, optical-window coefficients, and
> > gain sensitivity coefficients) can be supplied via device tree;
> > sensible defaults are used otherwise.
> 
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/of.h>
> 
> Regular drivers do not to be OF-centric. This won't allow them to be used
> outside of OF-only platforms.
> 
> > +#include <linux/time.h>
> > +#include <linux/regulator/consumer.h>
> 
> Missing a lot of headers, follow IWYU.

...

> Here I stop my review and recommend you first to review others' patches and
> learn from other reviews. This will help you a lot with avoiding typical
> mistakes.
> 
> Also Matti would be the best reviewer for this as he worked (still works?)
> for ROHM and knows the HW a bit more than average kernel developer.

Forgot to Cc Matti since I mentioned him. Now done.

-- 
With Best Regards,
Andy Shevchenko


