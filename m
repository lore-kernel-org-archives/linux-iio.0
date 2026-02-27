Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453C3EDAB1;
	Fri, 27 Feb 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208377; cv=none; b=CE/Ye45brkps9lg/VKljZ/KFcTBn6GPlYhiG1p886P1ywgyl4JaEbE1sYN22TyE3DWxYOke1UvI23Ry3qG6F7sr6+Bu87UPQwu0MlLxEd0WGsU7EB4Ji47AA4ZFAFKtSXFfMg+K7T2pOP0cJnFnZ1jD+xO0atohFQrOs/GAH/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208377; c=relaxed/simple;
	bh=iTAAzM1avpXnPBGkx8yvf1lPZJlOyGHY2e/LUkrW6hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+zQOIZRvdizOaWT8OvJOEzbv+wzd+ZO1Vv9MFgRYJmaJmqihce0onCpy8wI8NyT7gZqjNtKsIhDyUR1Jzx+RGcUdvKngwa7t7lJe6ooUqzZYxB2NkmEwx8BtPxcszHwkcgzcj5WD6xhccTPDpy1/xjss2nICFOtb9DRi8Z2yUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axwW28oo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axwW28oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772208376; x=1803744376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iTAAzM1avpXnPBGkx8yvf1lPZJlOyGHY2e/LUkrW6hY=;
  b=axwW28oodwJE7kS+mUphdSdJQnki1fOy/5M7kb2xzDVlQe+MemHZntOv
   x11YKMGUmr+cR3Ox6JqEEXj2Rz/JjzOGrxI/V1WktvfDOu7NzR46OgnJP
   U+Lv6MnTE3Wu7vN56NaVpGq8p+4AqG7gETImcU/06NIbqxZrtMoCB5Td1
   qI7JQqODYFL7mbLgaUf/1QPfQ08OghWJc451jJyHOLnChxt/ZsDucfii6
   z5WXTqauBpHv9VubpvmChAYytYGferywnlYiYxt1yC5Tsgndaj5HUnHVI
   oe3j0b3ODZ4B8N2GM5Jsyi63faTmWk8Yof+QRU+DMgBzj4OgaA60gkfDK
   g==;
X-CSE-ConnectionGUID: 2suwgJdBTbmnWvkkiqpKdQ==
X-CSE-MsgGUID: +gxphB2PTBacuJ7LqqFF/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73199155"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73199155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:06:15 -0800
X-CSE-ConnectionGUID: siXcsySVSlO15CBmGdCtVQ==
X-CSE-MsgGUID: OMTioz5sTYCPiJYaCqaaag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="247448100"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:06:12 -0800
Date: Fri, 27 Feb 2026 18:06:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ammar Mustafa <ammarmustafa34@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs: iio: ad7191: Correct clock configuration
Message-ID: <aaHA8U3HrIbg8D46@ashevche-desk.local>
References: <aaG6Rds7GAf9ZtF8@ammar-VM2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaG6Rds7GAf9ZtF8@ammar-VM2>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 10:37:41AM -0500, Ammar Mustafa wrote:
> Correct the ad7191 documentation to match the datasheet:
> - Fix inverted CLKSEL pin logic: device should use external clock when low,
>   internal CMOS/crystal when high.
> - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.

...

> -- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock property
> -  needed)
> -- When CLKSEL pin is tied HIGH: Requires external clock source
> +- When CLKSEL pin is tied LOW: Requires external clock source
>    - Can be a crystal between MCLK1 and MCLK2 pins
> -  - Or a CMOS-compatible clock driving MCLK2 pin
> +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
>    - Must specify the "clocks" property in device tree when using external clock
> +- When CLKSEL pin is tied HIGH: Uses internal 4.92MHz clock (no clock property
> +  needed)

Is it active-low or active-high pin?

...

When I see such a confusion in the documentation I propose to replace HIGH/LOW
to active/inactive or asserted/deasserted.

And no need to swap the entries.

-- 
With Best Regards,
Andy Shevchenko


