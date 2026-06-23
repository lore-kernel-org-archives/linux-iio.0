Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033A34752F;
	Tue, 23 Jun 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245923; cv=none; b=dcMFUCcKLX0X4+AorOE4GfQRyKhKCTyQNfqToM2v9B9O6OExO1g5hoXwveUdQzOe1cSA+Ly+nSkseJmbtwL9JIoOVl5+j5Ah73rcQx8et+g3Fc//tBBPlaWUq61wibFq1PY/miIHR/j9kMFBNTltxSE0bzEtRcxXyl/3JcFDXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245923; c=relaxed/simple;
	bh=uvVFv53CXK/rEhLQGkQzZ/g5szLMnAPogO7PmwOV+lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLckSbyldaDJcenLxAMDdVQunDJzRqG+BPJdSxWjXUqMTPvBpQcLCWwvD2PSz3yJ5r+5nlQEGG1/JW2fxsUs6KShRi8H0f0u7XRYsiAs+uHtFBvHICw05GifhKmkhmScBbXQymSOpxEx8AyQLUQ1sLA6+N77PZT41hbw7F3D5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHPz18Gh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHPz18Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245921; x=1813781921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvVFv53CXK/rEhLQGkQzZ/g5szLMnAPogO7PmwOV+lo=;
  b=PHPz18Gh6XssBjmJWetFjhoMe4/kcayDSBI8lYqRaVErZulTtZTbOUzq
   Bif0+GAhF42VXem1p0aiWp+uWshD7ISsIyUAqrk/4Vsj1jEHkV5TANhLh
   FPolmzhx5CYiZp9ndeUMnpez5KKnVK+ITdzsk1UrtNAWYYtlJYAmtogRF
   NtiHsY4xoHcpq1vFzAeFbut0EFJ6Tw5l3cStR4d9ds7keUbdz8upfSVTc
   iWH0ivYUIZnN7zeGB/zI1WatGZYtE8lPXUptYib87eozxD9tvfuSbelrQ
   V5Axv8AlLXekGJYTKNOnw2NS7BsbokkMp0q4GfONex5lT0lxpla2F7eGv
   Q==;
X-CSE-ConnectionGUID: PQIRnN8jSkqaKi1gejRg4g==
X-CSE-MsgGUID: 73QcExFqREyTUlO9s+CY7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86904529"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86904529"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:18:41 -0700
X-CSE-ConnectionGUID: lVRDWY74R2+nU3oekvaWwg==
X-CSE-MsgGUID: NYWCem5uQ829Lb01T984gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273684743"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:18:39 -0700
Date: Tue, 23 Jun 2026 23:18:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: add buffer hwfifo watermark
 attributes
Message-ID: <ajrqHJk7bbKLQJBS@ashevche-desk.local>
References: <20260623-inv-icm42600-add-buffer-hwfifo_attributes-v1-1-d190800e60de@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-inv-icm42600-add-buffer-hwfifo_attributes-v1-1-d190800e60de@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 12:10:38PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Add hwfifo_watermark/min/max/enabled buffer attributes.
> Hardware FIFO is always enabled and used.

...

> +const struct iio_dev_attr *inv_icm42600_buffer_attrs[] = {
> +	&iio_dev_attr_hwfifo_watermark_min,
> +	&iio_dev_attr_hwfifo_watermark_max,
> +	&iio_dev_attr_hwfifo_watermark,
> +	&iio_dev_attr_hwfifo_enabled,
> +	NULL,

No trailing comma in terminator entries.

> +};

-- 
With Best Regards,
Andy Shevchenko


