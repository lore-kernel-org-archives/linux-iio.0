Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EB3431F5;
	Wed,  6 May 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051280; cv=none; b=uiAeE0dJqjGW16P8DMM0R20Tf0oITpPIOBYRC5WbmoxYSFGfizseX4tnc3W+3Pn7C4Ym6z4tt9UscZdxVI7aunjPtU6oHsMfbHNb2TBDUj7OJJlqTzbBCrFVUgoRTrsSc2BiAxst+drmGTQ+Ct1H763O4TnLOtHLbJiHR7XSL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051280; c=relaxed/simple;
	bh=UO0SxN6KLsxVV3/1s4U4qSQnKrsYDwvjGphVV8hhLg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsaXzR8UARy3vLtUzxw8kNqgCXgS3E8Eizh52sx4/gecmOwhOK/MpiwFX3mHQDvTvC1bRaE7cnnykwgPwIrRCoaaP9GIg8shJGfzOlS9QKfKwNcvlyniWmmSsi45dJALIp6jjizJX5ShjTf8qoLBQ2VUS4dK7DQcf4ZKhDAsdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BicPKUSW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BicPKUSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778051279; x=1809587279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UO0SxN6KLsxVV3/1s4U4qSQnKrsYDwvjGphVV8hhLg4=;
  b=BicPKUSWaVzIQOvGjWHxuYu+EOaXf4QxsTpjnhMe9cnxRmEz6+DwTjZo
   uXU1p6S8hAzqVJUc2lkxjwhIhga6jtftTyeYKI8u3fBUoHEE1iGytBDHe
   UVgufQ8QWwpH79Jx5Lc4nva2qGp08b0ozmk93w9l65deW8O2Hn3Y0AtYm
   33+aSfMmS1CNaVOVU+OVajXq/QXyA8ohT18s+k6AtXCl+kpofXUn+20dH
   3Bf6fpxFIhaN5yw3H6LzhB81jIdRby+Lds6jvs4oBt2gFA96ZURlnnIQj
   WC8x89pglM8DquzGDJ+vw+mTFIXkr+gYoO2QgbrSlL/cJA6/ht62n0B9L
   w==;
X-CSE-ConnectionGUID: bcKXkPdJSxKHcYjt+zzy7Q==
X-CSE-MsgGUID: Pul2EB4cS0SFf0xC8jt4RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82839685"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82839685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:07:58 -0700
X-CSE-ConnectionGUID: AoHN2A5OSFGcxbGyB+BZAw==
X-CSE-MsgGUID: Ow3SZiNwSPik04ty4bELtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259482645"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:07:56 -0700
Date: Wed, 6 May 2026 10:07:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: joshua.crofts1@gmail.com,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <afroyRauK7IJrl8w@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
 <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 08:09:22PM -0500, Maxwell Doose wrote:
> On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:

...

> Small nit but I wonder if we can change:
> 
> 	if (val < 0) {
> 		dev_err(&client->dev, "Error in reading GPIOD\n");
> 		return val;
> 	}
> 
> to something like:
> 
> 	if (val < 0)
> 		return dev_err_probe(&client->dev, val, "Error in reading GPIOD\n");
> 
> Would be good for code density.

Not in this patch. IIRC we have a dedicated change for dev_err_probe()
conversion. Also note, dev_err_probe() is only applicable to the functions
that are part of the probe stage and probe stage only. If the function shared
between probe and run-time, the dev_err_probe() has not to be used.

-- 
With Best Regards,
Andy Shevchenko


