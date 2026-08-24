Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB43EDE42;
	Mon, 24 Aug 2026 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561205; cv=none; b=HJSxSQefUB4ogU+3CDvYLlzt+B1zBNSO88nsqmVk5v0sgcYWxrJ+0yXnBOYIH6RgWJzEV5bjulQYebwRzr7tHOMboOH3LJYe0y/mzTelOxnC3mG5unBP+g4h0CtUQfQlHPhmJHsr0wvsyfyg/w72aG3Ej7uwr6SGsEDuJP3s1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561205; c=relaxed/simple;
	bh=UZVNb5yLAilHhfWPXtC+jGKM1jc/+Xg8SMt5FeCOauA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIiIeN29Wqe+tqlK8jE3m/mVmWIx3Ld4zTCLlo0pQHPva070GBmF5DhFa/l23jIX5U/lQfiUbI5FJdaJ6l2JfWKuMgbIGI0ydI9hjIZJ2vTknfym6FuzOud93w1cJN2MR/KPeZtpbx48hXETk7+tIl/b9TVsNXMaq/laDC/JF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/ZCQCkb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/ZCQCkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787561202; x=1819097202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UZVNb5yLAilHhfWPXtC+jGKM1jc/+Xg8SMt5FeCOauA=;
  b=K/ZCQCkbT3z5gzYuwFmQNvDBGz2TpXzdTbdkKpzNkRpZGoVkAP16o4um
   WkM7fIvBNt+xTltRqv/DTjJ6xlbTDAw23+RLviaIHD3yHSJLUZqhSV1p2
   JAsyGHIvoPfATfNo0YVBxZmMf6BygC/VesRN+LENRZlYIadut7XmtLX+H
   6TSVzX5Dz0thEnPG6uNFT0pESgT2QzN6yDeWmS/05EQSKqNXvGvPMk3RO
   NOVp1cv06ct32durlGmirxQDYc4ySVxwAw2fXg69Fyj/R6ZznBqKM2kUU
   0RWZ6EcDdSgMp+JFBFzkLbMw430hm7egko2OQExYa7lELk1e/GA057UrG
   Q==;
X-CSE-ConnectionGUID: /o5hoECJScacWx8qztkeNQ==
X-CSE-MsgGUID: 1T0mtTIERUCLRv0WGTxMaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91821268"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91821268"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:46:40 -0700
X-CSE-ConnectionGUID: MZJeHxLJQNaZus348bLQAg==
X-CSE-MsgGUID: 961tmB6nSj6ZZpoLriq8Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="296843458"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:46:36 -0700
Date: Mon, 24 Aug 2026 11:46:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <aowE6mvlRw8RrGl_@ashevche-desk.local>
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
 <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com>
 <aogvjsjOatTpiw7j@ashevche-desk.local>
 <CAF7HswOMH2FGEZR+ZASDrSQjgi_YCd=6ZUoxTdTBfwsec3Y5YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF7HswOMH2FGEZR+ZASDrSQjgi_YCd=6ZUoxTdTBfwsec3Y5YA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 04:09:14PM +0800, Kyle Hsieh wrote:
> On Fri, Aug 21, 2026 at 6:59 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Aug 20, 2026 at 03:51:52PM +0800, Kyle Hsieh wrote:

...

> > > +     /*
> > > +      * Datasheet: td(RSSTA), the delay from the RESET rising edge to the
> > > +      * first I2C START, is 100ns minimum.
> >
> > This is order of magnitude delay. Do you mean 100 盜? (Actually would be good to
> > use Greek letter in the units, looks much cleaner in the comments.)
> >
> > > +      */
> > > +     fsleep(1 * USEC_PER_MSEC);
> >
> > Otherwise this should be simply 1 (no multiplier).
> The datasheet says 100ns minimum, so the comment was right but the delay
> was far longer than needed. Changed to fsleep(1) and used µs in the
> comment.

Note, we have ndelay(), so using it as ndelay(100) might be even better.

-- 
With Best Regards,
Andy Shevchenko


