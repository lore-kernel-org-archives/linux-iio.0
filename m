Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F91EB5E3;
	Tue, 14 Apr 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186215; cv=none; b=IUVvNIQ8G8ShW48l/qulTtdADHaT/nelJlNBcmqXDJmWK5kyYXm4ifQRMQgCYRkx86dEQfnZVhmQAXaxYEo2v/tHCVuLkHni0AYVx76o3hVwOfZ/E9td0tAWmoJPGzHObxU9P1L5enYHj27x2Tdm6slxHgBps7n4PV8TX4npX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186215; c=relaxed/simple;
	bh=VVrpcdkZQkRWLJAoC2Fqi/ptL/mp1QBM/Qmmva793CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWJeeokHhTgKMNCYgS1lvxi/plLB+YwPnAFes9jUpV87zXLSbz+h4mvgzQK9R43Ka5gnL7z6lvtnQclvNZ31D3OxLe9+St+GhgW3vqOvcsvf/aocVWygMK5R6j1iSMsI/72FXUopN3ocgCChJfantf09XVLfO3D4qNLRluhV1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2/4kMkP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2/4kMkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186214; x=1807722214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VVrpcdkZQkRWLJAoC2Fqi/ptL/mp1QBM/Qmmva793CA=;
  b=A2/4kMkPrJhVoYAVSWGyTesylGE0XrgL3Mh4KwD9UTB9hEmjm+ccNuqw
   zf229Oy1yvPuOC9Pla5/P1suCNqtMy7eEQ88c9tgLlxh/8+axqLz3bF63
   U40OYCAYervvMoeyoDqCbqBc7pXfBOQ2e/tlrebe5tJQTr5taihI5h73g
   fETyKiuxDZe0FL9ZgrsavEUfFx1L1qDvRfa9shOnsK66LSLszex0mGLtk
   isEWT1QQ+3blpSK1/8ePk6l4w0J1iNxTRSC/0O7O0f/reqUC7lwxg3mGC
   GCdIzfS4AXIhq4ZwY9wXfsjAY4ikxwhil9ZFuatPkrNSYn5diLoEjL/AT
   Q==;
X-CSE-ConnectionGUID: kt2v8CeeSx2JcutDay0z3w==
X-CSE-MsgGUID: DOR5quBQTES7ym5veSaVOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88532222"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88532222"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:03:30 -0700
X-CSE-ConnectionGUID: giJxleKUS3ih+I48wVgs0w==
X-CSE-MsgGUID: enwJUzcUSKm0ZIFpfE+k0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235107593"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:03:27 -0700
Date: Tue, 14 Apr 2026 20:03:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad5zXNdMTxbt1GHS@ashevche-desk.local>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com>
 <ad4K-K3MpwD3U4F-@ashevche-desk.local>
 <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com>
 <ad4oX0Py3T8j9Y7h@ashevche-desk.local>
 <CALoEA-zbi1VOv86FrU2Skkuota0UGcMyHVJwffyEY7+ZsMSNcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zbi1VOv86FrU2Skkuota0UGcMyHVJwffyEY7+ZsMSNcw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 03:27:39PM +0200, Joshua Crofts wrote:
> On Tue, 14 Apr 2026 at 13:43, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Please, avoid following the suggestions blindly. This work needs a careful
> > check of what's exactly is being used and which header should provide the
> > necessary information. While it may compile it might be still wrong. You
> > need to (briefly) read the code in full. I don't use iwyu tool with tweaks
> > by Jonathan Cameron, old school guy, but you can also try it [1].
> 
> Don't worry, I wasn't blindly following your suggestions. After some tweaking,
> IWYU recommends keeping device.h and removing slab.h. My question is
> whether the swap from asm/div64.h to linux/math64.h is valid? The asm
> implementation would be platform specific, so swapping to math64 seems
> like a good idea.

Up to you, but that would need to be a separate patch, because it does
the opposite to what your patch is doing. And justification is most likely
that it's preferred to use linux/ generic over asm/ in the drivers. Or
something in those lines...

-- 
With Best Regards,
Andy Shevchenko


