Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089A279DC9;
	Sat,  4 Jul 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184766; cv=none; b=aFxzW5J4WqwZEy34UX5ZSZZ4WX8mj1yZnifwVWVzQri/LfNnYaf3v1BCKhWY3P9pWCBxu1hDgVdjRXsvqaaGCL8/3hhGu1AMHhk8FRcMg/dMz5DcyHIJaJu2TDUZiM4oGk3G8OLc3M/z2d6zhWz0b9dhUiwSsK6qMkZab+B7o2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184766; c=relaxed/simple;
	bh=S1rTVlnC+OJLu5zeLuUrwP29zeQmW+jHInRpCh4cSb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgaFRQFQb8ii8YOStPfpcaYYzNJNhWslljW6sJa0kWNgRmUsYsHCtQzepndNTA1zYmXw7Gui6hoCOZcPIfn+Swgwe8L7/q9F+xcqrX2gs+Ra+LdYpuX/V8YNh+cjljR66i9WJEEF/QHELFIvsTjtF6IrFuVjGbsxXP7L0LhO4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuCvMFS5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuCvMFS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783184765; x=1814720765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1rTVlnC+OJLu5zeLuUrwP29zeQmW+jHInRpCh4cSb4=;
  b=cuCvMFS5WfFNfZLRbWHUpzNFj/ncS5SLlMXGbI5lYip3/0Ie/rfJZrhX
   GejuVjfOEPJ8uKJcCsD+vH5EfaoycgvgqcJdF84hMMyCnh89l1jOQ9pM5
   ivFB3IBu5/8bSZ+FI5zOOnBXcAUV+nk2Sn7sYqBldbxexvAd+cF8ETxPE
   s+Ntb2M04E1FesInReMOzlFRxPZHM58/h0KsAvoVnskh0Zq7RuwVgZdDm
   zQu4ptEu12xYmU5b264aFHnVnoy9WfffKDvFsFTnL7CuncsYNv0vXLuVP
   4vA/C5IYXYrVn2xV2mP8k3YeqNcVY/XQQcNXawGyBbVvijnVfPS2iev9W
   A==;
X-CSE-ConnectionGUID: OPlXxuM1TFmhMAw2jgRFqQ==
X-CSE-MsgGUID: h4rAv5fUSJiq94q6MC1Lpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101431781"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101431781"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:06:04 -0700
X-CSE-ConnectionGUID: tCKMggPtTWSGRKfCPg6hiQ==
X-CSE-MsgGUID: 3RkDQhuCQa+/xFITm+/ikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="249988383"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:06:01 -0700
Date: Sat, 4 Jul 2026 20:05:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <akk9d-Zrx52C674x@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
 <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
 <akj3Ay8mwemRj-9U@ashevche-desk.local>
 <akkwWxCf10rfThMk@fedora>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akkwWxCf10rfThMk@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 10:32:32PM +0600, Siratul Islam wrote:
> On 26/07/04 03:05PM, Andy Shevchenko wrote:
> > On Sat, Jul 04, 2026 at 01:42:39AM +0600, Siratul Islam wrote:
> > > On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:

...

> > > This can fit in 1 line.
> > > static int max40080_update_bits(struct max40080_state *st, u8 reg, u16 mask, u16 val)
> > 
> > Here...
> Keeping this function single line results in 86 cols, which is just a
> little more than 80. So I thought splitting here was avoidable. But if
> you think it's an acceptable split then so be it.

Split is a safe choice. No split is a slippery slope depending on some factors.

...

> > > > +static int max40080_get_range(struct max40080_state *st, unsigned int *range)
> > > > +{
> > > > +	int tmp;
> > > > +
> > > > +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> > > I think tmp can be initialized, since it is only assigned once.
> > 
> > I don't get this comment. You mean switching to ret?
> > 
> I meant tmp is assigned only once so the indirection here, i.e.
> declaring and assigning in two steps doesn't buy us anything. Instead,
> it could be initialized like "int tmp = i2c_smbus_read_word_data()."

Ah, definitely no to this suggestion. It makes code harder to maintain
and the pattern you proposed is actually discouraged. You can search in
mail archive and find like ~1-2 year old message from me with the detailed
explanation why.

> > > > +	if (tmp < 0)
> > > > +		return tmp;
> > > > +
> > > > +	*range = FIELD_GET(MAX40080_RANGE_MSK, tmp);
> > > > +
> > > > +	return 0;
> > > > +}

-- 
With Best Regards,
Andy Shevchenko


