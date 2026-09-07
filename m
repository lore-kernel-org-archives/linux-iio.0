Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549323644A0;
	Mon,  7 Sep 2026 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755443; cv=none; b=MIw6+WPqIVwaVgZN58PJ46B8foSNWhfSzx4L5ITi1l4qSsbdayabSldvx/LoL6vVmFIq08XyP7BZNq9TzFWWYpbxDxgZ8PKWcer2aAmSx/DbhZ82Zd6frw/C3pzn4qx0y5LsFjJB/U7AQf/9bI8bTmnWT17Nn0+ZQBXMoNCj84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755443; c=relaxed/simple;
	bh=fmjmtEYWjfe2KRiDQSEt2kJYJS2FBbAOx4mBKJNeXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPTr46ar01OgSPIxTXAelVFGx05NUl2KfnIG0Resd14CAKeUjfalAogwvOTweS/rPGSiVpUwlsNILlJs65YKuTpRjvf0YkHR3Yf9AgR95KKTxPxMlPdCbIp1OJ/sv1VdORV3Nr1uYfyoucdiqHxRZax+94Jr4PPxzQg/DIAsd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9Oydha0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9Oydha0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788755442; x=1820291442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmjmtEYWjfe2KRiDQSEt2kJYJS2FBbAOx4mBKJNeXCc=;
  b=b9Oydha0QGcWS6mghCOeKKUgtpiYysnJM0/cL+R1O7/zzYOQZwDe9EaQ
   AOVDcfraq7RuoAw7AUhGbZRrottOL0GCefjdLY9YGCUPuTG2ixqf1vpeF
   rNGg+WejEfInwjYoUHaWwLT2Zc0xzoh6BRSnovQOir09TCpGZCNw33rSX
   2i/huB8YBt1HKs2jHSshaUNgT4YJfgVfmvZmqfrZsil5foWuqw4KxIbKT
   nWXuAQx3KEzAyT3E319X9KBLwBY+xUB9GYkhnW0jEVVdoppJyf5BuntgY
   I6Q+EpP6khLupxWOB2DyyKOUTIb7/bzmVNEkURzqE2DCu3CZoEybY6CaR
   g==;
X-CSE-ConnectionGUID: cTFTFbHST1iP9dXQiZX/FQ==
X-CSE-MsgGUID: qfZylRN2SaWB7iPOq7V5zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="88298192"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="88298192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:30:41 -0700
X-CSE-ConnectionGUID: DiUY/2DGSIC2i7a1siKKTQ==
X-CSE-MsgGUID: vUvhQ+aqQnKRBsxRmpWRZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="266915979"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:30:38 -0700
Date: Mon, 7 Sep 2026 07:30:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add support for AD5710R/AD5711R DAC
Message-ID: <ap497BPHehKLEJGT@ashevche-desk.local>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
 <20260906190559.7ca260f9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906190559.7ca260f9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 06, 2026 at 07:05:59PM +0100, Jonathan Cameron wrote:
> On Fri, 4 Sep 2026 16:35:23 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
> 
> > The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> > configurable current/voltage output DACs with an on-chip 2.5V reference.
> > Each channel can be independently configured as a voltage output
> > (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
> Series applied to the testing branch of iio.git.  If that all looks
> good I'll push out in a few days as togreg and linux-next will pick it
> up.

So, still time to pick-up tags!

-- 
With Best Regards,
Andy Shevchenko


