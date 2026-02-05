Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B652727FA;
	Thu,  5 Feb 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311576; cv=none; b=gGbFxj8D/dw02w9XapPEGhKoffF8DFLKvYnnQ7wYyQjdaynX6HaMHvmdug57alcMupKajWS3WSpsoqhg+V7lMOdIJXHLpO27hJ1TvCEllOrccnK/LYi/StHlNZxyqhR4ZJvDsCIpL2x+cSCgieLYO8RZxn6jiaR80OQGqRr5ms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311576; c=relaxed/simple;
	bh=0idIWL/GIM+wlWEcQx/MjLXxcl9N3MK8YyVi1jvuQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv52poyuvKJK3n6dkiX3uiFCl2ZuUtu9mfOcMdgER5mG6oYdyCUaJcnnX47ppQxAENLIk+XHmyK4PtRRZT2JxdW0gh2kBy+Rrk4QXiUruQuYqg2GbBllw3/+2WTSqqFB+/oFje7k+xuKmgoXLmmdZ/lYE1mdJx2EtOTx5hrYWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncMe3GKf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncMe3GKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770311576; x=1801847576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0idIWL/GIM+wlWEcQx/MjLXxcl9N3MK8YyVi1jvuQsM=;
  b=ncMe3GKfgWqBm93GCiX5Zdaj2W2W1OmxAnDZjCPn1LT/CpAMW83GQKym
   Adz51A/StqSKEphQYVc8YSuoOzC1Naz7dZDJQr0qb0JbaeDYZsteDZn/o
   RvOicBS9pDx5drM/ZJ/FBf38HUEamqP+WBH+0IYLYuSrWi9hKqA1BdDuF
   NFYP3X7o7gaOcaXiOD9YIujPZ8KE+TWQj+loQwg/LMx3AWIjTjuvSUPJx
   38q3RAH1xAm06oGre9SHV+noWv77FZg0yMMrEFLqB8//v6VZcBOIQWA1F
   Tl05Vz3CaD/H9cUKlxVFW/zCLEMdkXBpPvM/xfmDGCAcTuWxO0WJrpMdJ
   A==;
X-CSE-ConnectionGUID: 16V0E8+xSP+yAuD0BbZjRg==
X-CSE-MsgGUID: C2iwBdSlTTG5XoFuNDvvzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82953804"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82953804"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:12:56 -0800
X-CSE-ConnectionGUID: LOTjmKVVSb2g0pfaafk4Hg==
X-CSE-MsgGUID: A7dHXsBIR8eR2c4c5LN7+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215092932"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:12:52 -0800
Date: Thu, 5 Feb 2026 19:12:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	David Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration
 with devm helper
Message-ID: <aYTPkt5jKoX3X_4i@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
 <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
 <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
 <CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
 <437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 10:30:31PM +0530, Harshit Mogalapalli wrote:
> On 05/02/26 22:26, Andy Shevchenko wrote:
> > On Thu, Feb 5, 2026 at 6:51 PM Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> > > On 05/02/26 21:59, Andy Shevchenko wrote:
> > > > On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wrote:

...

> > > > > -    struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > > > 
> > > > Do you still need spi_set_drvdata() or analogue in the ->probe()?
> > > > 
> > > 
> > > That's a great catch, I don't see spi_get_drvdata() anymore after this
> > > series, so yes I think we should get rid of this.
> > > 
> > > Should I fold that into this patch in v6, as spi_get_drvdata() is also
> > > removed in this patch ?
> > 
> > Ideally it should be done in this patch, but let's wait for Jonathan.
> > He usually may tweak these small things when applying.
> > 
> 
> Also, while checking the patch now, I see I copied a wrong tag(RB with
> missing r in baylibre from [1])
> 
> So that's one more thing to fix. Let me know if v6 would be a preferred
> approach, I can do it.

Let's not hurry, wait for Jonathan to decide.

> [1] https://lore.kernel.org/all/a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com/

-- 
With Best Regards,
Andy Shevchenko


