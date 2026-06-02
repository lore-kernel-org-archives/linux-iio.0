Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3E3A48E4;
	Tue,  2 Jun 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427126; cv=none; b=aBKgdKp8OL329p36nOa1qFuY//+h87Y7P1ZAkuYQI0mzMKjo4mYi376hXntjevYXi+k7zZ1HNnaOmLojK0tJ6GCzRtEo/ZQZkDzdP8afamsUDjp54oyuGJZFep8bKSoPvqvbxam67c3cl0Y0IGRp+S+d1ywxmCc88IOzLOBmZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427126; c=relaxed/simple;
	bh=puW/AIjXbe1g4c/pUu2Ti49+dlv5vy6QlOXsQmRJrjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f09h+XZ3J6JV4l7FG3Re8+4Ta+G6KKvHvSuCwAOzkoPBwvoql/7Xuv7M9eGiyYfnPb4EIdyoDRkQQdWxdhoQbpadOyJPzZJL2SvTtD1sj1+7vt9DXKDTo/QCQYKgsnvTQ5XmkH934rrwiEubI9T2WLajxfNmy6GJyI00IG7V0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjM1iBG4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjM1iBG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780427126; x=1811963126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=puW/AIjXbe1g4c/pUu2Ti49+dlv5vy6QlOXsQmRJrjo=;
  b=IjM1iBG4sI/sYF9qpUsY/1TR9iyUUkaT7QmsRteiEXJToZR9il+etZBu
   o+dL5y6HWxsQ+tIAWKdylbo0x5OtFMn3KMeLr7u21jbQDuiA0ORVO68vd
   wxgj2gYKEVJu5cBwEpImf1nSZyyZREwHbEtX2GTCZEW//IjQdWV3DmsGl
   CoVOZ2rspw9zwwLUjv+sMofBAZl6SQjSARPqnv4nAzIw2b5ae35JAJWiZ
   aMJjvnbwVrVoWoiWjrmCgw2XsuX4dxmwPPCbzm9ENY8JozJNV4f49MGSV
   vit2Xa/M0cfLOErsezcFzprKKJQLq8uhKGm1sPel0fjDVc+rDRCoY+Jrw
   Q==;
X-CSE-ConnectionGUID: Oqc9CEmIQGa60npBo9xayA==
X-CSE-MsgGUID: rLkq4K/AQDOGOwCMwF7KIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81352109"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81352109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:05:25 -0700
X-CSE-ConnectionGUID: TMObdb68RuCpr/TuHZrDIg==
X-CSE-MsgGUID: QCVh2yWEQ/i1q+vLpSnYQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237642828"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:05:18 -0700
Date: Tue, 2 Jun 2026 22:05:16 +0300
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 07/12] iio: dac: ad5686: add ldac gpio
Message-ID: <ah8pbPeqoI5xNle0@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-7-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-7-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:54PM +0100, Rodrigo Alencar via B4 Relay wrote:

> If wired LDAC, should be held low when unused (pin is active-low), which
> allows for synchronous DAC updates. This will be used to update all the
> channels at the same time when adding buffer support.

...

> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -9,6 +9,7 @@
>  #define __DRIVERS_IIO_DAC_AD5686_H__
>  
>  #include <linux/bits.h>
> +#include <linux/gpio/consumer.h>

No user of this. C-file is the one you should include this in.
Hint: The opaque pointers can be just forward declared.

>  #include <linux/mutex.h>
>  #include <linux/types.h>

-- 
With Best Regards,
Andy Shevchenko


