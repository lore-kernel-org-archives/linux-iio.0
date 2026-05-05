Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60727241CB7;
	Tue,  5 May 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987253; cv=none; b=MVcUQKWx3pKEgvfOTy2j9MU7imjJ+E5iEyKeorE9MzYAaTJZVHodoaJlDKEAPklK4ZZ2R0fYJMFUENPB7dbY3dXaZOXSPhLEWSZNdtGScWmwzdKUA0/Ru2Fd4Sys/ZFYxwXcaqaNgbUoUKNNU79D9jE+hWXUfEIr6GH2eX/7cEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987253; c=relaxed/simple;
	bh=Z5vNW0939nzE3ajv4jcRSpP5El+v036Xm8P6+kDqlI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAjlvzGOK3hn9H5aBHyS/tgc4n3iwfG8rSbSOXVosudgXCiEFn6zrPVNa0t4T3+vKS7NZJvYjUj+9tXnZJ1goSoTy7WVxEz5HSLHOcSorujXZKv75vSinRllswM8cYZGO5J1axfHtCH2gjqlFrN6BAEOP2TvaUaXxLe2DHZAy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM2903XX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM2903XX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777987252; x=1809523252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5vNW0939nzE3ajv4jcRSpP5El+v036Xm8P6+kDqlI4=;
  b=VM2903XXT7q0LJI1HZ91RRpXs8sM8muk77jEDlreKjVLqh+rmGxsTEya
   WEDFPJPX+GvQvVFvIxR9PkybxsaryoQjhgHLLt4Xcbr2sN7h5y18FC6g9
   JMk2Xz7axezIARG+d3QjELXyH/xXBFAieXc0eZgjSgEupEvI1mO8+snsu
   eAAIzdrDQadFkdfGZUsbCWJPdi+pK1zy8KS9x88vS2VlKolH7PQ1YPeAJ
   0UnmNQ21mlucxKCZw+RSnos6ezhdEjfvl/K5oyRd0gMwbTFaDSUMzJWN9
   IvDG2ZAVi0I9yZrvENVaQW+6Ile1N9fRj6oWvSpb/8tU+/a8x17Z7rdWq
   g==;
X-CSE-ConnectionGUID: 0mMJqFprQ8KcWfl48298+w==
X-CSE-MsgGUID: yn3Fp4msQB6HiZQaHyd8vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78847018"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78847018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:17:43 -0700
X-CSE-ConnectionGUID: JpQMSc4RRGCA/Pm+bToJyg==
X-CSE-MsgGUID: omsQqLIqSu+b5dg3j9Y+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235896229"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:17:36 -0700
Date: Tue, 5 May 2026 16:17:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <afnt7awu2vRI8JTh@ashevche-desk.local>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add ad5686_pd_field_set() and ad5686_pd_field_get() helpers to cleanup
> powerdown mask control. Define AD5686_PD_* constants, e.g. AD5686_PD_MSK
> to hold powerdown mask value for a single channel. AD5686_LDAC_PWRDN_*
> macros are replaced by AD5686_PD_MODE_*, because they are unused and the
> LDAC feature for async load of DAC channel values is not related to power
> down control.

...

> +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> +				       unsigned int *pd, unsigned int val)
> +{
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
> +
> +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);

Just noticed that semantically this is more like _field_modify().
Besides that I would consider adding a shifted mask variable or definition


	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);

> +}
> +
> +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> +					       unsigned int pd)
> +{
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
> +
> +	return (pd >> shift) & AD5686_PD_MSK;

	return (pd & AD5686_PD_MSK) >> shift;

accordingly.

> +}

...

> -	if (readin)
> -		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
> -	else
> -		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
> +	ad5686_pd_field_set(chan, &st->pwr_down_mask,
> +			    readin ? AD5686_PD_MSK_PWR_DOWN : AD5686_PD_MSK_PWR_UP);

TBH, I would leave the if-else untouched, only branches to change.

-- 
With Best Regards,
Andy Shevchenko


