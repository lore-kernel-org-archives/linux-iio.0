Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31E3AEB39
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134092; cv=none; b=r4PJXGeb4y19aHjNqdPqP5NSHoVakn6g8Dg9cm1KaTxNEpeBRS2gt3RbfhQ/Ond8FZGMxhjBdsI6pUrepa8vHUqFn80qVr7IJWXN2UGt0mv6S6PQH0KOj3wUvyRq9TSuOvG/SGsHMoeL7QZ5Jv6Alqn2A9H4xvmuvbeYtiuWJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134092; c=relaxed/simple;
	bh=MiqYTUUKZ4s50r23PUmYCXguj6euConASaR2QHwnfS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyuPZQ0MH72ziKYx27MmJSzq+EO3dGH49qF+5eBIMNSNsuJPtlozQopVzv/WcHhxI060Zt5K6dxoy9hyu0AkE6pG5c4E0u+hMQQZeixVsdME9xOfpdiVdD0c5biV24r0vEcTfreHGsel9qWsPEvjDUSKhjpP6wZ6UbYzYimxbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpUE6m6K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpUE6m6K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49258ac7294so2696675e9.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782134088; x=1782738888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+q8fGHiiz6UE9tgA3SyIJs4m0VfOg89EkuI9d8DFfc=;
        b=RpUE6m6K76urDO4q6XunKBN6iOeBpKcXZ5LTJV+OJPXOnFCc1IH4o/mfMie7eNVZHH
         gfYPbfUnC1LoB9tUt9cc/8v2LNgRM0xbJK9f+hZENguXoToglbbxbgq5ZZdsjt6/V649
         w4xc19fQ4sYz9VGyF3sOqMD8TAe9WVjs7H2sVOtqyGlnGR6VrJR5wHTyrRxtJhahaHO6
         8Y116gwiTEfFa2MADKjmZ4SjORkqYApkfdoEa2l9y3hNgZM/4/C0Fay+vGljQIVKfxaW
         qqli/FnoTlso9R1sPZiEtVCdo1Wzmp6xUg8D6zUwSvdkoTteHKX6OdUQxtFO8va/E4iw
         kP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134088; x=1782738888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+q8fGHiiz6UE9tgA3SyIJs4m0VfOg89EkuI9d8DFfc=;
        b=QNY2jeLKgwTPl24WRjJ9c8GelF6IICbQQVgb4Wy9BdqOAVEZdtWl9/7B/n5heqdGak
         WAoaHpG2jTL3RPWInNmZ9VoOvu027ftrGyON77H5Ws8rCW8iozTrCW0TBylArxKk7aNA
         KW0JgZDk3oHNc7dJYVPo+T+mfe7xehTsCnNMGdpz9Fhh6AUEC/OMyISsUQPjHDgrzkCN
         ccPvqw1OuFMxJkgT7Z9YB5Q2g+jNXRwv6ts5gfae0kgBkzes6nBso4kw7LKapcBWGOWt
         xccYUd27ujjCweU+9GXLBUhnhajEQF5ityHydha8HXKWps9tsHO2vQxcqc6G5wbp/MOM
         KGbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Yxu+xErTBldcWcfTI61ZiuntiPXScPL1oN3d05WEpZ8FGCkOC4lSFPAyNsAoDF8p5r4XSAPl+ymE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOvZxe00jTT94dmunYIh7evqlAoUVXnIqGtU14cFyh9NVPYI0
	PgoAd+Db7v7ZpsFsCWL8z3eC/s8IUDQhBWIafsaeeGC1PT58zmG51P8B
X-Gm-Gg: AfdE7cn6SdcZHi+g3NNsb8C3Gvd2jvJC/1YpvnFYutf3N6P7gDrgErWU785/r0yubJz
	Vb1/avQPlZ1sbH4SRtbMH386FUcl8R9RKM1Bv1zBlZUPU2wLntpj1DCKnsNL0rTJ3YbvTbnzk0Z
	yetjFYyK+GCkBw/+EMTU8z/G0gk8QoJ+hnTMuOJsJOMLSN+ivNXvnziDe5L0duCUzvxy1fbQijh
	97Y6GS7JwtBog0wQBwvTmWFuIxhur6BFrldjmL9wo94UmQEQq9MVmvcBBMmYWp7wSmiw6yKVrT5
	ZWd84cCF7HSRQjx1Ss6uQx4Lv+ON29i2KLZapw/nptHNtO3gSLVDBrMMCzH7KK5rGUaPM0XeVix
	jIr/AKB1Ppg6RdGpf50qC0ebYhIAToacuQf816YmrW35i4MDQbxQFRDCgbyEcrw/eNEsHEmz6YI
	FgfvTP
X-Received: by 2002:a05:600d:6451:20b0:492:25a0:1730 with SMTP id 5b1f17b1804b1-49240ea820bmr183786325e9.32.1782134088047;
        Mon, 22 Jun 2026 06:14:48 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15470sm340432535e9.2.2026.06.22.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:14:47 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:15:50 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <ajk1FX-d_KoW14f-@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>
 <ai-0CIqteaSJJkau@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ai-0CIqteaSJJkau@nsa>

On Mon, Jun 15, 2026 at 09:21:02AM +0100, Nuno Sá wrote:
> On Sat, Jun 13, 2026 at 11:33:36AM -0500, David Lechner wrote:
> > On 6/11/26 10:28 AM, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > > replaying the descriptor.
> > 
> > Is this for both directions (e.g ADCs and DACs) or only one?
> 
> We just have usecases of TX buffers. IIRC, there should be some
> validation (some layers above in the call chain) not allowing cyclic RX.
> > 
> > > 
> > > Skip installing the completion callback for cyclic blocks. Since the
> > > transfer is continuously replayed, the callback would fire on every
> > > period, throwing off the block refcount.
> > > 
> > > Because nothing prevents a new cyclic transfer from replacing an
> > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > > correctly terminates the active transfer before loading the new
> > > descriptor.
> > 
> > Is there more to come after this to actually make use of it? Or is there
> > a way to use this with DMABUF from userspace already?
> 
> Yes. One can do TX cyclic DMA transfer today. Some waveforms examples:
> 
> https://github.com/analogdevicesinc/iio-oscilloscope/tree/main/waveforms
> 
> For normal non cyclic transfers, libiio also handles DMABUF just fine.
> Best way to use it is with USB where we support zero copy between IIO
> and the USB stack.

Jonathan,

It seems there's not much activity on this one. What do you think about
the changes?

David, from you silence either you forgot about it or I guess you
are happy with the reply :)

Just trying to move this one forward

- Nuno Sá

> 
> > 
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > > There's one subtle choice in here. Given that the termination callback
> > > is not set. We will never give the block refcount. That means cyclic
> > > blocks are only completely freed when we disable the buffer and
> > > iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> > > as it makes it more simple to handle. I also think this a fair
> > > expectation from a cyclic transfer. We set it up and let it run until we
> > > disable the buffer.
> > 
> > Makes sense.
> > 
> > > 
> > > Alternatively, we can give in the refcount as soon as we give the block
> > > to the DMA layer with dma_async_issue_pending(). But we also need to
> > > make sure that the block is not added to the dmaengine_buffer->active list.
> > > As said, I feel that the current approach is just simpler.
> > > ---
> > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > index 98acce909854..4a78cd3e7c7d 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > >  		dma_dir = DMA_MEM_TO_DEV;
> > >  
> > >  	if (block->sg_table) {
> > > +		unsigned long flags;
> > > +
> > >  		sgl = block->sg_table->sgl;
> > >  		nents = sg_nents_for_len(sgl, block->bytes_used);
> > >  		if (nents < 0)
> > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > >  			sgl = sg_next(sgl);
> > >  		}
> > >  
> > > +		if (block->cyclic)
> > > +			flags = DMA_PREP_REPEAT;
> > > +		else
> > > +			flags = DMA_PREP_INTERRUPT;
> > > +
> > > +		/*
> > > +		 * There's nothing preventing a cyclic transfer to replace an active
> > > +		 * cyclic one. So always set the EOT flag.
> > 
> > What about the non-cyclic case?
> 
> Non cyclic will also have DMA_PREP_LOAD_EOT which should stop an ongoing
> cyclic transfer. If there's an active, non cyclic, it's business as
> usual. The transfer get's queued and will fire after the current one
> ends. IOW, DMA_PREP_LOAD_EOT is only meaningful for active cyclic
> transfers (it's ignored for non-cyclic)
> 
> - Nuno Sá
> 
> > 
> > > +		 */
> > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > >  							 vecs, nents, dma_dir,
> > > -							 DMA_PREP_INTERRUPT);
> > > +							 flags | DMA_PREP_LOAD_EOT);
> > >  		kfree(vecs);
> > >  	} else {
> > >  		max_size = min(block->size, dmaengine_buffer->max_size);
> > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > >  	if (!desc)
> > >  		return -ENOMEM;
> > >  
> > > -	desc->callback_result = iio_dmaengine_buffer_block_done;
> > > -	desc->callback_param = block;
> > > +	if (!block->cyclic) {
> > > +		desc->callback_result = iio_dmaengine_buffer_block_done;
> > > +		desc->callback_param = block;
> > > +	}
> > >  
> > >  	cookie = dmaengine_submit(desc);
> > >  	if (dma_submit_error(cookie))
> > > 
> > > ---
> > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > --
> > > 
> > > Thanks!
> > > - Nuno Sá
> > > 
> > > 
> > 
