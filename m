Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1E221F26;
	Tue, 19 May 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193814; cv=none; b=O+e5h0sgAe5Ak2bPK8a3n8TwhiPxUCDm/lkidnC2Qbf6vlmibY2Zda/GpP0unD9iiZsF0cX1eAdeZXiUmDAKJE1W5gZoUTwp8/bubuh87PGKeIJlxJgD/qg3rhGfkyzDr8Q2K48MmiyEEdZhpkvW1+rfn5Y4NDeNa54iHx8I5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193814; c=relaxed/simple;
	bh=wed1uInsNPuOCmWK6K2xVCOG9Mf8L2lAW4/zULYZeXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEf+JH2MNLtl4Lw+iC6VgsU4YmObg/JnUTN0polTdtOJmowE5WkQ+QZg/nI5fTCqZRmlpE8lENh8Yyt0FVV/vqzP8LIBz5+pyvMoaWAWrMfyOSuZlQ+DsBBlbWEGso1uDEdxkLuPljAkMaq3JBewrD62VOzM6K9HnJA11juNIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzNbTxru; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzNbTxru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779193813; x=1810729813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wed1uInsNPuOCmWK6K2xVCOG9Mf8L2lAW4/zULYZeXc=;
  b=mzNbTxruBSDL1EdGbyk/7XARIhFCRe4huoRsgi8DnpgyW1rBnHcGnWwB
   vUDa3GqD2N58woDAC1OP/h6EQD2iiQ+ftbJaOcPIF1Uw0ssAkj7wK4LRa
   KqgsQ5xRAo9PSTCRQ4MwG/mn0H20ie9bvo4s7FGdtmYPXBjNcXafRFoPQ
   uM4CCQ+Is2+uoqMPJS2zvpWB+DOLVgirUMB9BpxumfMjWK/GCCu+HGaF/
   t9PAR3sHgaqRlYaICRjP1itm2cXrK4S10o54GC7+fsGhiEhc9mWFXgKNp
   zYHCohnwr88n83Xu8BFrPerJ3aX7K4H1Jq7rOd7Gv1xGqCW7k+Sjeg43i
   g==;
X-CSE-ConnectionGUID: idCIULNeRwqMiFmpGQvrdA==
X-CSE-MsgGUID: IjGDafDaT8iIUVcUzPHzrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80032830"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80032830"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:30:10 -0700
X-CSE-ConnectionGUID: tC35eIlVToW+FmKx2KVueQ==
X-CSE-MsgGUID: B/otJDZGQwiecB1bgo/Seg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="236747273"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:30:07 -0700
Date: Tue, 19 May 2026 15:30:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Message-ID: <agxXzSvwvqyU9Jji@ashevche-desk.local>
References: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
 <202605190130.oWitiRzG-lkp@intel.com>
 <agtXwmSPs8iARJ_e@ashevche-desk.local>
 <20260519085902.28b1730a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519085902.28b1730a@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 19, 2026 at 08:59:02AM +0100, David Laight wrote:
> On Mon, 18 May 2026 21:17:38 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, May 19, 2026 at 01:32:51AM +0800, kernel test robot wrote:
> > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on jic23-iio/togreg]
> > > [also build test WARNING on linus/master v7.1-rc4 next-20260518]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-Convert-IIO_CHAN_SOFT_TIMESTAMP-to-be-compound-literal/20260518-151541
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > > patch link:    https://lore.kernel.org/r/20260518071349.469748-1-andriy.shevchenko%40linux.intel.com
> > > patch subject: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal
> > > config: sparc64-randconfig-r132-20260518 (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/config)
> > > compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
> > > sparse: v0.6.5-rc1
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202605190130.oWitiRzG-lkp@intel.com/
> > > 
> > > sparse warnings: (new ones prefixed by >>)  
> > > >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast to non-scalar
> > > >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast from non-scalar  
> > 
> > Thanks, the sparks were expected exactly in this and one more driver.
> > I mentioned that in my reply to my own patch already.
> > 
> 
> Can you just remove then cast from:

Not a cast! :-)

> a44ef7c4609724e Ibrahim Tilki    2022-10-03 @807 \
>   	channels[chan_idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
> since it is no longer needed?

I won't have time, if you can wait a couple of weeks (my vacations started,
I am busy with something else). Otherwise, feel free to drop those from the
two drivers in the same patch, thanks!

-- 
With Best Regards,
Andy Shevchenko


