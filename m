Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD05343D7F
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802594; cv=none; b=h3jQ3KRl1qMnBp15kd1NoJWd1tRCgnbQLynPZibHUt5tNwYzQsGZnpos+aqOL7ZJ61vz4l1SzDLXllrPnuyW62WbiZti4J/CTB3h3Z9+WDfW+jyF8dVGPPUv1lkQUQclGQXRftDkRzrrBiPpv5XnAuL8bEv6VcYkIJTJbtIBftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802594; c=relaxed/simple;
	bh=ek1Rt+RCKFx1ZAENatPdrTmZhOVWSxe+TUDrReqCslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snBndYgJKtZ1ef7ykSWFu9Bu6oKf0/+wU4XZJMSbeTlunAwoEae9XF7xN2Ag8ARDL8ETm+nVotsz7TAWOURDDuLbej3e/tA7Nzi3uOHm8pLaCR9ZM6j0yBWMK0pzyLyadZ+Yb93vb4zW0t9P0/rwt7F+oGNo1bg22hLBMGRylSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTF8u9QR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTF8u9QR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8636445e9.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781802591; x=1782407391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pb6ELezZamFIkjKnVRa59Yjxr/sCCIOAAtSuv8gn1wU=;
        b=DTF8u9QRWt0bafU4I/kvxlEJn8P425OJmfYbnHsDt2e6rNF1FxFN/eFZojYeEU3Vwd
         0kuRMoxT93tCujJBZgOYCi9pVii7NqtudAllomOuorGnvVVtVzYwcP++CVid0MEnhTcj
         dMB+uLpEkH4Zlj1kBdUhGjkFWgZVCwsUgDLVPLnXPeDzS+l+zetkWHQnF0+9nyB9hCF5
         FCNeD3tQidY3ICSdGrmpF2DeOuUDQ2bzfAF6fazb3n/IYX53I9X+lgsEXgHJkar0FLlA
         tAgoHd2rK63HIp4sIUB8b6IVEqUGhKXaJLdijEpFgkyNo0MIOLyog2pdb2Q80ynNqP/J
         D8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802591; x=1782407391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb6ELezZamFIkjKnVRa59Yjxr/sCCIOAAtSuv8gn1wU=;
        b=COxqkb/YJZjJfnGB0kw8nfP0nYCompU6IT7yhgdL8hiFl0kGwepTxQE7KKXsn/fRwP
         jfp9Y3FZK/XbPOKpkNm4g3widkfLAVfmQ5qyGWq41mcoaNcVZ+ABYlKJNhkeTJjG4qLo
         +Q8eqZ8Z2JdBCwwHEsLx3jD9CF4C36eVZyBCpliZyi5U7xBDPlyPDIxHl7qNZx6mkWae
         YvU9g7kmO5G4A7bRPo+oFZHCaO/ChzFVcixORaTKkzk/kMn2K7UdL6r9o1YMdjcM0I6/
         qbcgHdEAjlfPT0Cn6Olj5llE5MvrLKE1EOtzcEkH/8yuWw1X95eSPAOf0sN4la8C5s+v
         xd6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/josydk9UwZNP8ouFwqd2iE5Of/njc6qhlkmLlU9A1HgZ6PYlfFYWJdAnZY6evkez7IbEkR1WBKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqL/nTxu4Eu8sZa/8Jr3yIfZOcaBkQPcVDjQBerF5kqFSn1Mg3
	l0O5F/LCjRWY8imL9XLbCqPaOP8SrACqRiilcylFHSHYbdcrx1FGnGR5
X-Gm-Gg: AfdE7cmztY/941CmEEJBF/gmYlLr7Qi1lxraMUwLbr88RS87nfZdHiLT8NdFlusJMDB
	FjfbgeqW3qg7ZK4MZpsRdzeiwNAfAAdHiMR6FERaWE2bB5mHWQDzzdGIN0Zf7JPOwEBbCnrdh7+
	o3TRnk8fuUUUG4n7SvSapQVYRrGEoNRkSQA2zrja/7mNxC7YGmo3uAZbPev7FZ0OO7rVTsmoy5d
	vECG9VU+VJju4k15ybCyyCfCML8yoSh8LH2KvVm2+HhKmq9AT83AcTB+fX7/U3BQEcBNy62FTJi
	KDdHaWutbeZ1zQVAh+DjoMl+vAVJKwfDvVTtXRaHav+q2zXvEk97sO0mBBcZXQfY5HeamgG4vLi
	4mgbFk9WYCVHba/iGqcqnPD0o36fw0t/giapGJ13C3CI/6IQH/JNDgRMMqb7Lj5TA9ge1b2nymi
	rSZfGX
X-Received: by 2002:a05:600c:828a:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-4923f56c180mr7690965e9.22.1781802590913;
        Thu, 18 Jun 2026 10:09:50 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc422c0sm233910f8f.26.2026.06.18.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:09:50 -0700 (PDT)
Date: Thu, 18 Jun 2026 18:10:52 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajQkupPzv8-GdEjv@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajF4i3o0gNRtUelb@SMW015318>

On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Nuno Sá <nuno.sa@analog.com>
> >
> > Advertise the source and destination bus widths through the new
> > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > BIT() mask. This moves the driver onto the representation that can
> > express widths of 32 bytes and above and allows the legacy u32 field to
> > be removed once all users are converted.
> >
> > While at it, give the channel width members their proper
> > enum dma_slave_buswidth type.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index d47ff27e1408..19c258d511ca 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> >         struct list_head active_descs;
> >         enum dma_transfer_direction direction;
> >
> > -       unsigned int src_width;
> > -       unsigned int dest_width;
> > +       enum dma_slave_buswidth src_width;
> > +       enum dma_slave_buswidth dest_width;
> >         unsigned int src_type;
> >         unsigned int dest_type;
> >
> > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> >         dma_dev->device_synchronize = axi_dmac_synchronize;
> >         dma_dev->dev = &pdev->dev;
> > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > +       if (ret)
> > +               return ret;
> > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > +       if (ret)
> > +               return ret;
> 
> 
> This patch is okay.  I think most system only set one width once, do we
> really need pass down arrary.

I think so. See:

https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475

And likely there are more. To fully support all widths I'm not seeing
any other obvious way.

- Nuno Sá
> 
> Frank
> 
> >         dma_dev->directions = BIT(dmac->chan.direction);
> >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> >
> > --
> > 2.54.0
> >
> >
