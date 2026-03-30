Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3742C21C2;
	Mon, 30 Mar 2026 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865367; cv=none; b=f4kQ6RQba5I8Kx/TOghk/2Zpki12mmDsefwP0S19Sm62uAaXudQ7/vGA32zBG2sWRdH/A1007ITGPVoJqoiSc9neuESKRkEAKcgoYU0muZV8Vh2MEp4TNxi7+DyrMQpTXfomN3Onnb22gckZ9DL7fa4FQ06cDy5X63iJGYx+mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865367; c=relaxed/simple;
	bh=b1wbgVKmqFLid/23m/YU5qgot5QtI5DzMi8gEjYlWeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsVmxf5wwEc0eCeeEdm18lsryQsER6xFgtLFZoYxdQFb4AK+Asa0DIoCHODqC2UbSWUkVsaFn2yM5Hc6yvQ2sGRL9MBCCGWrD0zb5GC+3Olf//pb5578n0MhiDwLb5giA0N+p2aqj6fMChD3SfzbbzK7Iw5BgvVOTKvOLc0+p5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgtIUC/+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgtIUC/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865367; x=1806401367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1wbgVKmqFLid/23m/YU5qgot5QtI5DzMi8gEjYlWeg=;
  b=BgtIUC/+2i+/JLq9AYVSdqzqFTtYu/zPf/v9iqXYbtpqqk2906wJ3WLZ
   N1uMAae/8joz19jNToRo65X5TCOunFn+0lsb/M9+EXvNiwqRbwKw75F8u
   +jOosNg1tmM10gJii4MczKmHeK+XMaBKSfnIqvUTNtgUfxa6r/mOeb1hj
   220X1guW7179619PC/5ciQm54JSONryRA/sTm7pHJRqDWz+g5vjOH15uD
   gThdX6TTlza1u/lfIdv8Sqb1hfLCo2omrMbPfOsdSgQK8cSlOf3CmHhB8
   keFyLucU5kg0Cc7+g0E7+f2cJofu8QzwtA4Y+uC0Gfh0pvYQyAsRwS5Oc
   Q==;
X-CSE-ConnectionGUID: Cl8ONiZtSrK5xYdLKtU6Yw==
X-CSE-MsgGUID: OTcEGMjCQWu6Kn1gCzZHbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79719387"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79719387"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:09:26 -0700
X-CSE-ConnectionGUID: nZo+FfT1TIuDiheCutHltw==
X-CSE-MsgGUID: aKNm0gY9R8aDx6TX9qAqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225912947"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:09:23 -0700
Date: Mon, 30 Mar 2026 13:09:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: use sysfs_streq() instead of
 strcmp()
Message-ID: <acpL0OgqPYoVbzb-@ashevche-desk.local>
References: <20260330074850.12638-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330074850.12638-1-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 01:48:50PM +0600, Md. Mahmudul Hasan Mabud wrote:
> Use sysfs_streq() to compare the input buffer with the mode strings.
> This is more robust as it ignores trailing newlines, making it safer
> for sysfs store functions.

...

>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> -	if (strcmp(buf, "full") == 0) {
> +	if (sysfs_streq(buf, "full")) {
>  		gpiod_set_value(chip->rdwr_pin, 1);
>  		chip->mode = AD7816_FULL;

I think it might be better to do more work on this.
First of all, convert to use IIO_DEVICE_ATTR_RW().
Second, convert to use sysfs_emit() instead of sprintf().
But with that, switch to use a static array

static const char * const modes[] = {
	[_FULL] = "full";
	[_PD] = "power-save";
};

This will need redefinition to start from 0 (I don't see why it needs to
start from 1).

#define _FULL	0
#define _PD	1

This allows to switch to sysfs_match_string() and return an error on
unrecognized input (which is absent right now).

So, something like series out of ~3-4 patches is expected.

-- 
With Best Regards,
Andy Shevchenko


