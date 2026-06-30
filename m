Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CD2F8EA3;
	Tue, 30 Jun 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821539; cv=none; b=j1zB3GwO7Wf7f3VCgpFdGK5aeSV4VfwGVLi64/sZv9e0wVkKguwevkTC1twejtSdqNaH59vO8kI2gtv89JxcTdg5uBsMEClnLGPLazeZOSbO4YW5/0B443idMg2CY+Sg/Ue2KGllEbcVn5idIf0Ad39M8nOYWrkpy/0LQJahRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821539; c=relaxed/simple;
	bh=1L1Wf90eUreqxVia02nbtpsp46qa1tSbDPiKkspanxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfPqf1o9YiJfQCIBgyqORKhOByAajy9vqjNp8FvFSAJzh/isMFGGBWa+Uu6k5MunVdbbtI1Y7K6+usvldOt/FK1OP/MhqCvLI9vg6la76FCwWw4ldtXpH/x8NevUQtJ2Kdi1FSAH+gUlrvFLkUbCV2PFJiSesDrjNUDDco23WGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gh4Pp9sj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gh4Pp9sj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782821538; x=1814357538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1L1Wf90eUreqxVia02nbtpsp46qa1tSbDPiKkspanxE=;
  b=Gh4Pp9sjCetVUOkWTwHQpyLEoy/cOYxBV6AooIlDnVpFURfu+7WjKdno
   ytH6OWSGPNXvKKD1wsRe0nf4CLYtQrVPOk/+ttHeQI2BXeVq+vsUOJqol
   3OEdwQFvWZuFgow2N+AsA3s0xKS1lE+0CChf461XTM341qSYcKPK1Vh/0
   WcRr4+hJMxwKq4p/pTUPes45K4EN1NMEEDzw0LjiKiJJpEn8jxQAbiqQO
   i5FuI+mJF3v/plRRjBzPVhLTBUd9YJ4qw+mB4/7CVvwc9Sz1xGpOIngLm
   02tbJbapLmw//di5vkENuKB4Cufjifbl3rCKm8PnMXff6Xu+BbuPJ2z2n
   Q==;
X-CSE-ConnectionGUID: 03k0YnqNTDCTjyNdZL3ieQ==
X-CSE-MsgGUID: ZAUgaabLRCubhczhagZGEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87215138"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="87215138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:12:18 -0700
X-CSE-ConnectionGUID: e9Lq9jYXS82f6jnbPm0cww==
X-CSE-MsgGUID: XZ09lzFXT/CFBp5EHYEUUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="290376670"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:12:12 -0700
Date: Tue, 30 Jun 2026 15:12:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, jorge.marques@analog.com,
	mazziesaccount@gmail.com, Jonathan.Santos@analog.com,
	jishnu.prakash@oss.qualcomm.com, antoniu.miclaus@analog.com,
	duje@dujemihanovic.xyz, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] iio: adc: at91-sama5d2_adc: use cleanup.h for
 NVMEM buffer
Message-ID: <akOymRWOi5xOsrog@ashevche-desk.local>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-3-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630093603.38663-3-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:05:52PM +0530, Varshini Rajendran wrote:
> Use __free(kfree) cleanup helper for the NVMEM data buffer in
> at91_adc_temp_sensor_init() to simplify error handling paths.
> 
> Since __free(kfree) requires a valid kfree-able pointer (not an
> ERR_PTR), store nvmem_cell_read() result in a temporary void pointer
> first, check for errors, then assign to the managed buffer.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


