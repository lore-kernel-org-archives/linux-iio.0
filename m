Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B05478E25;
	Sat, 12 Sep 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219338; cv=none; b=QAqoD5p4tCv9YDUgefX9y+p5Bs5Qgj3P48rr+dRzmiMOSTKBtJkWlFN+9pn/XPDE5EwA25MQrVsZnZGXWo764TTFsQMbaVXCf597g6UMgWjIoxpQ9+tkUxQhHPUkGS9AL4j5JHnfLV6M6aOK9/z4brtgRJaSkRtauLALuzQphP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219338; c=relaxed/simple;
	bh=BOCroOJEaN/c+qJk5JxHZ9/qarv56VFO8jjyDmUDmlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkBacL25niAxeyBeUkpRgiAlb9scAUEY4LPtuhTQ+vWp3OYBoGNWgFV078FPqVmRnHLQ444mETBYHW0xvUXX8U1qMohWuFaKvWSlDLgJgKJcViybNyViDor4LFTioxxqmh+T9YpoE+gb5indVTrztnfbxmpfEDnaKGhTvbXbWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y394gTHB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y394gTHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789219336; x=1820755336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOCroOJEaN/c+qJk5JxHZ9/qarv56VFO8jjyDmUDmlY=;
  b=Y394gTHByj7QPUVqdk+jf2PIPJjxAHfJFbqZWNnCsKLEmp2ajq7w84gx
   KXU7l3faGZzkqkOUUMwoHt0NhpPbXCGwh4a08vmcO+RVEKSOLerCFBwX1
   tfPIsBZN9nvHirq0yNmA71Ag+heKTy5IK/SBSBsBLzP5GYZK1mUY6PhuY
   JLqdsapHKwFfa2qdKVNkimuIWIQoA8nbVovRj7dS8A2YVCJk1ro51/kI8
   Ap0IxRZfq23cs0DKDrjaaD7xsitEpTKrof7fd6YCLxpj2jYSxFhB0tcYD
   ATE7QRNIiD8t/2R5h3rKpQZpBlNohjm8LUOlhpl6xiYUS/nbGyp3WjAKg
   w==;
X-CSE-ConnectionGUID: Y9lYbDEDRRq5I9EkNxZXlw==
X-CSE-MsgGUID: Jqo12sXkQ6S9RkHv6bGl0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100318961"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="100318961"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:22:14 -0700
X-CSE-ConnectionGUID: B7LDMt1jQ96Kz7kW5wmCEw==
X-CSE-MsgGUID: hFNH3Yn6Qq+pFFUYU0vguw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="272158036"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:22:05 -0700
Date: Sat, 12 Sep 2026 16:22:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] i3c: master: enable driver_override for I3C
Message-ID: <aqVR-jBabQKcsfjL@ashevche-desk.local>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 02:09:33PM -0700, Meagan Lloyd wrote:
> Opt-in to driver_override sysfs functionality for I3C subsystem.
> 
> Update some I3C drivers that are assuming that if their .probe is
> invoked that the bus match function already checked the ID table. Go
> ahead and verify in .probe that i3c_device_match_id() returns a valid
> match before using the i3c_device_id pointer.
> 
> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> Assisted-by: Claude:claude-opus-4.8 copilot

Assisted-by: LLM

...

>  drivers/hwmon/lm75.c                        |  7 ++++++-
>  drivers/hwmon/tmp108.c                      |  2 ++
>  drivers/i3c/master.c                        |  6 ++++++
>  drivers/iio/adc/ad4062.c                    | 10 ++++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c |  3 +++

No, each IIO driver should have its own patch.

-- 
With Best Regards,
Andy Shevchenko


