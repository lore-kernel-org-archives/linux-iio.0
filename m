Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198D369229;
	Thu, 26 Mar 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513899; cv=none; b=rM3Zu1ArjWoDf1c+wM1n7Gz+z+0OF+9Kd2PpjYh8PaAfJ3foLCEsz+fEAAQS7E5bdEQSE25xqrfiRA5UG1V/no38Dg8xeUzTWQIlJlKgDBd5Ru0c1In3/r6M9UHoQkA/Pa+tHfL0srcvr1jN1qMJhLFEmTn+1NRTRaGKER60AOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513899; c=relaxed/simple;
	bh=gAWH2snjGO4sJBIFc7ZRvsV2TukPjjVSLaNtvLdSxx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnl1UkbFlmOUErrtlHh8fzEKr/BTlgBQzbmcDNMVCJGkO9D46gfDZ4SdMXxHLuaMVyy+agQNNnFh+E0RwuTIVODrqVgwomKE/E+NLQRwypirMk2d9o1IWodKT4A6QNa3ZHfSshdIYRu8f9Yu9YoDZKBXuNQju5JSdcscpbjOu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoG5pcvI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoG5pcvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774513898; x=1806049898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gAWH2snjGO4sJBIFc7ZRvsV2TukPjjVSLaNtvLdSxx0=;
  b=UoG5pcvIRyxZ2GPRsvODJTN85d1StMlaeX723cJcz6s19bH9czdrTRaj
   LrKJtmJhkAr2vCXE7PrOxhseq7OFDpal3wLShp6ianE5TfqivjO/MlBPR
   FtJjEA4b7nHqLHAuonjXinTVOSfmD4RkgETv+U+GvsJ6Xf5yLAmpre9SJ
   eXxSoSd/KHxhGuBS5Zr4dgGtVFQfImYALDImjGOEtxfyv5YU53kzR5Sz2
   jFqvSXu7qj8YO/x38ADX/mT0rT6t8VZLR1tqOBxLlIX7cN7DuU9uL/XF6
   5KtmI7qpE6krFl/WklH5EI1GuXjDzMMk0M53DycZazPGDlpprnBgkVKUJ
   Q==;
X-CSE-ConnectionGUID: HP4uDM5wSBWuoCCGvTF/WQ==
X-CSE-MsgGUID: vWDJsefUR/q1FHiKvYeulw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86643223"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86643223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:31:37 -0700
X-CSE-ConnectionGUID: nMD3rO//QbKLo77sOe3rMQ==
X-CSE-MsgGUID: Tcrn44/fSBCSzo87LS8wIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229872567"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:31:35 -0700
Date: Thu, 26 Mar 2026 10:31:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Milan =?utf-8?B?TWnFoWnEhw==?= <twoexem@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Message-ID: <acTu5PEOCSpMU1wz@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
 <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
 <acPU86AwRJPUb22L@ashevche-desk.local>
 <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
 <acPsxval-nfltuVP@ashevche-desk.local>
 <891e9fa4-3a84-4a26-80f0-8503e71aee5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <891e9fa4-3a84-4a26-80f0-8503e71aee5c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 03:22:55PM +0100, Milan Mišić wrote:
> On 3/25/26 15:10, Andy Shevchenko wrote:
> > Hmm... But it has different HID? Can you also cut'n'paste that
> > device description from DSDT?
> 
> the LSM6DSO is a combined unit that only has one hardware ID. The DSDT only
> has the GYRO node, there is no separate node for the accelerometer. The only
> other node besides GYRO in that DSDT section is for the ambient light
> sensor.

Ah, right, the third one there is probably touchscreen or touchpad wit
the HID CPLM3218.

-- 
With Best Regards,
Andy Shevchenko


