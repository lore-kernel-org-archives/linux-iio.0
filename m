Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FF3CA4BF;
	Wed, 17 Jun 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690281; cv=none; b=ql1Ux5Q72EaWxFPyXa2G4XDMY7ozkP8P0+Xid9r2Y2f3lxIRO/BNZDyL/aS2ISf8qpy5D/PS5QIdU35sZYiBpUReotBDSytcjgvPffmzMzA2j4IgauYcnBTnif42m8lR7aO2CDmzAaSLrcb4FvWuEW5REXCz7NvLrBzS9U0PzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690281; c=relaxed/simple;
	bh=G7eYxoqDYKJCLMufa2vb/0b5tYXLZLxtXsNPoHeFCXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgYFpap8C7sxr55EWXcYOYa1VasknT4HtPCE6Zbl1kYXk9mg3Vp7YmKRsfDZTWYug6fqQ0O8MwYH4wcwcTZ2PCwc2VnPGN8CG7Xt2JCxx3P4Pc5QfWY8pxUw0PysgoD7+uyxcsi0dx8AgSohDNfJRUa4S77yt6x+PYvrSOxMA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7MrVU3s; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7MrVU3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781690280; x=1813226280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G7eYxoqDYKJCLMufa2vb/0b5tYXLZLxtXsNPoHeFCXg=;
  b=g7MrVU3sBoa8K+mD8n2NgnQGhRlNWIrj8T5Rk/IdfvCli4Qj10w/YSoe
   CqmPNciF95f0jMvr01jnvTxsbMX21NyiezoGTBtbTDa2kbiMaU3BKLF6g
   mlYFtxy8/iXLoxZUTbR541G+qb7u80tql/zgqCjTd6sFIUzjAR3h+v0Ru
   XCspn12ykV19+tOeEd1rXfxisUtsqOltW1mqLkVLZ1J5n+cRYxkSsKPl6
   g2qhe7OMgvyDzv1C87QW1DAAjWwl1fD91MftdfhIs9xwUz+ds8x1nBa2p
   v03degp3GB+plhmN+nAoyOnzTQ5Fu2XAHIyIQ0MG99evXhhyoQrv6QjxB
   Q==;
X-CSE-ConnectionGUID: K4lIdHFMS0ahiArCkQzC+Q==
X-CSE-MsgGUID: HRRVprkMQNWWNlJ4ZDM3IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82356643"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82356643"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:57:59 -0700
X-CSE-ConnectionGUID: KEiNLP+6Tu6VQJvvCrzQIg==
X-CSE-MsgGUID: AWDweLUGRvShQVqwJTgCrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="253134475"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:57:56 -0700
Date: Wed, 17 Jun 2026 12:57:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 0/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajJvouBANqhVaHXJ@ashevche-desk.local>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 04:40:51PM +0100, Nuno Sá via B4 Relay wrote:
> The DMA engine slave capabilities advertise the supported source and
> destination bus widths in src_addr_widths / dst_addr_widths. These are
> plain u32 bitmasks where a set bit's position equals the corresponding
> enum dma_slave_buswidth value, e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> bit 4.
> 
> The consequence is that widths of 32 bytes and above cannot be
> represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> 32, 64 and 128, which simply do not fit in a u32. Hardware with wider
> data paths is becoming common, so we need a representation that can
> express these widths while still using enum dma_slave_buswidth.
> 
> This series switches the masks to bitmaps that span the full enum
> range. Because there are many producers (DMA controllers) and a number
> of consumers spread across the tree, converting everything in one go is
> not realistic. To allow an incremental migration, the legacy u32 fields
> are kept alongside the new bitmaps:
> 
> - producers set the bitmap via the new dma_set_{src,dst}_addr_mask()
> helpers, which also mirror the low 32 bits back into the legacy u32;
> - legacy producers that still assign the u32 directly keep working, and
> dma_get_slave_caps() folds such a u32 into the bitmap it returns, so
> new consumers always see a complete bitmap;
> - consumers can read either the legacy u32 or the new bitmap during the
> transition.
> 
> The axi-dmac controller and the IIO dmaengine buffer are converted as
> examples of a producer and a consumer. And this actually fixes a very
> open coded path to undefined behavior in the axi-dmac driver and
> possibly others.
> 
> The end goal is to convert every producer and consumer, then drop the
> legacy u32 src/dst_addr_widths fields and rename the *_mask members.
> I cannot commit to a timeline for that conversion (it touches a lot of
> drivers across several subsystems), but I do intend to see it through.
> 
> Sending as RFC mainly to agree on the approach!

I have another idea. Why not having 8-bit mask for power-of-two and 8-bit mask
for non-standard ones?

So, u8 power_of_2_mask represents the respective sizes directly as ORed values
and u8 non_standard_mask (only to cover 3, 5, 6, and 7) does the original
approach for it, id est ORed BIT():s of the sizes? And yes, I understand that
it's not so KISS as above from data type point of view, but I think wei should
never need to have a heavy bitmap() API calls just for them.

The whole exercise seems due to DMA_SLAVE_BUSWIDTH_3_BYTES. and we have less
than dozen drivers that use it.

> I'm also not sure if the dma_slave_caps_get_{src,dst}_width_min() accessors
> are worth having? Their purpose is purely to keep consumers from touching
> the representation directly, so that the eventual u32 removal + mask
> rename is a no-op for consumers. The alternative is to let consumers use
> the bitmap directly (find_first_bit()/test_bit()/etc.) and just delete the
> u32 members at the end. I mean, now we do have a bitmask so the _mask
> suffix can of makes sense.

-- 
With Best Regards,
Andy Shevchenko


