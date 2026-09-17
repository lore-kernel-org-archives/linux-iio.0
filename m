Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4874FB9BA;
	Thu, 17 Sep 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648202; cv=none; b=h18aIY8wiGlH3D7aid0xzDo9kwadMsOuTp94MwHCtWbuZmFrMSMD7o6Kr6qVZvIKMlnFl+SuVJ5bAqDcssN9738HrUqfEtXKEIXwKq7Ve5aj/BT6Izxhwf7TGoOe1NVaBuIxxzqdGvfUQ0d7GJj8WdjwsLtP+Ty+vQJHEuBXkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648202; c=relaxed/simple;
	bh=Oqvk+Keh5+Ql737zReVMLDiTiT8AwvzkKVkDAtra2Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDoy+J1kyJPMsywazo0SwQhzqF3SQzxNBUegs/OYQ6Rfpp4JLGeamYXVtac+3EN0l3Xa3oI7Adhb0fg5WVvFGjGtMkzAJ+vs5Aq0n70c0ewJ63HI5OlxpLh5VwkbLyKyQbWa5otcYngKKCMRpJ5Z6otTGd5TcTBs8SVu2bWeRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdeXy1uP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdeXy1uP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789648191; x=1821184191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Oqvk+Keh5+Ql737zReVMLDiTiT8AwvzkKVkDAtra2Vo=;
  b=mdeXy1uPTLLql2WruTFP5qaijPe1mgKngaqU9VG/0GC9wavHJnowy/aE
   eEw9EaOXiVcH0gOaPm9F8q79mBUSlIuBDKLydGTaqQp4ujak0TQ03H4YQ
   XeICFVij7mSWtN3/Hx0T4B9vCy8dvoaLThFVs9r1UgKN8nNJnd2qyJQ7m
   Ae2lqyMCKWkAJzsBpIwoOVFW56YmXXBcJPh65PiCqzzPCRniynbyyx2Lr
   mdcdJmbD+BjCqsetzQZ/tzewHhaX+pnx8Nwylx4QcwUiQ1n9W4TIXp4ml
   lrtHsmCXvNc7yMQdq8Is5b/y8i5CtfPlTeXr9pEVaT9Jufj2s2Bd3azE5
   Q==;
X-CSE-ConnectionGUID: ee5Mc+jCREO9vRd2LwIrWQ==
X-CSE-MsgGUID: oFUwVhWnS3WlZSyWebSDhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92573762"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92573762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:29:41 -0700
X-CSE-ConnectionGUID: q7wUCXPPQLuH38dTRGvSJw==
X-CSE-MsgGUID: 7wRmEb1xSZiTIN0GvTGGMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270071211"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:29:36 -0700
Date: Thu, 17 Sep 2026 15:29:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
Message-ID: <aqvdLr-VEUMAHese@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
 <aqlb5iZQ07Xicq0m@ashevche-desk.local>
 <aqvF1aOtAiDrC_MW@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqvF1aOtAiDrC_MW@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 11:54:00AM +0100, Nuno Sá wrote:
> On Tue, Sep 15, 2026 at 05:53:26PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> > > On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > > > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:

...

> > > > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > > > >
> > > > > I think it is good to split dmengine consumer and provider header files to
> > > > > hidden dmaengine's detail.
> > > >
> > > > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > > > I suggest to do one step at a time. Would it work for you?
> > > 
> > > Yes, but I hope the file name is finial expected file name. it is okay
> > > just move enum dma_slave_buswidth to there now.
> > 
> > Hmm... The whole split as is in this series is due to bitmap.h and the whole
> > train wreck with headers we have. I haven't checked that particular enum, but
> > if it's possible to gather it in one of provider.h/consumer.h at the end, then
> > yes, we may name file accordingly from day 1.
> 
> Yeah, as I said to Frank that enum is used by both providers and
> consumers so leaving it in types.h makes sense to me. I also realized
> that the current series is relying on widthmask.h (or dmaengine.h to include
> types.h - for the enum). Might be acceptable (and needed for legacy code
> just including dmaengine.h) but I wonder if we should not explicitly include
> types.h for new (or converted) code.

I would take IIO example, id est guarantee engine/types.h to be included by
the headers that need it (by the end users). but it's still fine to include
explicitly in the DMA engine core.

> > > > > suggest name
> > > > > 	dma/engine.h
> > > > >
> > > > > so we can start move more API to this files.
> > > > >
> > > > > after all user include this consumer header file,  old
> > > > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > > > which only include by dmaengine drivers.
> > > >
> > > > Traditional naming would be
> > > > dma/engine/provider.h
> > > > dma/engine/consumer.h

-- 
With Best Regards,
Andy Shevchenko


