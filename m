Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7D4052DB
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760449; cv=none; b=cHACTKgsNpjf0EpAIXSjA7csIsL2dIjdfQfxa/otI9p9D0BtSIsT9i3uoDMOOsYDP8AQuPwaDRxYs6jhDN5CFEPwvD8YOtOIkmB/gSliM0NNC56UzS0xQkvRk4YBg/J+WUI546/S9+wsrrmS2NE82iAQNI9uIh64R9J0Gv8A64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760449; c=relaxed/simple;
	bh=AXct+peyhGQRc2kaBjGP1yN0sVFdplmAYVc/6HFqGmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXdbj5K0Csu53v7dZ8wPxCJ52SGxZpFfl6+uzDEYw7AsHQyPXVxCzqI9nV9To+IK+C1+O/e5WQVZYQaLcrKDrU5yoyZfj7kWLR7E/nLE7BbDFufdh/xSpr9HxaAq6rDfWY6mJSfexthPiMOUFfCsxboRFSrtPrl10WC3T0bpj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l31AYpsZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l31AYpsZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49800c6a846so17743345e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785760446; x=1786365246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WqscRAKEYBt39skofdEcGtg2VLcJdEYES+naCN0pIA=;
        b=l31AYpsZ/s0Nu5DXh2RzkOmGJhuy3lHKGRnF9JCBmckM/YFqSIbU16GZT70ySInYwN
         SjK+Ideerp1pR4G7hYxCQmqtKIXiVRtvOOgQREdewNPi6mrRlOX5PNZYZRPRVRVSacB1
         3P9cQH4joYSHPoxmfxRFUIzK+Hwh8Y88Q23BlwKy4IjhGAVsGoGlDJ88p+HWrwKSkBMu
         QYECWlPny4WR07c+6tq8SAyynDZXwl9/kixmAl0slUx7rQKeRYVn0z8GTXnw1Cy1eZ3g
         8FdV7R2j6NSQlCNn3OmtJuBVM+rj+eIHlYnBwGgP76JYu8in3ogqbBD2NsA9H6Alv5JF
         JDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785760446; x=1786365246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9WqscRAKEYBt39skofdEcGtg2VLcJdEYES+naCN0pIA=;
        b=s1QuxcCeZRGPqV1JYmCItlTqKZUEyKbZBHRaLmWD9iWpWeeeeFk/8HHIhKDCMYPqAc
         zeIrhMSlblM1m732l0XwX7iHJo28DqxMC/WM1gyvgTl79CKjm8b+8bra5XVzyPMyioE3
         LglWv+TgoTZm2mfsIKdVZ38wEtBPJOmTH3EVRVkDTccAbZjkwIoPfx1REFX8ZlCmW0M4
         y6aBXOotiZ9xnaf55Funwi4a4aGi9Rh5hGBvCk8QAsl68KGctGTlQxQu+iZRJKwWHLTG
         mScCCHYVwIvSKXn91tNC/J8Xw+LwnGjjiLtdDEPlneVVVXUeAXqnF7+uDh1+rAAP0PQh
         QOsg==
X-Forwarded-Encrypted: i=1; AHgh+RoPxRWBxWyKXyvna3elAW0VYPJhKr+1e8U/kS7NL7xvT9Tcr9JxQFezZR9t6Ihc0b5mWUVW57V53s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPuvVcaJPzY+nzxP5wwhnNo9e3WzV2SCbLScki6MjOo4LQMCI
	QB3FD/IHhW6vdDE7r58T3Q6BzpVQI73douJnoA9kISdsDw1BHNs0Mo1M
X-Gm-Gg: AR+sD11y6jEJSG3x1IYbJkw9nu6qYyfmBAyVnWD6NsCuqBLrTefLcG8UxnXlRgEjMUL
	U4ulriLdTt8LgaaiFmbIFaQ7BESNguAT2r7PKe2Q72+t8ibAer+jUnZKMWapHms+bNTUE5DWuRc
	7GkVbrLVBsyR7DRWIGFRyGanTy7Na5ggrK5w1GACdZqFk6QoD3R3+xRGNZ4z6E0JhdrvWEyEGZI
	OAMNIL8lG5ZYYtTbkTmuUGvqBWZssKquOLGy0mC/VafRKim6S3bOlUMif3tel7t0u8RXyDRPVdl
	A/3crwbd+gMv38ngr9MbT2jT5LlZro0czY7JG9qUlaXg+2sQrM2d6tYF+ZYcbt9Q+19aAVXy/vU
	28FCkKb03abw8kPe2zQqk828tepBmpkC43ZaYLce4lpFWmdrNk6vCwNBMoSVUkuwTx3yDNFmcr5
	fuE5bfW4KOKRQPlkLtx4G4yjzcNJxxTy358apqYmCuulM7mGClkUXB
X-Received: by 2002:a05:600c:e48a:b0:493:c337:db0e with SMTP id 5b1f17b1804b1-4980c69628fmr149527095e9.18.1785760446196;
        Mon, 03 Aug 2026 05:34:06 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b59a33sm228843055e9.1.2026.08.03.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:34:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 13:35:15 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>, nuno.sa@analog.com, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <anCJ_mM_eygMn9ho@nsa>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-1-3732f1f9d9ca@analog.com>
 <amujDsVXJQ8gaCvw@SMW015318>
 <20260801034222.45d4d479@jic23-huawei>
 <20260801034617.5dab3286@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260801034617.5dab3286@jic23-huawei>

On Sat, Aug 01, 2026 at 03:46:17AM +0100, Jonathan Cameron wrote:
> On Sat, 1 Aug 2026 03:42:22 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 30 Jul 2026 14:16:30 -0500
> > Frank Li <Frank.li@oss.nxp.com> wrote:
> > 
> > > On Thu, Jul 30, 2026 at 03:23:08PM +0100, Nuno Sá via B4 Relay wrote:  
> > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > >
> > > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > > supported width as a bit whose position equals the corresponding
> > > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > > be represented at all.
> > > >
> > > > Introduce bitmap-based bus width capabilities that span the full enum
> > > > range. To allow DMA controller producers to be converted incrementally,
> > > > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > > > producers using the new helpers populate the bitmap and mirror the low
> > > > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > > > legacy-only producer's u32 into the returned bitmap.
> > > >
> > > > Add helpers for producers and consumers so users do not need to depend
> > > > on the bitmap layout directly. Once the remaining producers are
> > > > converted, the legacy dma_device u32 fields can be dropped.
> > > >
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---    
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>  
> > https://sashiko.dev/#/patchset/20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca%40analog.com 
> > has a comment on this that smells plausible at least.
> > Looks like the stm32 driver modifies dst_bus_widths in it's device_caps()
> > callback.
> Reading on, you fix it later in series.
> 
> This is going to break bisection on that device, but not build
> so I guess maybe fair enough to do it in this sequence.

This is a bit tricky (with trying to keep things compatible throughout
the transition). But I think it should be fine because the current patch
keeps (or at least tries) the old addr_masks and even we then update the
stm controller we also act on both the new and old variables (so
consumers still work).

- Nuno Sá

> 
> J
> > 
> > Jonathan
> > 
> 
