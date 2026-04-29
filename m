Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA334219FD;
	Wed, 29 Apr 2026 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488288; cv=none; b=UdLI9Av1JY30SNq+R9b/Xtzw3RgKnQgLzJfiL0l9wP/K7uEevT130n8IeTa7TZ9sS8FsEVBnnskTsj8bZvizuHu/zPH2Ik+BxgMxHTdTJiJUQHqGBtMeAs3jjyGJIWmMf1CwTUGtyE4gs9YCrJwOKXmIPSSRoIfKxEC1f/8c07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488288; c=relaxed/simple;
	bh=LFwrqm56VV4SH3MszIwuuyZc+GzyQQrQtJOjF4akcqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeRsyAGqujgWTiKoeBjpevIGLbP5hLWNG2DRK9K56Nf+bXN61NO6XwEKyiVYreLjNFmYThuQaUDFdpejc0RQtaIpHZLHJDrHk+alnRAekgoLC5DgKjGb3gp5vq7zztHhCy5J+Kro+c0jq+84PH8MFmXvk5rWfvznNwRV6W3Ulcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIQCD5nm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIQCD5nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488287; x=1809024287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFwrqm56VV4SH3MszIwuuyZc+GzyQQrQtJOjF4akcqc=;
  b=AIQCD5nma8+Uma22Or68+f9yQbeiNuXENAoQqqnfTyw49ifu0cQpuPoA
   fGjBBavzvMCiNzxJP7RnnO6zdpgY+Ig0sxWyjJ9bVE2w5hronwowdsmKM
   lE2u4g5EmaJP3ApyJg6MhIHkmLV27/ag0ADz22i76glApFo27WEOONljQ
   yrSH9IjVJJpws9DwvCEI9p8Wm09ryveiEdwR55Dy0g+bSo1MIipTXuCgT
   6k+5UnoxN4exha8vVD2CjS1m41bmNGCmGDx8cC5KR5mBT9Qd92EtBf37e
   Z0erDBVAPe6c44IQmLFmJPSaEzUfoHQacUNVqApVO7VnLGLkqPIU0Thgp
   A==;
X-CSE-ConnectionGUID: zSrwbbiISW+rxLSqHbeoOg==
X-CSE-MsgGUID: ej85uIQBSPS8nmJEhnv9zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89024992"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89024992"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:44:45 -0700
X-CSE-ConnectionGUID: gSCnIhR5R66zw6pPhdagmg==
X-CSE-MsgGUID: QHVZMKENSr+T2TI/R3TYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239373453"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:44:42 -0700
Date: Wed, 29 Apr 2026 21:44:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/11] iio: adc: hx711: introduce hx711_chip_info
 structure
Message-ID: <afJRmJsZ-8ag0MSq@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-7-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-7-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:39AM +0530, Piyush Patle wrote:
> Add a per-variant static configuration structure and populate the IIO
> device fields from it at probe time.
> 
> This is a preparatory change for adding support for more HX711-compatible
> hardware variants without duplicating the probe-time setup.
> 
> No functional change for existing HX711 users.

...

>  static int hx711_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> +	const struct hx711_chip_info *chip_info;
>  	struct hx711_data *hx711_data;
>  	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;

Follow reversed xmas tree order, please. This should be two lines up.

>  	int ret;
>  	int i;

-- 
With Best Regards,
Andy Shevchenko


