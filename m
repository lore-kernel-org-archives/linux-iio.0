Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562D2DA759
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023943; cv=none; b=nirNIU6d1vi61gtzoooGdHTco9rb7ktZV93s/wj/39EEgp/x+SmfkhTTBsE4hos5JVBOzDCQLoFslL7nVGeJ5mKd0BDxej21fe2/IswkyGERkL04HFEkUZNTuyRepdwC3lufy0VTAmub5fYlHWwmB+5lyW7wfS5S7RsSWzHG7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023943; c=relaxed/simple;
	bh=hakn+gZG/YFWCFkXjekj+kvyfuJfJyugadrRDXHdA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VySNr9CvvD5sRPCo7pdqM706u1vPV2Xjt8rAmQTdTw1Jvj0LTBYavukHKDr2uuzuDD+DEsTcHkmeC5aN7xAwO6YEhgMDGO8qnyV9chZjPYKeUWLnZ3dEAoj097gc+ITQqi5ERAjjw0ts8ICcknn5ThRBXdF8L+jF+8BtT2ABA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrB1hhx7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrB1hhx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777023942; x=1808559942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hakn+gZG/YFWCFkXjekj+kvyfuJfJyugadrRDXHdA6g=;
  b=NrB1hhx7aLvBH9ZrKehnReNns9MZ9V8uG5YWx6IZzFT1H7s4eh1R7ODd
   Z4I3PhDzu2MaMiy63ZA+lUprgEMLvdkAhf2dDSbkWfQhdo/AK5wfxQYyx
   Y5zywGG1Ikbr39YO7cJ4eJrFRBUnHY5AC8EVXo4eB/c06cWKT8rL94O2v
   SsXro55MDxUxPm89ol2+UD5pvegJ7Q0TvETbMGEwOdUcamvj5TeCx+j2+
   kjqgYVjdERS4n31Nk+qIdmQXV7if+WVLbEGJcHykLBCU7ruGjjfulstBW
   oG8JgtEUQSyJisUsMks6iuUby/Dnl4wA15n5M8M5HU6qxTyXRcXH7MrKg
   g==;
X-CSE-ConnectionGUID: u0Qv38WuQXKgwks5s3kbUQ==
X-CSE-MsgGUID: JCvJMQ9ZQ163KPdX3hwgUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81608906"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81608906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:45:41 -0700
X-CSE-ConnectionGUID: NUD2afy6QMmlNLynjKgEGQ==
X-CSE-MsgGUID: 5uNwqq81QJmHRvbpojr/Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232769137"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:45:39 -0700
Date: Fri, 24 Apr 2026 12:45:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Caio Morais <caiomorais@usp.br>, jic23@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, michal.simek@amd.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: fix header includes across multiple drivers
Message-ID: <aes7wGq2NYmtfMgs@ashevche-desk.local>
References: <20260423183349.636757-1-caiomorais@usp.br>
 <a9307e04-3754-465e-a610-92c6e83cc3e6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9307e04-3754-465e-a610-92c6e83cc3e6@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 01:45:12PM -0500, David Lechner wrote:
> On 4/23/26 1:33 PM, Caio Morais wrote:
> > 
> > Remove unnecessary includes and add missing ones as reported by the
> > include-what-you-use (IWYU) tool.
> > 
> > Files changed:
> > - drivers/iio/adc/xilinx-xadc-events.c
> > - drivers/iio/buffer/industrialio-triggered-buffer.c
> > - drivers/iio/common/st_sensors/st_sensors_i2c.c
> > - drivers/iio/common/st_sensors/st_sensors_spi.c
> 
> We'll want to split these up, one patch per file in case they every
> need to be backported as a dependency to a fix.

Per driver actually, as the last two belong to the same driver
(different busses though).

...

> This looks like sorting alphabetically, not actually adding or removing
> any headers as seen by the equal number of insertions and deletions.
> 
> Usually we don't bother with sorting unless we are making other
> changes on top of that.

Right. At bare minimum we expect sorting + IWYU patch series.

...

> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> >  #include <linux/linkage.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > -#include <linux/iio/iio.h>
> 
> On this one, it would be more logical to move the iio header
> down one line to group it with the one below.

Hmm... Personally I consider them different group, I would rather see

linux/*
...blank line...
linux/iio/*
...blank line...
linux/_whatever_driver_specific_

> >  #include <linux/iio/common/st_sensors_i2c.h>

-- 
With Best Regards,
Andy Shevchenko


