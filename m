Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4431E5B88;
	Mon, 14 Sep 2026 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373538; cv=none; b=osWmjWIFYb71SwzgtKBecNJAxJLIROyz2COvGxYHwL9Dcc2x4FsqqQh6zpe/Me2ZrDoGc96bwIHhp/09bZBWBd98ppCDb4rSiaoFZgD6RVw1o/craNId+5nTtN4awTGzCc4OkyRFwWr1LU2XlxswEN0e9LmDbjZDwjufVnhRCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373538; c=relaxed/simple;
	bh=1OQgv3CLoOAvRHFXo8obITZm5ME7dKxVV+fENPflSNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5wjr4FBrQWO3QIQJS8GgRynwtVj2xWQdtbRGImGetL4cZP6kaTjxtzzx6D0dv2CiCI97ybN5Z/LOBsqzrC1fnb928+N+dDwJ4dfKoatmYYXYnhvBbCl+2ywVGmePVBdP5smpHyDT6zDCIQoi0Vx83AArib405wqbm9qryYogGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHeiFAea; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHeiFAea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789373537; x=1820909537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1OQgv3CLoOAvRHFXo8obITZm5ME7dKxVV+fENPflSNs=;
  b=XHeiFAeaSByI4sh3XEnuRNpAKyoGkKknvT0NfSCT8k/E+r/ioWBAR9Sf
   6jW6c/+0/Mls/ThsLk5rlUOZOS0V0f7iheOSfZoc4RzbafmhIKwtGlDvC
   tmqZqv+p/0aJnUWqYQzRAefl8ciJvOE/mZTLHY1jpIn6QsuxPYm23Tzz5
   jR2JZqtSll7JyX22nzbTUOu2hadwWLuuwNF8h0kWilrEPl4brTYqh/FcX
   VUrfpV2YP5ruIw0CXSBo5iTFYfu3RM8c0W7sBARY0sKBcPXpIMRr7naiw
   WQnDsclAUExYtFrEzHXEgoNGlrPCtqh998iKQZwoRHtL4fUiQUKuwq9MC
   Q==;
X-CSE-ConnectionGUID: lnn62VZWTRSmHi+VtrqtDg==
X-CSE-MsgGUID: NMmViMFURRyVNgg3bEA2Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89930525"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89930525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:12:16 -0700
X-CSE-ConnectionGUID: Pk3tLVsuSq+B8gP2yd78ag==
X-CSE-MsgGUID: j+X708W/Q1mtQ7SjumjlBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="269292406"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:12:11 -0700
Date: Mon, 14 Sep 2026 11:12:09 +0300
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
Message-ID: <aqesWfdIsiR31sql@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:25:43PM +0100, Nuno Sá wrote:
> Use the dma_slave_caps bus width helpers instead of reading the legacy
> src_addr_widths and dst_addr_widths masks directly.
> 
> Keep the existing default assumption of 1, 2 and 4 byte widths when the
> DMA channel does not report slave capabilities.

...

> int snd_dmaengine_pcm_refine_runtime_hwparams(
>  	struct snd_pcm_hardware *hw,
>  	struct dma_chan *chan)
>  {
> +	enum dma_slave_buswidth default_widths[] = {
> +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> +	};
>  	struct dma_slave_caps dma_caps;
> -	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);

> +	dma_buswidth_mask_t bus_widths = {};

Do you really need the zeroing?

>  	snd_pcm_format_t i;
>  	int ret = 0;

>  	if (!hw || !chan || !dma_data)
>  		return -EINVAL;
>  
> +	ret = dma_bus_width_set_many(bus_widths, default_widths,
> +				     ARRAY_SIZE(default_widths));
> +	if (ret)
> +		return ret;

I assume that if ret == 0, bus_widths should be set accordingly.

-- 
With Best Regards,
Andy Shevchenko


