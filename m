Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA647D929;
	Tue, 13 Oct 2026 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924316; cv=none; b=ocNv29v9y2O9ckCL8lDJnwDcYsoI5d8uEdAVMGBGGgHHQiOvoRB62X34kXi+2OsSa/LFPZwp2+UZ8xChfHiuljk1Vsx2pBMY/eeZ98YRY0TrNhgxJ5Ic/umAbkw6dPbGk3XwFPzicRDvNW8NNoHTmtSyiVsteORt2pFMJe4j5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924316; c=relaxed/simple;
	bh=SnjBCQL3fxVrkUlkrveHed2lQyGc829sXIVxyIFt2Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmI7y9Xdwme1ZLryWZdtJAPanlYontNStTPJrBrp3le0ipvUnpd2o+8IWISSpE9NkoeEPxY4zM+jvT3/riMkZoOnIjU7Xy5NJSRbEMBMjAf7UbfC8snoas6o0Xi9bLabiuLsa2CtEEW/MpJbWfM6Vpj2M+Ph3mHjDiNw4a8TCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgRGL/p3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgRGL/p3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791924315; x=1823460315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SnjBCQL3fxVrkUlkrveHed2lQyGc829sXIVxyIFt2Ws=;
  b=BgRGL/p3EdBq4yx2NI8eh3uq5RxgV3b0RIUfjqgMnGAHAktL6HpY3Yv8
   GZlZvfoQEie2bFlUn01E7NTsyuDm2PTuP/BoMDXKPwkPI1WOPYO3wHt8K
   txfR1DwbMwP6IfXItFAaw/TDsGhnBN+fpiv4Ur1ei1ylh4Ajbb8M+EqSw
   Mk9fLhsCUm+/CSYQBMkk5Wd4mlEX2YKqsuIfOq4Rt1OsinAz4TE69GuuI
   o7XJKVwTzwxRos3wK835tSSgexC4V+4/HstPB9YK95x78+RSFcDWF7nJF
   y1pDiIKie5gLjim7GAzufCb9H0sky3/zlsNSURECO5DbEbhr/d1sgSkGI
   w==;
X-CSE-ConnectionGUID: i1t3icQYTHC1ch8x1fp87w==
X-CSE-MsgGUID: xhDdWjxcSYCjHblIvkE/Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="554163"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="554163"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:45:15 -0700
X-CSE-ConnectionGUID: Sv6IeZAwTSSirbf2P2MH/g==
X-CSE-MsgGUID: DfSps1OESxSmHxTjwSvCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="3024448"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:45:13 -0700
Date: Tue, 13 Oct 2026 23:45:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: inv_icm42600: fix kernel-doc Return:
 sections
Message-ID: <as6YVlc_OAf6kPoX@ashevche-desk.local>
References: <20261006045413.14320-1-kapoorarnav43@gmail.com>
 <20261006045413.14320-3-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006045413.14320-3-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 10:24:04AM +0530, Arnav Kapoor wrote:
> kernel-doc expects the return value to be described in a "Return:"
> section. inv_icm42600_buffer_update_watermark(), inv_icm42600_setup()
> and inv_icm42600_irq_init() use "Returns ..." in the body instead,
> so scripts/kernel-doc -Wall warns for each of them, e.g.:
> 
>   Warning: .../inv_icm42600_core.c:511 No description found for
>   return value of 'inv_icm42600_setup'
> 
> Convert them to "Return:" sections. In the watermark comment, move it
> after the description, so the description is not parsed as part of the
> return value section.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


-- 
With Best Regards,
Andy Shevchenko


