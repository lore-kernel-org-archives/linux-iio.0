Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF163361640;
	Mon, 10 Aug 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382135; cv=none; b=AQ9+vbFhKxk6KGh+jUwm1VCpmbj1M0pZc/VOeLYSPKD20EFF83kEL/Sx6p2sWCn9G+626lIAQTbLtel94YbrlqpaKzHZevGq4eBAuJ1JlQ/S93tQRExLI3iap30IqboToErYLqpi4GAMslBbRHPtaHRnnV+lDrrLUyY3WryHAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382135; c=relaxed/simple;
	bh=pg/C4PuZiCsgFSv2u4gQ8k4Pryvg+x2Tz6NLkthRA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmpDv3u2uDXb7xZm37qLdxxlxt5rNMkhi+1tDx7iC4P9vfaV6G1e+KBLlCWGC8brB5NC8ua7wPeldlFZyERD9oTzZ70sHPoTXxB1SXrdUtXx0NjerjQ2hZDCQUO14KPt24Cp7FEQIU6ysZ2VXef+uiwRHIpiC6eq/RmDZij+NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHxIpGHK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHxIpGHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786382134; x=1817918134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pg/C4PuZiCsgFSv2u4gQ8k4Pryvg+x2Tz6NLkthRA2s=;
  b=hHxIpGHKkR3gG5eEq0RErHbmitFVXBOS4b370sXywF57XJVm1yTzfHsx
   pycObPY2JYwUjse/DzY6E43evbGJs840fCW90UKiltax/nW4hlnAI/jUO
   lbljhfKAnCLGeHuzw4EbPCPQCrlaecviQ4hNF3Qy27CbLI3kKxlqLbjHc
   +C/zsNO9KEd5jfw4uy9UGJZzEKUphyTDkJtA/ZpB8fIMynW3rZ4W0JJvt
   Iu8JpQJUt6kFfH+ey2fAd3MNpf5+bx0mCRrql07nNsaSsGJpeNWUcJMwh
   6OhedqDzVFHNjSjyr4K5rD7oYPlRcwg1ZVfrRaQTmKA0Tx2VWj2umc1cT
   g==;
X-CSE-ConnectionGUID: fcHw9VA4QQqQpMHP2hqyeg==
X-CSE-MsgGUID: Z6zvkz6XRVi929//K3t0Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98263761"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98263761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:15:33 -0700
X-CSE-ConnectionGUID: 8RnImatjQ5mcL2/PDGpmig==
X-CSE-MsgGUID: 76VIFlvsQQi3E7BMWCxIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="263151636"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:15:31 -0700
Date: Mon, 10 Aug 2026 20:15:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anoHMANpRU744hPp@ashevche-desk.local>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 04:06:42PM +0100, Nuno Sá wrote:
> The src_addr_widths and dst_addr_widths capability masks encode each
> supported width as a bit whose position equals the corresponding
> enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> 4). As these masks are plain u32, widths of 32 bytes and above
> (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> be represented at all.
> 
> Introduce bitmap-based bus width capabilities that span the full enum
> range. To allow DMA controller producers to be converted incrementally,
> keep the legacy dma_device u32 fields alongside the new bitmaps:
> producers using the new helpers populate the bitmap and mirror the low
> 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> legacy-only producer's u32 into the returned bitmap.
> 
> Add helpers for producers and consumers so users do not need to depend
> on the bitmap layout directly. Once the remaining producers are
> converted, the legacy dma_device u32 fields can be dropped.

...

> +++ b/include/linux/dmaengine.h

>  #ifndef LINUX_DMAENGINE_H
>  #define LINUX_DMAENGINE_H
>  
> +#include <linux/bitops.h>

Ah, this is unfortunate, this is a wrong header, the correct one is bitmap.h
and I think we may not include it here (see below on why).

>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/uio.h>

...

> +static inline enum dma_slave_buswidth
> +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> +{
> +	enum dma_slave_buswidth width = find_first_bit(bus_widths,
> +						       DMA_SLAVE_BUSWIDTH_MAX);

This is from find.h which is internals of bitmap.h.

> +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +	return width;
> +}

The (big) problem is quite a header dependencies hell we have. All my cleanup
work of kernel.h I started on the simplest thing I wanted, id est to make
bitmap_zalloc() and similar to be static inlines. But it's impossible to achieve
(and I think that no one, except may be Ingo, see his 2000+ patch series a few
 years back, is capable of fix that at once). That's why having bitmap.h in the
kernel wide public _header_ is bad, bad idea (at least at the current state of
affairs). So, make it exported function instead and keep bitmap.h in dmaengine.c.

...

> +/**
> + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> + * @caps: DMA slave capabilities
> + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> + */
> +static inline void
> +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> +			       unsigned long *bus_widths)
> +{
> +	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +}

> +/**
> + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> + * @caps: DMA slave capabilities
> + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> + */
> +static inline void
> +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> +			       unsigned long *bus_widths)
> +{
> +	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +}

As per above.

...

Another (compromise approach) is to split the header that includes bitmap.h to
something like dmaengine-width.h, but I don't know how spread this use is. Do
we have all the users of the current dmaengine.h to use these APIs? If not,
split, if yes, then comment on this in the cover letter and perhaps that will
justify including bitmap.h in the dmaengine.h (but personally I am fully
against that).

-- 
With Best Regards,
Andy Shevchenko


