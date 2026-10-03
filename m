Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28C2882AB
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059856; cv=none; b=LYFA+YbAzttu/+I21/IBkdi9xeR6Ux8uOEYl4QwFe52gIdABoSwveLteM4fVuLQp+ajmORtLOqSj5s6cxfpJEvbAw6V4t/DJIJYlyCqT2CZGvJtSEfDy6V6vskM5UgDGdozgRc94j/BDPQMQw8yXZE4yXonhH2e85h02tRITPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059856; c=relaxed/simple;
	bh=oNHBLkdi6Yvj8/dJciXf93hcJFbAY6lyT16OXx1eYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV9ZYiGn+JREWrZ8WZNPpGKQGL+DrbrWhr54V1kXKu0B60mABLWi3YkElMQzdCIhTEQRwHk+hlLVytqHrw0sVL+S3RF4Lmeg5gWeXkzsiAMWhFDnkZhTLTGB1WJ+CBA+dztzF9rLHPn5F28LtfdyV8xGEjPYSWq1WecY7neA+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5n3A0Uz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5n3A0Uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791059854; x=1822595854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oNHBLkdi6Yvj8/dJciXf93hcJFbAY6lyT16OXx1eYgc=;
  b=M5n3A0UzC2ifFPjXq0XsAZx4EmOrkzRIIbTExBLqN4ZKMPxtgTQoDopp
   t5xtlA/7Fv8Ws+poAed1KbwmvlsJz/VrkV1VUBJz3CJobDwha89HlwhCn
   h/HlDiaobUXSRhFoBAjlqK+hX9YDjhuAW1xjVEjMPdh8Z3uUL6qf4dXsK
   k+BuK+yTiDT0wNqSWPiKx1L85a4++v5bb56yGhPP2xzNIqcgDSzCOD+X4
   9RJFICsuwphUA1Hj3qvtWs8mDNQzMFLoCxxQa6SlnO3qvkrAsYkCR1kQk
   WaMAPa1Vk/q4XjGVfZXXqRZXlGd3SrqN9Bfl9D/xVwsI4sbZaJyMORdh8
   w==;
X-CSE-ConnectionGUID: wSnhw35URdanpOqlO5EATg==
X-CSE-MsgGUID: xTgThCxARqmyOz7oFRqsYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="95600564"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="95600564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 13:37:33 -0700
X-CSE-ConnectionGUID: WlelNB7ySlOEfwXNwOP9cA==
X-CSE-MsgGUID: 6+lOCwGoQVyrqZRuP+QRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="274295378"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 13:37:31 -0700
Date: Sat, 3 Oct 2026 23:37:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yuval Saar <thefireking@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, maxwell@maxwelld.cc
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3422: describe parts with chip_info
Message-ID: <asFniVfXlEW_7PAw@ashevche-desk.local>
References: <20260919195507.94130-1-thefireking@gmail.com>
 <20261003001647.1975549-1-thefireking@gmail.com>
 <20261003001647.1975549-2-thefireking@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003001647.1975549-2-thefireking@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 03:16:46AM +0300, Yuval Saar wrote:
> The driver encodes MCP3421-8 differences as integer ids and switches
> on them in probe. Point i2c_device_id.driver_data at a per-chip
> structure instead, and keep the channel list and 3 SPS support there.
> 
> Compile tested. No hardware.

...

>  	adc->i2c = client;

+ Blank line.

> -	adc->id = (u8)(id->driver_data);
> +	adc->chip_info = i2c_get_match_data(client);
> +	if (!adc->chip_info)
> +		return -ENODEV;

-ENODATA

-- 
With Best Regards,
Andy Shevchenko


