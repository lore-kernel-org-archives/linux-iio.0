Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485F294A10;
	Sun, 12 Jul 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839501; cv=none; b=TPC+vUPG8jQzyJo9YNJ1KQChW7aVGmc1mu+RyPrtq3pbNK9XB1GM0zWNUiUVbl3Fz32hKXp4XVWjgf7YUTpXtvMWs1tW6XO/RHwNJCim7TjTz+OabJbiwhsYKw9pY4LegBJH3yh61VkMR3Px1KsrgLLDU/lMLcdSXJAC+ohJw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839501; c=relaxed/simple;
	bh=rgDOrAsS86/dLcVCS9PYTZAKJLYdoNb2JKbq3HQwBsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpS8tcqGobC5zkty2u3UreohFss+dLWF98/Q0VYGHSmdGCMVZOEKX1fA0lWcOTwZUVO6dfUa5z5eLGV6Y5+1eWu2YIXJ52RzEe5sjwSgVfjp5kvRLQgUw1H/ZqEbj69gLH45p1GFpS9OnkoAGxJ/Z23sigQPUyuB3sb3iGbS0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAtiZkaf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAtiZkaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783839499; x=1815375499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rgDOrAsS86/dLcVCS9PYTZAKJLYdoNb2JKbq3HQwBsk=;
  b=hAtiZkaf7HPmQGFSeiE4kIxP5o35pIaCTc2dgkdDTH7QpEwmVOgZe+IC
   MEqOZnRnoh6s3EIwNnC3wCZng1cmD0csCNWnNRbTPu6Yxw4A2i8/IkqUw
   KyBag6uNM+qVdNnRBm32LHorDJvyb/ZLYj/LGTqCTtuL1IIxVWAiIFvn2
   TTdzRlkx0J88Qh1brjkRROwdbtqNk3R7NTRZRGMLpMDUGtRyU6S6s9qPD
   AKVshNiX7ywzySX07JzT2Davf1G3T16KrYfcvADGv9vmG4aOm5P/GpA+t
   OxmKHBcUoZnjJr0lRDf1Tp1FJ6ISsYP2Y37/fpHZCHd8pH9eLXQYpP1Ib
   g==;
X-CSE-ConnectionGUID: vPrpqp2mRY2fIvNnuYf1GA==
X-CSE-MsgGUID: pUDzhoKQRdOp9+p2Js5vSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102034113"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="102034113"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:58:18 -0700
X-CSE-ConnectionGUID: SamUlIaaQsSiV9rq/wnGLg==
X-CSE-MsgGUID: 2T14nhQ+S3mYbjtqSwlj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253511955"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:58:14 -0700
Date: Sun, 12 Jul 2026 09:58:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] iio: dac: ad5696: properly check i2c_transfer()
 return value
Message-ID: <alM7A8m85ncku2VR@ashevche-desk.local>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-1-1bcc8c280e4d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-ad5686-new-features-v7-1-1bcc8c280e4d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 12:20:45PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Verify that the expected number of i2c messages were transferred when
> ad5686_i2c_read() is called. This issue exists since the support for I2C
> devices where first introduced.

...

>  	ret = i2c_transfer(i2c->adapter, msg, 2);
> -	if (ret < 0)
> -		return ret;

No need to touch this.

> +	if (ret != 2)
> +		return ret < 0 ? ret : -EIO;

Make it use standard pattern:

	ret = i2c_transfer(i2c->adapter, msg, ARRAY_SIZE(msg));
	if (ret < 0)
		return ret;
	if (ret != ARRAY_SIZE(msg))
		return -EIO;

-- 
With Best Regards,
Andy Shevchenko


