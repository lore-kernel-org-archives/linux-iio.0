Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDF25CC74;
	Wed, 11 Feb 2026 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816650; cv=none; b=Ktom1F7YQlgFY0i+fGh/fNQ9JqpMEkeJIhO+5I2v8RBU2a7SapKbyH06mm4vheV6gEo3g5c/QdPh05vL1C+iz04C+RR/noGZWZwmzvJSz3vl3n2t/Ko4620ap4+Zi/9zdGe1ouF7oyhQJHxubvVaceos45DQAPjOvtu84bGaaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816650; c=relaxed/simple;
	bh=k8+oopUjCVil1WXtQO+baWanulYNHNXYgiQoqDo4IaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTQOdSUNEjhtjF5WU1M2lQ/WOgb+tbxJuPROtC7UpztUM0HPT/59iJ0tLEhFKL9BS2OvrR5NiypG0he+V47SMoaOFiBcxQp61jEB2rqJbGKZr/nXPK/oyhDZhwdKq4X6wRqWKaMMg/JIAh27BdycwgWLk3I/8o+Y1n7nwr4w2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dewejyc4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dewejyc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770816650; x=1802352650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8+oopUjCVil1WXtQO+baWanulYNHNXYgiQoqDo4IaQ=;
  b=Dewejyc4SGFHsMSp44pCCKx25PSnTSS9xcE4Q8LAXNkEf12uZ62x9VYT
   7jcjsJp8sgLtXt7NtRrEshUPaOcFzNMFuehw0V7D8SpItOShjzsWIoKxX
   vNykLtQOnc+N/YvmnJqDhB/G2iKiyvyaf8MYmj7aRAIf5eCyoIpjqxrZz
   DermkEsyS2FmkLPmDVngWdZRZMAy8b0ESpZKABLxiIxlvo8Va86d2ft1f
   swJBUtbPPabWdM9gUIYF80O9J2i+B1B7R2N2pFU87w0eppxTMSiaZmmG5
   0reaK9/tR2+1yxY7nnzHQmVWphm1NRdM0taV+K9l8A8FxOoH+dKcHP1mt
   A==;
X-CSE-ConnectionGUID: ZAlf2H6AQwq6HMOYvuYdEg==
X-CSE-MsgGUID: kSmAqrocQ+ucs3ZhqfY98Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72149281"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72149281"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:30:50 -0800
X-CSE-ConnectionGUID: yB4+r69BSJa+YdjrcVB1dA==
X-CSE-MsgGUID: +2oa1+Q8Quy/FF4gmxPqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212354094"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:30:47 -0800
Date: Wed, 11 Feb 2026 15:30:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/11] iio: amplifiers: ad8366: refactor device
 resource management
Message-ID: <aYyEhGWhql7C78PY@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-7-15505f7b15b4@analog.com>
 <aYuPhB_e14orrZ64@smile.fi.intel.com>
 <whgxbva3eeushqmj57xsk2q5kv3pmrffu2fzgmxyynvvzb4fyr@25arbt3bqulm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <whgxbva3eeushqmj57xsk2q5kv3pmrffu2fzgmxyynvvzb4fyr@25arbt3bqulm>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 12:10:11PM +0000, Rodrigo Alencar wrote:
> On 26/02/10 10:05PM, Andy Shevchenko wrote:
> > On Tue, Feb 10, 2026 at 07:42:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > Adhere modern device resource management with the following:
> > > - Voltage regulator managed and enabled internally;
> > > - IIO device registration handled with devm_iio_device_register();
> > > - removal of goto's from the probe function;
> > > - ad8366_remove() removed as it is not needed anymore;
> > > 
> > > With the drop of goto's dev_err_probe() is used to report probe errors.
> > 
> > I think the regulator change should be split and go before the previous patch,
> > because that one affects the ordering in the error path and remove stage.
> 
> OK, that can be done, but the same way,
> the error check would change as well as the dev_err_probe() args, not seeing
> much benefit there as the same lines will have to be touched anyways.

The point is to range the problems and target the more serious one first.
I consider the wrong ordering, (mis)use of devm_*() are in a priority to
just a simple cleanup.

-- 
With Best Regards,
Andy Shevchenko


