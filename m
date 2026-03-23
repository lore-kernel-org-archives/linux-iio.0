Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB733328FA;
	Mon, 23 Mar 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264004; cv=none; b=KJLWS6CgHhJIGs9+kKHsCYoyFJIpSvjIw12v6LoCDyw58EpSM0Ic8PZ0pHlVMTws0QRF5LSycF72dRNgeks3Jt6IYabEUHRT/PfmgtQ4gRD328S7ehkl3yA8Dx0rA8a5+ZEUEayIxyGckK+R9cqiCjT66JyhZgfW47EI3SyDxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264004; c=relaxed/simple;
	bh=iKYPMqVl0Bw64WkaCxOlrBQo1kDKKXPMvQwCT72BQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtFJezVGUxkE0CLToMhtUZAAhK3joIFolewhJPivLFrhRmFpekM5juHhIYzyYTZtGcuHLlhFW1BvmUPw2s2CSOf9QAkViApUSI4SyjxdnEC4iItHNzk+xeQ1Wl4OFJcQEE8VROyW79rknpyPD+m663p0hM7jERqzzP1sUlD2IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVFcvtDf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVFcvtDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774264004; x=1805800004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iKYPMqVl0Bw64WkaCxOlrBQo1kDKKXPMvQwCT72BQvU=;
  b=UVFcvtDfRQcnGO55luLBZTXL5Vo/1zyDyFhmhp+px5l2AkGu6MQ4ddUH
   mzsZx+lV/QkC8jr9SkRq9UxVsyVYDofouPO8y7jpKyGq4Y+0Lqpvn13Pq
   pk0fXCpEfOTbR5OPH2iPA5vC+zyGy2BjED92O9gPwnQA7JG0Oo5hO8w9w
   Mz5le01iYd2wAShm44NlhF1R39CMY5ZMp8VL1RSte3Qp/NNOR+yt54JUi
   btsfFACuhEv2xwZRxrEKkLL3NWl49e35TTJvweBtQAS8gBewZdyhJa11p
   rkqfUlYd0SBlF3jhM3tcedXcftdP3Xiud7BvsHsYflqsour0C0jv0lkee
   Q==;
X-CSE-ConnectionGUID: F/DA9FZoTKG7PLSsIuMOqQ==
X-CSE-MsgGUID: t9NvomlrSDmnwJinbZwnhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75228581"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75228581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:06:43 -0700
X-CSE-ConnectionGUID: uznmrb98TtmAmZ7/HVhbKg==
X-CSE-MsgGUID: BcO38b3uRNSih4zv4/dxYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228070818"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:06:39 -0700
Date: Mon, 23 Mar 2026 13:06:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	"Marques, Jorge" <Jorge.Marques@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Message-ID: <acEevKlA6BAVIM_x@ashevche-desk.local>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-4-carlosjr.jones@analog.com>
 <ab1eQ55b_8JiyAGA@ashevche-desk.local>
 <20260321125417.5ad7622d@jic23-huawei>
 <SJ0PR03MB5854B6F86E441F18E85A9BF3F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB5854B6F86E441F18E85A9BF3F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 10:39:30AM +0000, Jones, Carlos jr wrote:
> > On Fri, 20 Mar 2026 16:48:35 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > >  config LTC2309
> > > > -	tristate "Linear Technology LTC2309 ADC driver"
> > > > +	tristate "Linear Technology LTC2309 and similar ADC driver"
> > > >  	depends on I2C
> > > >  	help
> > > > -	  Say yes here to build support for Linear Technology LTC2309, a low
> > > > -	  noise, low power, 8-channel, 12-bit SAR ADC
> > > > +	  Say yes here to build support for Linear Technology LTC2309 and
> > > > +	  similar low noise, low power SAR ADCs.
> > >
> > > No, in Kconfig help text (and possibly title above) we have to be
> > > crystal clear for user what IPs (chips, SoCs, et cetera) are being
> > > supported by the driver. There is no go for 'and similar'.
> > 
> > One follow up comment is format the resulting description as a list as it
> > reduces churn in the long run.  e.g. how AD7173 does it.
> 
> I was informed about the 'and similar' context in the Kconfig to scale
> the driver smoothly but I mistakenly applied it to the help text as well
> instead of the title only. Will revise accordingly. BTW, keeping the 'and
> similar' context in the title since there were 9 instances of it in Kconfig.

OK, works for me!

*Just always put yourself on the user's position who is not familiar with
the coding and may not even know about programming.

-- 
With Best Regards,
Andy Shevchenko


