Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809C37D12E;
	Tue, 15 Sep 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484016; cv=none; b=TyW48riov+3rDgrX2m+YrF5NcgbH0yiyAOt2wG4/vQLhEeQDcOPKIc+E8whdhH66/179y875sxwWy2bHkmDiMbRuKffLXv5SBClJn5n+Bu2PaNlQ03yJaDgnTT15Z/UIviWT05eQni0LTtUbDEDmDMCDG4uuYbw/v65EF2Twm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484016; c=relaxed/simple;
	bh=PeCPQwsh+qKGrcT3bTdkFKnhdBA1fVZf3KBFD/Bg9AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH6D+Rf4VPPwVjnW+9cjeYaxzemGKNRTlQ/FMfiUc5cGSf2m5atZcuCEDTTntM1hyzSFIvSm61WafJWu57M40+MsDCd/UJNhCKZZMrB1g2rVD6WFgifcVyN2p2ge++ELArPMJh/G7GM/KC5nDyy60hEBhbKh1LrKnibNVXFrAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc9Dk6Yy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc9Dk6Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789484015; x=1821020015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PeCPQwsh+qKGrcT3bTdkFKnhdBA1fVZf3KBFD/Bg9AY=;
  b=Tc9Dk6YyScGEtemGXaTh9nko1vd+MmLxHp0f+fRLtzZjZwSoUoanPi4a
   ISgxOZcTDwk8zAtiWRjSgQGt56ttaIahGcbcgdqg2dOn7amwn6V0Ulrrx
   KRodF9Z6j4qNpC75xH7FFGn9bBp4rYRX4cXsNxVbYUT2dBd1zNoxfJGC0
   +5hnAPGqQEXQ2O4dhGMwqV69QGwnEdGawo9bgJ6A/h10ChAY+CzdbEva2
   Vh24SbsY+tmUgcou1/fANVZSR/AAb2m6S27yWduTztipHkO8t7udx4S60
   gfNu6bJSTqYLK8JoAHh/YPv2CKYs4gNleDXoZM31TJoa2dXKcVKxDF8pj
   A==;
X-CSE-ConnectionGUID: xjQH2LblSqWHRjGFDAU1/w==
X-CSE-MsgGUID: tkMc6KQWSiW+FeMThGZ7DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112619422"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112619422"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 07:53:34 -0700
X-CSE-ConnectionGUID: pD+gpyMUTpWXizQXOXxYtA==
X-CSE-MsgGUID: MNUHoTn5StWYHXkAWDsF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277156120"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 07:53:29 -0700
Date: Tue, 15 Sep 2026 17:53:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqlb5iZQ07Xicq0m@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlYOHIFU_dB72I3@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > In preparation for the bitmap based bus width capabilities, move
> > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > include/linux/dma/engine/types.h.
> > > >
> > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > new interface would make every one of its users pay for it. Keeping the
> > > > basic types in a separate header lets the new interface live next to it
> > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > users are unaffected.
> > > >
> > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > already opened with /**, so kernel-doc expected every member to be
> > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > in particular, as its meaning depends on where the value is used.

...

> > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > >
> > > I think it is good to split dmengine consumer and provider header files to
> > > hidden dmaengine's detail.
> >
> > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > I suggest to do one step at a time. Would it work for you?
> 
> Yes, but I hope the file name is finial expected file name. it is okay
> just move enum dma_slave_buswidth to there now.

Hmm... The whole split as is in this series is due to bitmap.h and the whole
train wreck with headers we have. I haven't checked that particular enum, but
if it's possible to gather it in one of provider.h/consumer.h at the end, then
yes, we may name file accordingly from day 1.

> > > suggest name
> > > 	dma/engine.h
> > >
> > > so we can start move more API to this files.
> > >
> > > after all user include this consumer header file,  old
> > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > which only include by dmaengine drivers.
> >
> > Traditional naming would be
> > dma/engine/provider.h
> > dma/engine/consumer.h

-- 
With Best Regards,
Andy Shevchenko


