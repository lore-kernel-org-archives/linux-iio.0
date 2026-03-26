Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B65399030;
	Thu, 26 Mar 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519341; cv=none; b=uk+HOJd0tTvDXEygQb5cJe1OgVeEkUxpfglPabK08bSNkIpwiKrfoGRtrR6Euxje3lxvCXM64bRO9ic/GDCOK1spbTxJZEC+6p6LffLeUriyxIpJtt5w8ucTal4+phrZIRjf4SLYiqJ9Cn47TtGGZjp0ISCOvu08Wst5/617xsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519341; c=relaxed/simple;
	bh=nkTHZpS1iZIrStFdeoJM7CBUlj3zWAX//AI/af2dbXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6Bb3fL9XemFT1k9uV6C6kAf4Ba52BLDJLIeIqPRInZS3RQiuPqXYUBq0uVJWn4PGLBfY6jGQRjvtV0MchI5u3QOD12p5URPaJWzC9ZX8svJ1qPT4iC1xrvfQHRmydJ1yP3zDAy3qiXwL7U1k+6D5E6D+GbK/sDu43/dzKWojkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCVb4tKt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCVb4tKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774519340; x=1806055340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nkTHZpS1iZIrStFdeoJM7CBUlj3zWAX//AI/af2dbXo=;
  b=dCVb4tKtr+VfWamZK/Dc2OwQRFv60o0kKCNDpBxhU6tMctaeKM4xL2rj
   f7A1tCAvZI/A04gYe6la3iejgPVRHlbsJMyd4NLsHY43P4Bhs0U+2Q01b
   /woNOCFiUIlSb5Y0kmzaXXhcbpXROrQE8sB2sf27zyt9gt65i6gG2a/8Q
   a42m1lXv7Usu0JJsr0aYoY8mT60xLV9xYoIAsc99n+hAy2W1xLCwvgRuQ
   muDKKKLGUb3kT3eUU0Wf2H9WPx3spmOQc5ueYbZUfdvpqESkCzcTuPkKX
   TVpNJD9Juwt+zMky+GqJ/73x4QkVek2UQr/r6I9y8WQBjGmxiZLIWVo1J
   g==;
X-CSE-ConnectionGUID: Do3hcuaOSDWkZgAGHfBPew==
X-CSE-MsgGUID: I7t2VmqSSZucNme/AF7CIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75640657"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75640657"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:02:19 -0700
X-CSE-ConnectionGUID: fqBzUegUQj2ngPzHDojIeA==
X-CSE-MsgGUID: UtYQceKbQwW8scqw3xXGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224022927"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:02:16 -0700
Date: Thu, 26 Mar 2026 12:02:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Milan Misic <twoexem@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Message-ID: <acUEJsNN5a6-FaLD@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324193626.77231-1-twoexem@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 08:36:26PM +0100, Milan Misic wrote:
> The SHIFT13mi or SHIFTbook tablet device by the German manufacturer
> SHIFT contains an STM LSM6DSO IMU declared in the DSDT with the
> hardware ID SMOCF00. Add this ID to the ACPI match table so that the
> driver binds correctly to this device.
> 
> WHO_AM_I register returns 0x6c, confirming LSM6DSO.

Based on the provided information,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


