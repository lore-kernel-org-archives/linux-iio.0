Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DED368D51
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120344; cv=none; b=QWg03RLJNILIaAo3VdRN2mU0XANfeyKI6ipv+xUrjm0wFmMCJkF0wCV1MnxU5qMrdcFOnIrbOjqBRSXHngp9TnbqvsSvbXbEpMw2UdXMMHY1uf+iVotXsaebR7/m0mV6qYSpqSy6uAyyD73aZLImSpgz014+74zLDcKe+hSzrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120344; c=relaxed/simple;
	bh=Y6Td5KWnNW2jhqaxsvjarPPHJA2xevanPTsc7EJGaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbn8LmM0vbNjZzJA6W1vtvAol2DLuOcGsADsaBa6VsZfbXh5nJ/Ff41G+e89OxTKBGv6XZ/D9YmHeHn6Rq53H7wkggv5NaWh8X2g4VuSYdQogWCOTtUqqz3hTOBQfTT1FHlduqgRF+ka+pY/Wv6b+SwvnNczZNFkZwN3L4LPXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhV9bJFz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhV9bJFz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4626fdc829aso2887441f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782120339; x=1782725139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTNaglsuT50Ihg7ladjK7v55JZCOz4iDdCHaBxElsvI=;
        b=ZhV9bJFz23ATLnYEgV31NnU5D8TJtb9IDh6fMY6vEyLv9AVPE0CISgBkSmx8sIkuRO
         xan9b5zyJo7SiHVvoAGGU5vMYJbtEGiYTGK6WVJ+MCfOQu0aqDTqQOKqLxEIdETdKbBW
         5vpFI8HoO4hLrXCslsIRALPKRGVLc0ljTv/N+/KzwshGBeayU2WX7ItYaitXWz/zDmCX
         nnENLIQZ8EKhZj53pxvVwEWLelZS40vDBuy2NxpjwyVHwJDV3+W3zDMVse7rcBBu8UYb
         6qlJJlUgMxe+2BV+7c5nmdJobF4GdUlisxoR6/+eUVo85t8/RUTh5LhaHyNQQe8QbnWc
         uNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120339; x=1782725139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTNaglsuT50Ihg7ladjK7v55JZCOz4iDdCHaBxElsvI=;
        b=cms0ndAqmXzpgdaCH6R5WzMkSIBwsKccJ0e4DyRUFC5xXw0cidpSYngBbmF+nHmWVi
         6MAeXK5OfSrqAxylvizy7XGC98X0SsnwP1Dw+Q8U9Fa3Pbe+UnGLAWQy37Cw5H1zn1s0
         JHUjRzQhVl+Y2vhLeK/dpqnH3K3qV2ClzIVkd+L7IqSnzgMQPJVy2/Cp8wJjI9ikM0vw
         Cv5cnBACN6BAILIMGqOniht02ZX3wAS2bPUgAv00jsNBHTSrXi3vla9ezvxQ1vRuTh4B
         HPzWY3uiJcU+futmqKNSGcnKN54yiFjM4FKtxGuWIUHy4O+2XTp8bIEPIbVDu3bKMP7E
         xmeg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa+h4TFdhF846MJlpg43J6+UZzofWrJ3GZf3m4i9V/bE90GKoOt82iE6py8ulCZOnQ6bf5jBcv7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB93GgHM08B86L0ysBUctwhYp5Oicd/AXxxgNBci2CKnBRUFjm
	3RVK4qe0MTqjM2aSNQEtYpU+0gIhSFZ0y5r2wXYVliPT5/8xSgxtRTPT
X-Gm-Gg: AfdE7cnw/Nlv/QXdA4oFiGg5nTDGN0/KdAAkZVNa+bytqmRKeRVAYYT398LwPT4Ixa6
	gKFzTpMcToD9muHjQWrfBshCb3woDeGgNQbJraLbJ4upG3xxAxJjsEHdildk/rqggqOlsDMNchA
	uNXnw9Pyq9ezlCqIhIvoUio5i4bvNy2G19JcZ6+E8eY5NRcEh9AcyvnMwyn34zLWNVhfk4EHSTG
	ZI2H8q16rcW57+F1wkJoZFpH1gkB3evZiTRvse4+CjIBVMIRPasboBEypG6WLmUvbRRCbiqVYnE
	YtXqjNcXC8f9xsh2WOnYDUlUzxlWbnIfDZeo/7UyT/PPb14Uor7iqCBKKiBQAToWwq9xiaE/J1A
	ahaExEI/RePgfUCCTxDXNZVdQbEs8T03+7BQuom8sloyNC5tXvcLSeo4P8F+HhCNlKa14Tzp49b
	n3mPdY
X-Received: by 2002:a05:6000:606:b0:460:e0f:8d19 with SMTP id ffacd0b85a97d-4656d643cbfmr16475957f8f.9.1782120338802;
        Mon, 22 Jun 2026 02:25:38 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57b8asm25223370f8f.26.2026.06.22.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:25:38 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:26:41 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajj8AhN1YC3uvuLb@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>

On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > >
> > > > > Advertise the source and destination bus widths through the new
> > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > be removed once all users are converted.
> > > > >
> > > > > While at it, give the channel width members their proper
> > > > > enum dma_slave_buswidth type.
> > > > >
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > >         struct list_head active_descs;
> > > > >         enum dma_transfer_direction direction;
> > > > >
> > > > > -       unsigned int src_width;
> > > > > -       unsigned int dest_width;
> > > > > +       enum dma_slave_buswidth src_width;
> > > > > +       enum dma_slave_buswidth dest_width;
> > > > >         unsigned int src_type;
> > > > >         unsigned int dest_type;
> > > > >
> > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > >         dma_dev->dev = &pdev->dev;
> > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > >
> > > > This patch is okay.  I think most system only set one width once, do we
> > > > really need pass down arrary.
> > >
> > > I think so. See:
> > >
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > >
> > > And likely there are more. To fully support all widths I'm not seeing
> > > any other obvious way.
> >
> > I need more time to understand why need src_addr_width, which looks like
> > address alignmenet requirment.
> >
> > If it is address alginment requirement, only need lowest one, like suport
> > byte, must be support other alignments.
> >
> > if it is total address space, which should be controller by dma-ranges.
> 
> I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> (I think src/dsk_bus_width is more reasonable). because the name is the
> same as dma_slave_cfg, it is easy to cause confuse.

No complains for the new naming. If everyone agrees on that, I'm fine.

> 
> So far, still have not seen user case, which more than 8byte for cap.

On the consumer side the IIO dmaengine will use more than that (we have
designs for that - that's how I found the issue). But yeah, it just uses the
min value (it is just that dma-axi-dmac only sets one).

> 
> Add it should only set min value should be enougth, if update only user
> sound/core/pcm_dmaegine.c
> 

Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
And IIRC, this ends up being configurable from userspace so we might
really want all the available options.

Hence, given that we do need more than 32bytes and some users (seems
like 1 only) do look for more than the minimum width, I would say the
array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
complicated at all so I would just not risk it.

(we can also have one liner helpers for the case where only width is
set).

- Nuno Sá

> 
> >
> > Frank
> >
> > >
> > > - Nuno Sá
> > > >
> > > > Frank
> > > >
> > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > >
> > > > > --
> > > > > 2.54.0
> > > > >
> > > > >
