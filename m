Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E244238A;
	Tue, 15 Sep 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457354; cv=none; b=SO7uzzf7pVnIn17vO0YQ6SYgeBKeltVfV/sZPdJL8fG5mSvGG84qcAQo1DehWxAd4NFeh4MZNr9rxl4tkzUAGKJOAxbxagum18yxDc3BojEfvOuv6PEuVhgB3Pb/9oKxT3G/fNfxL861z07zGFtsMViOeYAi2C8rQmfdIDyC090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457354; c=relaxed/simple;
	bh=lblm+duqrIKOSpchtCRVtTa6szJIWB3TTaSd5w1skBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHdyBW8RlozvSC6YHQqThh/Bvcj2zrLIHPEvqbnZK+m9AS5A7EoFkYb8MjYE6dptUDwpsQWMiHD3f9Tiu/lu8LpiOkyA+pCJn/GruzDxWZ2cDiYyLJNrV2o7k75AFkGkhz2HpKJgV8VHzZwEebwVKdsCSfSXhFF44EJZ+XfAHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9b3RUUS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9b3RUUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789457353; x=1820993353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lblm+duqrIKOSpchtCRVtTa6szJIWB3TTaSd5w1skBE=;
  b=g9b3RUUStmHmGD0ATybemfTeI9EXELlGGeo4Xm/FMsHZGX5fn/EjC57H
   LXoEc6TGH5LpS8P1YWMUzWLF0CfQwss/w5WrMp2DwOX5LLq6+YMHlDRSP
   vHtZLOA+Aq4bCeyjfhjlixLlGWzYmOsg647PWYDJ7xJK6KfKLmG5jKLMZ
   m/FO2YMgmKG/eTQCMF+if0ZXPxBwYAangi2kLndfe4RwDn408Mr0Xm5fD
   u/faiVWXCqkNUtFn3bHpBiHcmqjDtVKvfH//B1S+y5a79yR6SLCRvFTXQ
   zBbdSpPgfV8ot/H0TVEIXCTh3IoBayPKKpeVTBOo+Ez4bQs+uFsMn7fFb
   A==;
X-CSE-ConnectionGUID: ipyUg877QC6PkwMBijGxSA==
X-CSE-MsgGUID: Dah45PrASTK2d0g5+j2F+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88949050"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88949050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:29:11 -0700
X-CSE-ConnectionGUID: PDk0ELz7ScSPdw85lzMxbA==
X-CSE-MsgGUID: 3YeBiet9Q3mnjwAAhfSuvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271061383"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:29:06 -0700
Date: Tue, 15 Sep 2026 10:29:03 +0300
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
Message-ID: <aqjzvxI4ecoFvRLT@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqgCQvRw9fns__0d@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > In preparation for the bitmap based bus width capabilities, move
> > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > include/linux/dma/engine/types.h.
> >
> > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > new interface would make every one of its users pay for it. Keeping the
> > basic types in a separate header lets the new interface live next to it
> > without that cost. linux/dmaengine.h includes the new header, so its
> > users are unaffected.
> >
> > While at it, add the missing kernel-doc for the enum members. The block
> > already opened with /**, so kernel-doc expected every member to be
> > described and warned about each one of them. Describe the UNDEFINED case
> > in particular, as its meaning depends on where the value is used.

...

> >  include/linux/dmaengine.h        | 20 +++-----------------
> 
> I think it is good to split dmengine consumer and provider header files to
> hidden dmaengine's detail.

It's indeed desirable change. but isn't it a bit out of scope of the series?
I suggest to do one step at a time. Would it work for you?

> suggest name
> 	dma/engine.h
> 
> so we can start move more API to this files.
> 
> after all user include this consumer header file,  old
> include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> which only include by dmaengine drivers.

Traditional naming would be
dma/engine/provider.h
dma/engine/consumer.h

-- 
With Best Regards,
Andy Shevchenko


