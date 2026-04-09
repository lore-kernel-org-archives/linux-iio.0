Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663F39A806;
	Thu,  9 Apr 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727308; cv=none; b=dyanF0W6bF6uFF19rthtF4pZpglQeac1WwthrUdj7Ylyo/RPRWTXFd55OLCQGSeoLncWeHRXa6OQArw/Sia26G40mymwodGf0Vtkpky4z6fmNcd1ZD4ofaVzK1esHfx7bFdxOwEbeavOkrR1ZlUhEnvomAUYqj4TivQJUP0TLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727308; c=relaxed/simple;
	bh=aiPMN0rCbtn9ZdXGLDSuRLXtz8uBc5VGEKLrCuUKg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCH8miRq9YkR4fKVs1AHzLf7m/cbPAlo9ihIiO/CwU6+tWbd4P/rWoyE9fF1oPoQnq1vZjWuQAQzeOTYqWqd8P/3WU/l3T3z15E5jWJ42+JL3SiLKPOt8Cu9Q5mOyR1j+ttZ3HuaTpmofBqZymmSmPmEbIP1vLFX+GCREWiztrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFrkRSe9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFrkRSe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775727306; x=1807263306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiPMN0rCbtn9ZdXGLDSuRLXtz8uBc5VGEKLrCuUKg+Q=;
  b=YFrkRSe9ifJIaTu5LcLHvShN2LmKTK8Ngn/wAzVoXYS46A24zzQlzHG1
   XE/fRP1RkRDHpnMv3Y9ydOZiRh0kLyMTu+r7zbHINYM66IGFVz8DOLVxh
   3ks1nL8ZeOsVfGRnGogTQh1fpvfL7SWB4+GjtWuGifSw6uONa7I6J1inN
   5ox/fI8bu3XorD4/JVr7pUUhnsfIJ9gLWAF2b33bfXFuwBhPxOIE+HEUY
   3nSK6pcKXafF+Ai7wJ6e9bkYNChksJNec6nbF9IBciSuKy/jnHa/aSSXD
   mBvWfd51vM32HwvIg7UVWb3Ua5+tM19iT4SWxMS/pPm3iJYK1+/nyAOWA
   A==;
X-CSE-ConnectionGUID: XjVu/klrST6Q1wRWecZaXA==
X-CSE-MsgGUID: JV0icBHSR2yKUYFzRoASfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87016251"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87016251"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:35:03 -0700
X-CSE-ConnectionGUID: GZEB7otATtuf8LvAxGPPRQ==
X-CSE-MsgGUID: dKAFXiRCSE+4h49lgwHnnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227867311"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:35:01 -0700
Date: Thu, 9 Apr 2026 12:34:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: light: vcnl4000: move power state function
 into device-managed action
Message-ID: <addywsAU2ku-s_tY@ashevche-desk.local>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
 <20260405-vcnl4000-drop-enum-v2-4-7c8dc98c3974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-4-7c8dc98c3974@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 05, 2026 at 07:08:41PM +0300, Erikas Bitovtas wrote:
> Move power state setting into a device-managed action to get rid of
> fail_poweroff goto label and remove it from vcnl4000_remove() function.

...

>  static int vcnl4000_probe(struct i2c_client *client)
>  {

> +	ret = devm_add_action_or_reset(dev, vcnl4000_cleanup, indio_dev);
> +	if (ret)
> +		return ret;

>  	ret = pm_runtime_set_active(dev);
>  	if (ret < 0)
> -		goto fail_poweroff;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto fail_poweroff;

Shouldn't we undo the _set_active()?

> +		return ret;
>  
>  	pm_runtime_enable(dev);
>  	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(dev);
>  
>  	return 0;

>  }

-- 
With Best Regards,
Andy Shevchenko


