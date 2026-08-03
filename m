Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3438333C
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760660; cv=none; b=BoNcu2jOU8bst/cvZ43MUU6dy3vQjBgfRr4eA2QptEZlUcjdQUnDSdhQyStujyGwDjnbheU5BAUrBt/5O35DgtyEwBubFCQOAdzYYbODQ7vV0rMwXa0AyzkvvRc2836smWM7gep8S/96n4BYLLJJBJ4BAcpS1aLZYWTfao297sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760660; c=relaxed/simple;
	bh=fGJPO+nSLHdUlfO8yRis7kZEX21FJFWb5OOt1voCBVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blojhlwg9jzlYbHN8fDRIl02TgZnVZOxU0VvbG6MMKRzia2BsTi53R6sSQ0IsGzE4c5SWsfh334hfhxGx3+tKur6gcAc4MjVUVC/Ui3cSw9hjM3z4he+7f4JlQiX1DM+TrsmPrUfpMkjYbbAj2/PrlxA9N+03WGVV29PmvZccx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcsRTKaa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcsRTKaa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17548915e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785760657; x=1786365457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CcwBSNwXNz53utbquU56tNtJiKq6TMRrnU9O5srMNU=;
        b=IcsRTKaaKhFyjD2N6d2aAvBOKF9xuSd6jJZHUdR/WZF+knXbtHRSA01YMxYbz4X55A
         +Zu1DNk7/BGaXco8wMPl9eTdzXv8JcTniasEfLvqQjyYbLiCGivJOhrCdt1Xiw+fcBWn
         pGVSjpCs/ZhN5R5xLhWIhrulWHMfLqxc/IgaYaS/Z851zTPbRe6a0LnbI4L8v1KYLrAc
         jWTmWF+5MKcL663/60+HePuwxGcKloJT+MpVxHy+mRd6PSv9k68j/QcdLI7nHfif913s
         7SH0VLQbcVr15BJ72PYtiGJVRqiHz0TFmnrKQZAkeTzpzsL9MZHKxWYYGTZTUCatgBTr
         31WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785760657; x=1786365457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7CcwBSNwXNz53utbquU56tNtJiKq6TMRrnU9O5srMNU=;
        b=f/OKNG1f7OclJn5fIA3N6zMyu4pTp3w3ASdi8Co7/nRekpzuesMu1FA2kh1Fxt57Ch
         x2sKfDNX613y0+JMz3GPVJk6xmdceIBk+a8TILnmCuxDpKzqWKUMs5TXcbJ8wZzc7lUH
         bVh+I3z7e5MT7YTtX7kVPBWH9bUXDMDrBfNl+1Y7XdWodse92piWzNUdN1P4WI62hj6e
         FywnIuO0gaQxzjDIMpZc/pfkOl1h8lfQKTFbs24/RP/xGfgcEyuV4SEkrwsk0DlkxCbV
         MZXMbZFyB1LjjYHYQLbHp/W7zjq/glH8eZZQ9pB7KKU/mu/rDAbuLz4wydvD0ITiUo+p
         Uqjw==
X-Forwarded-Encrypted: i=1; AHgh+RqtTtJ9c5OuL4Fp7phYLKKSsgTNZcxfaJ+RxikaO4IlBYrKvOa5Q9arfILeeYKgJAIVRbI4kBp5yi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK70UZIkovWppzMeNOZFVsMY1zGFfjVodskljVguQrIXtiSrNv
	O6M7i2HlpZ+Ij+daQAGvluge+IRvZHpdjnPyf1dBv2mHFFbqPVjBTdIE
X-Gm-Gg: AR+sD11WWb2sBRIyQIIO5g/BoyBIWuBRN/twFzx0xeRG6vLeFYihnu+5/EfCyBgIIx9
	7HOrd8pch7HaZoc0yl0H7oP7rRnHQYvAc0LlbiUO16lvkCjPXnxQaIlH2VEPEosM6Fqk69/lmbZ
	ioi1QS7q23kxxB8TnsVk2zVZcgzUYUYA7/r+8v6/H4cSFsPE3hf4YndadlPP1s2aY9WlORxO3Md
	yeIuDym/2Mp/cpu1mPVmQvFa7M/PlsM3zuCEYmFCgDuA9QxBFpllG3VCzVqy827uWF+8r+b71wi
	SS9ZXI2Uf7WFwK5kieB76KJYvtzndAQ3R6GTeWEPfbKH9SNNiO0DQypKKXI9OljncMqfrgaRnVg
	viRJVsH80pj/mn55cuQEG3lEp55K4ZqXmQCs941AD2P7DALXqnq2d6H7wX9IhJZPGjusvbjKhVx
	sut01G/MnFK3TAR9CyyRwnTlig/vgzIwEiWs/DqzzyOR8s7DbgCbnb
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4980c66c991mr261324315e9.8.1785760656734;
        Mon, 03 Aug 2026 05:37:36 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b21e66sm203681365e9.0.2026.08.03.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:37:36 -0700 (PDT)
Date: Mon, 3 Aug 2026 13:38:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Message-ID: <anCLovMjz14Zxyup@nsa>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-9-3732f1f9d9ca@analog.com>
 <amunW2XsMCC3GmeK@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amunW2XsMCC3GmeK@SMW015318>

On Thu, Jul 30, 2026 at 02:34:51PM -0500, Frank Li wrote:
> On Thu, Jul 30, 2026 at 03:23:16PM +0100, Nuno Sá via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Nuno Sá <nuno.sa@analog.com>
> >
> > All users of dma_get_slave_caps() that inspect bus width capabilities
> > now use bitmap helpers.
> >
> > Remove the legacy fields from struct dma_slave_caps and stop copying the
> > dma_device legacy masks into them.
> >
> > Keep folding legacy dma_device masks into the returned bitmaps so
> > unconverted DMA controller producers continue to work during the
> > transition.
> 
> which one you kept?

The one in

https://elixir.bootlin.com/linux/v7.1.5/source/include/linux/dmaengine.h#L890

given that we need to update all controllers in drivers/dma before we
can get rid of them. I guess I need better working in the commit
message?

- Nuno Sá

> 
> Frank
> 
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/dma/dmaengine.c   |  2 --
> >  include/linux/dmaengine.h | 16 ++--------------
> >  2 files changed, 2 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 7be23ba769d0..ee0b8bfc7c97 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -592,7 +592,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >         if (!device->directions)
> >                 return -ENXIO;
> >
> > -       caps->src_addr_widths = device->src_addr_widths;
> >         if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
> >                 bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> >                 bitmap_from_arr32(caps->src_bus_widths,
> > @@ -602,7 +601,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >                             DMA_SLAVE_BUSWIDTH_MAX);
> >         }
> >
> > -       caps->dst_addr_widths = device->dst_addr_widths;
> >         if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
> >                 bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> >                 bitmap_from_arr32(caps->dst_bus_widths,
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index cea57b166dcb..f37a0559ec5f 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -495,9 +495,7 @@ enum dma_residue_granularity {
> >   * @src_bus_widths: bitmap of source bus widths the channel supports.
> >   *     Width is specified in bytes, e.g. for a channel supporting
> >   *     a width of 4 the bitmap should have bit 4 set.
> > - * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
> >   * @dst_bus_widths: bitmap of destination bus widths the channel supports.
> > - * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
> >   * @directions: bit mask of slave directions the channel supports.
> >   *     Since the enum dma_transfer_direction is not defined as bit flag for
> >   *     each type, the dma controller should set BIT(<TYPE>) and same
> > @@ -516,14 +514,8 @@ enum dma_residue_granularity {
> >   * resubmitted multiple times
> >   */
> >  struct dma_slave_caps {
> > -       struct {
> > -               DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> > -               u32 src_addr_widths;
> > -       };
> > -       struct {
> > -               DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> > -               u32 dst_addr_widths;
> > -       };
> > +       DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> > +       DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> >         u32 directions;
> >         u32 min_burst;
> >         u32 max_burst;
> > @@ -1789,8 +1781,6 @@ dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
> >                                enum dma_slave_buswidth width)
> >  {
> >         __clear_bit(width, caps->src_bus_widths);
> > -       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> > -               caps->src_addr_widths &= ~BIT(width);
> >  }
> >
> >  /**
> > @@ -1803,8 +1793,6 @@ dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
> >                                enum dma_slave_buswidth width)
> >  {
> >         __clear_bit(width, caps->dst_bus_widths);
> > -       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> > -               caps->dst_addr_widths &= ~BIT(width);
> >  }
> >
> >  static inline int __dma_set_bus_widths(unsigned long *bus_widths,
> >
> > --
> > 2.55.0
> >
> >
