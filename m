Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569664;
	b=OSGecZu58oFQBVI+48iRPGsB7xCDjIS8fsgkfl408A+RN+Tz4E2u5+ucf7r/RjmvGuqo
	 Sqxs3NWh8p6+QJF1x7cQIhvcpedmh0Ui2dFEOUn1tVH2Qj6HXnfhAky7mCSmWq7kun22G
	 8gbOpkrNzemtq6nu2hycBUxCEJ/gxXXz0maRr87VS537FND9raTfwmgxpyn/RDxoXvF3e
	 EChoIMjuULEyV7pjooq6ES5rDsH9kIMPGyeYOQ4qcyYVYBzTVlFLBM6DJH3n2Q2TmZqOu
	 PRqtbhkASqB4CPQqcHgKzZAu88lb0YyMBD/ZxX70OMuCC8VcUAvz9M05osvOrDl3cnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569664;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Organization;
	bh=hJ3w0Rkv8rzZbtJ40JmOGOSGjmJX+i2pPaF7KicxJiw=;
	b=miSfy3TSjnrMF430L7ycxqHcLkbB5z+G7aGHY+BekKBy9IHgDLgm9rs/RFks3W623wTE
	 0kf9ohxAXmwc8IApx2pBHVhKN21Q1kffLN+EUI4NJYb45Yj9/dn9g1PVcrQVoHiFAwCP5
	 zL2MjX/3iDJ45XlE4jFwegZl6+uQWVBM+3kuczi6RMQ7BXFohlv+A5k3hIfJxu3T5wq7t
	 Bmod8PYIhn24dtaIiE3Dnjlp9gCgR5/88j9mtp70P57HM4/RdCY2/pTKCZTe9lPr4URA3
	 KAgXGqatFqOuIkUm6dBmcXYli0xQa1EzVBWs1gltZkBF22ggbEn8hh+quJ1gpiY4Wxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U77lLge8;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F143606A31E;
	Wed, 21 Oct 2026 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F143606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U77lLge8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792569663; x=1824105663;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=r3D5d6RtNxdjjNnm6DEAdRn3465kBrNdTDufDDbBtu8=;
  b=U77lLge8MQQrvyk2dNPiZ8jg1+sCQrCsr+B/K0+bkQF/lQAy7wpZSVzg
   1Ocd7Fmkvml8SM5t3yHmuwC4dxgqpBoZ3bC+4zM86jSwvFZRHE8lrZbvZ
   NU/vZEN7pL9jCYd/yaZyXllBYw1Bo5o3xKQZPG07edE+DRLyV2LrV0axz
   /qmC3An81BCruHfOjlph98saxQNz2TySPuVPRMNRPP00XLeg34JAQJjYr
   wm3FRzOxU0LWe5nPNmSUJUwv87hvDHelP2QxClYB4b4PhG77s9aeNnX/R
   cZY+fXI/2TD/gboT+6JJXDIlNHd5z8BC6+oymKmErKirtND+UtesNJ+sm
   w==;
X-CSE-ConnectionGUID: em0+7vhnQ16+qAvFb6H4Vw==
X-CSE-MsgGUID: LmS2uX6XScScnfUN+u9n3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1179804"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1179804"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:01:02 -0700
X-CSE-ConnectionGUID: f+MRbHyiQu62zv0m6RN+Ug==
X-CSE-MsgGUID: kSMIm8FRQy6G6Tx6j5lU1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3489890"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:00:59 -0700
Date: Wed, 21 Oct 2026 11:00:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <athxOKkugAYL62F9@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
 <atEdM6wi_FAGFjrr@ashevche-desk.local>
 <20261017031411.05dee323@jic23-hlaptop>
 <atXSBHbOPYYltHUW@mm-ntb-00805>
 <atXZwm5DzCK8S0_K@ashevche-desk.local>
 <atdRJ3JqAyGWOnxf@mm-ntb-00805>
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
In-Reply-To: <atdRJ3JqAyGWOnxf@mm-ntb-00805>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 01:31:51PM +0200, Jan Remes wrote:
> On Mon, 19 Oct 2026 11:50:10 +0300, Andy Shevchenko wrote:
> > On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:
> > > On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:

...

> > > FWIW, I don't think it to be very urgent, as people probably don't use
> > > it on x86-64 (seeing both as it had only DT probe support and that
> > > impacted users are likely to have noticed the oops).
> >
> > What do you mean by the second part of the sentence? It's as easy to use on
> > ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
> > enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
> > of DSDT/SSDT provisioning).

> I did not know about the PRP0001 (thanks), so please disregard that
> argument. Still, I believe x86 users to be few if any, since the oops is
> quite easy to trigger

True.

> and AFAIK most x86 distro kernels ship without CONFIG_OF.

How is this relevant? This driver doesn't use any #ifdef CONFIG_OF or alike,
so most likely the driver is available for x86 as well.

-- 
With Best Regards,
Andy Shevchenko


