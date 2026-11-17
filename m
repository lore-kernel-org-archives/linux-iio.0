Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933935;
	b=bF/nz7pScGgKnlwGwmWVFzayeOkb/ByxI3EuNrBkwUVa4Cu8mDu5ymkSizhKv/xZjqDX
	 V2D0WF/DsOyPR4gHF0hSbJ47KvPxYsIxSpd916nqNK9d/gZUQ3HrJdgenNejjBfwzIUCW
	 IYOeZMxCGthqn8iLCfO3wKAOm4AVCk+bLGnAK1GXzza31aJ9e8IbHS6A0mcVm4zzY1ar8
	 5v9iaFzq3wOT9ZHJWUlT79bGPpjB2HILZ8nxTMpYxQSKL4DIp1cErONmK3YxQzRkAo80h
	 Uj/Zrm+F0LDfSjQtkHpHOqiy7SdcKSZKh/hm+xgeRpeSNrLQfWpTTcWFGZoMIzFONxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933935;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=n9s+Iv6o4T44HnlSLGtNszPAgrcaF+/YdTYKaUuhfQU=;
	b=bbDhSvs15qniDM9J/kZzj4RtjkDpzt2IPTi2qjjhSGrzuvx16LeaLgTqO8SISkMQuUsl
	 BFf2Hzq+emgJ46RtPUCTeRIu14H7oblFC0UVzJ7A+BfimxsU3d+ilCVZUlU4kSPUTWft/
	 uYwdj+2rXaBhs8bt0l+5K+al/8Xh5+TQSQNsqPV29+CWa5h5JM7R5zNdOJvBiZK8GB+zu
	 L0fGcdyJZQgjoW92qrMHGIJRYsiEZyK6BwlhQu3wFzehsRcPPSvYvX5u1oAkh0mO/OyIp
	 k4bH1pyPHwZDDoIekoyDOqw87fTlQEc8b0khcTNhqxAbpeewqNBGbx1JQCrTaOwKvLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Le5cC+P8;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78356606A31C;
	Tue, 17 Nov 2026 16:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78356606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Le5cC+P8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794933936; x=1826469936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N+d66yr6C0e8MRXHvNBLsN+m8f+qKcd72SfnRt9GtX0=;
  b=Le5cC+P8jMubLDGyFfSVF2mnYYoiiEKnf7S+62AcCANQIhhjU0FwfGGn
   fqm9F5JnZynz/A/YDr8rl4k4N9Iaf3TUFj25VMIiaOTpAv3GE7U0fVgv0
   ZisZk0iYKGftay+ibXgto/32s83DJcdlD6/2HpRYWzwBncwKTGFgdopVT
   VMbCyYbhllkMHsH5HQOd46ncSDgjiWF+g6lqvqvakXLiXRJrQmPbuzVWv
   nYghRv0rQMOc+JKdm2KnOlx2UNQikVyZ3YVe6DNHKXUKh37o/IrU7fWOZ
   1FUpU6lbuiVswVp3+86F7jOPMFi62wzeg9hJ2Wnrr2TsjpFaDevoqb0Aj
   A==;
X-CSE-ConnectionGUID: JStyL1/3RTyqlJfXqIKfEw==
X-CSE-MsgGUID: mR2u/2lVTqy3ee7kv5nlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3755259"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3755259"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:45:35 -0800
X-CSE-ConnectionGUID: BiGz+kCjTaG1Jkk1oxiCfg==
X-CSE-MsgGUID: 3rejU2SxSEGqQl4sVSDFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10412452"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:45:31 -0800
Date: Tue, 17 Nov 2026 18:45:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: at91_adc: fix NULL pointer dereference
 on trigger remove
Message-ID: <avyEqQEL3A_YNcgg@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
 <20261117140510.391907-2-abdelnasserhussein11@gmail.com>
 <avyEb9La1tqS90Cp@ashevche-desk.local>
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
In-Reply-To: <avyEb9La1tqS90Cp@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 06:44:37PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2026 at 04:05:08PM +0200, Abdelnasser Hussein wrote:

...

> >  	for (i = 0; i < st->caps->trigger_number; i++) {
> > +		if (!st->trig[i])
> > +			continue;
> >  		iio_trigger_unregister(st->trig[i]);
> >  		iio_trigger_free(st->trig[i]);
> >  	}
> 
> Yes, but no. Please, rather fix the above mentioned IIO trigger APIs to be
> NULL-aware.

Actually the iio_trigger_free() is already NULL-aware, so make it only for
iio_trigger_unregister().


-- 
With Best Regards,
Andy Shevchenko


