Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2B386C3D;
	Fri, 27 Mar 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604084; cv=none; b=kDUy/JsShPajFMCTPkQrq7vZmb8hHLKaK5ubO4lkfpwW6BTm7JAHCho4VX+FcG0olw6y6lWQ9kdcJMkZ+Kv/2ISn5e7d/Yfi/aZPGT2wRvYVSdMWnblUvjzE22zUkhs7IgHICqlmDoP2FCRhsa6zoJvlf+pwbidl7m4f49BwJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604084; c=relaxed/simple;
	bh=R+xoSkiyzgPMsc1hrtIiLMHYcpuJLWkS/eZ8wuMJGek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCkPWDxaCxw6qKS3mguTvV4UlrKZ1QLZo4jxpdgPFdjXapg/RF0z2vZokkWv9lHhQu4J3tuaT5RKDFQYbRR55WsTczhDdu8YnkgELy82xI2AV+q6tutUgi2K8dk4Vrs5fkge/7mn9/LWEk2+m7GPWB8Jprz91rja4iGaapMITTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aY8gdEzM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aY8gdEzM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774604082; x=1806140082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R+xoSkiyzgPMsc1hrtIiLMHYcpuJLWkS/eZ8wuMJGek=;
  b=aY8gdEzMV+27suj01VyWa6CVTrglmxV+yL4P7T6Ww19TvjhzbMMICt8r
   FhuHZEzQ54BuPW4Dyv+wGwXxVY+rQyIihIAZRAF8n1n+xzpkfYHzcLlO9
   g6rJvbFscZ8BzA5loACCWnLldN0EP73MQb2zkwjAfVWeZYzakS9zcphTs
   KFdZH3R1cLJuvJtaZjFkVdMH8g57xfeC01cfAubDA12uj+gH865yLdDP0
   vzRp2FGGucPAZuz4VdIusz60nIvtA+8uS/T1YB1F7KKiBCOEhwxeMUTj8
   70MJsVOM5An5i79p2u9Eck4TBD1LwtWyrdcJE//9NzLn/P0ZEtdD8Z72P
   w==;
X-CSE-ConnectionGUID: 8YWjgWGNQgW4ir5EMhei2Q==
X-CSE-MsgGUID: vCJo/GuQRS63zcAVFc7nnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75873882"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75873882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:34:41 -0700
X-CSE-ConnectionGUID: O4QYUlOqQ5CBODt5mdnSCQ==
X-CSE-MsgGUID: TDEyiEWwQSSLCPPzUkj2MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="224310630"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:34:39 -0700
Date: Fri, 27 Mar 2026 11:34:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ltc2309: Add read delay support for LTC2305
Message-ID: <acZPLXhC9PWNIpeN@ashevche-desk.local>
References: <20260327034159.15545-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327034159.15545-1-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 11:41:59AM +0800, Carlos Jones Jr wrote:
> The LTC2305 requires a minimum 1.6μs delay between the I2C write
> operation (channel selection) and the subsequent read operation to
> allow the chip to process the command and prepare the result. While
> not explicitly documented in the datasheet, this timing requirement
> was identified by the hardware designer as necessary for reliable
> operation.
> 
> This extends the existing LTC2305 support (commit 8625d418d24b
> ("iio: adc: ltc2309: add support for ltc2305")) with the missing
> inter-transaction delay.
> 
> Add a read_delay_us field to chip_info to support chip-specific timing
> requirements. Use fsleep() to implement the delay, with LTC2305 set to
> 2μs (1.6μs requirement rounded up). LTC2309 does not require additional
> delay beyond inherent I2C bus timing.

> Also optimize chip_info structure with __counted_by_ptr() annotation
> and field reordering to minimize padding.

This should be a separate patch.
Please, always split the change to logical pieces.

-- 
With Best Regards,
Andy Shevchenko


