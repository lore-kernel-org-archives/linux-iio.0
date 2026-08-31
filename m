Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207104A840A;
	Mon, 31 Aug 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183926; cv=none; b=HV0pOavV0uB+J4eClCJzMOxXS8M2j9Ej1mk4iv5c00lALxq9F8UGNsjCA2ZonbjijLAxduspHmZioXmJDfw5giXrLgJfK/g9eslWzhANsxnOAp5eQK/dThu8PqyqpusWTJJwO4nniVBERBnnK6eQUik0lxJ6QS+XLD5McwLDDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183926; c=relaxed/simple;
	bh=iJE3knD8GZpNzW3zg5su/vA3JNJNn8xjodGntYeADPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4RPiwEcXIMRu/oXbd0JSVKiJlJV3p79GhbOCm6TakhzsYeKeXebyUgY9hlX9be4Tui4z+qbABJW+hazKDpC/5IdiuFshodDU/WMxsvBnhbi2irsbBpSZcXSTa0XZxOc69Zv2IcUIF38tfQPabQyuugrBGa4ficFj4SGd0ZUZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8ob630k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8ob630k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788183923; x=1819719923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iJE3knD8GZpNzW3zg5su/vA3JNJNn8xjodGntYeADPc=;
  b=b8ob630kGceMOIaT1UpM784iJyr/ykIsx5oegjACNgtnjWcker96eYTn
   uKGX7qjlTLWSdq5Z4M2xuK7DuHDsGPt/2pw9uUlFfrZSaoMjqbejQNnZ7
   29TKfKg7cGC/PnH81G7MjTQO/4Duyx8i90Z7Lpwq6TysongbqZ9dHNjU1
   8Y905f2haawe+nJ5cYiMqJcRyVNG9wR34oJeNtf0Nww1VHatCHP+BbeRo
   QOzd24IIldoqIjptu+i78V7gy/rYJeTuMNgjCi/Pv1euQFCVpiQI2tblk
   J0I2Zk/l5rUfnZ4DPa0ph+Bm0aqNfMHL+xXNP9iTrDMgSf90eZ68tROR4
   w==;
X-CSE-ConnectionGUID: N+fF6TtQTMqXyr09JvcZ3Q==
X-CSE-MsgGUID: F6jPQ3gyQx2DuajCnMB34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114129498"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="114129498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:45:22 -0700
X-CSE-ConnectionGUID: 8jytYmUyR0S7PAi1zuNgxw==
X-CSE-MsgGUID: YDMavWC2Tn2LTkRLkvF7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="293632864"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:45:17 -0700
Date: Mon, 31 Aug 2026 16:45:15 +0300
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
Subject: Re: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <apWFa4BFoAL2AhG3@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:
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
> The new interface lives in two new headers under a new
> include/linux/dma/engine/ directory instead of growing
> linux/dmaengine.h, which is included nearly everywhere:
> 
>  - dma/engine/types.h holds enum dma_slave_buswidth and the new
>    dma_buswidth_mask_t type. Like dma_cap_mask_t, the type only needs
>    DECLARE_BITMAP();
> 
>  - dma/engine/widthmask.h holds the accessors which are based on the new
>    dma_buswidth_mask_t type. This gives us freedom to change the core
>    without affecting consumers as they only see (and should only use) the
>    new type.
> 
> Note the fold only has to happen in one direction on the producer side:
> nothing outside a controller driver reads the legacy dma_device fields,
> so a converted driver's mask is not mirrored back into them. The legacy
> dma_slave_caps fields are different, as consumers not converted yet
> still read them: dma_get_slave_caps() derives them from the mask when a
> device_caps() callback adjusted it. Both go away with the legacy fields.

...

>  F:	drivers/dma/
>  F:	include/dt-bindings/dma/
>  F:	include/linux/dma/
> +F:	include/linux/dma/engine/
>  F:	include/linux/dmaengine.h
>  F:	include/linux/of_dma.h

Unneeded, previous entry includes recursively.

...

> +/*
> + * Basic types shared by the DMA engine interfaces.
> + */
> +#ifndef LINUX_DMA_ENGINE_TYPES_H
> +#define LINUX_DMA_ENGINE_TYPES_H
> +
> +#include <linux/bitops.h>

Not yet? Perhaps next changes will use it, then they can add it.

> +#include <linux/types.h>
> +
> +/**
> + * enum dma_slave_buswidth - defines bus width of the DMA slave
> + * device, source or target buses

I would describe the _UNDEFINED case, it might require some clarification on
what behaviour is to expect with this one.

> + */

> +enum dma_slave_buswidth {
> +	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> +	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> +	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> +	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> +	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> +	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> +	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> +	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> +	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> +	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> +	DMA_SLAVE_BUSWIDTH_MAX
> +};

> +/**
> + * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
> + * dma_cap_mask_t.
> + *
> + * Each supported bus width is represented by the bit whose position equals the
> + * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
> + * width of 4 bytes has bit 4 set.
> + */
> +typedef struct {
> +	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
> +} dma_buswidth_mask_t;
> +
> +#endif /* LINUX_DMA_ENGINE_TYPES_H */

...

> +/*
> + * Bus width capabilities of DMA engine devices and channels.
> + */
> +#ifndef LINUX_DMA_ENGINE_WIDTHMASK_H
> +#define LINUX_DMA_ENGINE_WIDTHMASK_H
> +
> +#include <linux/bitmap.h>
> +#include <linux/dma/engine/types.h>

+ errno.h

> +#include <linux/types.h>

I would group subsystem ones.

#include <linux/bitmap.h>
#include <linux/errno.h>
#include <linux/types.h>

#include <linux/dma/engine/types.h>

...

> +static inline enum dma_slave_buswidth
> +__dma_bus_width_min(const dma_buswidth_mask_t *mask)
> +{
> +	enum dma_slave_buswidth width = find_first_bit(mask->bits,
> +						       DMA_SLAVE_BUSWIDTH_MAX);
> +

For easier maintenance better to split the assignment.

	enum dma_slave_buswidth width;

	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);

> +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +	return width;
> +}

...

>  #ifndef LINUX_DMAENGINE_H
>  #define LINUX_DMAENGINE_H
>  
> +#include <linux/bitops.h>
>  #include <linux/device.h>

> +#include <linux/dma/engine/types.h>

Same, group them after generic linux/*.h.

>  #include <linux/err.h>
>  #include <linux/uio.h>
>  #include <linux/bug.h>

...

It's possible to split this patch to two:
- move the existing type into a new types.h header
- add support for the new API

-- 
With Best Regards,
Andy Shevchenko


