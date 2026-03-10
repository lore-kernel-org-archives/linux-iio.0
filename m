Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9D3BE65B;
	Tue, 10 Mar 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145282; cv=none; b=Et6nMGckAjLgAokQ+/24/ouuxzZRVnmZwUoInFiXauVqRexzmcsC485c9NB6PPIap6m/Q63e3WbU+1KSZvc1krvtd7mGQJhbTjRZ0Q+KounDQDvC2uDffHn88QgRZf4w29vxWQc9WT+Lct5jaKPAO3A9dE5XBXaeGk3x9usx/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145282; c=relaxed/simple;
	bh=eFkBUmpV7WVnCz91t+c89INaY8co7jUAKAGKZqsLsn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLyWq9AN7d9sOKbIaerDUC/dRiSm9dbvXtlLVCQ3CxHqSpzBTbBUYlo7/VWIBs/rUPMRfsHWmEvyhJQA2uPqAlZbuE/gkQvgD2xnws2+4ckR8CC8ttzK/RkuzqC3y+PmAEoBUQpvh3UCJM41Y+vOYZhp2jgumaOPBNXfRt1ouh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM5tuea5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM5tuea5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773145281; x=1804681281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eFkBUmpV7WVnCz91t+c89INaY8co7jUAKAGKZqsLsn8=;
  b=QM5tuea5KLeA+6uJz/kGRfBoIaKjPgND548BAIXvtVSJmLF0C00YXt2I
   cemqnUMRT88lJYgyswMIldxN3Omt2XRqAxWAwgv1Toq0thGt8+xNBgy8i
   9730GajfiWyMa79GFegEvDfl+kIndvdZ76HCwMjFMbXi6FfOIhg+l1u0S
   1iihTXXdAKtG46PjD3BvgFOZ8ycUf+iFSA6zwlsyCtlyfcQFWmkRr4bcM
   aktcD+PD1lHoztRsvISGZGKOH0CR5XKMwSE/e3hQeLy9f7ytJEP5TDuvy
   0jVpfszT6YQ/MAEOLkfXoSdCUiImJyagq8u0TuHvywbwCwZWLVTFtNZrw
   w==;
X-CSE-ConnectionGUID: 1vMXrghOT/O1NURtTMIWCQ==
X-CSE-MsgGUID: B/h21v9jSbK25tRSMzNhdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74090079"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74090079"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 05:21:21 -0700
X-CSE-ConnectionGUID: sVpJ/eRKTCGKrYAA9f+nGA==
X-CSE-MsgGUID: t3m+nCeISg+XdjfClXKxoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216882056"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 05:21:18 -0700
Date: Tue, 10 Mar 2026 14:21:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Message-ID: <abAMvPm0G5jK_GZh@ashevche-desk.local>
References: <20260310-mcp47feb02-fix1-v3-1-d46a830055f3@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-mcp47feb02-fix1-v3-1-d46a830055f3@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 01:56:44PM +0200, Ariana Lazar wrote:
> Store reference voltages in uV instead of mV to avoid invalid error code
> in dev_err_probe() call. Vref variables store the actual value returned by
> devm_regulator_get_enable_read_voltage() function instead of the results of
> dividing it by MILLI. The corner case [1-999] divided by MILLI of the
> voltage reference variable value would become 0 is covered too.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	struct device *dev = &client->dev;
>  	struct mcp47feb02_data *data;
>  	struct iio_dev *indio_dev;
> -	int vref1_mV = 0;
> -	int vref_mV = 0;
> -	int vdd_mV;
> -	int ret;
> +	int vref1_uV, vref_uV, vdd_uV, ret;

Hmm... Semantically ret != vrefXX_uV and putting on one line is questionable.
But I leave it to Jonathan and others.

...

>  	if (ret > 0) {
> -		vref_mV = ret / MILLI;
> +		vref_uV = ret;
>  		data->use_vref = true;
>  	} else {
> +		vref_uV = 0;
>  		dev_dbg(dev, "using internal band gap as voltage reference.\n");
>  		dev_dbg(dev, "Vref is unavailable.\n");
>  	}

Now a question here, why do we need use_vrefXX if we may deduct it
from vrefXX_uV?  Perhaps it deserves a separate change.


-- 
With Best Regards,
Andy Shevchenko


