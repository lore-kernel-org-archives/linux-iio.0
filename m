Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508647;
	b=2phG0bgr/Qi/K/CCZggSa7b5lMEwE2pbdBcEnPAhSziYUQv9CdpzDaURzFvVV20b+9sD
	 8qVCpSWbaj65VQmccrQ03za/EJl+tXh0ZoHDfJ9p435zOwv61VbpT33UftW9ttyW/Cd/O
	 aJhhXZ6Tc/XgqsLBvEJ0JMr6exT8X3Z9NWGTy3d9Sjn8sdRdB5WkYZIqd1j4ij2Lv+1nh
	 5hKkHfOkYgQBkPKxsP8wMq65C6fi9GDoDtccHJzXRJIg436XTk5g5+eiE+7i429N0gXHd
	 0+n0s2uEpDj6LDvwAFZTuxKWMKHoAJQc8EDIS5tFt7zLjVEUkYyEIfS7wZnjdgpKSSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508647;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Q9IUUokyhhxcwwnd3VmjtZDnKb3B/VZSMg/NmJ1WC78=;
	b=SL1RiL1FZ7ueCiKdJj5PMloR2/a+BKU66P25PBqvrNoDpBTASJ0YrHD995z0KHgJA2WO
	 KCmazLwt9C+3G3loxNAkewYcfiL03chRbWPPrKP8W7KFeGclnno1jW3PpUMJkudn/XIiz
	 yUHicbhrRdWOk2mAy+tzydAEZWgmYySlstz3SKe+D82e+pzWyjEAze+yvNf2Os1P/DVmo
	 0STxMpygOXklM7f9PX8JcFl3ysW6r34koVEWCCxKoYn33cygnlZFw8nsMj7uX7iLmgCtZ
	 00eBLdarMHBoADsVVEdyRAIZBEHG0or0ei7iuvXlqDEE2ZYK4qKE20BmRsAXtYKRhyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SedL0ETW;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE4606A31E;
	Tue, 24 Nov 2026 08:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0DE4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SedL0ETW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508647; x=1827044647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bz/D0Du0W8QrobDHzxFQOqw7RTEOA+BPUbV5XJQADkA=;
  b=SedL0ETWOu3f6m4dldUkurSi+/XjeV835ZuQPfdWfFQzchRpktk61xGN
   4kDT3LKHqEYKuN1h5wcvd+MRDACgA6y6puSmp2hIwngZamgkqKrrO9/7Y
   MDF+lRz8KodckM84RG5Kfn3b7zazs1JY9kLf7jJwErhbD7O0LWMGgm7FY
   Ybcoe9Toc0RJi1q12SrMTHrTyFJa6JmK+XffFykaNr5Evf05sxxdzohlJ
   ap78QfDEZIWNyhrgsQj4/Y+fyqB8xEkaRQoWwFznn3gZLrp18ekhtsV9c
   SZ4HVGfvQ6D8FCk0hpFpMU8y1HocJ4pMX9v1cTutJIG7B1ljxjO91SlEC
   Q==;
X-CSE-ConnectionGUID: FomsdZDtQGSV26hRVzZgxg==
X-CSE-MsgGUID: /9fOy7/ET/GIQNC2+fpFsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4249590"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4249590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:24:06 -0800
X-CSE-ConnectionGUID: D9dgaZXiRMalxMxhb3U6Qg==
X-CSE-MsgGUID: 1QdCORzCQL2ckV0m65mkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11290601"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:24:05 -0800
Date: Tue, 24 Nov 2026 10:24:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
Message-ID: <awVJohyKR-zxykbG@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-8-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123220649.36887-8-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:49AM +0200, Rupesh Majhi wrote:
> Include the headers for what the driver uses directly and drop
> linux/iio/sysfs.h, which it does not use.

Thanks, a few amendments may be made, see below.

...

> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>

> +#include <linux/bitops.h>
> +#include <linux/bits.h>

The former guarantees the latter, so drop bits.h.

>  #include <linux/cleanup.h>
> +#include <linux/container_of.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device/devres.h>
>  #include <linux/devm-helpers.h>

> +#include <linux/err.h>
> +#include <linux/errno.h>

Same here as long as the driver doesn't use special Linux error codes
( >= 512). And for now it doesn't.

>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/jiffies.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/math64.h>
> +#include <linux/minmax.h>

> +#include <linux/mod_devicetable.h>

Uwe already pointed out on this.

>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/overflow.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/types.h>
>  #include <linux/unaligned.h>
>  #include <linux/units.h>
>  #include <linux/workqueue.h>

-- 
With Best Regards,
Andy Shevchenko


