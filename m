Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B426AC3
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890288; cv=none; b=TuOrvgPLZOawrk+0qlzfUIniIKWhDLkI2EGNU0oRsxK92uwgoU708gaRqGtpZtdN+F0ND1s+ocoSs+Vo20FAZziKTyzKBaUjBrphtmrc2mFFMWL3Mvv5rFImdglmnkpxXrbvpfc3CPj6FuB0MsTo8fxr5dUvfSZLJ1IrH+rX4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890288; c=relaxed/simple;
	bh=uBlSsVw6g4TFCUKMywoXM8NWpQ9HeCWk3BGg4GYxcVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVZcDvEoj3ymPKHWrFa+WHiRhhVunYAT62N9RESpXuAktwZL4fWUUL0x2NxCC5MVRZXhz54Vxm/DdalfVlCHVQOeqGvm/4iWmDZAXMNIYw+UHgod2LqznXvg0pMf0dfpZGiC5eIlgjLlJpahiPdvSdFK82S9uXvzYcxSuGN9Ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOSSDeqC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOSSDeqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776890288; x=1808426288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBlSsVw6g4TFCUKMywoXM8NWpQ9HeCWk3BGg4GYxcVc=;
  b=NOSSDeqC/Uj9cpiszNO6KyaQfmxEqIASQb52pDoa7AwiqkQB+qQ5cfDE
   KDLUVyIIfy5W7i2yh9ZZzkqdt7aW5J+UJIJL3R3cL1qcQeT+yW+Q6O5BL
   GDzqI0KH4yJXPl/bSZqNkUVgj5NB3yrwY/QN/+/L+syP4X6ZPNqY15yYz
   DvbOllc+5sYf+wN3hMeUNpVw9u1NYGmolw19XeEMwHplXX5fYMQ8xX/ZU
   +KFuSerFpQaWIUR+GjV9XiWJEkgjHsR5angaCqGafDYFe0XZxPbshDCz3
   nRGTLEPCPti6dFnL3K7x8o04KiZo6hhDYoJualJ/a/soH//3GdpNpdF7v
   A==;
X-CSE-ConnectionGUID: vSAnGeAJTZ+pLI41s3nDeg==
X-CSE-MsgGUID: SwcrIfqmS/SmQtnvWe4aSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="78040890"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="78040890"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:38:07 -0700
X-CSE-ConnectionGUID: L/W+1rF9TICslymRVU4FuA==
X-CSE-MsgGUID: qwUi+qDHS4mdpOImaO6aOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="262843681"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:38:04 -0700
Date: Wed, 22 Apr 2026 23:38:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual
 lock+unlock
Message-ID: <aekxqlop8d2htRDY@ashevche-desk.local>
References: <20260422192521.7472-1-guilhermeabreu200105@usp.br>
 <aekxNBLWOXqkqXi_@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aekxNBLWOXqkqXi_@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:36:09PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 04:24:36PM -0300, Guilherme Dias wrote:

...

> Have you even compiled this?

Taking this into account, I insist you to start reading documentation and
review others' patches in IIO before doing yours. Two people in developers in
this patch and none of them even compiled?!

-- 
With Best Regards,
Andy Shevchenko


