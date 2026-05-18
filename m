Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772A3B9928;
	Mon, 18 May 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088632; cv=none; b=IOLIhmnCn5ZMKO1QYxRVcQNlGgYtr0tcDMb6xM/35huk5A+C91KY0dxywAmML5OMe0uFgeXkDJAzYXVd+n1C1tsdonzADnxraeYTSvebg/YYX/2OZ/Y3fQxhaRLyk59aKOQJvwdWZv+DHMCw/DFnls6Yp/jIUGAFRhHsoowjaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088632; c=relaxed/simple;
	bh=Q2AVmY6R3Hik3/2+qEM5f+xza08K1DuTIwiuQsLypDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn7Yixnb8MWgg5dsqhcXb/gkXr6q0z5Vj4mgCK0LM1wZYx/O8bMyYG3fSdBElbx/hP0kxldhRUI3HVPuAr3tnrE/eKT7qNWTPLWF/Nwa4UavYmfzTT3J0V+VtfFXhIrrCwJIlt2yrQYGE6ubRBfDR+Gmlme6mxkcJQS40me2jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l923tBto; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l923tBto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779088631; x=1810624631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2AVmY6R3Hik3/2+qEM5f+xza08K1DuTIwiuQsLypDE=;
  b=l923tBtosiSxi/43A1n6rbQtnab6Kg2eAX0Lx4fb1zsvVzZxsVyvhkOM
   nggKWsIJXy92T0Mt3/YRCDeyrJwAzEkz8YzzFFNpSiUatcTFM4T0x9Pue
   FSM3XzeeS6/LtHG7PihaCzE5fBfVPLX45R9Ec5Lh/fSPEmmfXE1G17pPa
   IKr1F+SHehrekNSr9FRKE4OqK4VyoACrbfzZxVARmBk5Go8+5WHCuw7BQ
   v3tY6G9y0J3/HsyIfeW7J3ef0rG3NrZxSh0aTfhDqdcayCKvyoqTyG2ML
   kkuWcgz7Ja03DpEEj9f5NsFoF3l4qZKqv7noli2ez2uZWQyXB7CkGJhPi
   Q==;
X-CSE-ConnectionGUID: iiZt334BRgaQKjMXpA1/0A==
X-CSE-MsgGUID: 9I5wbmKVQs+Y+XD6SoR5aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91394808"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91394808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:17:11 -0700
X-CSE-ConnectionGUID: 2tnZHUcEQMOClje6TCaflQ==
X-CSE-MsgGUID: d2GL/rgyRVe4RkWuccy0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="269684542"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:17:09 -0700
Date: Mon, 18 May 2026 10:17:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Message-ID: <agq88mkknwGvTqBR@ashevche-desk.local>
References: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 09:13:29AM +0200, Andy Shevchenko wrote:
> Currently IIO_CHAN_SOFT_TIMESTAMP() can only be used to fill the static
> data.  In some cases it would be convenient to use it as right value in
> the assignment operation. But it can't be done as is, because compiler
> has no clue about the data layout. Converting it to be a compound literal
> allows the above mentioned usage.
> 
> While at it, tidy up the indentation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v0: to be incorporated into David's series

Also may require to amend the drivers (at the same time) that use it inline

drivers/iio/adc/ad7606.c:1478
drivers/iio/adc/max11410.c:807

to avoid potential compilation issues.

-- 
With Best Regards,
Andy Shevchenko


