Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0D3DD53C;
	Wed,  6 May 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059348; cv=none; b=iJNgCjjIw/JGTEbdUaz9YmuljqWdcVTNBmm2RbH2cqMoctSkjnwmBULSsg03xmBHnXIRI4L57WlnxjWmYaNHP6geB/31DF+7pMK/RzIAfuTBUtFYNTwzdJUIgJxrcuIpzDSwj4oOYrLOOf3VyiFBLgVsLmVBHe2NrWApNjzf8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059348; c=relaxed/simple;
	bh=mDUy7aeegBtIiQ+XfOZRuf7QkALgRF3Z2rzURvFwqb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFNbcyB1zPQ2rpE5yCUiJJhK0Dt3qrzOlP2VFBCORaUyrt667bXoLPcMcPwPLg0J2uOmZpZ0G/1eEm2EYv1zMEMdtIwjBaj6lqMxqz8EN8QNj/YgmspZntTiZdkYxr4frr1searutzpOKuWRBC4kG77kAtPh5RY3fqBxkWvZvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrNGBT0h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrNGBT0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778059347; x=1809595347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDUy7aeegBtIiQ+XfOZRuf7QkALgRF3Z2rzURvFwqb8=;
  b=SrNGBT0h2ZOzsWP9wpsZ7o3xojgOBS8941NsFnQJrnzjmCkl4X829rA/
   beiMB/mbcNmZQFgoJw9x+5Rf5rMql2ug5U/J100Pve7oqOZ2j00r/rfjc
   AkORRJW+iCv02jKFa6nbKtY/6l4cWdAwK90yavoxJBjEajdgRJ0XXF1tY
   EEKNanL+A8DCBbLKQEEGYN+ejla/+4P+9W3MR8tlpfnsriPKZjKCbBwr2
   jIHhd23/DEGzV4esPCb+MPIXXza70qsHUKX4CtgZlYLUDaxMxNeLHts1E
   pYa4AzNYn9aRRCdemEx/MDuuCMIJSl9ZMLymTqz26R84PyPIyU+0ylTcI
   Q==;
X-CSE-ConnectionGUID: 58r/J2tYSCiHYFhqFoB3uQ==
X-CSE-MsgGUID: FZeT+n5VSr+v8AI011kVjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79092626"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79092626"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:22:27 -0700
X-CSE-ConnectionGUID: oIbI8ZJXTruLkHUClhruBw==
X-CSE-MsgGUID: 1KhlqVwbQAikxXZZhJif0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259517978"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:22:24 -0700
Date: Wed, 6 May 2026 12:22:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <afsITtK0oEUMcqPi@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-6-sanjayembedded@gmail.com>
 <CALoEA-xhRv7UN-yp_PLAbmvz8rOksCroT2Uhx=WTk=WpRujx0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xhRv7UN-yp_PLAbmvz8rOksCroT2Uhx=WTk=WpRujx0w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 08:45:32PM +0200, Joshua Crofts wrote:
> On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> >  static int mma8452_probe(struct i2c_client *client)
> >  {
> > +       struct device *dev = &client->dev;
> 
> Stray change, I assume this belongs to patch 7 ("use local struct device") of
> your series.

Not really. It switches to dev_err_probe() that uses it.

-- 
With Best Regards,
Andy Shevchenko


