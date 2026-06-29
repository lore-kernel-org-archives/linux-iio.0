Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298938E5C4;
	Mon, 29 Jun 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712575; cv=none; b=UXwvCT0MOuvd+y2LSEFb7RIG7D0pvQ3dfxt3zbt4gKKeXNay9NKYsNSgQI7e53ijE83UxB2RsKir0KBBc8KlZV0ZLxfjYczVLLwf3d+06iHTGPsjENjpcG+BuOqhuzHJXo5KEjsjXHEWQx2b3GpUN1I1Zw3TRXUTwR3xIimSJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712575; c=relaxed/simple;
	bh=NvCI8xSXBkSFzYgxj1c8fc1UUuokXOioekXBgeG0es4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzAZ9gexaHdFm/B5/lrfyORpUPUY7z8o6WXQHeImanyD2/6VBIEUptddFUDyRDE4hKrl5u3dHYvfAOVlqJmjIi3GJSEffLonIaju0VAZWXbw0/wlObsyeTLVRg172bfIiz7nRaitFYKglyTxxDTPptSUdzIrMI/XIGRUgL6ASF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSr5suvX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSr5suvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782712574; x=1814248574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NvCI8xSXBkSFzYgxj1c8fc1UUuokXOioekXBgeG0es4=;
  b=PSr5suvXD7MoaVuqzEL4CLxDVEJ7JIwzgr//4U2wJkr+6OMjASBeL/V0
   N1E9QFR1wTEr6ViSWK3LBeP78UU8KjKn19XvEcyssGX5swKsaROJvKp8N
   j+6xz/aA0xn/ot2UZ3hdBHMaKF9nUOmmRXahvtkKo+zvSOc5ogzOWiJuB
   PNGoRq4MbRFAdLl6o73CX/10QI8vrAXQ0poNSwVWdZY7qaAlNjs/H3hV7
   IZQjVaTYc5RZ0vyuvLtai9nC+/zz28LBxrgNmNSDBeOBCg2ZVtvN7pnHD
   kzTvQBVqQO5ibjGGJYPeYb3Ln14p5LBpv5WMpzPtfRsKw7pItRHkOcqqM
   A==;
X-CSE-ConnectionGUID: SFm9c5icTDiXhBRqcVpYdg==
X-CSE-MsgGUID: pl/F82foR2WqbkrWm28aLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="100934572"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="100934572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 22:56:14 -0700
X-CSE-ConnectionGUID: dx3E/cpyRciiRW8hkHN+Yw==
X-CSE-MsgGUID: lqonxQIRTNeedec9PYRqRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="248496217"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 22:56:10 -0700
Date: Mon, 29 Jun 2026 08:56:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, julianbraha@gmail.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 4/4] iio: adc: ltc2378: Enable triggered buffer data
 capture
Message-ID: <akII98e0oteX8rB-@ashevche-desk.local>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <a98804f122b7c1d1c159ba20060a250ebe2caaed.1782397418.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98804f122b7c1d1c159ba20060a250ebe2caaed.1782397418.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 11:35:59AM -0300, Marcelo Schmitt wrote:
> Enable users to run triggered data captures with LTC2378 and similar ADCs.

...

> +		indio_dev->channels = st->info->chan;
> +		indio_dev->num_channels = ARRAY_SIZE(st->info->chan);
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      iio_pollfunc_store_time,
> +						      ltc2378_trigger_handler,
> +						      NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to setup triggered buffer\n");

In 99.99% of error cases this will be -ENOMEM, so this is a dead code
effectively. Please, drop the message, return ret is enough.

-- 
With Best Regards,
Andy Shevchenko


