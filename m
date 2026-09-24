Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755E37E5D9;
	Thu, 24 Sep 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258759; cv=none; b=HUF+CATclEq2U5c9Qo8183E6vFITdYz94haUWtGijuWAW+BlQlg6iThDPyU/V+Tw4BjvT9SbfRi8gmn03SF00rxuSUD3FcwL1i82DE0WDkCtOmnc5/qwByM0hbnyqWKusYaHuqankzwQmB9Xtt61WuXZAvYNA+Gj2Vxa1mF8Hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258759; c=relaxed/simple;
	bh=tHPSxBX3SChRTn7iwQQ9iRYsvYrHq8RHXY6tDtmVZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=katZfjhPsu7CudhmfncINhKL+++9Od6Mqk+Q/aWH7Ag4+BxdZV3TZosgSnKYyeRT2EvB/CeWfzmqmtS1teMtw7E5EZXXOvwSMIGUzYeSw8BJMGZKGrfZdYigfzdg8dpyd7My5y1lp2d6/+O5WD/11++bBYwNZY0qZN//UDJLJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7WOxotw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7WOxotw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790258755; x=1821794755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHPSxBX3SChRTn7iwQQ9iRYsvYrHq8RHXY6tDtmVZbA=;
  b=O7WOxotw2pPrAne572hBTOeCrdf2S5cRMfnEQOQy0K48+xWPDefc5/P+
   kevVV7nZo5IpKWmDzS9GzLDYK/jTc97VYjl/CipV40u88Mls4ydveV90M
   E5dJ0+t46c9LLHEt0tJeKLQCHIbFMd0x8DEH54FlfP4ms8BbJjImtmKcV
   x+NoCYQ7S9blJ+4LUByqZC4ZG7EZ/GoPORbgiSYkoswo9Za3qMTM3q0BB
   xMGIBxC4dR4YP+MENBi0cJH7EdqNBVL8zC84iDsKhmw6b3EsDW/GIti7m
   WxyDS76EXAcMhUQcS19ZvalAxKLs1yuml1XG3Wc9q8yzKyW5+t9jKLxhi
   w==;
X-CSE-ConnectionGUID: M7U5KmQYRcyyiqJhaZAn3Q==
X-CSE-MsgGUID: AMTGHFKbR22K99u7skEWzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101609676"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101609676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:05:52 -0700
X-CSE-ConnectionGUID: vOj/8TvDTHu7trQlU9qkMA==
X-CSE-MsgGUID: LrMC1PVoRgeTuJlYxHA0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272623125"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:05:50 -0700
Date: Thu, 24 Sep 2026 17:05:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: cdcp206@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Olof Johansson <olof@lixom.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: check reset write error
Message-ID: <arUuO2EnavmdIKyy@ashevche-desk.local>
References: <20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 23, 2026 at 11:41:09AM -0500, Carlos Casadiego via B4 Relay wrote:

> The software reset is required to bring the device into a known
> state before reading the chip ID.
> 
> Check the return value of regmap_write() and abort initialization if
> the reset command cannot be written.
> 
> Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
> 

No blank line(s) in the tag block.

> Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


