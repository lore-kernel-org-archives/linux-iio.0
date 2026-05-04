Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC23A9D9A;
	Mon,  4 May 2026 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893792; cv=none; b=Jm9riegANOXuaNu06o7tXrYPguHthZkZpryH8cVAL5qt4JTpoi9Nv6ipNaARCr1G6Wzfhxk7f+i81FsPncCIfjCh3AqnfGbNG6AWy5A42E2dCq3Op37FYO3gz7820bf97fWFJn3noDQ4lY4fZWidpG2jS+nZEUak90ultBo9Jmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893792; c=relaxed/simple;
	bh=OLmE8wK40XFXXX4eMyP6QCIdfgwwzbBnpvTPEAENFL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfUDCfRyO1yTtCdi43Ef09w3X36tbhxvSijBoANXQBNnNwsdHZXQIDt6fpmASsaCBdYkjbkKGQSGBAWFdj6FjxNlvWgfMRAZlockT4Gw9fv3fNUBd48Pi4UXQbkWxjRbA0vXU41EzQagGmX/QiV11NbvGLFFbNURtLPs1fCxuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOkOgzv+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOkOgzv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777893790; x=1809429790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLmE8wK40XFXXX4eMyP6QCIdfgwwzbBnpvTPEAENFL8=;
  b=TOkOgzv+ILkdMTJXc6Fsp/bGZjO3Ffgf1vtslcYupzbYlqCECW3LbQfY
   +5jSrnSDSZ4ysP4zU6dgcnuFyXtDI+K0MX7jYuKLNHNyJgblZuy8/k+9L
   pRdfFMb2J+T0iHPbk/RTOVGRjGvejSsCE6N+T9ly3rsrMCKwtvS/VWuMJ
   0ii5asjJnn7tR1JN8FGNHI6ph0cslPiZWWA25OhmRmKDJYtXOFrb0uBvo
   MWgz2JJg/sGsALk+tMOASRJQ5ycHVMHmMHQwkO0CIcCBlGti96jNaUCYz
   OEAH98SEKbJipbsHIjhOMlvj7X3t3ei3rZQ4127kHZShxLUwCNYo/LxX4
   w==;
X-CSE-ConnectionGUID: gAL7TkXJToO4JN16BFBB8Q==
X-CSE-MsgGUID: VsSboINTTe+rs+fQCo8w0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89851960"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89851960"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:23:10 -0700
X-CSE-ConnectionGUID: efTp8Uj7TKaz7nZKFE75MQ==
X-CSE-MsgGUID: /aGLwqrlRiCqNq+YHPQAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231131773"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:23:06 -0700
Date: Mon, 4 May 2026 14:23:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: gerben@altlinux.org
Cc: dlechner@baylibre.com, jagathjog1996@gmail.com, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] iio: imu: bmi323: Fix potential out-of-bounds access
 of bmi323_hw[]
Message-ID: <afiBmFFnuABWbaKR@ashevche-desk.local>
References: <20260504111946.28315-1-gerben@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504111946.28315-1-gerben@altlinux.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 02:19:46PM +0300, gerben@altlinux.org wrote:

> The bmi323_channels[] array defines a channel with chan->type =
> IIO_TEMP and enables the IIO_CHAN_INFO_SCALE mask. As a result,
> bmi323_write_raw() may be called for this channel. However,
> bmi323_iio_to_sensor() returns -EINVAL for IIO_TEMP, and if this
> value is not validated, it can lead to an out-of-bounds access
> when used as an array index.
> 
> A similar case is properly handled in bmi323_read_raw() and does
> not result in an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

...

>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = bmi323_iio_to_sensor(chan->type);
> +		if (ret < 0)
> +			return ret;
> +
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
> -		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
> -				     val, val2);
> +		ret = bmi323_set_odr(data, ret, val, val2);

ret = foo(ret) is a bad style.

>  		iio_device_release_direct(indio_dev);
>  		return ret;


-- 
With Best Regards,
Andy Shevchenko


