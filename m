Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD042379A;
	Thu, 16 Jul 2026 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224850; cv=none; b=HEgP2wS9be6JAHRRNxG3iKTMgy5+1TQCUGhS4mUyOuat/F25hcWTcTkoGS2QV3bv6YqhnL7H3LJCdaZjDdjB786UKKue1a9N2YXQHuSNnvvZgga1f3nLEkfcj9R+SisDJkpqAVOVA06niAFOdLjJ3IGwAfiz7XGA+Hx4xzm3uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224850; c=relaxed/simple;
	bh=ea09xXIql0Vwcx2VTKHAftRJUQrphGJ+lmuiVVx4FuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbKwQ/S1npwc5fsjkNSd6KfqvEZMWTSQ+V5F1l30nErb9v1Qa+g2BGuMfQjv6qnYe56gz4RQ2GqWPYER4wZETCZQpZRapYRvGJeTRJhLCMhHBDlSanADe7xcaEUU0ppy3hZYQzF9IrruEGfcoZIO83i/Ll7pLr1xz8QhSJYRZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHYGIuxi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHYGIuxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784224848; x=1815760848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ea09xXIql0Vwcx2VTKHAftRJUQrphGJ+lmuiVVx4FuY=;
  b=JHYGIuxi1YSw0NETpd32LOojHgQH3GZlh0mQVuUpJ1uOH8hnLkBGk0rn
   785Jeb6qMSQPwgZbLbaFoMLrl18hG0cpDa/XqERQ13FQLEJN7GAzdOygx
   J8k/G6JMb61+OEVS/9Iu1sCtWn4a5xdsCumkR5GxKD90fkLEcLpJ6OzXm
   sr3hcpWchf0DxLgrJ300TR9W1ZSH5HTDhdHv+d7hiAVXTWWjrT0iWhCtp
   Y/0wuwIguTMmRXzbWxxKQliw6JL3+BT36aUE6m7/MQuSEsRqhFk7uUfCC
   8aXaFH/5UrO1/0g0gOJHO9qE7RFkD3HtER0TUvGg4wZPkVlJwu5hwCL0i
   Q==;
X-CSE-ConnectionGUID: FJ49paJEQtu3c1XWos6sFw==
X-CSE-MsgGUID: GwNylCHiQ7yyRA1xgax69g==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102318954"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="102318954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:00:46 -0700
X-CSE-ConnectionGUID: 6hptxKlCTii0nZ3LHYY/wA==
X-CSE-MsgGUID: jiRKyIQ1TFWXo1xgUfF4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252167139"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:00:42 -0700
Date: Thu, 16 Jul 2026 21:00:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH 1/3] iio: ABI: add DAC high_z powerdown mode and current
 output entries
Message-ID: <alkcR44-bLyZWA74@ashevche-desk.local>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <20260716-iio-ad5710r-upstream-v1-1-e848a4bb701f@analog.com>
 <alkcBaHV0gHY37wR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkcBaHV0gHY37wR@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 08:59:38PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 03:59:25PM +0800, Kim Seer Paller wrote:
> > Add high_z powerdown mode for DACs with high impedance output in
> > current mode (IDAC) and 15kohm_to_gnd resistor to GND. Also add
> > out_currentY_powerdown_mode, out_currentY_powerdown_mode_available,
> > and out_currentY_powerdown entries to document current output
> > powerdown support.

...

> >  		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
> >  		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
> >  		640kohm_to_gnd: connected to ground via a 640kOhm resistor,
> > -		three_state: left floating.
> > +		three_state: left floating,
> > +		high_z: left floating.
> 
> It may be less churn if just located before three_state, but hey, why?!
> three_state is a synonym to high_z. What's the impediment to use it?

It's probably named a bit awkwardly as in documentation it's rather
tri-state.

-- 
With Best Regards,
Andy Shevchenko


