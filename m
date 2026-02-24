Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1229AB05;
	Tue, 24 Feb 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927429; cv=none; b=pt2uowhxCBiEWAtWkZTdaahjS2A8W6O2XZOE9MrYVTY+tNJc2doYjbqcnkwUbE0qeb9LoLuAj8fRUHr4BNBUvsicIxxBdVeE/x/DFgwKJeCh7IFInw4qXcZ3UQFNhDvBqDf3KtWLhTY6tRZPxA2zfuGWu5yDGOE942KoVEVbiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927429; c=relaxed/simple;
	bh=eMOKGjZ3bk0IcaapzXqG8zUxGxnu+Cv4xbFguZHsdas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7He94LGgXeRrjA9c07vYlyFwLgGzYuyOZhLxHYDZcaG6GPPj2LK4yL81AFN/3dPt2u2H/LCJ6GUpZCNh7m39QTpan+QDFaJmAXuq/EBncCZRp6T8XAT+ckimvk01Z55RIPCMyKknjjO2F4lDL5EZ7aSHEKLFZ3GOY/FNYMrXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UewVo808; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UewVo808"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927428; x=1803463428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMOKGjZ3bk0IcaapzXqG8zUxGxnu+Cv4xbFguZHsdas=;
  b=UewVo808Q0NxeofGfrY7MrSZPSP3ifWvpN7MzkjivnpjyFCYM6e3+XLg
   PH56hbOoDHzHPNnNbaZ0iafapvUwI69IsCjgezqL6LutPYbsnotAY8QpR
   fM3SccsCT4MMej788YCqSvIizpcARS3VBZMB68RgBSTBuj++QeinH0x5m
   SGw/RtnE1CSivNavUyjHbhbuhbYD5AJtNqRgC0DTZhYGSPBxCLQVubsPS
   PhqjElSxPjqIr73aj3zjZTZkBru+bd4oazOc1J+w0eKGRQ4qxHturP2du
   NUaMbbszDrEBiYUQO84LgBa4gseY3R+fmi+//gfcXbYAftYM15qG3jgka
   g==;
X-CSE-ConnectionGUID: qM/bWfKdTVabCaBQTQCmqw==
X-CSE-MsgGUID: M/FZaZKsTfm6N+V4BBRrLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84299503"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="84299503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:03:48 -0800
X-CSE-ConnectionGUID: 57pePfSkT6yL6jsRNEoRuw==
X-CSE-MsgGUID: /W6DpP1LT5m/0RjfGurl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="219952128"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:03:45 -0800
Date: Tue, 24 Feb 2026 12:03:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: gyro: mpu3050: Fix irq resource leak
Message-ID: <aZ13f-uxphEnXKGU@smile.fi.intel.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
 <20260224023511.274038-3-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224023511.274038-3-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:35:09PM -0600, Ethan Tidmore wrote:
> The interrupt handler is setup but only a few lines down if
> iio_trigger_register() fails the function returns without properly
> releasing the handler:

>         ret = request_threaded_irq(irq,
>                                    mpu3050_irq_handler,
>                                    mpu3050_irq_thread,
>                                    irq_trig,
>                                    mpu3050->trig->name,
>                                    mpu3050->trig);
> 
> ...
> 
>         ret = iio_trigger_register(mpu3050->trig);
>         if (ret)
>                 return ret;
> 
>         indio_dev->trig = iio_trigger_get(mpu3050->trig);
> 
>         return 0;
> }

Same comment, try to avoid citing the existing information (id est
the contents of the file).

> Add cleanup goto to resolve resource leak.
> 
> Detected by Smatch:
> drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
> 'irq' from request_threaded_irq() not released on lines: 1124.

-- 
With Best Regards,
Andy Shevchenko


