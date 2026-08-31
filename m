Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506958E2B0;
	Mon, 31 Aug 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184246; cv=none; b=gyhh/Z/+4balrJn/cMQvfVE4wtwkAs3cEhn0FBGHDv199T0Welu0mOJGaiynNyHLyRvWR80TqcuwTgl+s/kqF/fxIdI47LL1tA0OAR5j57Snlje2Rxah7ZQIMIBonLiQueJLKbRG9lVyl4m+6RgabeZd/b1wj0MGRY8+21mnuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184246; c=relaxed/simple;
	bh=9QNW7Xng5+XGxRoxGgg+zNxQpyqGrtp96z2nbaxdnLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7/3okKD/ONwhUjDPwViO9on+KGzSpYQBtqkbK5954zT2CtHsrTrpJ9VxmjJ1vtK6LcGsjb7Tak7w/09SUR6WksbTPze7Q4hTj3djOiVdgT1LVM6SAQT6RxyekDpWtyKIKGhwK4l5f8jZ37t/t/1bpqujh/bX1sZQ6coFnoWfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+11IJ83; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+11IJ83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184243; x=1819720243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9QNW7Xng5+XGxRoxGgg+zNxQpyqGrtp96z2nbaxdnLc=;
  b=B+11IJ83EihxOwsj3OuVQZQb5XIBgkPok5tSicDG1ih95nRrdp6oA9P6
   Ovl4vsUFsW71fuoe+5HWvCC2Yst5VYzb0x5Dkj4W4wdty8kORT85T0dgl
   rXGxblU723jkdfoGLTRJpn2z+Tb8DnOrRTcrCnfe1alhz+4oeP3kPS+zs
   QJaQiszrVpzMRSxnKWdN9b1t2fAMkO5TVSFZ3MVazq5J0wJ0KdVpW4yhq
   NDX8kT+hIXu4S+68zwBpkcLK8//1X+D8Ap2/j4Y19ZW7xbWno5czzqieD
   xRQmg79boZVdzNFyS23/DYbkZXDY5cSmBvOqKfe5C+j/tSn6NOss1Gksi
   g==;
X-CSE-ConnectionGUID: YpNKTyUkRWyyoE0bMEF2Aw==
X-CSE-MsgGUID: 4IAXe2tBRsaMyI3bBFlxKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99942229"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="99942229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:50:41 -0700
X-CSE-ConnectionGUID: FsmQNTR/Tim7lx99V8nD7Q==
X-CSE-MsgGUID: TH6ZphDPTduHY64nSInkbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="269393170"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:50:36 -0700
Date: Mon, 31 Aug 2026 16:50:33 +0300
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
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <apWGqZPhC6wCuakp@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:46:37PM +0100, Nuno Sá wrote:
> The DMA engine slave capabilities advertise the supported source and
> destination bus widths through src_addr_widths / dst_addr_widths. These
> are plain u32 bitmasks where a set bit's position equals the
> corresponding enum dma_slave_buswidth value, e.g.
> DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> 
> The consequence is that widths of 32 bytes and above cannot be
> represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> paths is becoming common, so add a representation that can express these
> widths while still using enum dma_slave_buswidth.
> 
> This series switches consumers and a small set of producers to the new
> bus width capabilities, represented by a dma_buswidth_mask_t modeled
> after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
> so the remaining DMA controller drivers can be converted incrementally:
> dma_async_device_register() folds a legacy-only producer's u32 into the
> mask, so consumers only ever have to look at the mask.
> 
> The new interface lives in include/linux/dma/engine/{types,widthmask}.h
> rather than in linux/dmaengine.h, so that only its users pay for the
> linux/bitmap.h include. Every accessor takes a dma_buswidth_mask_t,
> which means the interface will not change when the legacy fields are
> eventually dropped.
> 
> Once the remaining producers are converted, the legacy dma_device
> src/dst_addr_widths fields can be removed as a final cleanup.
> 
> This issue was discussed before here:
> 
> https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Thanks, this version looks like the right approach. I have looked at a couple
of patches and only the first one needs a bit of work, the rest looks nice!

-- 
With Best Regards,
Andy Shevchenko


