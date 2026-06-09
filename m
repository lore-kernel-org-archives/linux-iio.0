Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7D4D2ED3;
	Tue,  9 Jun 2026 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031485; cv=none; b=KWHm5MONDJ+b/d+L53rOCD79WeT+bdyMH6nklJSi1CdJ9JXwUbBdk8i+VHi7SMJWhis/6j+78bL0uGeZjX+EpoPAsN2NBsLOin+rPqA4mq0YB0/GD5A7EkQv4yLGaEhe1jML4KGw9VRq5jBdmUWpVld/mWRLJcsZXLFFi765RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031485; c=relaxed/simple;
	bh=qBaTipJIBdrNj5yARfGrmu93QPHd7TPizSBTvXriavg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niXnr8iy7sIOyULWKWy5lru0puADk6qsdGBSuzaYRrbMG+NWQPirrKGlh5+lNZHRmMe7rSOboqLjV3rVxfXRORLWMo8090WBngMzSw+xWXAvrWBrYHZCdLM5kjGvw9w/p3pJr62p+zM86mB3i5AYMna1KL7HRazDEb9d1emiqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByG5abzW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByG5abzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781031485; x=1812567485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBaTipJIBdrNj5yARfGrmu93QPHd7TPizSBTvXriavg=;
  b=ByG5abzWfmWTRhc3dbMP93gqS7JY13aoNTcnvLkwE+IC7fnrjUMTcWeW
   aKD+zUtquuuW5XQsuJCIEkidUAmcve59/o8mK3t/8LaYoT/VGI5YYWSqd
   xGoQkPUTbMKEfrrHiIYKQ7UEdMJg72tUJj1XhxfC7xE4OHo0r3E5mKwwu
   X1g7/xrWX2dbCGIoUrzLx7DV1MLtl3ZO9C27GH48Od10f6oSp3qi3xFx0
   PK7cJ5UUJshcg7WtRKG3aOzVlWUBxrw2tXfNGT+j+Ztm+E4wA4NQ/GfdB
   75UtyehFCwy0Oq8h37iv1EVJVIskhXXFV/bk9E9+5PQIh4nbuTKNgC3iY
   w==;
X-CSE-ConnectionGUID: 6Hj95BXdQaSG3kdP/x9PMw==
X-CSE-MsgGUID: molkidvMRSiULTcKwoZtcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81553312"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81553312"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:58:02 -0700
X-CSE-ConnectionGUID: Rx+734n5QG2Xmo6vFLT3SQ==
X-CSE-MsgGUID: EvwIZx1rR36cJPrntihkMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241520510"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:57:58 -0700
Date: Tue, 9 Jun 2026 21:57:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V10 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <aihiM5Ao-vuAsUyh@ashevche-desk.local>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
 <20260604201832.60656-4-macroalpha82@gmail.com>
 <aiL0g8d0Y_JeAC5c@ashevche-desk.local>
 <PH0PR19MB99733851DADB0671AE5F76B788A51C2@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR19MB99733851DADB0671AE5F76B788A51C2@PH0PR19MB997338.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 03:52:38PM -0500, Chris Morgan wrote:
> On Fri, Jun 05, 2026 at 07:08:35PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 03:18:25PM -0500, Chris Morgan wrote:

...

> > > +struct inv_icm42607_sensor_conf {
> > > +	int mode;
> > > +	int fs;
> > > +	int odr;
> > > +	int filter;
> > 
> > All of them are supposed to be signed? Why?

> > > +};
> 
> A later commit will use -1 for invalid values.

Okay, perhaps add a comment on top that negative values will mean invalid case?

...

> > > +#include <linux/delay.h>
> > > +#include <linux/dev_printk.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/property.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > 
> > IWYU, please.
> 
> This may sound like a dumb question, but what's the best way to invoke
> iwyu for a kernel? None of the readmes or man pages seem to be getting
> me anywhere...

In this list we (I mean community related to IIO) discussed iwyu tool and
its best configuration. Yep, it's barely good and far from ideal, but that's
what we have currently. Otherwise `git grep ...` and cscope are your friends
to answer this. Also doing review on regular basis makes this knowledge
developed better.

...

> It will get extended, so I'll keep this for now if that's okay.

It's okay.

-- 
With Best Regards,
Andy Shevchenko


