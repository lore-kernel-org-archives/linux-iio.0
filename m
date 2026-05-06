Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1530C610;
	Wed,  6 May 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052358; cv=none; b=dCJwkQ3tiqTRtUEgH27DZAssT71/mgLEgiFuI6MYT/TQjve1fORDh8hFJmLz9xLDTRWRUrMLgOaEkfW75QdcAhxjxLBAS8X6z1J5tT8fNQ2xBqKz5BoA+xBmjvTpZ2TMVBJJ97mdn4pxZ6glFNFyosoUA/+xfilXdLZAOTFgRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052358; c=relaxed/simple;
	bh=UjJX+Z0GuisaTRIRYcSJemaTdvdhYahy84Qu7RDrclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btX/LCbVNYxTHWEoSXL6GY1tjo/rRyF6SSt5IVe0TO8OCpPW3AUpMrdoRNCP8vxVm6S4bFb+KiTDDZE6xY/obRBt5dcM68LaSbuaqGbsUXgI9Cr8w7W31cNmV9kpHrBOv1/7Z7xRc3VciTFEtRpdkkLZLkyzMuUYUbkhvOSr2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrbJthKE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrbJthKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778052358; x=1809588358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UjJX+Z0GuisaTRIRYcSJemaTdvdhYahy84Qu7RDrclk=;
  b=DrbJthKEn4tfk9yQmWr8fpjJwIphq5YpXOean6luBI4cAwGWT7Vu+jZA
   sfPBk5wzv/isJ7dCKnNTW66WU9BAKKMj+SvtgqQNf8tS4w2VOjgqVd9wI
   enVe7LWXez3/WsdUAocUAEcG1onNGWr4IsX9Nq9nUxi/uIH+SBg2C2yg6
   WqU9rkXtVhswdoif9lG4/vO77Cfm0VE2niCEc8oYCfYtxXTl4FTjIkKC6
   gOJ40hpM+upZmSBygHQRBJf1KNQY4zBFr31L/2/xXCpxSSgwlR05MPW9U
   pnpzTXf842D9tyFPRSpHgy2UdynGJscmTtZwb48yZ5a+rpaZJ3NRc7Iyl
   A==;
X-CSE-ConnectionGUID: wQAX8EoiSHS/oLpQN76ueA==
X-CSE-MsgGUID: UIuy7poZQ5GppMxEPvyrKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89283468"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89283468"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:25:50 -0700
X-CSE-ConnectionGUID: 6TkjfeaoSF6U+TVo4Ivm5Q==
X-CSE-MsgGUID: X1ADEw+uQ9Sy30gRFsDSdg==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:25:44 -0700
Date: Wed, 6 May 2026 10:25:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <afrs9ZN3moV157fR@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
 <afhReLCsEdaEOT_H@ashevche-desk.local>
 <LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260505142640.49cde0ca@jic23-huawei>
 <afoFjaUBcGXeuEzH@ashevche-desk.local>
 <20260505171723.390feb20@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505171723.390feb20@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 05:17:23PM +0100, Jonathan Cameron wrote:
> On Tue, 5 May 2026 17:58:21 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, May 05, 2026 at 02:26:40PM +0100, Jonathan Cameron wrote:

...

> > > > > > +	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > > > > > +		irq = fwnode_irq_get_byname(dev_fwnode(dev),
> > > > > > +					    ad4691_gp_names[i]);
> > > > > > +		if (irq > 0)
> > > > > > +			break;    
> > > > > 
> > > > > This is problematic in case the above returns EPROBE_DEFER. Can you confirm
> > > > > it
> > > > > may not ever happen? (Note, I don't know the answer.)  
> > > > 
> > > > You are right, thanks for this!  
> > > I'm missing something. Why is that a problem?  Driver will return
> > > the error and a dev_err_probe() is used so it won't print anything.
> > > So probe will fail which is exactly what we want.  
> > 
> > If there are two IRQs and the first one is probe deferred and second returns
> > an error, we return that error instead of the deferral probe.
> > 
> > May be I missed something, but I have no idea how in this case it may return
> > the first error code in such a case.
> Ah. Indeed. I completely misread the code.  if (irq) would do the job to fix this.

Not really, as we are only concerned about deferred probe.

	if (irq > 0 || irq == -EPROBE_DEFER)
		break;

will do the job. But again, please double check that the
fwnode_irq_get_byname() is even capable of returning deferral probe
(probably yes as my weak memory tells me).

-- 
With Best Regards,
Andy Shevchenko


