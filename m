Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BB3F44C8
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421437; cv=none; b=gm3rpDSlNqF2U6ng3F3VVTLfZaD1mStkUHD12C3fuGyHMQxxG5MhpTWRmaWt+Flp6PaTqGGIv2foP04Mdo3otXZkwt3tj2S1PiMfsQTJl2scpgJiLZ9czOkVjnL5VOWizNT2MG7HktW5YJRWsYsTLYFBG260fCjR6I0TL7ZmqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421437; c=relaxed/simple;
	bh=6GKVDGt8++Z3SmyeeAfhpQ2m8gNqkXmvXwH8B/1NdqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUVtRcM9vDEZdqwCgMepOAzBC5mCgkTFHj6S8qEFFGECtb7SHhRjF+eRBT6sEES9j0uTKTVkI33C5YJmFijmzOqvld9wW8I4m3ymj+W398F+pm1YIze5nGqoxMZ0z6k+RUOEm6kYvlPzUVDSKTI2ifRiz8SnELhqCcnKoI210is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpuQ212g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpuQ212g"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so43327115e9.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783421433; x=1784026233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lo7IxzVTQLWZAr95D4JR3gA5SqUdthr8XwmLY9ogiMc=;
        b=MpuQ212gYBNHS54n8/Ik2Mn1zzQYqgiiHTs2R8AkJXnjuGT/DH89g70eV0KgcVipTT
         JoWGPUP0ul0ofk4UWRhz78Ejn4Or2gamRx2bd3yDIk1nGg1w0SXmVxCUZ05KTFMa8sSj
         GsJ85LpG9dku9VWflP9doyhPZzXg1BkpdNjdowLWvNy3QtwnUW30PBH7/+DQjE64d3bk
         uPoTBZ/HCBllcFNs85CatZ09FB/eKCcgd0hXKPiKaHr6IY6CN+ZKSMikxoePpU68SNEm
         xUcadHYL5C7DqFrZZV6hIBSD86YBM/0xBIc7HLSsyw9eCk09jXcJRVm8w7v4n/Vo3Yfu
         rSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421433; x=1784026233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lo7IxzVTQLWZAr95D4JR3gA5SqUdthr8XwmLY9ogiMc=;
        b=hXxgb2KAFXh8hhQSqZ64pVDpNFFXqoLd+eBPwuq1wdrA8EoR0N0Gl/wswXoD7lqn5q
         udBCq4AvXxIu6pyQHKCf2Nss1r62cshE98u0zsV2FKJ0vagnuZqFbs92mKra7wqSuC8h
         uEGmgGsgOzM0L+wkYU39g0C1a/1IEBTEuXPeSEZaMvAA7TGeq0rEaP4kD5X9DARTVU0l
         T1X4y1sYCdVmCGrjTELLpk39kfQFIQ4W991UHCN6+b+4JxEsCHwL2es2ETcZbusnLg0R
         o0Kb+XjPnoFlXPRSvvpZqGkZPGM/9VNYti0UIxuGGD0w4HTa7WYLqhNFvY6pRg5NwQfX
         nu4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrNnRo5S5nqVk7huvUAM6HZVJSK1ojukHfiqiVjc+tAvP1kO5LtCNP2lzY7TkGCUe7oFSj6nE9ft+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyY5LlU6yEJyvyGUhchFREX9NSlxwKDpsc6n9sMYY0FM1QfZ3N
	2otIaFOnlpO5nidcHBSAA7RabzasDIFE1sL08mLrUdkL9fiXTPP/2r8M
X-Gm-Gg: AfdE7clg3eTF7tJ20fRuLJC52B5ZVdapS8zTPdau4IUOqQvToQWaxKokRhGrfe1zMKP
	qlhUA4DYW5hxTAnpXocfx5rZkBeN949eg/2drBdmOR9dvtUQ8toLIXMkpm1uXtZNA8h4nW8adY5
	xM0CB4rHBYrr5hcFwVEiuqTHRNydgFAtMgOrL3UGHEcrgoBstr7S+JSTXOAXOtxlvs4nDatrUMO
	FBEgsWJTjcakLiiBDflpJ1/WxkbsO54b5RuRiZTRjPJpi6vPJP+yVt/wwrai2y/wUut9snUX7p6
	htTePDm5v2jVFplys6oR+kMIT715sRLCMqBUL+6AreD94UmKa0/guI2k8cRKAxym/xWXEWS03NP
	8kCLKHoQirab2xC4VWIZfw80XyJ1D8p2G9CQB2DX2YCfrmZg+fM8vbFxMhFmVRz9jLBh4+79rUR
	dgUmFc
X-Received: by 2002:a05:600c:a00a:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-493df038767mr52091965e9.2.1783421432913;
        Tue, 07 Jul 2026 03:50:32 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ab4dd0sm49016845e9.2.2026.07.07.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:50:32 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:51:38 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <akzZKkI_xWGNg4gq@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <20260703195238.271aa219@jic23-huawei>
 <akt6IDED7qwtkM7t@nsa>
 <20260706164719.3e8196ce@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706164719.3e8196ce@jic23-huawei>

On Mon, Jul 06, 2026 at 04:47:19PM +0100, Jonathan Cameron wrote:
> On Mon, 6 Jul 2026 11:07:58 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Fri, Jul 03, 2026 at 07:52:38PM +0100, Jonathan Cameron wrote:
> > > On Thu, 11 Jun 2026 16:28:57 +0100
> > > Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >   
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > > > replaying the descriptor.
> > > > 
> > > > Skip installing the completion callback for cyclic blocks. Since the
> > > > transfer is continuously replayed, the callback would fire on every
> > > > period, throwing off the block refcount.
> > > > 
> > > > Because nothing prevents a new cyclic transfer from replacing an
> > > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > > > correctly terminates the active transfer before loading the new
> > > > descriptor.
> > > >   
> > > I'd like a little more use case stuff in here.  Basically I had
> > > same question David did on when this was useful.  
> > 
> > Alright! I'll re-spin with an improved commit message.
> > 
> > > 
> > > Otherwise, seems fine to me. Sashiko raised a concern about a particular
> > > sequence of blocks being added.  
> > > https://sashiko.dev/#/patchset/20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c%40analog.com
> > > I don't really understand this code well enough to be sure if the issue
> > > is real or not!  
> > 
> > Hmm I mean, for the same block it's not a problem as we return -EBUSY.
> > Now for the below:
> > 
> > "Could an unprivileged user repeatedly attach and enqueue new DMABUFs as
> > cyclic"
> > 
> > Don't think the "unprivileged" part is true but a privileged one could
> > in theory just keep the list growing until we disable the buffer. But
> > this is part of the choice done in the patch note and AFAIU,
> > dmabuf-fences also have this kind of "don't unref me right away"
> > behavior.
> Should we perhaps set a defensive cap given we think this is unreasonable
> behaviour?  So fail to queue a new one if the backlog is 16 long or something
> like that?

I guess we can add that for some piece of mind. In reality I'm not even
aware of any usecase where we enqueue more than one cyclic transfer so a
backlog of 16 should be more than enough! I just allowed one cyclic to
end another one because I don't see any technical reason for not allowing it.

- Nuno Sá

> 
> J
> > 
> > - Nuno Sá
> > 
> > >   
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > > There's one subtle choice in here. Given that the termination callback
> > > > is not set. We will never give the block refcount. That means cyclic
> > > > blocks are only completely freed when we disable the buffer and
> > > > iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> > > > as it makes it more simple to handle. I also think this a fair
> > > > expectation from a cyclic transfer. We set it up and let it run until we
> > > > disable the buffer.  
> > > 
> > > To me that seems fine
> > >   
> > > > 
> > > > Alternatively, we can give in the refcount as soon as we give the block
> > > > to the DMA layer with dma_async_issue_pending(). But we also need to
> > > > make sure that the block is not added to the dmaengine_buffer->active list.
> > > > As said, I feel that the current approach is just simpler.
> > > > ---
> > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > index 98acce909854..4a78cd3e7c7d 100644
> > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  		dma_dir = DMA_MEM_TO_DEV;
> > > >  
> > > >  	if (block->sg_table) {
> > > > +		unsigned long flags;
> > > > +
> > > >  		sgl = block->sg_table->sgl;
> > > >  		nents = sg_nents_for_len(sgl, block->bytes_used);
> > > >  		if (nents < 0)
> > > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  			sgl = sg_next(sgl);
> > > >  		}
> > > >  
> > > > +		if (block->cyclic)
> > > > +			flags = DMA_PREP_REPEAT;
> > > > +		else
> > > > +			flags = DMA_PREP_INTERRUPT;
> > > > +
> > > > +		/*
> > > > +		 * There's nothing preventing a cyclic transfer to replace an active
> > > > +		 * cyclic one. So always set the EOT flag.
> > > > +		 */
> > > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > > >  							 vecs, nents, dma_dir,
> > > > -							 DMA_PREP_INTERRUPT);
> > > > +							 flags | DMA_PREP_LOAD_EOT);
> > > >  		kfree(vecs);
> > > >  	} else {
> > > >  		max_size = min(block->size, dmaengine_buffer->max_size);
> > > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  	if (!desc)
> > > >  		return -ENOMEM;
> > > >  
> > > > -	desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > -	desc->callback_param = block;
> > > > +	if (!block->cyclic) {
> > > > +		desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > +		desc->callback_param = block;
> > > > +	}
> > > >  
> > > >  	cookie = dmaengine_submit(desc);
> > > >  	if (dma_submit_error(cookie))
> > > > 
> > > > ---
> > > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > > --
> > > > 
> > > > Thanks!
> > > > - Nuno Sá
> > > > 
> > > >   
> > >   
> 
