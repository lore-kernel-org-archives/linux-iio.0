Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56D48551F;
	Fri, 18 Sep 2026 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712707; cv=none; b=VfLpGu8UfFFPIXN4E0UemQAleAh6p+yAjuSzwohLF5V6GvBuwFKMywHVx7OSrWRo/mod/OPaOPVy9cAze+oyDzBOg7jvPkrxaykgLfoj0guLKCw8hFR5Z3HNPeX+TslFXiD06UAASLrhNGiXcGwZJAfMXVsriH1dYu3ExUK+rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712707; c=relaxed/simple;
	bh=kMWoUije5yTrC+y3H2eCV42peF2ZwHmEpdZ1AzMBN08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQDeeBD9EUEkXsBHmnEJEnBpUisxDPzQ/H9kzx7eSX5mjiJvOVUD88YNP+Fjc3dHeQg9W6JMokVtQ81+4UJUjUr6PAlNNGmrvSmj9BqpKS1hMuef8CjMb/GxRsz/6dx9u6HVlzcjPhQ1cEaQ9QydMVDH6UWWi/zSuSoLViW300E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/G8cbH8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/G8cbH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789712705; x=1821248705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMWoUije5yTrC+y3H2eCV42peF2ZwHmEpdZ1AzMBN08=;
  b=Q/G8cbH8IYMGqS6X4PrOGD9B4Uj4DLhriKBGgwAFnZJHC0k66Rfjj8/r
   JCs0ZdNyhLnvLU/i5/WeNEjFli9LTSnLHCIUqaLc7GQKK/JhQM48I6fZ/
   GJwFnb8rVLpeBWGGMOtYxcPdNqv0T/AjCk7TEe+UpZBmGYaDDPyhRhQye
   Z77ILAeM4WSIGcTesrRZNfgfO3ZVZAXwtzr6AxYqTePpT8dZqlVXHUaDX
   PDzHcFn9NYjh10gFOxcy+Tv9yZ3zevGHxOMLDAbqKfBNw8wVRbeGlJpvv
   iaBrLo2W5wodrZBpMDtEBQdwYu2FFCC8SsxP7r4Nh9g8FD0up5UnE6AoT
   Q==;
X-CSE-ConnectionGUID: ZeIFikmlSJC5X9dMXTk/WA==
X-CSE-MsgGUID: 7HxR9GM6SNaee240pnEuOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77761328"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77761328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:25:04 -0700
X-CSE-ConnectionGUID: nik7p8FETbK9DCqO6zw0zw==
X-CSE-MsgGUID: VmqEWhMvSN6swG9gHq3yag==
X-ExtLoop1: 1
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:24:59 -0700
Date: Fri, 18 Sep 2026 09:24:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
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
Message-ID: <aqzZOZ2ovBc6affP@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqws8pN2rfS9-dCC@parshuram>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> On 15-09-26, 12:04, Frank Li wrote:
> > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > On 15-09-26, 21:22, Vinod Koul wrote:

...

> > > > > Traditional naming would be
> > > > > dma/engine/provider.h

(Actually majority of the subsystems use driver.h.)

> > > > > dma/engine/consumer.h
> > > >
> > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > everywhere please. dma causes confusion already!
> > >
> > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > 
> > There some dmaengine code outside drivers/dma directory, like
> > drivers/crypto/ccp/ccp-dmaengine.c
> 
> They chose to be outside, their choice... They need to be updated as
> well to point to ../../dma/dmaengine.h :-)

Hmm... It's rare to make such a requirement in the kernel for the resources
like this. All I know about (GPIO, regulator, pwrseq, IIO), they split and
provide the interfaces to the whole kernel.

-- 
With Best Regards,
Andy Shevchenko


