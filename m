Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E93914F1;
	Mon, 23 Mar 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263717; cv=none; b=YdugTMRzdeIEsVjT60KXju2V4Tw3qFWp39rj5D2cbIaoywkN//9GJ5PrqgS+KEZAqPr17Qpz+mK2IXWvAcoPnEcp58luEK/TC4LQj/l2mtDTpCE1hnxoGfS6cbCc71lLakuLMiHe2vKUOl1rOx7wUdfNuaRtTcXuOaQKPwOvQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263717; c=relaxed/simple;
	bh=SixAnDle0LreyAXKXJ8mU0e3A8ALj9jmQCKRkUjzzJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjvNbo/85fCBU5lwpkqm2RTYfI2JZNTXVsO1zzUGAFFN5YCtov3u6AI88WVplzf4iWDxuOAQTZndunkWRmea3eEPpgHJt8X99gr/YRxDfAK4HSv+2fB/OQqRvJK58uNFj+c9qFDGGSlStt4IIfUyxErLh6JY92h9+9YwLpSnJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeAdb1vR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeAdb1vR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774263715; x=1805799715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SixAnDle0LreyAXKXJ8mU0e3A8ALj9jmQCKRkUjzzJc=;
  b=XeAdb1vR/ro+JLyX/MpeuVV+lyb7HDjOy1ZqVNIol22kABxLVeussfqI
   GHAXMwKulLRGsUYFaNdIwE53JH9r2pJk71KIZNX+pqFPBmz4v66qiI8+e
   TjsiWz5PESpf+w7EOsmTl9Wv0hFx/PCYlq+7eO8z6Zl5P02PPP+b2xbcS
   wgNAOMsoUqiYcRpAyNLjs/MdReiMgXXAx2G2dCfr4BVhIqxAO2Cjj5+6E
   5hx5T1TDFuM6W/AHRgoLkdgwG7T4CLMUkpxbZiH0r4Zyo4fcqQuJPxigm
   4Z2r+T2JSGFK63bto8GK88fTboZQEbnsixHOzS+kSeBqQenniz4kpwRYe
   w==;
X-CSE-ConnectionGUID: 31adrb+YRVqF97kpUdVyrg==
X-CSE-MsgGUID: 4/BdPNe3TjOlN4UqZwVFiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74967153"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74967153"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:01:55 -0700
X-CSE-ConnectionGUID: 4PAZ1anTSkaWoofQBwnFtg==
X-CSE-MsgGUID: LcPykfcWShKRhHEtyvY0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="219639289"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:01:51 -0700
Date: Mon, 23 Mar 2026 13:01:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 3/9] iio: frequency: ad9910: add simple parallel
 port mode support
Message-ID: <acEdnC9MC2fiirO3@ashevche-desk.local>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-3-e79f93becf11@analog.com>
 <abru0mNtpJSPSJux@ashevche-desk.local>
 <oqspz57p3xgzeq2lvcvhgihu3yeucufdjxurwc3dpuvj6dfu6j@kv23vp6xxud3>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqspz57p3xgzeq2lvcvhgihu3yeucufdjxurwc3dpuvj6dfu6j@kv23vp6xxud3>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 10:39:06AM +0000, Rodrigo Alencar wrote:
> On 26/03/18 08:28PM, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2026 at 05:56:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > Add parallel port channel with frequency scale, frequency offset, phase
> > > offset, and amplitude offset extended attributes for configuring the
> > > parallel data path.

...

> > > +	case IIO_CHAN_INFO_ENABLE:
> > > +		val = !!val;
> > 
> > Only used once, why do we need this...
> 
> Next patches introduce more channels here, so the additions are easier to review.

Yeah, but  shouldn't be better to put this in each FIELD_PREP() as it will
immediately show the correctness and the value range without looking backwards
in the code?

> > > +		switch (chan->channel) {
> > > +		case AD9910_CHANNEL_PARALLEL_PORT:
> > > +			tmp32 = FIELD_PREP(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK, val);
> > 
> > ...and not just here?
> > 
> > > +			return ad9910_reg32_update(st, AD9910_REG_CFR2,
> > > +						   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> > > +						   tmp32, true);
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> 
> -- 
> Kind regards,
> 
> Rodrigo Alencar

-- 
With Best Regards,
Andy Shevchenko


