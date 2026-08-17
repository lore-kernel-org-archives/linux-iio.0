Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F8417368;
	Mon, 17 Aug 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971935; cv=none; b=f96TdeAVsPro9W+H75QzOV3nVKkBF93AX2biXLmPqglZSAF8KG7ZOe17MNP7OEi47TDnKUmeRhptqn6qiPPw2oFfUF+Wma7yoMPGKHrQb9KE4Kjb1fOtN1RGibJThHJCv7xnFFYIzkwXGi4XrLXrromTZwPDoO1ywTUXK3zDWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971935; c=relaxed/simple;
	bh=gQPSYZ0+Yy2kCANGjD/T1ROayz/4tK0xY0qPUxojKMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkb4d1/KyhP9BYYWP4bM9MJ14zLotkrdVMyuSGTFkOKnMAS8W46BrVi2sJMD+IpucaSXHv1CB1NnT835Uyp59DikfoTZMFQwFhpP3eS2nr/ukaB0vHJy6aAH9bYiwo2+6iSsoWOZmQWWVRP+7OfpR+tudin2YBwsp6TjP5duqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8jHY+tV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8jHY+tV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786971934; x=1818507934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQPSYZ0+Yy2kCANGjD/T1ROayz/4tK0xY0qPUxojKMI=;
  b=i8jHY+tVggf2aY1ejzltSbiZo0bM2DoCoTBvlD7qWCIjpk8tIoU0E0tV
   tBDROJ/BZYZKIgR5wW/zuKHJMYjmLfix9tYVe6H2ZLzaH189Dl+QldIvT
   W7rtWJOAfgfuce2NihYGl2gW98b6R7PZJDUSOTfdkDo4DG7w9DtOpOhT7
   5itoV5BfI4YfGfJBm9pVDZ62lBADFfRibBTO4v3/L6+qPRp4AlZ/KRAqi
   9Xypr+tWawP/nS0X9MiONxZiRzt7CtCeszo4e8vOxbfvKj5XR8WafyB9Y
   56wSfEXYctf5ElaNfRgRPLV5pFxgngyp1zaJV/Kiab71BM1gs8DExCtyU
   w==;
X-CSE-ConnectionGUID: nMJbpy+aQZGwNERo0g7O6g==
X-CSE-MsgGUID: E8koi7DdQcG5Hc0Wg+BH4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87303130"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87303130"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:05:33 -0700
X-CSE-ConnectionGUID: Y68vzEzFSny1Jehzv6OMmg==
X-CSE-MsgGUID: XX2F8TSoQXejf/hp1iJ0Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="269184763"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:05:29 -0700
Date: Mon, 17 Aug 2026 16:05:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Petar Stepanovic <pstepanovic@axiado.com>,
	Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <aoMHFhvAPcVV1xRb@ashevche-desk.local>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
 <20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
 <anoYDi-bt-t6ZeeD@ashevche-desk.local>
 <20260817135610.00000c0c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817135610.00000c0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 01:56:10PM +0200, Joshua Crofts wrote:
> On Mon, 10 Aug 2026 21:27:26 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > +	soc_data = device_get_match_data(dev);
> > > +	if (!soc_data)
> > > +		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");  
> > 
> > -ENODATA
> 
> Hmmm, I always thought it should be -ENODEV. (`grep -Rb5a5 "device_get_match_data"
> drivers/iio/` confirms this, but maybe it's just wrong to begin with, a few
> instances even have checks missing).

After a (small) discussion in this list, it seems that -ENODATA suits better as
there are less chances to get that from other frameworks and calls. EINVAL, ENODEV
are way too much overloaded with the meanings.

-- 
With Best Regards,
Andy Shevchenko


