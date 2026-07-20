Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E531B82B;
	Mon, 20 Jul 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575905; cv=none; b=PmTlFmJ/bO8oJDC/5KDTT9XzIarQBto8ec/lRSvXefVmnW9NFomYVOPPBOgz6ptRCZZlHHKTA7dfxxLA8WnZ0gXvZMDpTckeYoqyQDS/DuueEAbhQUauVlnECyF0ZnMIhJmEiLqIOx1aksGJwgAki6odxWsBQDXBTUyXC64rDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575905; c=relaxed/simple;
	bh=u85aqKoeel3ff4NU6yrD2gdF+o2QAGRfB5QLOcHUWm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE9kXCVWr5AglDg9wCkMXBMT5fKSOtc5Je+L6PfNfEy1fNEvpecVucDRIFMAZttDT2ulUoCQd41u4s4NoO946NVITzjUki7XC3cC4okvgSqojIw9jdmyzPEW5K5MdBoTr20QCgwqgDYPOxxbL7rzrymedPwWHonqFAxBwYeDpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmE0HtGy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmE0HtGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784575904; x=1816111904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u85aqKoeel3ff4NU6yrD2gdF+o2QAGRfB5QLOcHUWm8=;
  b=BmE0HtGy9tY8Ks54StxwvTCBj8MC/qYclTM8xgH/TKmJuf1STTk8t+Fq
   HImzDd3P50+IrPy3MyFWWZJtl2dufqNIXuekQ8hSHHtzDl9e4MlgRI8z8
   afvLiXj0+dezTxiNMZoJdJEfs/xfiOfT1AE4GDWvX7piNX9qXEip3aQqQ
   hqjhdbUWe2CitQ0ZT8TonnqOSnFmS2p3L8fLwMaKUc4N860ig4EEx+OOX
   Re/QcV73JGvZtxCODVACtiuTAIwkOP9Z5wDIJiUB/qyRR3Wk4F3GC3KLP
   LBQgYjnF/KGDnU4CKS9k/oQSOuIPoLqdm1P0ZRjECu7SKAuZW23+dOxd2
   g==;
X-CSE-ConnectionGUID: n7O5XvCdT1uPz7i5mc9BZw==
X-CSE-MsgGUID: zjwlLCqpQ0Cygs+NxbL5zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87704509"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87704509"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:31:44 -0700
X-CSE-ConnectionGUID: 6BNVnjflTkqK/em697xGow==
X-CSE-MsgGUID: V1Sf21+uQuKm7DxRtmND3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="282029492"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:31:41 -0700
Date: Mon, 20 Jul 2026 22:31:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: inv_sensors: better timestamp alignment when
 using watermark
Message-ID: <al53m6cQ641ZPvYp@ashevche-desk.local>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
 <20260720-iio-common-inv-sensors-timestamp-rework-v2-2-aec31446809c@tdk.com>
 <al4HkNK8kxxqUY0V@ashevche-desk.local>
 <BE1P281MB14263FC8209148C6147866A2CEC32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB14263FC8209148C6147866A2CEC32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 03:07:05PM +0000, Jean-Baptiste Maneyrol wrote:
> >________________________________________
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Monday, July 20, 2026 13:33
> >On Mon, Jul 20, 2026 at 12:38:33PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> >>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> >
> >>       if (sample_nb == 0)
> >>               return;
> >>
> >> +     /* no previous data, compute theoretical value from interrupt */
> >> +     if (ts->timestamp == 0) {
> >> +             /* elapsed time: sensor period * sensor samples number */
> >> +             interval = (s64)ts->period * (s64)sample_nb;
> >
> >The both variables are unsigned. Why do we cast them to the signed type?
> >
> Hello Andy,
> 
> the idea here is to have a (timestamp - interval) doing the difference on
> variables of the same type, s64. I tried to avoid difference between signed
> and unsigned values that can be problematic.
> 
> Interval is s64 for this reason, and that's why I cast the 2 u32 values to
> s64 (which should not be a problem).
> 
> Is that OK like this or do you prefer I change to u64 (with implicit
> conversion to s64 when assigning to interval)?

It was just a question. If you think it's better as is, I'm fine.

> >> +             ts->timestamp = timestamp - interval;
> >> +     }

...

> >> -     /* no previous data, compute theoretical value from interrupt */
> >> -     if (ts->timestamp == 0) {
> >> -             /* elapsed time: sensor period * sensor samples number */
> >> -             interval = (s64)ts->period * (s64)sample_nb;
> >
> >Yeah, I see this is the original code, but consider revisiting.
> >
> >> -             ts->timestamp = it->up - interval;
> >> -             return;
> >> -     }

-- 
With Best Regards,
Andy Shevchenko


