Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304355;
	b=duiaIlIJ/PHtet6ifFCEkpS5BufxYSG/dpqNnHaIsjc7Uu0gOg2bfGIbkI/1l056eT8X
	 P0t8e1M4MIkxv2gboWOZVNpE7wk+YygX4lTFHNL/hLqfBFRCUqdUVJuTJMnXzeKdkse3b
	 RgIuxvmxy5McibD7XWiDH8oZO5yW5PeWDISt7DYPfIGOm7RiV8n4qSMuTUiVC/HN+mbVD
	 tzi8augyy3eWt/YcLSqcJ3z2gGXihQ0aX5s929M8hWAfjVryv5idKt5WGCPYAJTEECjOo
	 y/Q/aV0m4D0v5EagZ5+xnrO+T73p+6ozrjdnxVfqpbvxk7tJPhECZ+9L5EnHyRibr1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304355;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Yd4FxpRCS4fQY+YVzPkOkyaH0M5G0U4APBjJlbUa4/g=;
	b=22njJ/inJ2BgANIOcdQw4SbGeaxUeqHvhFNt5xW/JyNF/K0Se0cp65MeuH+c13BtxHO6
	 q8eRDsJKnRjBqS8t1SjHNp7nkROofsklmoiiuPZV5H3ICnf2p9KdaVYgERf/pp2Z6NaEL
	 /zOAGgldUcQ7GRUmmfozp4bwSb77hHVG1OYwjw3t3tncoZhrnhkfumG+gpgYC6DFur3uJ
	 O734ZzgJJrayrQ3OUczAOM4DIZ+MoDWULvT0aHMVbFPS7DXKwrPdpRrYBBJsEC87bqOEN
	 3CpyViiXwElFkmuA8o0YGHVbkKTrynlzrxNywO0UT5S9XCZv41Qtt4W+O9LcK4F4tFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBcc5m4A;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63240606A934;
	Tue, 10 Nov 2026 09:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63240606A934
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBcc5m4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304355; x=1825840355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+aBQV5lSYGDF45swiVHgkDWTmEtQKr+fym2AXMrBjZI=;
  b=cBcc5m4ABsejuZ10rzqhIuFF7ZAYOYBQzm9MnL1MeN2xzb8ldfNsAYED
   Z74Qgteqs3L85WrS0ZATkZSud51FM+h4Sr6Hp5Any3vEmJMScxmC+Q7Vd
   2C9h5Itl1gAfFF5Q8+SkXmR/fFMuXhxX1DMkYkBrl4TOt4zdIpIvPOO01
   jg7zsVomXxXb2EiF9FSB/+t5nWmoV29cYa1mu6VP2OTbqugL03+6iMJtW
   blYvoB7zAyqr1H8U8BsmRhNEHfMVE83pGTYQLlyg2i9isgAdtpJ1Fn59r
   0DDLPfCo65LSdupcly/GRAyY5cnHDpyEnkMxPI4J+YrdtPD4wO1GDE+51
   Q==;
X-CSE-ConnectionGUID: zJaLw8UvQ/+Si5ZhGm47iA==
X-CSE-MsgGUID: 1r943kFAQqSeWSRfNjLTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3145566"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3145566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:52:34 -0800
X-CSE-ConnectionGUID: RqZZdffeSYCZBA+bkxr8ZA==
X-CSE-MsgGUID: PIqk/GEfQ5CJNwQE2WRiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7968707"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:52:28 -0800
Date: Tue, 10 Nov 2026 11:52:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <avLpWqh5cbIYj3oA@ashevche-desk.local>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-3-maxime.chevallier@bootlin.com>
 <auyjgDddFs3OvnC3@monoceros>
 <20261108013218.0fe627e7@jic23-hlaptop>
 <avAy6cemm3MRHSQO@monoceros>
 <avIGbBH88xZwndaC@ashevche-desk.local>
 <avLluP28gVZEfFfe@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avLluP28gVZEfFfe@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:40:05AM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 09, 2026 at 07:44:12PM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 08, 2026 at 09:32:10AM +0100, Uwe Kleine-König wrote:
> > > On Sun, Nov 08, 2026 at 01:32:18AM +0000, Jonathan Cameron wrote:
> > > > On Thu, 5 Nov 2026 16:42:42 +0100
> > > > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > > > On Fri, Oct 30, 2026 at 05:47:04PM +0100, Maxime Chevallier wrote:

> > > > > > +#include <linux/i2c.h>
> > > > > > +#include <linux/mod_devicetable.h>  
> > > > > 
> > > > > Please don't include <linux/mod_devicetable.h>. <linux/i2c.h> already
> > > > > provides i2c_device_id and of_device_id. <linux/mod_devicetable.h>
> > > > > provides many more *_device_id and thus introduces a big list of
> > > > > unnecessary dependencies.
> > > > > 
> > > > > I recommend to just drop <linux/mod_devicetable.h> here. If you insist
> > > > > on full iwyu, there is <linux/device-id/i2c.h> and
> > > > > <linux/device-id/of.h>.
> > 
> > It must also imply acpi.h.
> 
> That's true, but irrelevant for the patch under discussion because it
> doesn't use acpi stuff. So at least here even with full iwyu you don't
> need to care about <linux/acpi.h> or <linux/device-id/acpi.h>.

True.

-- 
With Best Regards,
Andy Shevchenko


