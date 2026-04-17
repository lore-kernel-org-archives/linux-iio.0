Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173D37CD31;
	Fri, 17 Apr 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450621; cv=none; b=kwqcNlXU9ynEwdvyDBtvq69H0fT0bOdnSn9PY4xHGuP9X9FQaU36YscDhK6x7Ko07p6EvbJ7EbqQWmcd3yWwlZTNBmfnKe9oxR9BUyVNa8RUj1Kq/ayLd/zN3ghMGoemMfqHd17/+nwUsmumneSYXUxH+ilfL3cb84JhiX00vfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450621; c=relaxed/simple;
	bh=3kmTogxbiTa5dM4pR6otlJ8XOwDMuPwCPpCuSsGhwNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DByxRRA+nS7O3jz5xSich8c5wUcl+DaGdMmIJiA/SV80NjIc8ZDnrCZjxMqL9+cT07u3jKRDanko2elCSeMgcLZmSuvEKv9lpo+8E+o4YSc8oM/X8x9MOaegosn+OVK5B3PnPh2Cd8YjQUxnvT2lSIXwN1KbRbZdrk0EDyJinjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObIN0/0B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObIN0/0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776450620; x=1807986620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kmTogxbiTa5dM4pR6otlJ8XOwDMuPwCPpCuSsGhwNY=;
  b=ObIN0/0BBLxboOfGBgN8ki6kGfg95+Po81/lBbnfC+He3M6UziIDQXJr
   qaj0ztuisKjbvSZZ8xBykijZABfN7FI55Bj+B9I9ijjuyb7DSPrVq4N2N
   ASNBInR43Mr8EoJ2g/mq0Zs/cDYwQ2+I5lq8apIvpkcBLGOM3Orw/9IMU
   M9u192MoqIkkVrGNrZ1E0n0W+zz9KdYyLSRshUYYhijLqZWPBV1gZyXiN
   8Hy8FySQSoMwPuGPTCgdWlfRruJ0I/rpLSKO2NdoYNDHIEdQR1mSL9UBd
   fuCgniQUDVJalPBGWdy3HDUJmAElKk+6lAD/NlnamM+KYe9b3b3r3RIho
   Q==;
X-CSE-ConnectionGUID: 07b+PEQBTuaI1XFTu7AqaQ==
X-CSE-MsgGUID: fPIbZAgIQ+emP4mtCWHf8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77378798"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77378798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:30:19 -0700
X-CSE-ConnectionGUID: Gv3uZWhuSEmptNZHexg9dw==
X-CSE-MsgGUID: WoeeFo3iQpKFM9Xuxz/RIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="235476305"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:30:17 -0700
Date: Fri, 17 Apr 2026 21:30:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: remove unnecessary braces
Message-ID: <aeJ8Nlg1DTuvknGA@ashevche-desk.local>
References: <20260417130224.1308-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417130224.1308-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 01:02:24PM +0000, Joshua Crofts wrote:
> Remove unnecessary braces at single if statement block.
> 
> No functional change.

Code wise is good, but I think it's an unneeded churn as a standalone change.
Up to Jonathan.

...

>  	ret = i2c_smbus_write_byte_data(data->client,
>  					data->def->ctrl_regs[CNTL], regval);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		return ret;
> -	}
> +
>  	data->cntl_cache = regval;
>  	/* After mode change wait atleast 100us */

Side note: you can also fix a typo (missing space) and

>  	usleep_range(100, 500);

move the driver to use fsleep().

(In a separate change.)

-- 
With Best Regards,
Andy Shevchenko


