Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D822370A;
	Sun, 22 Feb 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771758453; cv=none; b=sFo6zOt72hVH6WByXEdNdwKoxEQaOPAnJqOcznU56NtrEU/UT6Kdno7D3aTa2Z9xCtKHx6SFgSaFJ5xKzcSyrl8DwVP8ZqYyAytHj6/cEBNxgjOMRaEB5DRgRIk1oQkKs6E2Uutyw36lCYDGGvWu9hyz9hRIOxuy/m1ceiz0I3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771758453; c=relaxed/simple;
	bh=1I6ou9k0sJ40FtkGW/L+M4qVjKzr/vsuMMUpxsTK7Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKFt2EPH3/Z+vb0tKN/xn+duJc4dIxHPC2jARlGwN+Q7tU9uggdU2py1X/HQOvhQ/30j7jvJmNGW2fdcQSvVDM4jssukAo8mKsRJQ0hRiW4W86svtU6IuoS0iUI8IugNb6uil0Q3oIl4Y5W0WmUq2bP4YKf+9Kt8DMVVLMqfDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgJeda+Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgJeda+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771758451; x=1803294451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1I6ou9k0sJ40FtkGW/L+M4qVjKzr/vsuMMUpxsTK7Rs=;
  b=DgJeda+Z1IPFX2UwA7l28a+i/mTW7IMun7Lve/ny0jeDrKndPa8K7wpy
   kEFr3sKExD1kOm++4KCBYtJApnkjHJd/EMJZz1td6VeTFQAWCKe9SumA9
   /bU/V67+O9iwVgW7pdGmHvnSr5vWQI92pr5M7Dkl7I5/eH99LMm7jzm4L
   uJz9l2i9OkFn674WAW6pmoj620PiZicPEmhBcJU2fa26D+mTt7+s1WTtK
   5qyfZCV8Px7F/nBIfLxc9yduZ4Qq8OqKITI/s2JsF37R/xo7bmZSCfa4J
   WzrBPU0F1ELp3jOlsEWPvHm9PsULHsQ+B11ufw44Y2H0UWWZbanZyPr+O
   Q==;
X-CSE-ConnectionGUID: Gt26Bvk4Sk2R04tvkpPMTA==
X-CSE-MsgGUID: YL0A0nBgQwiW+z+eE3Q5mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11708"; a="98238992"
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="98238992"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 03:07:31 -0800
X-CSE-ConnectionGUID: Dv5UTNkoQ6KYruK02U4awg==
X-CSE-MsgGUID: ZTVWWBVvT+meoIqmm8FsQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="219411524"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.171])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 03:07:29 -0800
Date: Sun, 22 Feb 2026 13:07:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix resource leak
Message-ID: <aZrjbmU8Vt98Sjwr@smile.fi.intel.com>
References: <20260220200522.19967-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220200522.19967-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:05:22PM -0600, Ethan Tidmore wrote:
> The interrupt handler is setup but only a few lines down if
> iio_trigger_register() fails the function returns without properly
> releasing the handler:
> 
> 	ret = request_threaded_irq(irq,
> 				   mpu3050_irq_handler,
> 				   mpu3050_irq_thread,
> 				   irq_trig,
> 				   mpu3050->trig->name,
> 				   mpu3050->trig);
> 
> ...
> 
> 	ret = iio_trigger_register(mpu3050->trig);
> 	if (ret)
> 		return ret;
> 
> 	indio_dev->trig = iio_trigger_get(mpu3050->trig);
> 
> 	return 0;
> }
> 
> Change request_threaded_irq() to devm_request_threaded_irq() to resolve
> resource leak and use current API.
> 
> Detected by Smatch:
> drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
> 'irq' from request_threaded_irq() not released on lines: 1124.

...

> +	ret = devm_request_threaded_irq(dev,
> +					irq,
> +					mpu3050_irq_handler,
> +					mpu3050_irq_thread,
> +					irq_trig,
> +					mpu3050->trig->name,
> +					mpu3050->trig);
>  	if (ret) {
>  		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
>  		return ret;

Now this prints two messages on the error path...

-- 
With Best Regards,
Andy Shevchenko


