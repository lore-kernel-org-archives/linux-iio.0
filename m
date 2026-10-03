Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5B3655F3;
	Sat,  3 Oct 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039177; cv=none; b=WdYmdBSKt2fdu8n5S2Py44NRmq1ILLuZTRG+pzZ5nQ/7xWw3ljEVtFY7WawaXE35pzzHDgtca228ausuxajulvPJ9jEo7g+2A36yFwbFssqviAjXnEbTklPvxQ63jVUK8Osdg6ZGoP049CbrDpM4f+vrwAc0JK4VamER4eZDBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039177; c=relaxed/simple;
	bh=WjedVfcJVU/MQt7k/NT42LV+0N9QCiM5k6UX3eo1nlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+st+A5UYY7T6CSu8eyn7ITUnVPgnNsed7z335Ot/6fNixQUQCfmaTh/sEvNympD+PCHnmg+Os/b8+hWphzv/GaI5N7dDodLMLEogtKKW/R8jajNYqupH2EogVfOtl7MzmzH8JWpd+prRNUnW5V4SFFr/WyfhCL3ibca2zuoWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YScjAeTp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YScjAeTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791039176; x=1822575176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WjedVfcJVU/MQt7k/NT42LV+0N9QCiM5k6UX3eo1nlY=;
  b=YScjAeTpEx/y96r4DB9trvKuQnn+pdGOrIGk+Ndvbahhpzok2e4KDMY5
   N/SWleCaahKsAe2A+54FrWk2Ws22R7aSnuvD2hi6B7WpGh1D7LpySPr+a
   +TUmgI4BybthZQAPb8gLpuy6bIJgg5kGwIv7irFtU8OC+9g5sccSk83k7
   KKJa24rs+9S9Imd36IiyBm4rgFWBhjVOOoInqxSLGM37k4Pv9C+2Hvjb3
   PzFF6JVlognhnIp5NhqCALZZcXmgXp2nJVFy96aO8OXjsIieYJ0mVtGar
   QUkPFUMpXpKMbltdX2jA2S5g/DeoPokn/CZPp2XlbZ8XtwnyqWDq1T7z0
   Q==;
X-CSE-ConnectionGUID: 4cACApzpQhajr8pIWFyMrQ==
X-CSE-MsgGUID: jx9aQSYNS5q1zLlUlGCxoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="113558219"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="113558219"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:52:55 -0700
X-CSE-ConnectionGUID: Jbe3JksrQ+e5M1GxtJoa9Q==
X-CSE-MsgGUID: ixJJ03mXROu58hsuGioCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="276532289"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:52:50 -0700
Date: Sat, 3 Oct 2026 17:52:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
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
Message-ID: <asEWwIfO0LB27wj9@ashevche-desk.local>
References: <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
 <ar-Il2qP_Qms3Qw1@nsa>
 <ar-13p3a7ENGfMOF@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar-13p3a7ENGfMOF@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 08:47:10AM -0500, Frank Li wrote:
> On Fri, Oct 02, 2026 at 11:43:17AM +0100, Nuno Sá wrote:
> > On Mon, Sep 21, 2026 at 11:12:35AM -0500, Frank Li wrote:
> > > On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno Sá wrote:
> > > > On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > > > > On 18-09-26, 09:39, Nuno Sá wrote:
> > > > > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > > > > > On 15-09-26, 21:22, Vinod Koul wrote:

...

> > > > > > > > > > > Traditional naming would be
> > > > > > > > > > > dma/engine/provider.h
> > > > > > > > > > > dma/engine/consumer.h
> > > > > > > > > >
> > > > > > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > > > > > everywhere please. dma causes confusion already!
> > > > > > > > >
> > > > > > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > > > > >
> > > > > > > > There some dmaengine code outside drivers/dma directory, like
> > > > > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > > > > >
> > > > > > > They chose to be outside, their choice... They need to be updated as
> > > > > > > well to point to ../../dma/dmaengine.h :-)
> > > > > >
> > > > > > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > > > > > scope now. So what we have now in the series is:
> > > > > >
> > > > > >
> > > > > > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > > > > > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> > > > > >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> > > > > >   drop bitmap.h from dmaengine.h
> > > > > > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > > > > >
> > > > > > I kind like the separation (and the whole point was to avoid bitmap.h in
> > > > > > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > > > > > will ever use dma/widthmask.h without needing the consumer API. But
> > > > > > to sum things up, what do you suggest for vÛE?
> > > > > >
> > > > > > * include/linux/dmaengine.h as the consumer API and includes the new
> > > > > > the widthmask API
> > > > > > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > > > > > include/linux/dmaengine.h as the starting point?
> > > > > >
> > > > > > Let me know how do you want things for v5
> > > > >
> > > > > Yes lets talk about dma_slave_buswidth, it is client type. This is
> > > > > configured by users to set the width of peripheral.
> > > > > So this needs to be in the include/linux/dmaengine.h
> > > > >
> > > >
> > > > Agreed! But providers also need to set the allowed bus mask. And I'm
> > > > just not sure they need to include/consume all of the consumer API.
> > > > Also, it's common to allow the provider API to be widely used throughout
> > > > the kernel (but I agree that could be even harder to get done - if we
> > > > want to make some stuff really private - but I guess that could be done
> > > > in a second step or more incrementally). We do also have some subfolders
> > > > in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
> > > > include which I do not love tbh (on top of the crypto stuff).
> > > >
> > > > I really think something like the below would be more appropriate (if we
> > > > just want the provider/consumer API without further splitting like the
> > > > types.h and widthmak.h in this version):
> > > >
> > > > include/linux/dmaengine.h - provider API (as of today)
> > > > include/linux/dmaengine-consumer.h
> > > >
> > > > But anyways, if you or Frank do not object in the next few days, I'll
> > > > take the above approach suggested by Vinod:
> > > >
> > > > drivers/dma/dmaengine.h - provider
> > > > include/linux/dmaengine.h - consumer
> > >
> > > It think it is fine.
> >
> > So I was aboutto start on this again and I just realized
> > drivers/dma/dmaengine.h already exists today so nothing to do on this
> > series.
> 
> I just find it and start some cleanup/move work.
> 
> > I mean I could remove the consumer include on the dmaengine
> > drivers that I'm touching but not really on scope and super important
> > IMO. So, for the consumer side, should I just go to the first approach
> > where all the bus_width API goes into include/linux/dmaengine.h or
> > should I keep:
> >
> > include/linux/engine/types.h
> > include/linux/engine/widthmask.h
> >
> > And have a better separation on the consumer side? Or maybe changing
> > s/engine/consumer/ on the above paths?
> 
> I go through v3 thread, Andy just said split to new type.h, but not have
> provided reason.
> 
> I am planning move provide API and data structure to driver/dma/dmaengine.h
> 
> include/linux/dmaengine.h will keep consume only defination and API.
> 
> why still need types.h?

The idea was to rectify the messed up dependencies. Without split of types we
will need to have bitmap.h (IIRC the initial idea of the split was that) only
where it's indeed required. Besides bitmap.h there are might be more headers
that "include half of the world" which should be avoided in every header file.

-- 
With Best Regards,
Andy Shevchenko


