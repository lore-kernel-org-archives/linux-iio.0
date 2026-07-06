Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CA20010A;
	Mon,  6 Jul 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368264; cv=none; b=GgAFUm4CaJ/RpX1M0xCi4GE4KaKnq2stcZ7oy/O3pC76RIm96Y5PQhoRzC42ZrkmonyyfNyizyyrGw/A8BwvK/jH5Am3brDpZpaQs7zc3HOvwXqR8QVQIU2DmllLZ/VKfzjzTr3A0FbHHP93HUWnH4Qizu1sv9J806NJEdHzTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368264; c=relaxed/simple;
	bh=zVZ/P8dEpMlwCDwgHICeR7/5Do/9/xtlKdFFEj534Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvG4D6elxYiXRJHXoqbuJn8eQ9UoJMti9zk5R5ACU4ZaYUJ8WdjXPf+Sl90xUQy1KBz3J6kAqbs4xZKCCQsmADp8m7TgFzgRpCY4ZGkwOkV622Wnop3fYFnBv/Ngiu6tnj1zVln0ZGkpJ8U+F/1d6o0VEqY3P+cu/34GcN+HBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7dLiij2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7dLiij2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783368263; x=1814904263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVZ/P8dEpMlwCDwgHICeR7/5Do/9/xtlKdFFEj534Rc=;
  b=Q7dLiij2+GEk0mt6vQvToh2xYn0Mc3Aa8oZImipQakAg+Vdfqc0f+aaU
   6tXUlEEVAFNpZw+XoUaY8DnQ5B7CbMwDMgAV6hQMg4tFX+SNjYMJPqlY7
   Ps4PNq0X4Bsd3dzP8Z+yki9Tn0YutTMf9AjxErLlXIP7DMgFGCTX1I6xH
   yr0vgLOVePImq5aXvO0i8nKpg05htW76ONsjSzZRymGRAqDY7iZEq2gTg
   VESvMTeNLO4fZSTNqcfZsSskjrVbyWlEgnuZKMiGnkjHRpGY/1NEe7TX0
   zn+hBfF8gLdcQSsU92NFoi0URRQSlBJEMm9zMv+x5J0T09bJgmKwNaEEg
   g==;
X-CSE-ConnectionGUID: Jp9IGxFiT3W2/4QD2XD3Ng==
X-CSE-MsgGUID: xXFYw/ooR9yt83m3BpFrng==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87925564"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87925564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:04:23 -0700
X-CSE-ConnectionGUID: cJNz5w3NT4qIZy8uJOknnw==
X-CSE-MsgGUID: ZeqT/bFXTnKAe5ZpzTjvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="252051912"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:04:21 -0700
Date: Mon, 6 Jul 2026 23:04:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: kxsd9: fix runtime PM leaks and
 unchecked returns
Message-ID: <akwKQZTzqHQ_4dzG@ashevche-desk.local>
References: <20260706074650.96042-3-birenpandya@gmail.com>
 <20260706074650.96042-4-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706074650.96042-4-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 01:16:52PM +0530, Biren Pandya wrote:
> The kxsd9 driver previously used manual pm_runtime_get_sync() and
> pm_runtime_put_autosuspend() calls in various return paths, which is
> prone to memory leaks if a return path is missed. Specifically, in
> kxsd9_write_raw(), if the user provides a non-zero integer component
> for scale, the function previously returned -EINVAL directly, leaking
> the runtime PM usage counter.
> 
> Switch to using the new scoped-based PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
> and PM_RUNTIME_ACQUIRE_ERR() macros to automatically handle dropping
> the PM usage counter upon return. This simplifies the logic by allowing
> early returns in error paths.
> 
> In remove(), use pm_runtime_resume_and_get() with an error check to
> prevent unchecked return issues, and perform a best-effort power down.

...

> void kxsd9_common_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		dev_warn(dev, "Failed to resume device (%d)\n", ret);
> +
>  	pm_runtime_disable(dev);
> +	if (ret >= 0)
> +		pm_runtime_put_noidle(dev);

Has this been discussed already? Because it looks to me a bit strange to have
_disable() be called before _put_noidle(). Also the commit message is unclear
about the flow change.

>  	kxsd9_power_down(st);
>  }

-- 
With Best Regards,
Andy Shevchenko


