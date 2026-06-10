Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA03F6C3D;
	Wed, 10 Jun 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088943; cv=none; b=ut/KvaIEUUmVzZmPARNMiVxRnXCy/N707cnNR05HlGdlIJHrUDY+A2bJ9oIC/gTSb8muZznjuJLKLjLbMas0ZExbClTM1iKKBAxJNK7QKlpTZmQc/d+Hr3Gks8i8kDDOz4Z1aRiFTOeuoZGFMgAfSCGvzCAoTcXVdVMWFBp1ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088943; c=relaxed/simple;
	bh=1zVls81C/MKyDPwf1t4ktAhirK05QIsPzMXmObztXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onb42V6nGx+kxqdZ8rpc6qH3FmuRUQoPiv56yRXQRvYXxXWMfr/rHjTTOsYcfd1wmSX7Idv75UTl08Z8ots87Gc2q2QHscxgcuq4MCg11sC2cGOIijFOlfY0xMvyLFYobGewumck3VTfrZesQax8B/kV42OF0DJAQU2B5vUG7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liTgM7/l; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liTgM7/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088941; x=1812624941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1zVls81C/MKyDPwf1t4ktAhirK05QIsPzMXmObztXq4=;
  b=liTgM7/lqmG9D30vvZi+nptWLjf2NluvFUarZY9IyaiyYJ7a8wz3DYBr
   Pqn2r7cBMQIev/Q+bNnLSMg+W8GB01MyI7IE3yndgTgvocmBu4mYmr1k/
   x+U890tK0YUzplWhIGj1qSQfP48epEWNEHYLKjOwVa5VTRACxBwn3JXyU
   0H5Y0FgFWuLMxvslXxFjaeFRDAV9nk9v2egh81EXOPkzTpioZNqJJQ7NZ
   IG5VplqqWOQlJ+cWBH7Jo1MIS7cdQWz0xDxXF7+dKcTiCSXdd1eHBXOuf
   qJCXG1THM85/WrLVND5tqiG84ZuqK9CyaGwl91BGSmjwlUhUaapUmMFUo
   A==;
X-CSE-ConnectionGUID: fktq0uxaQoSlgv3lf760Mw==
X-CSE-MsgGUID: A+YMgIYDSSmOcqx5bgKljw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80893419"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="80893419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:55:40 -0700
X-CSE-ConnectionGUID: qL3wmEt5RyOPRof8DYGGbg==
X-CSE-MsgGUID: DM/pXAo0QRm51b+3SIpuig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243174397"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:55:38 -0700
Date: Wed, 10 Jun 2026 13:55:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: bmc150: sort includes
Message-ID: <ailCqPN1zGTWaua_@ashevche-desk.local>
References: <20260610042418.90308-1-dennylin0707@gmail.com>
 <20260610042418.90308-2-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610042418.90308-2-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:24:17AM +0000, Hungyu Lin wrote:
> Sort the include list alphabetically.

...

> -#include <linux/module.h>
> -#include <linux/i2c.h>
> -#include <linux/interrupt.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/pm.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/i2c.h>

>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>

Oh, I didn't noticed this one is mixed with the other linux/*.h.

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>

Please, make it in two groups

linux/*.h
...blank line...
linux/iio/*.h
...blank line...
"...internal header..."

-- 
With Best Regards,
Andy Shevchenko


