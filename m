Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D742F549;
	Mon,  2 Mar 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469814; cv=none; b=BA5ycAbvPbmdON7fNXLpqWcF0yqxMZIadkuq/Si8Bfkr5940wuMAP6016dEzVl27uqVFchuJxCC2/LulrJdOpTcHRxWA2jD1e64AK0fFENDc2Iz/uIHBKqxxeh1gvUFVpe7bakFXzhEdAXt50y6T5hcEcaPbdmhaKosxIKCaGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469814; c=relaxed/simple;
	bh=cets079AyGSz2IBsGd75WBCR31fpL5QpjenkkctWv5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsPWD/vbs/rLY42qUhTwZTS1Vj+Q/r0nEXlE6s9qLfFCSTmZpRSHAd9BQbwNW0k+BW6/o7VHqLznRJZH+VmLyCHdzQ1k4vKz/5o6k1xI0JZPqSxtB+gTiCDSFWUqjczot5FAbS90wrbFsGRuJSazRFrUnuMClkmvfpHY/ULz2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/U7Xfba; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/U7Xfba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772469813; x=1804005813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cets079AyGSz2IBsGd75WBCR31fpL5QpjenkkctWv5w=;
  b=g/U7Xfbal4p4L6QEOFovqQ5iEIpxjKge4XWjQFO2uZIzf0qMqOD1RYHp
   8gPAQn9jiHgV1Ym6yewAiXrtp8HMR1ZpSZg4QCP2jE5gwPtDF5TWZkW3q
   YaEHMo/B1n+7VaeecQgI7e7iIa08LlthXz5VvANpE5OlXGGsKa7/9Dt55
   t5ICi5pguhHSZfznlntBQjlnwRPnSCsmXHgMV2smKoHkui2YaBsdVkVgJ
   wVBizp9xvRVJkQ7/wSOiLBNrUudKlU1/kIjpA/TToR162UDlLQXJOX2Wp
   8ZZe5PIHcMe3CQKhEfYGSM/MKUJUITSPWkpXNrpoe13aXRv4Cm5bIvUCD
   w==;
X-CSE-ConnectionGUID: m9+dNlLKRVCxsqTAN/kRTg==
X-CSE-MsgGUID: HuZEPwG3TnmpeI6sQGoOEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77349433"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="77349433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:42:58 -0800
X-CSE-ConnectionGUID: 4U4ZqyjMQGunrOuim1jyMA==
X-CSE-MsgGUID: BqPaKiwcTw+XpyglQhhVRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="215322361"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:42:54 -0800
Date: Mon, 2 Mar 2026 18:42:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <aaW-DC64WCxYYcgY@ashevche-desk.local>
References: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
 <aaW93QGdN25mqFUA@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaW93QGdN25mqFUA@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 06:42:11PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 03, 2026 at 12:00:04AM +0800, Felix Gu wrote:

...

> >  		if (ret)
> >  			return dev_err_probe(dev, ret,
> >  					     "Failed to allocate irq\n");
> 
> Also consider dropping this duplicate message as the callee does it already.

(In a separate patch, obviously.)

-- 
With Best Regards,
Andy Shevchenko


