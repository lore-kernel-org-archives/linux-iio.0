Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4A31813A;
	Tue, 28 Apr 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363211; cv=none; b=aZzbdNd+1KoA97ASiWYBqjBDgjs1UCKFUMuFkk0Onw7/jHxe5PiITxaXYdrLc40GxcswdkQMOlAXLEEEBBnD3/u1sCrTe/MrQOoISv49dawZW8n6D4CTwULeoetzq6uWcA8I0EHz5r+hC3qdwDmUydhjGMnPQlY4H1CqmYqJnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363211; c=relaxed/simple;
	bh=s6QvK267yaOTO23d0CuunCbayo/n7S1ukPM6TDZ6qKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNtnFfPdIkM/uF6hJUezUIph56yDZV0fnRhm/SoiDYZargn7QhrU84IOiBgyMPhuB4jt8V11simxQy6b6XZ0V1V0aflSAm0J9clGjQlriHH7/x4mIOo/ucEQww3sJyoev4h5slk2XKfJrvCR/MJQWweaoPT+M6IOCxupR04exNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GG5W3rOw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GG5W3rOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777363209; x=1808899209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6QvK267yaOTO23d0CuunCbayo/n7S1ukPM6TDZ6qKg=;
  b=GG5W3rOw4g2m/Lf8F3O3H2YKoXyojoEBxGvrPUrFJ9jv+sl7AMo4rrGL
   d9INBBqCxq3zYkeQIiy34NTFDP1H6uuJhQuevVfSqjgN7Zo4tnBD0DmIJ
   pY5UCJXcAzlvZEyoa1kwGWkb/jGMIWHsXqHfscrkRNF0HaLu9XHARz9As
   E9L9FZVFHWFlY7Oyt3nHhzxyq3Ehh8Pf3r2q0eWeZgF7wCcLL/HNGFN0j
   6Q3PdxPEHTbnfkYtRUqoIoPlXj6vk9n4UFqc/AdQBMwdUheIaENMQuR4G
   WkjMQNGZ85xaHmbu7xumk1i/Z1qRGIk/z96Yc+NnvGaQkWGRnjFicpFwi
   g==;
X-CSE-ConnectionGUID: bNnu+JbMRF67TlSBMUpmKw==
X-CSE-MsgGUID: ELwJfJJITZ6jQ8r0AEXvrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77428211"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77428211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:00:09 -0700
X-CSE-ConnectionGUID: rK8bJTl8QMaBn3l7IwnZRQ==
X-CSE-MsgGUID: iBQatMWkQBWk1fd4L8W/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="272010496"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:00:06 -0700
Date: Tue, 28 Apr 2026 11:00:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value
 checks
Message-ID: <afBpBNLucHg25So0@ashevche-desk.local>
References: <20260427215800.28082-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427215800.28082-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:
> The functions gpiod_direction_output() and gpiod_direction_input() can
> fail, but their return values were previously ignored.
> 
> If an error occurs during the GPIO configuration, the function should
> abort the wake-up sequence and return the error code. More importantly,
> failing to check these values could lead to the I2C bus remaining
> locked if an error occurs after i2c_lock_bus() is called.
> 
> Add return value checks and ensure the I2C bus is properly unlocked
> via a goto label in case of failure.

...

> -	gpiod_direction_output(data->wakeup_gpio, 0);
> +
> +	ret = gpiod_direction_output(data->wakeup_gpio, 0);
> +	if (ret)
> +		goto out_unlock;
> +
>  	msleep(chip_info->wakeup_delay_ms);
> -	gpiod_direction_input(data->wakeup_gpio);
> +
> +	ret = gpiod_direction_input(data->wakeup_gpio);
> +	if (ret)
> +		goto out_unlock;

While technically it sounds correct, the potential problem here is that you may
fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
What may happen if GPIO is not optional, but for some reason setting it fails?

TL;DR:
I am not sure about this patch. At least I'm not comfortable to take it without
testing on real HW.

-- 
With Best Regards,
Andy Shevchenko


