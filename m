Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197F26B777;
	Mon, 16 Feb 2026 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228517; cv=none; b=QvIHTa0tq09v5BbDUpoh9Ht3RC8lSvce7OPNyYXeQRpCC4QMBMLlnWBsyjmHVdlY9UJ5fWxavBx0T8MPV0Y4a+ylSehBSahi5Von//eulcsSKPSK4eALXNy3ml1+QsijRGoLBKd4+77IrnxBnmzvQnQau3xzD/OOINT5ygbhLM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228517; c=relaxed/simple;
	bh=0fYhSAk4HLX9L0EAeeFOZ8be86bDjs6lkQA6J6/zWhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMUffNX79SJJrsRFW04D8j8+mC/d4XaHjJPFx1nAkSLyG28l7ZvyT1wp9lUyM4PDwwTQhVeDC4Ylj/a+5Qe9H9WMoibRfOGYmF/CS5use5Egbaf+sckh7Lenp7QBnjIhWy2EZXp1uYnIznqKoFYBU2By1B27ri2+QiuApqFzjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FypHCj8o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FypHCj8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771228516; x=1802764516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0fYhSAk4HLX9L0EAeeFOZ8be86bDjs6lkQA6J6/zWhI=;
  b=FypHCj8ovrpLL7CPlUiOOwBH/bbz3nRUbWo3Up7uYHfN+aUKzo7p/3lR
   eRKsH9tc2obJ8WpW9OUUT0E31Lybdc27FQYkd03LRtqqAnJRMt0O8ooeO
   xQcOP9Kli6xyz3w/bEoSvSufOkOBN4PpP/lQIEV+jxE0IwBLRTlqoByws
   au0m8TA0Xpuiu2iA1mz+9XAEe9Rq7EKRV80vODsJ1VBOs9v85EEHeMiwV
   D1HudBDEKvBgM3UFhsXUiGYlAKWVm6TtReYTPJLlAAeLIlBEnaGHm4xap
   8QPsDTET1SrPvyZKlKBOpgwrOWZwRTNvTdyTA/h45CD1lJMSrqmKBAgjZ
   A==;
X-CSE-ConnectionGUID: ygARkbBiTdaEF4/++96QSA==
X-CSE-MsgGUID: KsGaQIbtT+KfBHwy8Z2pQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="83668660"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="83668660"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:55:15 -0800
X-CSE-ConnectionGUID: wYT818NwRT2qHa0bSwiMaQ==
X-CSE-MsgGUID: FWTc2eJhRr6wXuxw52+VMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="212772783"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:55:13 -0800
Date: Mon, 16 Feb 2026 09:55:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: trigger: use put_device() in
 viio_trigger_alloc() error path
Message-ID: <aZLNX6Ifw68k-zu5@smile.fi.intel.com>
References: <20260215222348.186806-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215222348.186806-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 11:23:47PM +0100, Salah Triki wrote:
> Once `device_initialize()` is called, the lifecycle of the trigger must be
> managed by the kobject reference counting. Currently, if `kvasprintf()`
> fails, the code manually calls kfree() and `irq_free_descs()`.
> 
> Switching to `put_device()` ensures that the device's release callback
> (`iio_trig_release()`) is properly invoked. This simplifies the error
> path by centralizing the cleanup logic (including `irq_free_descs()`)
> inside the release handler, following the standard driver model pattern.

How did you test this, please?

...

> struct iio_trigger *viio_trigger_alloc(struct device *parent,

>  	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
>  	if (trig->name == NULL)
> -		goto free_descs;
> +		goto free_trig;
>  
>  	INIT_LIST_HEAD(&trig->list);

>  	return trig;
>  
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);

Now, in iio_trig_release() you will call a bunch of code with
trig->subirq_base != 0.

Please, test your changes before submitting.

>  	return NULL;
>  }

-- 
With Best Regards,
Andy Shevchenko


