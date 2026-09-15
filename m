Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17F411F9F;
	Tue, 15 Sep 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457525; cv=none; b=d4egiaaVtnD8UuRMJF55n9UxUV3MTn8Rmh9qd5cH4Ypm9y1D9b0Yjkzo/qh1GOoN3q791nuyk5BbojlPgLYgKo14i43bXCLvAC/0b6rAuThw1ZJfXXOQ4Bgz2HyjQQluhCwBZSpx+a1Gv+pocenUMJ80DjLrbZNdEaLU8SdIoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457525; c=relaxed/simple;
	bh=hu4d0MW3Bf04FU74NUpVLNtB72nLl1SrcA3Swz/HQ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQf3Mj6xH1l912/81RbbNbU59JTRPxfQSMMm99qRSsOziXdMFKc+SnAqC4W/Ju6GqpQjZRcg0vaOZ+Y533VaMRQSnajJ3cD8toyPbqNlqIpW9kXnJ2nC14h0CmGLycUye3FmMWoPIqnXa3VgoXq+NVBMAmCX0UPSlCpxgh+oVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRuCT8m4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRuCT8m4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789457523; x=1820993523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hu4d0MW3Bf04FU74NUpVLNtB72nLl1SrcA3Swz/HQ8A=;
  b=CRuCT8m4i6SYNMz9Bg0gJ7F2jiNOKfxP04vAc9TjuPKENMPRHqF/0eo4
   bsD+IEZMaTNCgRPWeq7lnMb1s4IT0yLukTJPT7tveAdzMhG8fmDZzxQVU
   QzPOcWV+jrb6L1iq3NO5yuwLyFN7psww3tnICpfxtysHkz+DgwcFqJ8NX
   wwyXkbV0eY0Ds2wj6xVWyRwR2E0zIrx5Hah4IalnBquvzmc2GdJ78M+qm
   cA4NAnk4yYl3q7ygxL5K2ADD1qujDtbS3bGY1OWgud9FSxhyFeMGlqQuf
   aIloh7ksoOY3iVE+tHiJywgORzR+1kUlXQUHcECXzYWjgLIJ9ClxrFLMv
   w==;
X-CSE-ConnectionGUID: u61zRsqXTMOj7MBabWAKEQ==
X-CSE-MsgGUID: 4d5eij4uTt6PeLVwnI1HWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100967378"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100967378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:32:02 -0700
X-CSE-ConnectionGUID: gcNLgQiYRZKOETkK+/DZpA==
X-CSE-MsgGUID: rfWMtsATQle5Hq81vExF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269199181"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:31:57 -0700
Date: Tue, 15 Sep 2026 10:31:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
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
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 08/10] ALSA: pcm_dmaengine: Use dma_slave_caps bus
 width helpers
Message-ID: <aqj0a2ttFTXdgGx5@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
 <aqesWfdIsiR31sql@ashevche-desk.local>
 <aqgUo4-r0-TIKZLl@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqgUo4-r0-TIKZLl@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 14, 2026 at 04:39:38PM +0100, Nuno Sá wrote:
> On Mon, Sep 14, 2026 at 11:12:09AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 06:25:43PM +0100, Nuno Sá wrote:

...

> > > int snd_dmaengine_pcm_refine_runtime_hwparams(
> > >  	struct snd_pcm_hardware *hw,
> > >  	struct dma_chan *chan)
> > >  {
> > > +	enum dma_slave_buswidth default_widths[] = {
> > > +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> > > +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> > > +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> > > +	};
> > >  	struct dma_slave_caps dma_caps;
> > > -	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > -			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > -			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> > 
> > > +	dma_buswidth_mask_t bus_widths = {};
> > 
> > Do you really need the zeroing?
> 
> I think so. dma_bus_width_set_many() just does __set_bit() under the
> hood so if we do not zero initialize I think we could be left with some
> random bits in the mask. Unless I'm missing something.

Hmm... Since it's a recipient, I would expect it will be filled correctly
independently on the garbage it might have had initially. So, perhaps call a
bitmap_zero() with the maximum size in there?

> > >  	snd_pcm_format_t i;
> > >  	int ret = 0;
> > 
> > >  	if (!hw || !chan || !dma_data)
> > >  		return -EINVAL;
> > >  
> > > +	ret = dma_bus_width_set_many(bus_widths, default_widths,
> > > +				     ARRAY_SIZE(default_widths));
> > > +	if (ret)
> > > +		return ret;
> > 
> > I assume that if ret == 0, bus_widths should be set accordingly.

As mentioned here, if no error, bus_widths should be fine to use.)

-- 
With Best Regards,
Andy Shevchenko


