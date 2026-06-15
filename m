Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AD3BED18
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511604; cv=none; b=UNlJSyv0YN/YH8qIGX+ytrT6P2IgJiDG6KyGfCxFPMfUFJbezXteIVzgFsNUJHZZ6nZQWChjPgyhPUUDF253lQhRqb5Gli89ls/ysZRbf4YMMINjK2ScQTMXrDhEZZOsxKbgrJQX6TMBwtjhSrsyBnn7/LFe45HVyy6IId71kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511604; c=relaxed/simple;
	bh=Q86Wzk75gW2P/mN7uuN2BBu66cRHEnEq9mwHLBNaJ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1nQ8R0X3RU1P4ROXBeKl47ixS+ppbXTnpZnRLIiw+6odX+D0aIiEBHwYIHEwXNXuYs6ty7uXhSdPSctPMRmJfo0CHwK55FXzSVw6hCTrHZSVem2dUe7Rm+aMARl6xO18xFJXqcE5x4EkCO4VygU0ra2Z6ZgS04rfAjjHAqQ8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBR315TL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBR315TL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so20425365e9.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781511602; x=1782116402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lHpC/SarvVqcjmPBVY+jd+EhSBNnMZMCtjPmb3/U1Y=;
        b=RBR315TLFwQS2xKGkwdUT5VZuXV8nPJ7HO3hdysJQltb+hV7KoRZoLcSPGbSoZPN3i
         XrKlaNJVgZ1NOE8lXHM92B11GsR0A4f3Nn3xbLBqv7kvxYFZlKYztPWrw6Po1+Pvsh5C
         T7jHTDWbmkMUFjMzcdp0OhJ0BOw77n1tlPP1LWIocEiX+5/1f9nMk7cNtjnE8oVFUiRV
         +GjMpUkaRYjBr5pbEVCYeZJ3qPXx7YETYtntoV4tK8ytlgShKgmGS06jzkcmk6S7ujvG
         cfrr2aV/cd3XDC17vbskOyhqsbhZIozIffJhKCmQaPPJ+91ZyVKoaF0OIEukjUhOL4UP
         usrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781511602; x=1782116402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lHpC/SarvVqcjmPBVY+jd+EhSBNnMZMCtjPmb3/U1Y=;
        b=pDI8oRXPepsAiPtl0hrzzaS5vV3q7wuaQVNI+oV60LLCbxKQ469i2N5wg/ocjhx7pm
         QroefmpeXUiQhP1OusCNkI0ts1GCJxLCwnfn+TmKuOM/OFlUjEUsUP0+MRiP1vzs7kgF
         4dEVeLZBMflW+klU+QrPy17XFY/R7dyI+m2dJ6gp9OEwX/b/+bPtNsW1osNYFwwWa29S
         SBRwN8yEWdRSq0Y4VIq8N9dyJXKr6p2Bcx4bvPZQ2U5isOsFjaZo/vjHGq6NU2HZvf6A
         PhZO8WpJkQu0NV1v8RzFpmZyMgLi86VWoI13sDhwa5mimUVEZrp/KJ6OfhjeQwkU+Sd9
         Fleg==
X-Forwarded-Encrypted: i=1; AFNElJ+RPB/+AAl9TqFlwB+py4hQOSaesEmKaySLWTlvkwjYTbWvpm7JKrCoxv7FJ7KhS9Wvcwrb++wJXUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFSYvEvGQsPWDRPLInDFJwyLwEW7eAxSdwQOD/oXL22qbMwph
	WgeMr+BL3038Wgh4wGJt81NwnyVE9RFqDp3Jznii6ahTKIOOuxp3VXbP
X-Gm-Gg: Acq92OHFOf5OqjIthwq0ba9DZ/ccGvN/G62pNfnj8XANbk9+1VV3zU4ieEIpmXMNyiS
	1vutw09YCDUJcBVnrmbAUZm88/eqcmXIRmTllnEFS6g2RXWGCFBSKiwA2DlLUZXh95Ul/474pu5
	vGH/sNjUiT2IRtQYQ+VGYYoOGIRdYxh3v/IMWi5mOAPECLeP2/GkJG0qgWdkdzXF2THnjrQWy9y
	SJdaY4OudMjfnGmkdJufc5x2mrlwxtNG4yu5bf1LahsHcm1+FKMI4fw7bZ7zmTgZWfI8cfbd5GR
	p4E5aV3DVgh5KU7hukGKsWz359WuvZacgiHAJpaxVrrjLMKVy+9SjwS8aZGKbk1GBjuSpMqOpnU
	NoBkC6x0dnljNEguLKbCHoxfkB5k+jm/J0HFAfIuangv66bYIvEwUaLMWR9g+4M3IqHmo18L3Fp
	RYzkS4R0ITnpin+g==
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr113975605e9.34.1781511601147;
        Mon, 15 Jun 2026 01:20:01 -0700 (PDT)
Received: from nsa ([185.128.9.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b1056sm32717510f8f.18.2026.06.15.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:20:00 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:21:02 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <ai-0CIqteaSJJkau@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>

On Sat, Jun 13, 2026 at 11:33:36AM -0500, David Lechner wrote:
> On 6/11/26 10:28 AM, Nuno Sá via B4 Relay wrote:
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > replaying the descriptor.
> 
> Is this for both directions (e.g ADCs and DACs) or only one?

We just have usecases of TX buffers. IIRC, there should be some
validation (some layers above in the call chain) not allowing cyclic RX.
> 
> > 
> > Skip installing the completion callback for cyclic blocks. Since the
> > transfer is continuously replayed, the callback would fire on every
> > period, throwing off the block refcount.
> > 
> > Because nothing prevents a new cyclic transfer from replacing an
> > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > correctly terminates the active transfer before loading the new
> > descriptor.
> 
> Is there more to come after this to actually make use of it? Or is there
> a way to use this with DMABUF from userspace already?

Yes. One can do TX cyclic DMA transfer today. Some waveforms examples:

https://github.com/analogdevicesinc/iio-oscilloscope/tree/main/waveforms

For normal non cyclic transfers, libiio also handles DMABUF just fine.
Best way to use it is with USB where we support zero copy between IIO
and the USB stack.

> 
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> > There's one subtle choice in here. Given that the termination callback
> > is not set. We will never give the block refcount. That means cyclic
> > blocks are only completely freed when we disable the buffer and
> > iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> > as it makes it more simple to handle. I also think this a fair
> > expectation from a cyclic transfer. We set it up and let it run until we
> > disable the buffer.
> 
> Makes sense.
> 
> > 
> > Alternatively, we can give in the refcount as soon as we give the block
> > to the DMA layer with dma_async_issue_pending(). But we also need to
> > make sure that the block is not added to the dmaengine_buffer->active list.
> > As said, I feel that the current approach is just simpler.
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index 98acce909854..4a78cd3e7c7d 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  		dma_dir = DMA_MEM_TO_DEV;
> >  
> >  	if (block->sg_table) {
> > +		unsigned long flags;
> > +
> >  		sgl = block->sg_table->sgl;
> >  		nents = sg_nents_for_len(sgl, block->bytes_used);
> >  		if (nents < 0)
> > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  			sgl = sg_next(sgl);
> >  		}
> >  
> > +		if (block->cyclic)
> > +			flags = DMA_PREP_REPEAT;
> > +		else
> > +			flags = DMA_PREP_INTERRUPT;
> > +
> > +		/*
> > +		 * There's nothing preventing a cyclic transfer to replace an active
> > +		 * cyclic one. So always set the EOT flag.
> 
> What about the non-cyclic case?

Non cyclic will also have DMA_PREP_LOAD_EOT which should stop an ongoing
cyclic transfer. If there's an active, non cyclic, it's business as
usual. The transfer get's queued and will fire after the current one
ends. IOW, DMA_PREP_LOAD_EOT is only meaningful for active cyclic
transfers (it's ignored for non-cyclic)

- Nuno Sá

> 
> > +		 */
> >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> >  							 vecs, nents, dma_dir,
> > -							 DMA_PREP_INTERRUPT);
> > +							 flags | DMA_PREP_LOAD_EOT);
> >  		kfree(vecs);
> >  	} else {
> >  		max_size = min(block->size, dmaengine_buffer->max_size);
> > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  	if (!desc)
> >  		return -ENOMEM;
> >  
> > -	desc->callback_result = iio_dmaengine_buffer_block_done;
> > -	desc->callback_param = block;
> > +	if (!block->cyclic) {
> > +		desc->callback_result = iio_dmaengine_buffer_block_done;
> > +		desc->callback_param = block;
> > +	}
> >  
> >  	cookie = dmaengine_submit(desc);
> >  	if (dma_submit_error(cookie))
> > 
> > ---
> > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
> > 
> 
