Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1281FE451;
	Tue, 13 Oct 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900365; cv=none; b=A61x3YGxcHLmfd24glrbCVQeFJ52YFwM4f4Yp29JTga/9lJWs1BKGB/8XH5DbbM4meSj4MdcoWEJ8Zep8IpnuLbScf6b3rEcEkBbsU/nmq0vlLrCtBov7sbAW7kRrY98eiGtrGdsSHJpCRFbtck9LJUZBlpkJT0Umvr4oiyLMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900365; c=relaxed/simple;
	bh=sKU/XcsTHaTSX7e1d5LMbRt9ZT4u9MldIjoStyaSx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg/xcmRk22SIXTg9hd/ZZ9SWLhTXlAWDNuAFJRg/Z7O+cZG1UlGS4k/IMo9aqezs+FdKYdk2SRirK9gQn2wQLi8Eqi7EsYEFrmZrR4KXbLBhtew6roS5GbK+3sIvfQ8CtlaU9YWHQOeSTyD/1oCIQRq81i991E4wmFvYBLTRXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8tg/lXg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8tg/lXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791900364; x=1823436364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKU/XcsTHaTSX7e1d5LMbRt9ZT4u9MldIjoStyaSx1Y=;
  b=W8tg/lXg/dKAPs7IzQQpxleZdRqWN31/Iv4S/tvys4HXKF31nrNGzYws
   96aOIxJFmNESnG3knHPv3EJseISA1yyGDg0UwWZo8rU5xYmp+UCMuNDpM
   Wgwd/YLR0RGi4Egv6KY6Nqh2lWTVFHCwXmYbwavVMHSg7n/ez5OdwdXnw
   zKdkN1TCilO+nb8hfGz/amJlMlG5Qkh2uFpRC9WnFn39MWYMONWuF+h+K
   XtTPhfzXHZDanTZEaF+fZzn2Ww7dYMzZFiNbU2Z9jcVLlzCTHbArVPY+c
   gyuoZz83/FniZIIc9obzSJ7LVd0wO6Y4v7XpGCbKUp8rqsDF2Uj0ruYsy
   w==;
X-CSE-ConnectionGUID: a9PoP7KXROiav2ruzm2Ptg==
X-CSE-MsgGUID: JCqqn0wISIW4EJuB0iJBmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="634263"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="634263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:06:03 -0700
X-CSE-ConnectionGUID: mx6/uuVETymVvMK3wkKf5A==
X-CSE-MsgGUID: BDq0DslZTR67YS4YtKQNvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1493860"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:06:00 -0700
Date: Tue, 13 Oct 2026 17:05:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
	Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <as46xFp-3fXvWPlm@ashevche-desk.local>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
 <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 10, 2026 at 08:46:30AM -0500, David Lechner wrote:
> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
> > On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
> > <dlechner@baylibre.com> said:

...

> >> +	if (device_property_read_bool(dev, "gpio-controller")) {
> > 
> > I think the right one to use is device_property_present().
> 
> I thought this was the one case where device_property_read_bool() is
> actually correct because gpio-controller property is a
> /schemas/types.yaml#/definitions/flag.
> 
> Otherwise, we should just remove device_property_read_bool() from the tree
> because there would never be a reason to use it.
> 
> My understanding is we should use device_property_present() for non-boolean
> properties when we want to know if it is present or not before reading the
> value of it.

That's not true. The _property_present() checks any type of property, while
_property_read_bool() returns an actual value of the flag, while they might
overlap in the behaviour, they are semantically completely different.

-- 
With Best Regards,
Andy Shevchenko


