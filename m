Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432582;
	b=KKXfufrWFCCYwW0ELgtgsrYSsKvS0oZ3NH8T9g3ZpYQvO2z2msN1V389rrCbVyzLo2vb
	 IHsIphIJSWkcJ5F5NSzRmplVEgyf/I5dsROZe9b8ya411gNgP2vjgHFw+u8jyfWcXi6Og
	 9wjulRKt6emnNmoK1Kl5NWLTgGYpxD5F6pYRwU/mnYg7IrQvS1Hb6jsYSMQ6+ED0sEq3g
	 dojwpe8d8escFhZnCKCe8X5saA1hMraHfhjUMX/iIa9HM0POJyB0VWzbRxKJWu4xBntdX
	 WojnCwg0KERZGRok/y4odEDb07nz/9s85mjAs+vcN2xPsEj/7tb8ndCduNaydOD5sAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432582;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qMbhXwmp16IW/m6Dno0vydG5WKg0egDd7dQoH23pp9A=;
	b=eiN2BbGFoMq1M1oUHE+DQbmW5dBvmZ5JHPZxZ7RH1v/SuSzExpuG5Oy3FnmHTUvfI8WH
	 tc6NU3srmmmaXkmUo2zM9daR00lVwFyqiu9CRZVx+8AAqoupjIfaUmMYP9LTgdCxQLZpS
	 IoUw7+s0GhK3b29bRyVK1RZVEYl1oPzB/LqMus1znjP3yjKsLqOnTnwKr378Dih8JigBt
	 EUK2iePoPDvRmVT/1ynT4S08Q64UB/5wGVva7ZYsRhoYBO4tNStxHk4j74ZyerMOSYpF2
	 K+d2a/4cmB/kX2ukavAiJVIhURMXLhEUjGToLt9Q3kV4HYi1WYIWDKwkt1Ra3fz+2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="DsCJf/R4";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C313B606A321;
	Mon, 23 Nov 2026 11:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C313B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DsCJf/R4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795432582; x=1826968582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4k34Fr5FlxUz8r/biqU1Yem7YxcKuh3H79iZ7srFOYM=;
  b=DsCJf/R4HI7nC7YzPa2GYksy0RE7+UHucUVOIERI6LKJmoPQeUNvbFQY
   +c1JHFgaed+afpNO+WK6+OGA1SrcT2HH1I0KsvKJ1Ye22NiB/9sRsH3YK
   aRun871D7yhs94n59pyhLZTh5+/BUSNKQ+qMRLqBB3kD4HQNKH6xNO4ZT
   AdU+mUbxWDSX3bbThVXPl6/mcVWplJ0YclwNXMD33IIs0sCJcgwsUmB5k
   4YbCn5f9nvMCToWJ3uVctkw5HBkYM1OW2jHnXHRYxGhdyA29JQWcFz6oc
   MgzIMZqEMOESOGLx01xa0MrLs8YOdXfic/u1WB4r6zUjQyh3N+7f8dTpM
   g==;
X-CSE-ConnectionGUID: QAMjHKQlSamJcMIw2qqOFA==
X-CSE-MsgGUID: rqxuwbZrSgSVL3E0iqHjoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4287120"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4287120"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:16:21 -0800
X-CSE-ConnectionGUID: Ee46gVDURNyKMbCdKm4FVQ==
X-CSE-MsgGUID: cyxRiI6lQXuJYl05XeOFGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11172921"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:16:20 -0800
Date: Mon, 23 Nov 2026 13:16:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: proximity: sx9324: fix proximity threshold
 writes
Message-ID: <awQggK7cKRKH3jUg@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
 <20261122074649.239441-3-kapoorarnav43@gmail.com>
 <awQfT6jSKo9pjxjU@ashevche-desk.local>
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
In-Reply-To: <awQfT6jSKo9pjxjU@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 01:11:11PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 22, 2026 at 01:16:42PM +0530, Arnav Kapoor wrote:

...

> >  {
> > -	unsigned int reg, val = _val;
> > +	unsigned int reg, val;
> > +
> > +	if (_val < 0)
> > +		return -EINVAL;
> >  
> >  	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> > +	val = _val;
> 
> 
> Why not simply
> 
> 	val = _val;
> 	if (val < 0)
> 		return -EINVAL;

Ah, see the comment I gave in the other patch.

> 	...
> 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> 
> Note, reg might still be not used, we have more validations and with your
> approach the reg assignment is in the middle, confusing...

-- 
With Best Regards,
Andy Shevchenko


