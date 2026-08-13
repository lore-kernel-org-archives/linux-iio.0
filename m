Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC8207DF7;
	Thu, 13 Aug 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602674; cv=none; b=FyAqowjrPvJiOmUKESrOUYMd6a9UJS5blKtXBJ0vK6eMecOHCSgGmAtpjhBlj09V0MCR0cjU0j5dY7AHWBd6aOwnD8HrIEkQZ3lmw8RewAVM5b1ne9wwthqt0KUNvwKfiP//w2wq0lC7TkXHWmrKhcxiiahCoPWUyUi39jN5hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602674; c=relaxed/simple;
	bh=p9kacc5Ptx5pEvai8aMCmw6c0SajE0V32SL8KsbT4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdpwOSo7ZQd1Zh/KzJCgFQiONKobWWDQJj0oVSwhR4SowvBpQdtUBOCz8XFxHN0YZhV8Zt+JQz26zYrlDy7BlTUoSLV402Zt43DtiBVhtn2JopcCRrphFBHF0kCOlG/h2iqPH784hOhR+nJJt+3kFBL+UiTFE1rXyZhA00XTxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mn2Jdsij; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mn2Jdsij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602673; x=1818138673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p9kacc5Ptx5pEvai8aMCmw6c0SajE0V32SL8KsbT4qY=;
  b=Mn2JdsijKJ3GIA4+SoDS61rsVOKxxcRR2OByPA6ahvW02uxlkf/RTqZQ
   n+RPapwiyT7i6c3A4WY+xBFsbkS/ie0rQ4jtR3qpOMuYclVm6KX6blmXo
   wSo6Qjp9Bpz40darAwLBvWoYWVFxY7wdvZ15j50GXXbgatUaxEWp4ZEgY
   BmiH2mNC8kXLcRef0gSk95ZMybHdhqRSIcwOqA9/ikspo7fqYrfA+nXJb
   u3drjLXju8KCrcU8QK1KBrLM1Xm5dkCdghR+u/bf2Ec98conBFwqL5niz
   PIrSUR5QyfU3oUY3u8RK2kvwyYCV01ipgi4XBnkgVuZxx0fR7q9MCEGBm
   A==;
X-CSE-ConnectionGUID: tYuaZ00KSmaObw3ZdvUJ4g==
X-CSE-MsgGUID: ThsvqyIjR5KpmCVSWx96og==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97833266"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97833266"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:31:07 -0700
X-CSE-ConnectionGUID: vcPHvU7ETjKTHAbjZ50DsQ==
X-CSE-MsgGUID: oA7YgyOxTJaIOpxEgLI0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268128230"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:31:03 -0700
Date: Thu, 13 Aug 2026 09:30:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <an1ko4Dj_fCZuGB6@ashevche-desk.local>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
 <anxBgJZH57acnOZr@ashevche-desk.local>
 <anxasgXZsSKzvxG9@nsa>
 <anxt4HO1V7HPg4Z1@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anxt4HO1V7HPg4Z1@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Arnd — what's your opinion about dmaengine.h case (see below for the details)?

On Wed, Aug 12, 2026 at 01:59:59PM +0100, Nuno Sá wrote:
> On Wed, Aug 12, 2026 at 01:18:41PM +0100, Nuno Sá wrote:
> > On Wed, Aug 12, 2026 at 12:48:48PM +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> > > > On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:

...

> > > > Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> > > > is because of __set/clear_bit().
> > > 
> > > Oh my gosh, true! bitmap.h implies all bit ops, so no need then a new header.
> > > Indeed the whole hell is due to dma_cap_zero(). So, while your patch won't
> > > change the current state, in lieu of the said previously I would like to have
> > > a split, but since dma_cap_zero() is used almost everywhere, perhaps make
> > > __dma_cap_zero() an exported function then? This, of course, can be done later
> > > but if we start from the more mess, it will be harder to untangle, so I still
> > > think the separate header is a way to go. And perhaps these capabilities also
> > > can be split to dmaengine-capmask.h (with a fallback inclusion in dmaengine.h)
> > > so in the future we can only include it when it's needed.
> > 
> > Yeps dmaengine-capmask.h would make sense to me but as I said, I really
> > don't have the bandwidth for that!
> > 
> > > Looking into the structure of the include/linux/dma* I even would think of
> > > something like include/linux/dma/engine/*.h with include/linux/dmaengine.h
> > > to collect (for backward compatibility), where the first citizen may be
> > > your API, followed by split capmask.h.
> > 
> > Ok. So what you have in mind is something like?
> > 
> > <include/linux/dma/engine/buswidth.h>
> > 	#include <linux/bitmap.h>

> > 	#include <linux/dmaengine.h>

Not really this one,

For a bare start to have something like

dmaengine.h:
  include dma/engine/capmask.h
  include dma/engine/types.h

so the latter (types.h) will have the basic minimum that is necessary
for capmask.h and (future) widthmask.h.

> I mean, one way I can see to avoid the above include is to come up with
> a new type like dma_cap_mask_t. Something dma_buswidth_mask_t...

Works for me as well, and we can put it in

  include dma/engine/widthmask.h

but this time without back include into linux/dmaengine.h.

> > And have all the inline helpers in there.
> > 
> > I can go with the above for v3, yes! But note one thing:
> > 
> > enum dma_slave_buswidth
> > DECLARE_DMA_BUS_WIDTHS()
> > 
> > will still be part of dmaengine.h and what I could do as follow up is to
> > move the above to something like
> > 
> > <include/linux/dma/engine/buswidth-types.h> or maybe just have a generic
> > <include/linux/dma/engine/types.h>

Yes, the second one.

> > Generic might make more sense given that we move around 7 typedefs in
> > dmaengine.h but I'm not so sure about the enums.

If enums are coupled with types, then they should be there, otherwise we also
have a concept of defs.h (but not as distributed as types.h).

> > Then, we can also do the split for capmask.h as you said. I can do the
> > dma part of things I can't just commit to change all users in the kernel
> > for the new headers :)

But it's not needed, everything except brand new APIs will be back included
into dmaengine.h. Old users will work, new users will be encouraged to use
exactly what they need.

> > (Ok, moving the buswidth types into a new header might make sense in
> > this series - if we agree with that direction).

-- 
With Best Regards,
Andy Shevchenko


