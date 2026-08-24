Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FC399015;
	Mon, 24 Aug 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559873; cv=none; b=Wsd1IV9MMqMxKXD8ISJmh21Ce4kD7ydNwp3gKI3TWTvkaFAaOkoVAvzuDW5z0uU119ablLSawDL2kKWlHDRk+1FciMB7tRvbji8+xYk51H2sW6mJXWGxLPe4MIs/6aykN4wy0xLISJ6BRhu81mjbmZFKgTu6GtfbzGx9D+gTALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559873; c=relaxed/simple;
	bh=T+u0AfhP/qK+PpFXrb4r/N1R58f4fLirVkkMzk4BYJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igMFAZA6BzT8V87Me0XEtAtnE4Mzj4aSvut7ZZ21BZ/Tyyexdv6HlKtQWQco6HPDYkprmDIXauw1iMTWzdKSarrN29jnsZ783rIzapu1z/IUHSvihGC6q0e1fdg5YdANbb0kJ6QjWjYeogbVAro+1hQew2h3Budhw9q7OP91Vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br9XMUSV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br9XMUSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787559871; x=1819095871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+u0AfhP/qK+PpFXrb4r/N1R58f4fLirVkkMzk4BYJI=;
  b=Br9XMUSVeA/7sjGI141pw6JiWE0cZ6ZwptVmWg7ysstH/9nmjZLV0Rxb
   HExMeDboE0cNMVOEsZU5hLz4pf8RwqfI/CdKTzUUtT2tJiuUXTMdZRZgP
   S+Hi5q/pSdXmEYSm7AQvpSqXHSxQhQ+AwU4b0/KbvgkCoD9uF3vc183hy
   zs4b3xc+SenkVEOlyUYF1oHg3mG0D/gWUdRz98/vZSy58w432w9bmq2mH
   jQjgDLnerrm56pWyoZ9CWSsOhxO3JRvBLtR2GSPX2J22WxuCS4HLXABhl
   aFupb5AcTkqMsuuBBy6s6PCIHd5jmET49h9gTJWgdLyALWN1X8kK3wLNG
   g==;
X-CSE-ConnectionGUID: IkZqv1glRiCs/rL7jdwVUQ==
X-CSE-MsgGUID: tN6KjykfSdqMMUfxewiNfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88023987"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88023987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:24:30 -0700
X-CSE-ConnectionGUID: HxvpeLbQQUCOJ8+OmLKuVg==
X-CSE-MsgGUID: 7HXTuMsyQM25VroL5uIm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="305138782"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:24:29 -0700
Date: Mon, 24 Aug 2026 11:24:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tsz Shan Chan <tsz.chan.dev@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <aov_uhPCcno0YJTe@ashevche-desk.local>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
 <20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
 <20260822032550.31a0fa9e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822032550.31a0fa9e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 22, 2026 at 03:25:50AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Aug 2026 14:30:43 +1000
> Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:

> > The INT output of vcnl4010/4020 and vcnl4040/4200 is open drain active
> > low which can be shared with other devices.
> > Add IRQF_SHARED and switch the trigger type from IRQF_TRIGGER_FALLING to
> > IRQF_TRIGGER_LOW. Edge triggering can miss interrupts on a shared line.
> Fairly low risk change but I guess we'll see.
> 
> It used to be annoyingly common for interrupt controllers to support
> only edge based interrupts, but hopefully that silliness is a thing
> of the past.
> 
> So crossed fingers, I'll apply this and see if we get anyone shouting.
> I think we'll get away with it

In another thread somebody mentioned a type of the signal that HW generates.
Having OD output doesn't prevent HW to behave like it does edge interrupts,
id est generating a pulse instead of keeping the level until it gets acked.
With that being said, I would ask the datasheet citation to clarify the case.

-- 
With Best Regards,
Andy Shevchenko


