Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235833CB2FE
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144491; cv=none; b=Cw60ctMSGQGU8tB6egaSKMbOekuu/l5OhYh87QsP3qIcOrLzbTNk2wswt9cBEClr2b9L//be7Nx5wFiLHs5tVSReArje42/yShJ3cSvzPHphkwv/3ITaBj+6OCW6nFmdXWHY6kWVn41yNU2LILaSJ15uZnYs2p3zET3yqyymHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144491; c=relaxed/simple;
	bh=+Z42n4sPEF8dj/woNtdKHiuqgmf0U8tPl9HjTO8xyXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb2e8ZcrP7XDzt460e1IawB4I8ajDZx4jOAdc+shSVngV2ipdiKPXvZtrfM/vRrF4gA0kbzJ43KYauC+xpY7Ocd5lDY7+Hkd3t4y9LNLB1gdS3N5uT6yz4jwyt37TT/MwqtVxe6aEaw8aHWmx3iIw/b7LNtAw8NS6ocsf8siIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKLP0HeD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKLP0HeD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4631679f204so28519f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782144488; x=1782749288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iynV+owccXcnhPh1zvFcKuTEzPHPpzhPdIZVhwn2Hhg=;
        b=qKLP0HeDapG9bCSBeASIPNZ2wLEIL8ViYKfDQ2CcBUuWy5IJJm8fcs5eM/hKUj3fMs
         2SevZCvZ4N6QX+PzlRJlFvR4HTgM2Ui/V9bATPr/DdwfOQSq9ZQdDiYgk7uEletjIlMv
         bO7X9jWBISAFqXdw0FMXdCa/Dtzw1aUcDE+r+EUsN7hQyVE4PWXmfjG4liOpC5b6eQyg
         xquQAQjjUSA5Qj4LcdmVjxVzItfXQ9P4gI6KqPEwCwc4M/7ymfU9TE2gEptdR31g9svv
         HWHCBn0MxfvtqkkfI4I6OuJndrOCTEA3EYb4cThPgY7v3GbI4jQzs3AfQNSnqbeVTdym
         0z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144488; x=1782749288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iynV+owccXcnhPh1zvFcKuTEzPHPpzhPdIZVhwn2Hhg=;
        b=JiZkgtnb5USAVV6a8xGn5gtNyIoEVkD+QqpYSHC5w3xcKjoVRL/EYoaCfIHYe0+rgW
         81XTcg3mPxeY/H9JkaIHvSe+cZPgmNYMVfE/lFaD43oo13XBBJQ/9nDzjIWa2kWsATLJ
         W3ygl2lufPJEHN3eVSskcw33QhxKJrQTZQBvXhK/TAxHLsFoGtxEp/QBGUnFwQseUCKB
         prGJcLTEotQn+/kyshaOAmWmpNlZpIme5noH2Xj9aEUBu1huylT7llp63VbLeRhWxEGB
         KT5czO75eeSC3XH2AK6wFQ+FweZ9uG5xTt1WQjz5vE5BFHBuEa8ngZIiJEiEv/5pVbZz
         Pk0A==
X-Forwarded-Encrypted: i=1; AHgh+RpOODzf24RGmLk9cpxDqny9JiZ6Tb370vtOeVsHwZgtKoIp1gVAABE/N2ZFfeW80XI/2qiCUMI2ZRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gtyQEChvJIVY+dUW7eJ00+h4JtZvpYSPjsrZMykYc5yH/EPl
	3oHP5NTmfpyW6E9dTgiLf/EOGZ3YRu4zHGeRtaq0ysMC1WIM7qJvpCgu
X-Gm-Gg: AfdE7cn3nWJQ8Zn2+tpi6kQ6dliR6waeSK7pc78Cwh3mIOVU0RP3vZFBxIJWLGf1p3T
	v/uaftmwYLriFJKETgp+UhEteJq78MjY+rgjEo3nj53bDVXhwEk66Vn+cAbJDliDhGG40gUFqyz
	MdUR+yz45BxgVftxfFoappEHFIhHAXCTNjNQNIXkaXqyQKmHHwJcFIa+gsnbmG1r5VN9zo6bYhd
	fDKQnbYPHxQHOeXIRNWUIhvg9/Go15HYAnH/lRRkn2NxVnxyRXWVNN7L5LJjiUinoIuj09JQqg2
	h+qNLyaKN+khWgdGRIc67peW8yc3yE/sMuIvKKYZqA1eW4kzkC9gXzbq8pyAIjo7h7znLRldegQ
	AzY2CZx9+XJZKxVi1arqr+sWZo9mE7zcGJSa7KeIjQGQlKJKgQQuDoox3AkXQDi9MGKxvzKy2Kd
	UxzKDy
X-Received: by 2002:a5d:5f8e:0:b0:465:74f9:6a7 with SMTP id ffacd0b85a97d-46a7efb738emr214064f8f.9.1782144488134;
        Mon, 22 Jun 2026 09:08:08 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e3esm26187416f8f.8.2026.06.22.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:08:07 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:09:10 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajlR9QiXiBAH4mWH@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajlMAijTUHsnOhEQ@SMW015318>

On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > > >
> > > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > > >
> > > > > > > Advertise the source and destination bus widths through the new
> > > > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > > > be removed once all users are converted.
> > > > > > >
> > > > > > > While at it, give the channel width members their proper
> > > > > > > enum dma_slave_buswidth type.
> > > > > > >
> > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > ---
> > > > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > > > >         struct list_head active_descs;
> > > > > > >         enum dma_transfer_direction direction;
> > > > > > >
> > > > > > > -       unsigned int src_width;
> > > > > > > -       unsigned int dest_width;
> > > > > > > +       enum dma_slave_buswidth src_width;
> > > > > > > +       enum dma_slave_buswidth dest_width;
> > > > > > >         unsigned int src_type;
> > > > > > >         unsigned int dest_type;
> > > > > > >
> > > > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > > > >         dma_dev->dev = &pdev->dev;
> > > > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > > > +       if (ret)
> > > > > > > +               return ret;
> > > > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > > > +       if (ret)
> > > > > > > +               return ret;
> > > > > >
> > > > > >
> > > > > > This patch is okay.  I think most system only set one width once, do we
> > > > > > really need pass down arrary.
> > > > >
> > > > > I think so. See:
> > > > >
> > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > > > >
> > > > > And likely there are more. To fully support all widths I'm not seeing
> > > > > any other obvious way.
> > > >
> > > > I need more time to understand why need src_addr_width, which looks like
> > > > address alignmenet requirment.
> > > >
> > > > If it is address alginment requirement, only need lowest one, like suport
> > > > byte, must be support other alignments.
> > > >
> > > > if it is total address space, which should be controller by dma-ranges.
> > >
> > > I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> > > (I think src/dsk_bus_width is more reasonable). because the name is the
> > > same as dma_slave_cfg, it is easy to cause confuse.
> >
> > No complains for the new naming. If everyone agrees on that, I'm fine.
> >
> > >
> > > So far, still have not seen user case, which more than 8byte for cap.
> >
> > On the consumer side the IIO dmaengine will use more than that (we have
> > designs for that - that's how I found the issue). But yeah, it just uses the
> > min value (it is just that dma-axi-dmac only sets one).
> >
> > >
> > > Add it should only set min value should be enougth, if update only user
> > > sound/core/pcm_dmaegine.c
> > >
> >
> > Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
> > And IIRC, this ends up being configurable from userspace so we might
> > really want all the available options.
> >
> > Hence, given that we do need more than 32bytes and some users (seems
> > like 1 only) do look for more than the minimum width,
> 
> If FIFO space require 32bytes data bus width,  4Bytes DMA engine should be
> match requirmment, cap just help filter dma channel.

I'm not sure I'm getting your point but on dma caps, the src/dst addr
widths is a mask. So for 32bytes widths, we need to set bit 32 (which
currently is an open path for undefined behavior)
> 
> each transfer, dma_slave_cfg should set specific bus width requirement.
> 
> If memory have requirement for 32bytes, typical cache line length for
> hardwaer coherence transfer, it should use dmaengine_alignment.
> 
> So I think only need set min value should be enough if fix pcm_dmaegine.c.
> 

What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
there... The code seems to use the dma bus width to match against PCM
formats supported and filter only the ones we can support (per dma cap).
If we only set the min, that means the PCM code all of the sudden only
supports one format and I'm not sure that should be always the case or
that we won't break any user.

I mean the dmaengine src/dst_addr_widths must be a mask for a reason,
no?

- Nuno Sá

> Frank
> 
> > I would say the
> > array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> > complicated at all so I would just not risk it.
> 
> 
> 
> >
> > (we can also have one liner helpers for the case where only width is
> > set).
> >
> > - Nuno Sá
> >
> > >
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > - Nuno Sá
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > > > >
> > > > > > > --
> > > > > > > 2.54.0
> > > > > > >
> > > > > > >
