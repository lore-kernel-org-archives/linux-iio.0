Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03044C678;
	Thu, 15 Oct 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089406; cv=none; b=FaHJTCNumR6KCBwmu3N5orv8rDNma9n4F5h8LyJjH2CZb+X6nPeupi0Yu7t8FHlaxfTI9BVt7ABr6htxtEQ5RopF2EUhQf8gpiKPm+AHRLIYaKPIz8KMDb2xfJEHt/NZDPOpI7d0tE/M0P4r6UJ3oGkvWtcSsjeC6SlrO4KHFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089406; c=relaxed/simple;
	bh=2y3fDm/+7fq0b+/ghL7a7yuvUhnjOIGinyqQp4NpvnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeMPdB6ni6oxz4hEvEDUaXYo1hGkdF9AxXh8j+Nzxa399XWGsxMpqEhD1eN7msFMaLEb6cLvR/nYMrXkwGYDN/bFDqYpzPwgpSs5a6Zqj8fbD/mVLBVJpxkEHk8Pc6a3JGS4zKhrUwErA9iWoWgGAONDKYmInwRdZ6mTTM2+1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlMbbLoN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlMbbLoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792089401; x=1823625401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2y3fDm/+7fq0b+/ghL7a7yuvUhnjOIGinyqQp4NpvnU=;
  b=JlMbbLoNLEcBXkbGl9k3Dd4S5a76obcvpO+v/E3eHGnVc4QRWIcAzZ4+
   Iyfh+/BG3aiSu8ZdbJgUCZFGd9v0en+PWo9+M48V+UcbEjxU6poU1uYag
   q6VZc0NiG5C9jdvPxHIfvNgGUhrECgSS+2LMDdoQIiy4sK3gvDpufrU1V
   c0Ga5bZlGQaV3c+SEgXpgHH9m+WVl2yXYafBApxK+mmL2bYYhx9SSBOPj
   G+cT/83hOatwj0FDPyFjdw1wzPvlZ81hxIP2JRaLOFlCnPgUz/3NeXpip
   XFkkdVOqXQ/w3nlcnFYKngAC6xPx1d72MKJsq3HdqiWIBeCNkzHVXPmFj
   g==;
X-CSE-ConnectionGUID: /q7Y2cFWTxKxujKWfV3YrQ==
X-CSE-MsgGUID: 0GBTkZ9xQESfrKiX1vf7Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="880812"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="880812"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:36:40 -0700
X-CSE-ConnectionGUID: rbFvl76CTSm3QwbkRy4sCA==
X-CSE-MsgGUID: pqB344yzQS+hMGEBoRL72A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1767902"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:36:38 -0700
Date: Thu, 15 Oct 2026 21:36:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <atEdM6wi_FAGFjrr@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014141650.259929-1-ciakval@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 14, 2026 at 04:16:46PM +0200, Jan Remes wrote:

> This series fixes several issues found while using the TSL2591 in
> company products (Raspberry Pi CM5) and when testing (x86_64 laptops
> with MCP2221 USB-I2C bridge).
> 
> The original field report found that the illumination value has always
> been 0.0 (caused by division by zero on ARM).
> 
> Patch 1 fixes divisions by zero in the lux calculation, which occur with
> LOW gain and short integration times, or in darkness when CH0 = 0.
> 
> Patch 2 adds an i2c_device_id table so the driver can be probed on systems
> without CONFIG_OF.
> 
> Patch 3 makes the driver return an error instead of a bogus value when the
> sensor is saturated.
> 
> Patch 4 improves the formula for calculating lux values to make the
> returned value more accurate.
> 
> Patches 3 and 4 change existing behavior, I am OK with splitting the
> series into two, if that makes things better.
> 
> AI assistance: Claude Code (Claude Opus 5.5) was used for research on
> sensor behavior, datasheets and Adafruit library, to compare results
> produced by old and new formula, to draft some code for patches 1 and 4.
> I reviewed all of it and tested it on x86_64.

From my view (haven't checked the calculations, though) this looks good,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


