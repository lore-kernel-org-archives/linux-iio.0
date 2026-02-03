Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03353AEF5B;
	Tue,  3 Feb 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131846; cv=none; b=PGWpxtj6RMFySgu9L7kQMRV2t/JNd30BJboahiNmP0icZQCgb6/W/Oyyf5/pIS88sX6IcnANcFZZ18Mzw6t4qotMz18ziFsvqofwTpBmkkwio3tw8s8pY8qoKyaqMkMIfJit6QT3xoK73+VqemTHESHZD9fLui5vBbQuQyeNGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131846; c=relaxed/simple;
	bh=Ehmeu0Rpu77qcDr4uBHtIU/Dqxvqmqz5fj9ls5mDOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSsQcUOvqUE7/X1ZmC1SfvaPq0vs/4qU0HqJGWyVJdDaHZnFDbttg8h+Rkr8gAwrs9ll2BLkKvQ5jk1JUMjxbD4U5yrCUMnJImqMymXYnXhbKXeikpn7BLCaJV/Bp2j68haZQdyokOlogYkpBZYI9GeapaMPaD8rsLTHA7wdlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox/pWAO5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox/pWAO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770131845; x=1801667845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ehmeu0Rpu77qcDr4uBHtIU/Dqxvqmqz5fj9ls5mDOFE=;
  b=Ox/pWAO5NWUYgls9R/Io+CRXCSIGZeut+4BI6OCIhW6TsIGurL7/eDh9
   a5CZEbLgFeKxQA4pV7A8iMVaIuiXINo2P2dtfIFTWseMS3WXzJY7lNlRZ
   l7WwtPcmPQ7RI00hcBhQozhw1hD2xrS6QqiLHAgG1hk+h8j88LpdOgkLm
   QbG/NmCzXHEFFBfEjrUE5Yo4mcf1sGRqHzhWeDqiZloEzEZwuAn9TAkM2
   r/nPCnkxPFmPekCiNJvcgnzYCQNP6ra5CW2u7xSiCLLv70GLgwvzuOp+E
   w6q0LPWg+ZB0Vji7AJkv10EZVXYG8cdxSuOtJYtIBECpEP59A4ucXYLNZ
   A==;
X-CSE-ConnectionGUID: hCAVgteVQf+x6bZZ8H0CjQ==
X-CSE-MsgGUID: wBbn5peZR+KH2dftUhsx2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82414537"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82414537"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:17:24 -0800
X-CSE-ConnectionGUID: c5ALK/npT/ifYG7YklZc2w==
X-CSE-MsgGUID: +LvDjWfLSjiPqenAqY3cbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="232793496"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:17:22 -0800
Date: Tue, 3 Feb 2026 17:17:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v3 next 2/6] iio: sca3000: reuse device pointer for devm
 helpers
Message-ID: <aYIRf6j0fXR5NcEK@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-3-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203122109.689669-3-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:20:46AM -0800, Harshit Mogalapalli wrote:
> Cache struct device *dev and feed it to the devm helpers to simplify
> the probe function. No functional changes.

With or without below being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
>  					  &sca3000_ring_setup_ops);

Now make it a single line, it's just 83 characters.

>  	if (ret)

-- 
With Best Regards,
Andy Shevchenko


