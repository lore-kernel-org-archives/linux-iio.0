Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7440B366;
	Tue, 30 Jun 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820929; cv=none; b=tf2bhQMmPX2WCGY+rBHnvC04ZrKNfijIrmyGOBgKw7BGqxiG5bEt2x7Rznr2v5IOzl9UBiMhlXXgPxWJ6afOL3hTJ52cqtfzlPUe7ufaGRmnEFYqM7NGw37AWHBd3lNEDtOQ8NZSyYbeUM4ttzbx+8odYh8jKhaejiOysJNw+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820929; c=relaxed/simple;
	bh=zgrKdwrhX1yX3QV1couoB94Rb4WfXaOIuAcpGj2qLoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8x79NXinGWozBTBTRImSxRDnXEo2xNNZnmtVnnF906uFokcMA004W91oqhZkMr0x2lcF/8SnrIGuOm1CSyRfKSJ7tU25iNMxW0OOgE35AewUqip2MnqqGMnFFIoCfQV40MouvUDkw2BWTwDjXow+jTUirduEslZiSTI+QsTmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdXlA6E8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdXlA6E8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782820928; x=1814356928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgrKdwrhX1yX3QV1couoB94Rb4WfXaOIuAcpGj2qLoY=;
  b=YdXlA6E8RAApe5os/gFLKCW9ieKMD4DKjFLqyNnLTptsF9k5dll4QDzS
   S+Sm/LGYH2WY1XAu5nwnZRx7iBJTt6hAtW3dJDWMSYQub6X0liieQjdsv
   DfkYz0JiTix+AQtuxyWgpEP8PaVMN8AfG2105xGdde6F8CbGk7EwPomcH
   LfwROwpl6SEqHPf7Xr2rTbUgXfpDg77ZlAPlIhKZij8sN0e66VZnOXo6p
   nHBBU55N7DHR8Y6AFvtIB6RY4433aMysS6xMr3/lv9CzWxuedyKEy6loT
   7zz9YKhSdAyoKIwqwj0DqoNHnoW2fu2WBiN8D+oofB4MjTDnojMhpM3l9
   Q==;
X-CSE-ConnectionGUID: vu4gnTKlTf+gDZyHFl9NHw==
X-CSE-MsgGUID: Jco6KGEjTfy/XdpvTTOliw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82519951"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82519951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:02:07 -0700
X-CSE-ConnectionGUID: ArZCIJOwTI2nBxZLzV54dw==
X-CSE-MsgGUID: PvxFOoC/Rc69d0W/pt1BCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="275478852"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:02:04 -0700
Date: Tue, 30 Jun 2026 15:02:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832/ad9834: use div64_ul
 instead of do_div
Message-ID: <akOwOpTIBFmSvquX@ashevche-desk.local>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
 <20260630093931.00006eca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630093931.00006eca@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 09:39:31AM +0200, Joshua Crofts wrote:
> On Tue, 30 Jun 2026 08:53:22 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

...

> >  {
> >  	unsigned long long freqreg = (u64)fout *
> >  				     (u64)((u64)1L << AD9832_FREQ_BITS);
> > -	do_div(freqreg, mclk);
> > -	return freqreg;
> > +	return div64_ul(freqreg, mclk);
> >  }
> 
> I've actually sent a patch for this previously, however the
> discussion ended with the fact that there really isn't a point in
> doing this, since mclk will always be a value that can fit
> into a 32-bit unsigned type, therefore truncation isn't possible.

Since we are getting more "fixes" in the area, perhaps it's a time to add
a comment in the code summarizing the mentioned discussion?

> See here:
> https://lore.kernel.org/all/20260409182755.499a419c@pumpkin/

-- 
With Best Regards,
Andy Shevchenko


