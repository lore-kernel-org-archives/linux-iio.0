Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DF33F36D;
	Tue,  5 May 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965173; cv=none; b=gYWo5Q8uGlL+4YE7fjTW/A2FI20j/YvTEwpiQhTvDD4dR4oZHAY5KvQl0ShTXu0goVNrGhNDRGlJI3KUS+v6QoTOQYDuhzIKTJheJO6N/mS/gKGPDO0xZf3lsXpUl+iZfGn3XnyIrGlrwaA+8GH8Eqmxprkqy8611GZNGqHAC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965173; c=relaxed/simple;
	bh=oDdLpjr4iBkoyYEer4B60RKRDLgQjw83eiwOtfcSPMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3C+iS6RL/U8ksnNrDVzkEBc7x17Ae9kJASS6jVHwnhq0JnoqaK0Rj0pFO0V1yuXgu355v3PMQY2J5ahQFsBTfUfeKd1mNizT+T1kb8no2vi1Fp2RcG62Dyr8EJ42IO2p2ydvdsaLxWGWAZ75lmnWOcrGWwbNQf5zNBTPw0MG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMnRMlkh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMnRMlkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777965171; x=1809501171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDdLpjr4iBkoyYEer4B60RKRDLgQjw83eiwOtfcSPMk=;
  b=fMnRMlkhbQbKc2Cyk1rMzHNImZTI0iJaWb7qFkfcDtln0WRzY0lG558Y
   fT1OQ/Iw0FrLQdzSX+tra9AH+eQGiy9yQGQQ46gp8c0puL/fLRX6q4cKC
   vvv7OLc1YVkrzH01UgnEjkCGqFj2SEx8p2E8FbQ0v4DGeIVtO48HgCOit
   LmjF4uKBakHDy29P1DdbhQiunOnLh7c9aX9DAOCaNJO7oM/cN4MHj78Pg
   p6vw+B3M5SpgnSpwdUQ4hRBPUOd9pLJ7GFcwVSdYqR3X6+GWLtBoLoClK
   kdyfIpVMsn8gG22RBpro7S/RmG83advyKHQkwn055D85TB/A0A9236Zir
   A==;
X-CSE-ConnectionGUID: eCdAczteQya1oTQmYlQPXA==
X-CSE-MsgGUID: LVT0XJpGQcypiubZXf8XhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78733123"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78733123"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:12:51 -0700
X-CSE-ConnectionGUID: JOCNizUCTLi+47X600JzWQ==
X-CSE-MsgGUID: oMN9uDfyTtSRCMh0m2uIoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240031139"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:12:47 -0700
Date: Tue, 5 May 2026 10:12:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
	conall.ogriofa@amd.com, erimsalih@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Message-ID: <afmYbF8sLXugL-EE@ashevche-desk.local>
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
 <afhyiW_5embow_hx@ashevche-desk.local>
 <8d0ed33d-deab-4aa3-a7bf-3aaf84f4583f@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0ed33d-deab-4aa3-a7bf-3aaf84f4583f@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 04:50:05PM +0100, Salih Erim wrote:

> On 5/4/2026 11:18 AM, Andy Shevchenko wrote:
> > On Sat, May 02, 2026 at 12:19:48PM +0100, Salih Erim wrote:

...

> > > +     if (format)
> > > +             mantissa = (int)(s16)mantissa;
> > 
> > Potential user of FIELD_GET_SIGNED(), but for now just use explicit call to
> > sign_extend32().
> 
> Accepted. Will use sign_extend32(mantissa, 15).
> 
> > > +     *val = (mantissa * SYSMON_MILLI) >> exponent;

The idea is to think about this (and other) user and try to come up with the
solution that will not decrease readability and at the same time give more
context. Perhaps you need an additional patch that introduces the multiplier
for millivolts (as it's done for degrees).

...

> > > +/* Signed milli scale (MILLI from linux/units.h is unsigned long) */
> > > +#define SYSMON_MILLI                 1000
> > 
> > I think you want a different approach. I already forgot how it's being used,
> > but there shouldn't be a new (re-)definition just because of this.
> 
> The issue is that MILLI from units.h is 1000UL, which causes unsigned
> promotion when multiplied with signed int values (e.g. negative
> temperatures or two's complement mantissa). There is
> MILLIDEGREE_PER_DEGREE (signed 1000) but using it for voltage
> channel conversions would be semantically wrong. Will either use
> (int)MILLI at the call sites or just use literal 1000 -- happy to
> go with whichever you prefer.

Let's wait for resolution WRT hwmon vs. IIO.


-- 
With Best Regards,
Andy Shevchenko


