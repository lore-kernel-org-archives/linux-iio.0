Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37433364046;
	Mon, 11 May 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497996; cv=none; b=WMU59226UYnLAA5Nm9EpHbcPTRExEUjfVmw+7KjMZdw9N6Tk1vm9wNmTwUWxEfK61qPvsMX5PIi1Pty7egcGBz4/eKMc/J0r8o0V0vwIduLrxKvbS1dCnQK+udzEyyPaBJOS5eu0b2SdoRrmOVQEXWZKeH/1ADhoPTadbrKpLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497996; c=relaxed/simple;
	bh=aKF79kqUO2lhxMz+OgEqtc3DVwTBnRtLbb1ry/0z8RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEMe2gQS9QMkptHZ3K0llvpKRPUEa9AU3fsRcPCwPwLMinlLRv20kq3YTSNXU2dM0vJeg063vWuubTkt00kysRU3Kx7DQXBzjk1Y+DJrMGwZeVt6+lj/P0pgcCswVMJMwPJCv3LD+yySvU9GVaXyHty/H2fjJP7z+tTdKOBQS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMMOxqAr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMMOxqAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497995; x=1810033995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aKF79kqUO2lhxMz+OgEqtc3DVwTBnRtLbb1ry/0z8RQ=;
  b=PMMOxqAr1ILTOUHAFAmV/vdDq5Pi8YOUymxS+RuLG6TEU2F1AAOM/4KB
   Zv4Xdt3rateuVEuF7OgpGibgE3pfnSkaaAbrZ733bh5yLQdUVSwnPVdie
   CF/4vwIqtk8SKdyv3zLvgjL9zhHyThd188t4IYiX9McJ8+bTgMbc32JEx
   h4Oi4Ti8OO6/tLrrd0638tRIbtGQqfRRCm9nMLFBKi1dfUY1rDwRwKlDO
   dXXXKw4mPszk3rTAi/dh15XSv9E+j4l8Jj8XqgkIDNVI5KhLaWLDSaylB
   2NoDHf/s1lTEy6VXaj1ylH9xZwG9wdVs1jaillGolJaMv+W5YIAhocS5L
   A==;
X-CSE-ConnectionGUID: sTs+lOGsRxuCZLUaCAu8PQ==
X-CSE-MsgGUID: UzluF416R/6rA2Px3u8c3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90482122"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90482122"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:13:14 -0700
X-CSE-ConnectionGUID: j308AggqQmmeqgKnwrgRhQ==
X-CSE-MsgGUID: 5HI2WGbyS5CktaGO2NlHSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="237651463"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:13:13 -0700
Date: Mon, 11 May 2026 14:13:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <agG5xusKnl_NOn8_@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:12PM +0200, Joshua Crofts via B4 Relay wrote:

> Move the driver to use devm_* functions to automate resource
> management and simplify error handling. This also allows removal
> of the opt3001_remove() function.

...

> -		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"opt3001", iio);
> +		ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"opt3001", iio);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "failed to request IRQ #%d\n",

You need to drop now duplicate error message.

-- 
With Best Regards,
Andy Shevchenko


