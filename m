Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F37331A78;
	Tue,  7 Jul 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437306; cv=none; b=RtgawnS+MJ2gC4UnhiRC5Yzd8kh3TXeLgvbZ/Xfe6UHJYHk27OUefrOYhtlveBCyvPyNT1ZC8FFe4uxceBB57LNXK1YF/Q7URvvxAUaMml/k3NKTjjnRD1OvicqNlxZKJBSf2jPUA9iiTaZiEZ7D1aGuqqb+POlm4aiDjUTPErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437306; c=relaxed/simple;
	bh=E97w7/XqsywV6ia0XC9dsIo14fVSzdbdwoofqUJQSf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db1+K8i1FsnnfRMTQemPjveX592XwM9IXNRrd1CVTKHOLtr42hr1rQxLpGPSaDeSLQQSfdL5fEUwvpRcq9aIWhZgFADRnDz8BdngcIDgVapH4S/p6iZtYkDjs2Qo9aa1+iIiJd5bdxUNCutyfs/4JeBTdalyU/gugzMW3A/ELV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWfarYli; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWfarYli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783437304; x=1814973304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E97w7/XqsywV6ia0XC9dsIo14fVSzdbdwoofqUJQSf0=;
  b=ZWfarYliVToFsJOjyOAczK7NCq2Qhe/XFCVn3TkLDr3LTBL3ahsaY+My
   LknW/X4iIVl4lKJFIdNoU1F/BECw3SAJsTCTOt8uijBq4FuR20Wurlw+/
   5UOqx4mQ+pN0QtwJc7CzrCjXiTzQ9X6zBPZflirW8kBordru4VVNlL//F
   5XTIwIjGs4HSy/dHHNs5R2jK5EU/MMxm52oopyDAk1vdABTsncpbXPI2a
   5jR+H22PsdGUjMHfwCOv06Vis5i+wePrZdYiIxVwWRxzE0apgsJe+5c3Y
   S63HhB8F+Q8nMTzoxhal0yb4saWO9lsUnn2yAyKIi+SAqQeyLKRN1CpBG
   A==;
X-CSE-ConnectionGUID: NXovWZJWQpG279HcSY6TqQ==
X-CSE-MsgGUID: HJN1PO+3R5CeY9+c89Fpqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84060581"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84060581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:15:04 -0700
X-CSE-ConnectionGUID: EnqtkAxSR3ePEOu7aBtZAQ==
X-CSE-MsgGUID: rxgjrjVnS5aNA2BrK+yIWg==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:15:02 -0700
Date: Tue, 7 Jul 2026 18:14:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v9 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <ak0X8yrg5ujz8r5L@ashevche-desk.local>
References: <20260707112714.2261727-3-shofiqtest@gmail.com>
 <20260707140545.0000029a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707140545.0000029a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 02:05:45PM +0200, Joshua Crofts wrote:
> On Tue,  7 Jul 2026 14:27:14 +0300
> Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

...

> You're missing array_size.h, err.h, types.h

My comment against types.h was ignored. I think that this contribution is
heavily assisted by AI (which has to be mentioned), otherwise I can not
explain such an ignorance and mistakes from a human.

> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/unaligned.h>
> 
> Blank line here.
> 
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>

-- 
With Best Regards,
Andy Shevchenko


