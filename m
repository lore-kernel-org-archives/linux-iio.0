Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0D225788;
	Tue,  2 Jun 2026 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424871; cv=none; b=MptfiWIpzIL0CiqNkr+KGmehNLLtb2cKxK0kMBwyE6rJAPxoMNL2Nv/Ys1GaPFEevWHY8e4x+vR2SRzJEx2qwwMejy8zL9IgtPvrzsqb/Rt0RaplVBr50WzKvAHNGVyiaF5q/qZu2Vsv4AdqCKH5PaGqwSuxgSIjWJsjMovvqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424871; c=relaxed/simple;
	bh=JAKACGblmVp0qOtTpZKUe7ENVsK0mSqAwKq+52Y/t/s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEono+JHGhSxtXBa2ynsqzgl+ZeBYs15B+yNApbvRy5pQ8Y1nnc0t6mKN4oe9KpCTEpgAEEfizknMRl85Afhk0p+Lj4uajd2kkc7HqH63eaxMXUosFCASnq2tT74cvpMDqeAK/zVeMQXIJKiQnWHLfw2YRy52df4ip+Jh3Vtx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQzMXtkl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQzMXtkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780424870; x=1811960870;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=JAKACGblmVp0qOtTpZKUe7ENVsK0mSqAwKq+52Y/t/s=;
  b=LQzMXtklDSr3IbECYCKXkYlP6w4QEnffPHQiaXY4uAnTWHbADWjFkfhQ
   zaTHLkE9ZEwsTTSIxWtoiqrYT4GT/c24YDUdV/9X9dzYz21kiNBbucXFh
   xnRMyipFBDTKtVlVPvGmZ7V/itbzR0E3H85vm1AZ6h1W6NB0VNYMBUxtm
   MHjfD/ncRNzo0DQKIGiMDRyOaWLg/fjc7YBbYPv3GV6mYvDbl8Ybbt981
   Qoqi+EBnrRC2hv9dZcoK2TpAQZ79/hqUas0DwiHAz3IPSIkIU+8AKAIOc
   mEArmrvEJndPolr3a3IUKRx4lvJEoI87EuAlTXz6rZpunbo0EZr/SU/pz
   w==;
X-CSE-ConnectionGUID: R33Bq4ttQXCARhnvdirKiQ==
X-CSE-MsgGUID: rfzUiMCWRoGI64dnS0bE8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81348605"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81348605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:27:49 -0700
X-CSE-ConnectionGUID: X7dJPcHIRBuGkxCgZ6zc6A==
X-CSE-MsgGUID: f3PWSRppTeGC+zCSm+pprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237634600"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:27:46 -0700
Date: Tue, 2 Jun 2026 21:27:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 11/11] iio: dac: add mcf54415 DAC
Message-ID: <ah8gn3g3_-cY1kbQ@ashevche-desk.local>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-11-fcdae50cf51a@baylibre.com>
 <agTe7vZ94DnmD4Ed@ashevche-desk.local>
 <CALSJ-wBbjwrhTEpfKm-JHox7-E1YRQ=kTj1JN+KyiucTTu7c3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALSJ-wBbjwrhTEpfKm-JHox7-E1YRQ=kTj1JN+KyiucTTu7c3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 05:14:07AM -0700, Angelo Dureghello wrote:
> On Wed, May 13, 2026 at 11:28:30PM +0300, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 11:14:35AM +0200, Angelo Dureghello wrote:

...

> > > +struct mcf54415_dac {
> > > +	struct clk *clk;
> > > +	struct regmap *map;
> >
> > I believe that regmap pointer is used more often, can you check with
> > bloat-o-meter that swapping these two (by the order) gives any benefit in
> > object size?
> >
> 
> checking size in ColdFire arch with last kernel.org gcc had no benefit,
> anyway put regmap before

Thanks for checking.

> > > +};

...

> > > +		return dev_err_probe(dev, PTR_ERR(regs),
> > > +				     "failed to get io regs\n");
> >
> > One line.
> 
> i decided to stay inside 80 in all the file, is it ok ?

It's fine, but for trailing string literals like this the limit was lifted more
than ten years ago. I leave it to the maintainer.

...

> > > +		return dev_err_probe(dev, PTR_ERR(info->clk),
> > > +				     "failed getting clock\n");
> >
> > Also can be a single line, but this one a bit longer than above, gives
> > 88 characters.
> 
> same as above

Ditto.

-- 
With Best Regards,
Andy Shevchenko


