Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E72D73B5;
	Thu, 26 Mar 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552269; cv=none; b=rHYleuey73X5+4E/d/EKwMpFHoy1zuYjM0q4oN2S3x2X1tzzXb1Ng598jYenVEmcVrL/lq+XGVJJbetDEa4yXz+SXV7GsLaOSa4GJ6jlgQfSugCtdHvz5gLDGOxf0FR7KX1Usbsfm8zdFItiOs82+WFIoEJ2+RBPAVXoBYymgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552269; c=relaxed/simple;
	bh=+lOg7lqk+UeaJp2eIsvLJ2vsA5QwuYtE5W5Yxg3D5FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqmsZwODAF3qCLQNc7bNQmXzJjZLfMNLpKe4HFp/bsqWNk247nDIKOdGlBqexsxz2HIt/kk+8EbTJ0EWrpBGLFy0mxH0LOgq5KNKeVnyKu/lyMJ+sQtvbE+Nd/DpBdwFbPDsPFDEAvm77tOdi1GpPWEKAPamAOlDGsI+4MvviVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzSaJ/Bt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzSaJ/Bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774552268; x=1806088268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+lOg7lqk+UeaJp2eIsvLJ2vsA5QwuYtE5W5Yxg3D5FE=;
  b=ZzSaJ/BtarSGtbrQI9yU8RphYbMuVaoNlAKlJFd4deQJgtnzzy3mDZlB
   gps+rhx7Xf8fCSPNGOB1++Zx+GebnsrMs3ieC/T5WS93mHL0i9QPXe1ZQ
   +1LKVtoWW/ffCVR0HLNXHgKOyH0mTkwK+goxo+3S1kryiHH6fhsWw/fA1
   PVJvsYVwqXXAgOENST4O6IYx3ooQNdAcNPuGTXfwEOoth9ky95nyn6a7t
   x/Pt2o4yH1FXR93OI4JJSCRoIwlhfzYb3LNMNlshMAkV3zSxTV9h7Jjdz
   YhvckRxi4AMp8H5z37K/90TS0eo463HOICgf8auKW+wZ6En3iQcgQBayf
   A==;
X-CSE-ConnectionGUID: A6px1HwXRoKt1ixcx+U66Q==
X-CSE-MsgGUID: 425vIM8USdOA0mZQ73Dipg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74653565"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74653565"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:11:07 -0700
X-CSE-ConnectionGUID: FOhhU8aCTJSg2cNaoS4oHQ==
X-CSE-MsgGUID: ovHFU+sFSY6hpbkEDEDp2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="218489189"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:11:04 -0700
Date: Thu, 26 Mar 2026 21:11:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: adc: ad799x: use a static buffer for scan
 data
Message-ID: <acWExsBF8LGng0L-@ashevche-desk.local>
References: <20260326180529.19154-1-architanant5@gmail.com>
 <20260326180529.19154-3-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326180529.19154-3-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 11:35:27PM +0530, Archit Anant wrote:
> Currently, rx_buf is dynamically allocated using kmalloc() every time
> ad799x_update_scan_mode() is called. This can lead to memory leaks if
> the scan mask is updated multiple times.
> 
> Drop the dynamic allocation and replace it with a static buffer at the
> end of the state structure using IIO_DECLARE_BUFFER_WITH_TS().
> This eliminates the allocation overhead, prevents leaks, and removes
> the need for manual kfree() on driver removal.

...

>  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> -			cmd, st->transfer_size, st->rx_buf);
> +			cmd, st->transfer_size, (u8 *)st->rx_buf);

Indentation also can be fixed while at it

	b_sent = i2c_smbus_read_i2c_block_data(st->client,
					       cmd, st->transfer_size,
					       (u8 *)st->rx_buf);

(no need to resend just because of this).

>  	if (b_sent < 0)
>  		goto out;

-- 
With Best Regards,
Andy Shevchenko


