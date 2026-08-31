Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166A566C68;
	Mon, 31 Aug 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184085; cv=none; b=IhvX5rXLPlVa90sTUZiqNIDig8KakWRFTCE2WdJbPoIjj41R0zUZ0k82v6FqS6K2zY0Mqtx7UiFmoOazS2yFbU+dSky7BWD1iVy7FoKpuilykkCbBidvGQj7JApsw7KF40n31+0SBIfHDXgaHBUKjzztnmZaPvAeHyVV+JPfeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184085; c=relaxed/simple;
	bh=ie3xlaMgCZRHfQFO9tpvIrY06r9dN2T6vkkF4iH+iGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCE5+gAnRm/9tTWExn3N/XYiUEOdJ40ugarciew0XHXzgmhjkzySVBhT0147TQe1Q5MNrz89zlj5IST7WOltWSs1WVCbyBe3ZB2lnBXxwpHoKMW4BQkDCl74GTHOUmw7u5lkh3n/KhNaFL+ZoUqirDTvyYQh1t2UOcr+VcdzaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On9qWglT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On9qWglT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184083; x=1819720083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ie3xlaMgCZRHfQFO9tpvIrY06r9dN2T6vkkF4iH+iGU=;
  b=On9qWglT6o1/aYWrszcYZvtrb1ykS1Vfdc87JV1KkddHlf36YwojbDgn
   TrcTo0c0NxWg9zBAUE8QLjvKwfjc28qLY1r+z6LMJZb7fi/0fMHHo1YSf
   x2VA+eOZ6GbhUc7iIHkLK2cPwp3XcDAZhQTCSAgTvBJV6SVIC/hy6w07C
   gG2F5UbVgOhXyQXjZ5yrej1+bG4O884r0SdDOwj/DQVEYiK/kSUnh9JGJ
   NznxbRVVpp4LtgCNef/oAg3sIxKTD/7y7H79ydvHIEDTE2IdXovcGvenl
   rzOdh8oXcQ2oIlXHdVamQSeOOZFAo1kLY6ZFt24+liuUjBCj//T1ebBrl
   w==;
X-CSE-ConnectionGUID: N0Gji/AATxus7JyL+TvaCQ==
X-CSE-MsgGUID: 57eP9v3jTrOC574nAFrfag==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114129760"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="114129760"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:48:01 -0700
X-CSE-ConnectionGUID: +4KfFTj7TNWoAYw8FptzuQ==
X-CSE-MsgGUID: GDSOXyHfQ+abDtDfzeAhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="293633674"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:47:56 -0700
Date: Mon, 31 Aug 2026 16:47:54 +0300
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
Subject: Re: [PATCH v3 8/9] spi: dw: Use dma_slave_caps bus width helpers
Message-ID: <apWGCkIJ7zGh2Gd0@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-8-507d97496f2d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-8-507d97496f2d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:46:45PM +0100, Nuno Sá wrote:
> Store the common TX destination and RX source bus widths in a
> driver-owned DMA bus width bitmap and populate it through the
> dma_slave_caps helper.
> 
> This avoids depending on the legacy src_addr_widths and dst_addr_widths
> masks returned by dma_get_slave_caps().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
One nit-pick below.

...

> +++ b/drivers/spi/spi-dw.h

>  #include <linux/scatterlist.h>
>  #include <linux/spi/spi-mem.h>
>  #include <linux/bitfield.h>
> +#include <linux/dma/engine/types.h>

Even if it's not sorted, try to squeeze the new one into ordered manner.

-- 
With Best Regards,
Andy Shevchenko


