Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC83D25B4;
	Tue,  2 Jun 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398752; cv=none; b=PKd7KKVWelw0cfjIGOgsPtAFSNeMBDI2xRQjZ4+9z5t89Ov9HNwiUhl0KU0/GZu1lP9VLyJAY5LorMfwci3fGr7IN3Aavt2a4f5FJ6W1uIslNLhlvonmw21IPBSGtaF3R7xqhoUSpP9n7/UEt+H4CBBAXO+79v1L108YdYNrWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398752; c=relaxed/simple;
	bh=9T4zNQT0trs46eiYmksy1HHbaHk+hzaIynpxPXrOOy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2w+p8S/78FTHdFACYk1zKZT2mZSqthgDbxQauxG7Nhln5d3In7m8Ii80be0x/xzCNlGMWEwwfrzhvuPQ1o6W+FIdeFAN8BB3cvMuRaSHDkzlVoaMs6GGDay+FfmWVqYlYIx3FtLVEY83znbE0c0VG1Sedfqx2BZ0SnuBbJJI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQJvsk4p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQJvsk4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780398749; x=1811934749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9T4zNQT0trs46eiYmksy1HHbaHk+hzaIynpxPXrOOy4=;
  b=AQJvsk4pfK+zXxTGWCNxpm4E6c/no0sxTj083NvRPjMAFAaLehjl4sai
   5DyHqh1EJIZ593mwtdudszu0I9njwDpL4zuurc+UQxWkzg/KDMGI0Om5D
   ILNDZzxcYE/y7IqzlgZcbbMtRr4iCCqxG8Rs3mphauTPK/djjvwbeArMv
   1LDs81VSXXqRR6euuCXnyVyY4CZqzPQb95fMC1n1QAIOtnYxlYWPbx2bI
   yWKRXVne2/nkYx6nc5jnPaJ4O+y2s/STr3frZTT8veG698SO4YT3CSPBS
   arERcZ9G8SIWci3H9nH7wRTGwXh9NFeKCRZw0O5LE9se6cyTeO8BWnB8V
   A==;
X-CSE-ConnectionGUID: IqUj/wMxQhC7UW3xbpN7Qw==
X-CSE-MsgGUID: Z00l+qcsTjW3AFR5JHeVvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84803636"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="84803636"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:12:28 -0700
X-CSE-ConnectionGUID: vBQj/Q+8RgGRvI4hjRuesQ==
X-CSE-MsgGUID: DtVtKBtbSAiIrUHfWhG5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240874332"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:12:24 -0700
Date: Tue, 2 Jun 2026 14:12:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <ah66ljSiIc0ywFC2@ashevche-desk.local>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 12:45:35PM +0200, Javier Carrasco wrote:
> On Tue Jun 2, 2026 at 12:01 PM CEST, Andy Shevchenko wrote:
> > On Sun, May 31, 2026 at 09:58:22PM +0200, Javier Carrasco wrote:

...

> > + array_size.h
> >
> >> +#include <linux/bitfield.h>
> >> +#include <linux/bits.h>
> >> +#include <linux/i2c.h>
> >
> >> +#include <linux/module.h>
> >> +#include <linux/mod_devicetable.h>
> >
> > In C locale it seems wrong order.
> >
> >> +#include <linux/mutex.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/regmap.h>
> >
> > + types.h
> 
> Do you know any tool to automate this beyond asking an AI? Manual
> auditing is not very reliablo and it is not that difficult to miss a
> header that has been indirectly included. Building with W=1 and similar
> stuff did not help.

`iwyu`, but it needs a custom configuration. Even with that it's quite far from ideal.
The custom config had been shared in the linux-iio@ mailing list this year.

> >> +#include <linux/units.h>

...

> >> +	/* integration time + 10 % to ensure completion */
> >
> > fsleep() adds up to 25%, isn't it enough?
> 
> The problem is that it adds UP to 25%, but that is not guaranteed. If
> almost no extra delay is added, it will be below the margin I added,
> which was necessary when I tested this delay with real hardware.

Noted. Can it_usec be precalculated already to include that 10%?

> >> +	fsleep(it_usec + (it_usec / 10));

...

> >> +	pm_runtime_put_autosuspend(dev);
> >
> > Hmm... But why? Wouldn't this be problematic with reference count on the failed
> > devm_iio_device_register() below?
> 
> I could move this a bit further down after devm_iio_device_register(),
> but as I replied to a Sashiko complaint, the reference count will never
> underflow in this configuration.

Please, add a comment elaborating on that, it's not clear at glance.

-- 
With Best Regards,
Andy Shevchenko


