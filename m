Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0C38F253;
	Mon, 14 Sep 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373110; cv=none; b=jsoDRGDI5hIyyJR+3p8Bv/SsmU9SM0jWRA1HnApsNCRhF2RbVGKRSi7fJPhDoadr4/tmUmR5rs53isMUTpw7j98+UojrqdyMoh8cDugfOIYo1x8jWTuZk6EDICRWxVh+0ea5/N+pyB6j/dKEWkvkJkGCLW9v/r51BH2NYPuDcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373110; c=relaxed/simple;
	bh=ms02h7CsujbREPeLnaUOThPK+64TwYCRPpUsizrNp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnGNlW1v5nKWiG9oIxbLs2+fzcbuIuDo4RE8pBHfpdcorErVYExgciucLIfSKXvAZ5MQuGG1HXCIt/cAOX6rqaHzbsYmvipP/LSXZY/OzO3K7hswKolkXxfZs55yaToP4LfUeCNZUlTl1JQvSyWIKNP7SqjmDqwdFp4/UFNSfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2TP4zHL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2TP4zHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789373109; x=1820909109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ms02h7CsujbREPeLnaUOThPK+64TwYCRPpUsizrNp/I=;
  b=L2TP4zHLHvmazl7NahMd9Yw7qC90RXeB5i+JSeOEeD4YBc32yljScTye
   D7x4rC2lOcSEuOm+AxvP4xMEQcmv/zm3ExsM8YgOsJmWYFQlsz0ghZ469
   kZSHPwoM7PwK6nyxaHMfKcem4Xn7IVUqtvDhFfv9676RQmEVCC3oE1vJr
   k0WmcWla3L6p/Hy+N4hxzu47KFUfucbB4waiES6zpFstEp8KZdegFfC65
   gpnQ8f99wRFmgA7DhgV8k2TBdsXORWDylpbtXlMq+y/AK7JJIhh8x7laT
   cMdfV0+ee3Xc+8Haja2Y06OR9ObIkmSPrullglNnQxvBMw7O+Pt506r12
   Q==;
X-CSE-ConnectionGUID: Nu5+r8EcQuasyIvQcB+Iww==
X-CSE-MsgGUID: XSXvpDGLSa27m3a+rnlYNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100317036"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100317036"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:05:09 -0700
X-CSE-ConnectionGUID: k/BGMQlsQ26pQ7qXoD2Low==
X-CSE-MsgGUID: LyK3jnAQS4OvLkjyLJO+GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="268897922"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:05:03 -0700
Date: Mon, 14 Sep 2026 11:05:01 +0300
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
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 02/10] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <aqeqrQU7Gtj9uGQx@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-2-72b8fd4cc78e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-2-72b8fd4cc78e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:25:37PM +0100, Nuno Sá wrote:
> The src_addr_widths and dst_addr_widths capability masks encode each
> supported width as a bit whose position equals the corresponding
> enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> 4). As these masks are plain u32, widths of 32 bytes and above
> (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> be represented at all.
> 
> Introduce bitmap-based bus width capabilities that span the full enum
> range, through a new dma_buswidth_mask_t type modeled after
> dma_cap_mask_t. To allow DMA controller drivers to be converted
> incrementally, the legacy dma_device u32 fields are kept alongside the
> new masks and the core folds a legacy-only driver's u32 into the mask
> when the device is registered, so consumers only ever have to look at
> the mask.
> 
> The accessors live in a new include/linux/dma/engine/widthmask.h instead
> of in linux/dmaengine.h, so that only their users pay for the
> linux/bitmap.h include. They all take a dma_buswidth_mask_t, which means
> the interface will not change once the legacy fields are dropped.
> 
> The fold is bidirectional while both representations coexist. A driver
> that only fills in the legacy u32 gets its mask derived from it, so the
> consumers already converted see it. A driver that only fills in the mask
> gets its legacy u32 derived from the mask, so the consumers not
> converted yet, which read the legacy dma_slave_caps fields, keep working.
> 
> On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
> masks from the new ones when a device_caps() callback adjusted them, so
> that a converted controller narrowing its per-channel capabilities is
> still seen by the consumers not converted yet, while a driver adjusting
> the legacy masks directly keeps working.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


