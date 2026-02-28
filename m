Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9E1B424F;
	Sat, 28 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273757; cv=none; b=Q3b5yMvHV+R5cJrrV9wGV2aCj8YYMO7xrrtoYRmMhtp6Olny2xJsw2k76AMalY0WbNgPYtv5ewHxWnAYyRNvavZlMk+zBxWCxifANN23OWAfNYQQtYR4z8cP8lQS6Opt4c6ONpUK6XRFNrDlvFJm5gCz4U29r2S5ngD1ETA1f9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273757; c=relaxed/simple;
	bh=mjn98PrFgttjzzsVqZLupIhQAyUcyvfeH35x1QUk6us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLDT4FfGJGjgs4uNKhIOmmvBsRMDutWYeMUez++kmNZzaiyaplLNdp2cnII1+Ndod6VkTJ5LEmHVYgFsYit3DBvmOwVUusaE3nHZwiT8IBnPj5wgCda0pG0dY2qwBPD6GirSr7AiWBAAjPWopr4EZmBYzd8rst0pgnxTNJnyKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuFbugRm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuFbugRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772273757; x=1803809757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjn98PrFgttjzzsVqZLupIhQAyUcyvfeH35x1QUk6us=;
  b=CuFbugRmBb6yjrOAJgw3KfCwL1+OBWvpKaNyrhNhBydud/xpiD4SRjba
   zCFiGgwqz9Wgi8+x0+UDFfQMxY435VNudYpv7QtXv41B6rdmuWmxaae+Z
   w/7ZdK37XFMmVOLrvQOeKKzubUVKXUwjSahbcBnshQR3bfaiJNi4B0mrX
   TBm7848r1rtkd2+bbDM6aWudinL/91+UzPW+UIsAaGOC0a4xI8KdQ+6Vs
   2qLoTzuyURwhkgewLnchINrto1077O8qp4A9PGhIWIWB3eG4ZudSG5wXb
   WLKiLqQsUGTwoveZI0Ny0l/SjX1FuOMjEhkjncCgmRZeA3jVSJ1B79JoR
   w==;
X-CSE-ConnectionGUID: UkaMCFkOQ92+U8D5aO5bBA==
X-CSE-MsgGUID: 4ZpB2Ja+QfyaknG8bi2Cbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73392610"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73392610"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:15:56 -0800
X-CSE-ConnectionGUID: EWuOJOZlSyWTJNWRdmrL9g==
X-CSE-MsgGUID: yJ4dDrtDSq6Sx8EyNKp+yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221271577"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:15:54 -0800
Date: Sat, 28 Feb 2026 12:15:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: junan <junan76@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace NULL thread handler with a dummy function.
Message-ID: <aaLAVwiUZs_i8U3q@ashevche-desk.local>
References: <20260228023643.12000-4-junan76@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228023643.12000-4-junan76@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 10:36:46AM +0800, junan wrote:
> Hi,
> 
> This is a similar problem as [1]:

> [1] https://lore.kernel.org/linux-iio/20260227071409.aEG-iBFD@linutronix.de/T/#m15ab81856b42f72169fe51bd87fa399b5147441f
> 

Make it a Link tag.

> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> There are two iio devices on my machine:

IIO

> ```
> junan@fedora:~$ ls /sys/bus/iio/devices/
> iio:device0  trigger0
> junan@fedora:~$ cat /sys/bus/iio/devices/*/name
> als
> als-dev0
> ```
> 
> The function calling chain is as following:
> 
> hid_als_probe(hid-sensor-als.c)
> 	=> hid_sensor_setup_trigger(hid-sensor-trigger.c)
> 		=> iio_triggered_buffer_setup_ext(industrialio-triggered-buffer.c)
> 
> `iio_triggered_buffer_setup_ext` is called with a NULL thread handler, and the flag is set to `IRQF_ONESHOT` inside it.

> I am not sure which flag to change, so I replace the NULL pointer with a
> dummy function or can we just change the flag?

Besides you used way too long lines, the last sentence (question) has to be
located in the comment block...

> Signed-off-by: junan <junan76@163.com>
> ---

...somewhere here.

And answering to it I think it's band-aid and wrong approach.

-- 
With Best Regards,
Andy Shevchenko


