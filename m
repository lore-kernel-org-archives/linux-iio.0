Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407983;
	b=hp1z8WG7CkwFM9cIfAmlG5o8co3FJkxOxz/qkP1jdnVZMqjzTfXDRig3jNAy2ndi57Hz
	 g7wJWAdaWpqJULGFGhX1g+FQCBMxhYMc86oaEW3eRyKWZPPGl47oXir8rXYHLOYfxvtei
	 6HPoa1a047rtgrwjIbpy2YJ3PNGFd/2DUTF8dM8lRhtWLXLCZGJkpEejVTkmlkkZeS6Sb
	 wmO7P7US/kut8MDNWCqKm/Awykfp35s2dJ6g9HzZ0iHkNEi+U4MCp8KEBZ03bIzaulkMV
	 gNofGJ2DQOeUs3FVHcxIlh1AOLfTMEWLjfS69JQPJ8p0xvPx2nems4aQs8GOGILH7Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407983;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PZuSeEw5gKgjrhc7pmpD/7ZvZbd7Pher3TMM1GaWe58=;
	b=AGVNR6xW/Asjc8SNOI2/8EQsl/rKSxAMKeO3mv280oGDyLUZN7dYAI60LpJTKsAJHa8d
	 nbF+FdslcyrYHzlZOmZfyPM048EsG6Y+L2QuUPFuQQJeUnKDP3S3MhVcIktGh2PUru4Pe
	 Tpf66tg06gLFd1AM2Jh3CTWoP4Ho1+aj9XfLR3EWSMyNbzEqCWLr4Lsln4pGfTDxh8urE
	 4xI/Il1aqf7UIVBE30RQPM7vJIuugrb1SpRlA81GFjSO6/IML1s9BUNdK6r/YTS9v5oaS
	 n/QM4M/I2YkLahLfaIMBL6/JGxfqzBVo72cpfE4vkhPMq40o/5wDgnnzB9zV/NA+Weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cL3NEJka;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA7606A327;
	Wed, 11 Nov 2026 14:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0DA7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cL3NEJka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794407983; x=1825943983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m/mxqNQyOZsf3BKcIbzdVgfwzzv2uTsmpPIvY6eXe0w=;
  b=cL3NEJkaUHxWM4cIdiBLtL6cpMYIV4x0gWbTl4TEidA66LxlOP+5y4Kb
   /Gu02zNOtuY4Oe9lpermiYZ77bJQy6hkEMaGpVfrSAK62+I9e1dn/1oot
   bKuPQrD1mclD2EZo5kIBD8Gcv59iZvjLJlZrAqVadHsybgyF9nqbc8Ww9
   kpH44rQsa6L/2OrplYpYtrBr7h455ePufVl2E/u2ph/s8Z5iAGeeMrFdQ
   y3xGNSOEFHJ9z4NSi1L7UF/IGFU3XVaTMl3tX3lCKF/8fPDfUs1q9fZLs
   mVPRjPJ/NHkFUj4iPmmjDmijZANWznL5+TZsrC+VAsiDZUrKkRTFD9Tr9
   w==;
X-CSE-ConnectionGUID: qxNVpGZjQUacp+16rfNTDA==
X-CSE-MsgGUID: tF4xyA1uRPWHsdiIn8aBnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3100564"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3100564"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:39:42 -0800
X-CSE-ConnectionGUID: 5wWgrPazStCtvfNccIpzEA==
X-CSE-MsgGUID: mhYAUYHoQ3Oj5ypjCTWWtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8608433"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:39:39 -0800
Date: Wed, 11 Nov 2026 16:39:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Di Wu <diwux@google.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <avR-KT-6e77EexZn@ashevche-desk.local>
References: <20261111072608.3490763-1-diwux@google.com>
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
In-Reply-To: <20261111072608.3490763-1-diwux@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:
> Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> PAGE_SIZE limit and is the preferred helper for show callbacks.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	return sprintf(buf, "%d.%06u\n",
> -		       latency / 1000,
> -		       (latency % 1000) * 1000);
> +	return sysfs_emit(buf, "%d.%06u\n",
> +			  latency / 1000,
> +			  (latency % 1000) * 1000);

As David said, since you touched these lines, make the less amount of them
while at it.

(But no need to resend, usually Jonathan is kind to tweak this small thing.)

-- 
With Best Regards,
Andy Shevchenko


