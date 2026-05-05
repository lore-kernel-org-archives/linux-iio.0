Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982E351C1F;
	Tue,  5 May 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985987; cv=none; b=L+20j5OIAYiS5Bg5AGZ1elNdUxVN0mPlBKeZnbNJFbew9zOr2RqRkElLhX6fYPmz8hXyqJ1hm88kKf6K95PBKdpME3tcugJO35auZz9z3B1comzS4AKw7ZYZeZv9YBiS0U3Ech8jES6cKUwm/oG6NFL+nQ7fm9toEnP3R1pD9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985987; c=relaxed/simple;
	bh=BUDpNzzPXViw5pzB4sk0ev4l0l18YV2UCi81TKQClLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAJY2jgn+sIkaJJfp9sL8unmg+RG43fb6gNxb89MRS/NfgBYwQ038M6Uu+XpJ0PQ9DaxbTQHuyIxzOsmlTEqPX+sGna0J8qkf9lRaaSXLUhsBv/DIlS2bBnFP0ybPl8GX/AdCbEOG78CE1JRpEMq1RcEJD833BLfBuYOYUVlj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDjk2gqO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDjk2gqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777985985; x=1809521985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BUDpNzzPXViw5pzB4sk0ev4l0l18YV2UCi81TKQClLQ=;
  b=HDjk2gqOTAnxqBgt916rIyr1yeLqRSXceTpvBUn7K6SWmpjewJoNR3QK
   tpH8QGpzGpzqp70DJeEDT3QFjR6zZifMXNiJ4DU0IvDgfvwA3e8oAS0+E
   2cy65LALI8PnFsGm6YoJbHAzXVsaFEQqCwr7GLZt79Efa2ZyDQS1ePpPt
   RyM9ZwvsN44BbyRb+N7iMj2epXbm3YXXiIeGckVStpPiCxeToBz+sWrkS
   S2dW/X2BdaApZc7EMUzbIXk9W9j+OII3f8Xq13HmwQ2GSKUPT17o/bP+f
   yiuscz1yoKbHF5w9TkgNVR/7QvPXz/J6B8KwyxZkFu7mRCnmLw/VvRu4O
   A==;
X-CSE-ConnectionGUID: cI90Iji7SCGSOPSlU7Y92Q==
X-CSE-MsgGUID: opfARdbTTDOU1uQzQOSmng==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78791635"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78791635"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:59:45 -0700
X-CSE-ConnectionGUID: nXBLUuWITIeCJW/twTgE2g==
X-CSE-MsgGUID: 1d++VTCRTpuAjG4LP/rDgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235678254"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:59:42 -0700
Date: Tue, 5 May 2026 15:59:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 00/12] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <afnpvJ5dwkZBcTHL@ashevche-desk.local>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:35:01PM +0100, Rodrigo Alencar via B4 Relay wrote:
> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"):
> 
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> This one adds a number of cleanups and fixes, like:
> - Refactor include headers (IWYU);
> - Remove redundant register definition;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix internal voltage reference control for single-channel devices;
> - Acquire lock when doing power down control;
> - Fix powerdown control for dual-channel devices;

> ---
> Changes in v6:
> - Protect powerdown masks on read access too.
> - Minor changes to power down handling and constants.

You were too fast, Jonathan applied some patches already.

-- 
With Best Regards,
Andy Shevchenko


