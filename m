Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FD39D6D5
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707527; cv=none; b=i/p42ryFx2W3PKFHp+nsF23oc/MfwVTHHAVOZdIWJgn1mZmsT4G/CUZSYqL6hConI40Gb4x9uEP63wv/dmiAO3Zdo3fvf2qH0XQdiZDA06XnBgdxtyN1NtulApJOOdvzd4ErMEpI9cvFD79ylKwHdDiaKc2QquBwYaFpOuWKBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707527; c=relaxed/simple;
	bh=eMYGOMBl8PjAXmzUoCU7eoG0nBsUaAMorPEk4AOeCSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUo+xH5d2YUZax8XZdeZCa4rLE/m2aZDB6rZ41mKR49pIT9ls0au3/OdxeaQSNIDYVGn+fUQXfEByHSsa467ioOVk1sBHg2kJpqYycEfgEp0xLd6LWEwP3Bvf19km1VuUusL+efXIPeGhYi1KldLg040TscAHHaWBINI5RZKF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmJXn6BG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmJXn6BG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776707526; x=1808243526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMYGOMBl8PjAXmzUoCU7eoG0nBsUaAMorPEk4AOeCSM=;
  b=KmJXn6BGJcu4iq4T/nTRzGTsj3cYAij41ZqWdikLKWxybMRWwQPnaylQ
   7M0/tIolWyo7/CDNVKTn/vaSQaZNLZz6QNNfMKEOK3Nt6MRNwD8gtgL2H
   jGzvp9PKc+oqGROJymLAeGyWnPR3jnfWLJ/DEvRlhbBzFDU2wY+Lwqqai
   Swh74/TJSlfAWXIE8/kkIGbuuaqOZFDt0qICONAmkH0aieS1rsg4jua3K
   LF6WVYAnAYJkRbmr+1Oxs0b7q5SFNanAHEGHgN0CAFcI+x88tQ64T3gyO
   XQkIrcVNecUHneL6k9aFsMofvpibvJrfwiQiCr65F65HKiZOLc6ywi/jl
   w==;
X-CSE-ConnectionGUID: +5wQP9wZSW6Ql1QqXC8pEg==
X-CSE-MsgGUID: C6zvly62T6q0HI0UPnLYOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77543482"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77543482"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:52:05 -0700
X-CSE-ConnectionGUID: nwlypzOARlqdrw9SoApc0g==
X-CSE-MsgGUID: wIkDkUkbRLqUq9utO9z7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235802152"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:52:03 -0700
Date: Mon, 20 Apr 2026 20:52:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Luiz Mugnaini <luizmugnaini@usp.br>
Cc: cmo@melexis.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: mlx90614: use guard(mutex) for
 EEPROM access locking
Message-ID: <aeZnwBmq67YZaHbQ@ashevche-desk.local>
References: <20260420141512.196932-1-luizmugnaini@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141512.196932-1-luizmugnaini@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:14:29AM -0300, Luiz Mugnaini wrote:

> Replace mutex_lock()/mutex_unlock() pairs with guard() and
> scoped_guard() from cleanup.h for cleaner and safer mutex handling. The
> lock protects EEPROM access across five call sites in
> mlx90614_read_raw(), mlx90614_write_raw(), and mlx90614_sleep().
> 
> In all cases, the code between mutex_unlock() and the end of scope is
> either a return statement, or a call to mlx90614_power_put() followed by
> trivial computation. In the later cases we prefer the use of
> scoped_guard() to avoid holding the lock longer than needed.

...

> @@ -139,6 +140,7 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>  	return ret;
>  }
>  
> +
>  /*
>   * Find the IIR value inside iir_values array and return its position
>   * which is equivalent to the bit value in sensor register

Stray change.

...

>  	dev_dbg(&data->client->dev, "Requesting sleep");

Side note: consider dropping this kind of debug messages. They can be easily
enabled by ftrace infrastructure without being explicitly coded.

-- 
With Best Regards,
Andy Shevchenko


