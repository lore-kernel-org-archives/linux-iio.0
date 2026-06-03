Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BC3FF893;
	Wed,  3 Jun 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478865; cv=none; b=qmNrVqxmZotXcsrOCHe/R7FGXjNvEp8I6Zg3ltS66J5SKoUZupEQKz5THGr9sZ0ohUlj8HnGKtoebloiGVLkRn1Wdjextg/EeoZqj02V9r7TpFDKOL1BsDbxbLCGmgfBu1PowCmzXqEJ3t04KKfhFv5yBmTu1SGEXYz4F2+zvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478865; c=relaxed/simple;
	bh=2VipMfCJ7KpQWAynpZgY8FTuJlgOjiyHrev+cBAVjUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGUDfHbqWQKsALIMqQbj9lryGQgaoXcaoG1Ww6U0ywx+5UM7MSBru/Nqfxtfeg/dX0RjPu+ZJ5W30gFQo4TrtQX/MnET+CkKHVop4f9SKmYlnCiva66BWGRB0CVeBXAYe9aH4f+YoeTS1I3xaRNSqJ2Lm+Ulrr7D+nL3JxewBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeRcsrXF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeRcsrXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780478863; x=1812014863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VipMfCJ7KpQWAynpZgY8FTuJlgOjiyHrev+cBAVjUU=;
  b=IeRcsrXFpMWNZLzR4uYyahWC+FpMsvoef6ehO74pgOi6KX8i7SfUtDyE
   Seudg+rnWbyLvbDTrs6pD8zIRWxfj2aPdZegRbvRqDQ6069Oh4Gs7q3x+
   7asGODZJEcY+KieyUXwCYZw3qcX7gNUO8+h4xoNwXKXGxmXjYbHx5Pc7x
   poeRCOu1C+bwk544v7gIsVinXBRQRTf/z83GX9WsgPxAYKIzG/zkit/Ga
   uGB6MPYeh44MLG3bw/RbTwq0n6+KNSo6aOh4+9xz+DPKRMw49FaIln9Mj
   MKmuWt7efxMLYENCZETsKH80GI6GdociLdAif6n4LFpyvUDrPzLA5I0NO
   Q==;
X-CSE-ConnectionGUID: upy2IydFR9Gr41AWLkxRQw==
X-CSE-MsgGUID: 63kIkPFxRN+MF4i0HN32tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91854101"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91854101"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:27:42 -0700
X-CSE-ConnectionGUID: Ejm1GyzPQ76Kj+mu1reI3Q==
X-CSE-MsgGUID: D9PzUNgDTlOoBEAhC4RGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241179884"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:27:39 -0700
Date: Wed, 3 Jun 2026 12:27:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <ah_zieRL73oXCoxF@ashevche-desk.local>
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
 <CALoEA-zvki0Gvzug6bueyf6p5011_rP94uEijrUKaJTGneo_cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zvki0Gvzug6bueyf6p5011_rP94uEijrUKaJTGneo_cA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 11:13:17AM +0200, Joshua Crofts wrote:
> On Wed, 3 Jun 2026 at 11:07, Taha Narimani <tahanarimani3443@gmail.com> wrote:

...

> > +       chip->busy_pin = devm_gpiod_get_optional(&spi_dev->dev, "busy",
> > +                                                GPIOD_IN);
> > +       if (IS_ERR(chip->busy_pin)) {
> > +               ret = PTR_ERR(chip->busy_pin);
> > +               dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> > +                       ret);
> 
> Looking at this, you could eventually move all of the dev_err() calls in the
> probe() function to use dev_err_probe(). (For another patch though).

No, it must be in this patch, otherwise it might regress quite badly (from
the user, who wants to see a bootlog nice and clean, perspective).

-- 
With Best Regards,
Andy Shevchenko


