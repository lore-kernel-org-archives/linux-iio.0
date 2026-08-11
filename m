Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9E3546CA;
	Tue, 11 Aug 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471089; cv=none; b=IpVDfZPD9phZC8NRIA5NsIoHpFW8N7Pvc4OyzKY+NkGjGzF9qCeVaPnHsudEZzoCo27sQo2a1jgfwRcpHVtKeZXCVnJpbxK9m+UYjCYdxBbcPVrGGen+4xK3fqSD6bhaSNEe3INQ7lLGqZsmdj32pV3UQZjVNMjhNxpjctL61hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471089; c=relaxed/simple;
	bh=1Ec/ChQnkVdkPDPSEk2JwWXt668yO1n8wyIVBJoPQKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFjfeYwUXaod10NjXvsq8vjSakzMVwFcfjDnp4kPShgTWJ/aTS2UeNWs6XuOz7kuzSlyfO6GeZ8HX71m0EkZRkF08B2WrjEYRTCaawA8twe+wYIizAad/3yJs1aAWK9n/pMjE00X15S9cnEHfnssWcbWlNqjmhJtzOKBWvZYPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUNwRiIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUNwRiIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404B21F00A3A;
	Tue, 11 Aug 2026 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786471088;
	bh=HXNqTyE1ZMcxJir2v/wPOUu0IvyuOxUPn/K4gd/wx+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUNwRiIGPT3j2zmIjubDQmngzgFKNyadDsTnWNQE/Bnj/o1LQvxZHoxV038u/RXyW
	 p1nthapctWE3KL4oGi1fO4UbxI4HdMlDzg5LSUpZ+rGyEofsPegZz8FCV3pwRss3yN
	 epnPIfLdb3tX0jkXfPR5W/EuxgViw/IHPGvmaBKSa9SewQmHog6RnkivfA0gTSlsNS
	 C2Mc+I3C4HnAlsAYDfMPVJhzkx/2s4n0WEJApG3rN65BwkgHXQxhlzW8kNtwo7+Lna
	 oVk84eTi5qr9iacquMNURdVWm82AfahJhm3fWAwnmRXVR81jMR4im15CM34/LHAKfs
	 AknhK+HdglEWQ==
Date: Tue, 11 Aug 2026 23:28:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <antirKIhG8iaMqNv@vaman>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anrgDskNdV7PG-T-@nsa>

On 11-08-26, 09:46, Nuno Sá wrote:
> On Mon, Aug 10, 2026 at 08:15:28PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 10, 2026 at 04:06:42PM +0100, Nuno Sá wrote:
> > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > supported width as a bit whose position equals the corresponding
> > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > be represented at all.
> > > 
> > > Introduce bitmap-based bus width capabilities that span the full enum
> > > range. To allow DMA controller producers to be converted incrementally,
> > > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > > producers using the new helpers populate the bitmap and mirror the low
> > > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > > legacy-only producer's u32 into the returned bitmap.
> > > 
> > > Add helpers for producers and consumers so users do not need to depend
> > > on the bitmap layout directly. Once the remaining producers are
> > > converted, the legacy dma_device u32 fields can be dropped.
> > 
> > ...
> > 
> > > +++ b/include/linux/dmaengine.h
> > 
> > >  #ifndef LINUX_DMAENGINE_H
> > >  #define LINUX_DMAENGINE_H
> > >  
> > > +#include <linux/bitops.h>
> > 
> > Ah, this is unfortunate, this is a wrong header, the correct one is bitmap.h
> > and I think we may not include it here (see below on why).
> > 
> > >  #include <linux/device.h>
> > >  #include <linux/err.h>
> > >  #include <linux/uio.h>
> > 
> > ...
> > 
> > > +static inline enum dma_slave_buswidth
> > > +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> > > +{
> > > +	enum dma_slave_buswidth width = find_first_bit(bus_widths,
> > > +						       DMA_SLAVE_BUSWIDTH_MAX);
> > 
> > This is from find.h which is internals of bitmap.h.
> > 
> > > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +
> > > +	return width;
> > > +}
> > 
> > The (big) problem is quite a header dependencies hell we have. All my cleanup
> > work of kernel.h I started on the simplest thing I wanted, id est to make
> > bitmap_zalloc() and similar to be static inlines. But it's impossible to achieve
> > (and I think that no one, except may be Ingo, see his 2000+ patch series a few
> >  years back, is capable of fix that at once). That's why having bitmap.h in the
> > kernel wide public _header_ is bad, bad idea (at least at the current state of
> > affairs). So, make it exported function instead and keep bitmap.h in dmaengine.c.
> > 
> > ...
> > 
> > > +/**
> > > + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> > > + * @caps: DMA slave capabilities
> > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > + */
> > > +static inline void
> > > +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> > > +			       unsigned long *bus_widths)
> > > +{
> > > +	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > +}
> > 
> > > +/**
> > > + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> > > + * @caps: DMA slave capabilities
> > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > + */
> > > +static inline void
> > > +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> > > +			       unsigned long *bus_widths)
> > > +{
> > > +	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > +}
> > 
> > As per above.
> > 
> > ...
> > 
> > Another (compromise approach) is to split the header that includes bitmap.h to
> > something like dmaengine-width.h, but I don't know how spread this use is. Do
> > we have all the users of the current dmaengine.h to use these APIs? If not,
> > split, if yes, then comment on this in the cover letter and perhaps that will
> > justify including bitmap.h in the dmaengine.h (but personally I am fully
> > against that).
> > 
> 
> Hmm I don't think all dmaengine.h will use this API. Maybe on the
> producer side but even in that case I don't think so. These are all tiny
> wrappers that make sense to be inlined but OTOH, I don't think any of
> these needs to be called in any fastpath. And I do understand the header
> pain in here but honestly, no strong feelings. So, I'll pretty much
> defer this to Frank or Vinod.
> 
> Frank, Vinod any preference?

This header is where we push stuff in, so I would try to keep it clean,
so I guess better to go with Andy suggestion here

-- 
~Vinod
