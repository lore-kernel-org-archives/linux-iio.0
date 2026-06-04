Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD33955E5;
	Thu,  4 Jun 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559013; cv=none; b=ilR5gzmfwOZvkuarM1379/cTUI/RCOxdvjkK/TvsLvtWba2yf0efKipQNhzx9phzccCrr7nupVz4kbg7byV9fdtNE3VHe9F6vfA+EJz9e3KK9rSlN0/G92fUfF0GjylGRc+tMg2GQPSetw7hYj9DlTh9rTl2ZX3oO42Lg2rjHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559013; c=relaxed/simple;
	bh=+EsWJrGR8qAiWpqsUXS0/Of8UPrLT68Lhh12yWrfhks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdlOPKJspfTNvk94L4VJPwMgxJ78AzAr5tl4FePSBh0vfhwRy6RSBgZRWEa6x6OwnGg+wXm38u7vtkmr2iwttpU3X8lJl7urB9elEZeTFcewBDkC55pycZaYADF8NVgsVIAQ7q4VLA3qUq4qUcTw0WiRW5Pqds1pAa2JPEIUb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSumexND; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSumexND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780559012; x=1812095012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+EsWJrGR8qAiWpqsUXS0/Of8UPrLT68Lhh12yWrfhks=;
  b=WSumexNDe2eTGSAcjZJ+/d4QpGl1fGDFOPyIQdEhtptcCpHrBFiiFpSV
   YETQDGKI23NOY+3SOCe6tROeUK8dqj1HOex87zN7A/h6Qrbs0vreOWxhQ
   s/ZrnPLVZcWCAU8V1v/zMm0Aba64oRmrwQurFN5A8EBb4thN8mTXKrGVg
   e2ff9fpDekkJx7u4P+hkCnNg4nd9j79XoNh9+YXH48mpQjr0rRtsAdqV9
   Iz10eWFW/OK7cAqqmyAzLu1tA1ObFhqlLXF4i8Bv66OtGOfKQfIfK/uGK
   QKlhKkS8tdBRiixiJLof0hwqvT0NP0OUfj3jmVRh9YcG7ex62ABF6cCaq
   Q==;
X-CSE-ConnectionGUID: Uvdti8PqT4OgEzae7zihyA==
X-CSE-MsgGUID: WaDNCUgMSbiN9bfkqCJvnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81122213"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81122213"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:43:31 -0700
X-CSE-ConnectionGUID: B/HY0kz/TaKhSS03pyomIw==
X-CSE-MsgGUID: OoZJ3w7/SZC50gyfoxoFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241504422"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:43:28 -0700
Date: Thu, 4 Jun 2026 10:43:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <aiEsnl1cwLRXrUq8@ashevche-desk.local>
References: <20260603145134.58956-1-m32285159@gmail.com>
 <20260603174447.63a181d5@jic23-huawei>
 <CAKqfh0G4xDUh7ZR=f760yOAqYqjSLhWGw4UP8KiRM=nnZhg6BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0G4xDUh7ZR=f760yOAqYqjSLhWGw4UP8KiRM=nnZhg6BQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 12:27:18PM -0500, Maxwell Doose wrote:
> On Wed, Jun 3, 2026 at 11:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed,  3 Jun 2026 09:51:33 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:

...

> > > +     ret = devm_mutex_init(dev, &state->lock);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "Failed to init mutex\n");
> > The only thing it can return is -ENOMEM I think. Which doesn't print anything
> > so
> >         if (ret)
> >                 return ret;
> >
> > is enough.
> 
> If I'm not wrong (and after a quick google search), I think it also
> may return -EINVAL but then that means the device struct is invalid.

What?!

> Still may be worth doing dev_err_probe(dev, ret, "Failed to init mutex
> with error %d", ret); or something along those lines. If you want I
> can get this out today or I can also wait for more reviewer feedback,
> but your recommended changes seem pretty simple. TBH though I'd still
> argue for the case of either dev_err_probe() or dev_warn() since not
> having an initialized mutex is certainly an error.

I am on the side of dropping the message altogether. Invalid dev here is
nonsense. Just read the code.


-- 
With Best Regards,
Andy Shevchenko


