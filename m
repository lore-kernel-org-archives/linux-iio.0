Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7924CB8D0;
	Tue,  8 Sep 2026 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861682; cv=none; b=OVv4/VVO5IwlgxedZ0aZdtR+WLS7XhsOwjrDhZt5dti67f5IXr/ZjvjfHzqeU8RnVfOa6HMdqYtrAQap3ZPJxbtQ0Ujk6OvpvUqJM1rj1LXcgbLfKUo+idPCRWeCkjWWDGyHTzFNRGnZie+K56Emf+uBHSMbo5V5TZRvAGCdKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861682; c=relaxed/simple;
	bh=Qe0KXUo1TFYBgfJrkheM1X1P/uX4AqP6qqTPzrsRR8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roe1Bu3jiILcDYkpFybe1qwBTTsahpYwOEvKK02yWf6xbLhqPsmUd8JN/ZKzaurPB7XNU134yKFSHa2O5QQhgLH/buZjOjo8BzEWC32p0lMGfJVx2Hod/5gEQ3wsR1re5j8+vyOG2DToZbzM1qZhqv78qSy2GtvZsMErCRZcShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g24iGbRV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g24iGbRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788861681; x=1820397681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qe0KXUo1TFYBgfJrkheM1X1P/uX4AqP6qqTPzrsRR8A=;
  b=g24iGbRVABnJOeYT8MyU5bV4o3HAqe+a+HP1XlUZzPt3jZtt29HvDVz8
   KrEbJQzPGawXMpd+j+XhNYRegyI0iA2SfvpAqqexSplSH19u0LK/p0+O0
   V//AQUYBonmNU/YHu34PnbS2DGQSbZPxblFL6ibaDcJ4MB2KIGjPCiY/s
   iJzzuYzcXjSkVsDqJScJsi0kyhg1EvkPTUeK5VKpLG3oBH9zVC0Y8Q+/b
   gESbtUPxVja0yRmKTr7T7Scva02wEG7FCDlQdrGHJbDoX4xGxJ0BlytK7
   ITN3K9GL1iMncNzUWKIXR1MKMJOJ85pEyQzfpnpVKIP2V4Bip25khgPCh
   Q==;
X-CSE-ConnectionGUID: vMxU2LqOSsS48fv2yzKdsg==
X-CSE-MsgGUID: RZFUXzdERE6aZ3NXC5UeLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114798709"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="114798709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:01:20 -0700
X-CSE-ConnectionGUID: ScioqiiSTd2mE5vv2B0rxw==
X-CSE-MsgGUID: rvoFozcaRBWbqcoC/gl0Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271462413"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:01:16 -0700
Date: Tue, 8 Sep 2026 13:01:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
Message-ID: <ap_c6nbBQ2julqTb@ashevche-desk.local>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
 <apFCNNzhPfq0T6rn@ashevche-desk.local>
 <DL8ICXL9YZ52.2N7SL1NG0LV5B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL8ICXL9YZ52.2N7SL1NG0LV5B@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 06, 2026 at 05:15:50PM -0300, Kurt Borja wrote:
> On Fri Aug 28, 2026 at 5:09 AM -03, Andy Shevchenko wrote:
> > On Fri, Aug 28, 2026 at 01:38:18AM -0500, Kurt Borja wrote:

...

> >> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> >> +	if (IS_ERR(reset_gpiod))
> >> +		return dev_err_probe(dev, PTR_ERR(reset_gpiod),
> >> +				     "failed to get reset GPIO\n");
> >
> > But can you use reset-gpio driver instead?
> 
> I'll look into reset-gpio. But I think it may not be worth to use it
> because it may not change much here. We'd still need to manage these
> timing constraints and we also only use this GPIO in the probe anyway.

It changes a lot. The reset framework takes care of shared signals
(which might be the case in the future, if not already) on some platforms.
You won't need to do much in such a case. With manual handling it will
require a lot of code duplication.

...

> >> +	st->clk_rate = rate ? rate : ADS1262_NOMINAL_CLK_RATE;
> >
> > Can use Elvis.
> 
> I'm not really sure what you meant here.

https://en.wikipedia.org/wiki/Elvis_operator

-- 
With Best Regards,
Andy Shevchenko


