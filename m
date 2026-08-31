Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219653D0A5;
	Mon, 31 Aug 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184163; cv=none; b=elFY2tOnhJqBo8Mscg4ner4bXsuxBpTXdsG1YvetuCMhTGKwdjYI6YYt/NBxQ+VMOzyVGdFMlphATXaKUEwHgZRjadbubx7ftXgr0QBHb+LWSJ7y5yjLd480EXG4szRWZ9iDooz9qQePLxlHnMDWQdepPW1Xh9OsjoWX2xg2EZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184163; c=relaxed/simple;
	bh=h6Ld0f1tqG+J98xm0TFaV3c9NYudrk1XB2K3F5fgbz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvdV53poB0iKrN9m/iQDEjud47ijtgV5WQXOGCQQ19zw6sjtAkoFXeWKpjmHUtArS2ZxFH9fvGzX9cyyDZm3JMdmbgVFkXHFYI36ULVsZMCo/ybFIgZL+KJNfZ0Cuja9tUxLE+6R0KbjZd4s6OBqtlQki7w0ITsmnbr6qLu5ZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckeBmuAy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckeBmuAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184162; x=1819720162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h6Ld0f1tqG+J98xm0TFaV3c9NYudrk1XB2K3F5fgbz0=;
  b=ckeBmuAyTPfV3eZqx9BTn9Thm+CB03KvqJ5rhCig4l5Py8wMSSm/JoTd
   OQXEO59oYt+oc7Ln0VOsYxJgRR9E9Z5AriZBy7bTPEu4Qk9Fh8gZz/Obh
   FWMMSvKKBI2fNYXlU8YikH39Pad33i5ePOCU5oLX6zqFluWX3SzyMtAro
   klfDr3NLcChSBB+fu2a+01esdepSX75rsig8rVnBikv7gLYvlF41KKwFN
   CWmHrIB6DZuEiN8bmMkkNDhhj5/Urukvd+uoQYOKgfWygt55eA5b01+Fb
   znUDWlC691fxBoJfInXkSsPW/1B0G2lPE1baJwMFch7ryVGSkW0BStGBU
   A==;
X-CSE-ConnectionGUID: /gRO7v8ETDmI9CbgUjrhoA==
X-CSE-MsgGUID: diZPaJIZT4ahR2S7/mh5LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99192993"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="99192993"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:49:21 -0700
X-CSE-ConnectionGUID: rPusQVupTySZrL7PVWQddg==
X-CSE-MsgGUID: rol2X92aSNGypCZBpqZSJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272600396"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:49:16 -0700
Date: Mon, 31 Aug 2026 16:49:13 +0300
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
Subject: Re: [PATCH v3 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Message-ID: <apWGWdLTmpRVGTWX@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-9-507d97496f2d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-9-507d97496f2d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:46:46PM +0100, Nuno Sá wrote:
> All users of dma_get_slave_caps() that inspect bus width capabilities now
> use the bitmap helpers.
> 
> Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
> from struct dma_slave_caps and stop copying the dma_device masks into
> them.
> 
> Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
> dma_device are kept for now as every DMA controller driver setting them
> still has to be converted to the new helpers. dma_get_slave_caps() keeps
> folding those masks into the bitmaps it returns so unconverted producers
> continue to work during the transition.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


