Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F34028E2
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499204; cv=none; b=iHKwbQl3R7h5jFg+LDKC7azB8Vc/vO1RHdnAWXKdj3VHzjjXfvrdPVGP2dV3N5uCFykRsGtc9w5NcTPjpw6rweGdCciri/xk9nBiAtE72bep1xBATH2qWOeWpcbzOEcdkN/SiinaSBvGQxLsngDqQiV0dn9oLetlFfOJ6Bkkw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499204; c=relaxed/simple;
	bh=HgxWcp5WxtucaDd5qxLvZH5u/epKMYAedD1T+be2Avk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQb5qKhGa4nKRQ8v1+IlMb7DvBt/Yu2ZqtwZrJXYEuLgx09Mr0/9QBDgyhXJudUoGllym4mwmFta5AZMCYpKYAdmGsP2Bu/0q6F6tq0PvKujVJ5wdfmta/Y8SzJbyyxCFSkLfd2c5iK+NITne1dzyfV8QGFO5AT8PaUl+QlHckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPR+vuTP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPR+vuTP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c486f012so1439785e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499201; x=1784104001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6QhEX+Txs81eo25SZoOpApQZryF1aZClYP3jWmAXVNU=;
        b=KPR+vuTPSb/1t07HKCgPWKhnc+xn5ylPQPkgFg+u7i2Uil74JDSp/d0AJOvLnHN7ET
         jMqHRX+zQowJN5FKxmLryWTVhnH1j1reEMOddc6dQtMgFcMYBJjYzGOioAKf3G6MAtQK
         4Dh2T6Eru8yBLmZpSRzJ9OOlSxBFk8POVgWorL2SZbm84FVYsquiDyXs/G9k7dHsIXKD
         BsR0agcZJqDEOYal0vECgkroVFyLFA+DFBDLospk60Vk9kjLKbAVKJikhOTcIsYgFWmG
         M3catBO6cLEW0AIuKDDZvMhnsJ4oowjV1qayApdmegSwXpsKET67KZOAfnrtfV85CUBc
         54aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499201; x=1784104001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6QhEX+Txs81eo25SZoOpApQZryF1aZClYP3jWmAXVNU=;
        b=F2yp6fqydnjIRNSx+hfnv34kIcORw+9djXc8uSRAskI7s3DOgfOKXCvxMPOoekMeKE
         yjUwWzU6CZoJHObQOs73X6/1UwpVvGH0V/NAkKANspUhsIeaLJwz0089XNqWPyx6S0iI
         5ztZSGQLHNAR1qzYpJG2c0Kg0YTP1k0mhxg3BSgkP1AlJapSDlt4POt9wyyu9s4cR8g8
         w5FsXUQjyfuuokwaSedj73zFIlkyixNt40dEpO+Wg3S/CnsoCO+GBCcAtCPEyWQKxBB4
         d4K6SCBURYhmrneAvU6Uhf86YPykwWeI4/PSugcKdaRZlkDw33T2ilxUNLkamiTVubUR
         8ZGA==
X-Forwarded-Encrypted: i=1; AHgh+RrQunQ+c5V/k6r/BYneGRQoctc8boBntHBoZkIz96CRffvvrB5g9W3hR5HbMr9eJJPFxOm45Uoqvaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexWUMIaXxoFkvK4y8eSnYCkzCObvdBIdrxyTb28Wp2Ww9+rLP
	weVW+Zks6p62XJjGjSgQSTpqzgkWoY1a0AFH+tCMgsBAlZN63KhnPZqN
X-Gm-Gg: AfdE7clAgN7qrOvOXbqz6/zqcyDYM7o7C5IOuXuowU+zUMavUp4dmfs5WRUIEqI2qWt
	UGihPQyethPw8UbUrW62yR5tyKJb2K5pQ3olqtLIMvAHycTPZmTYmyqY+QkbUd2OICjBORtYxom
	FPPIZ3zXIknHLSIH8pIJUf33kYzdl1EtDyNYigQ4K25A4JIpKGIjHrA6EDqDEC1+9cKdCvoTdm0
	YXYnjXBJ622qO0A1L5cyvhjwZYP7pu0QvrxTlJ5uXe+uMpqTCAUDAoZGLv43Lbjsnqr9Ag46erV
	fKHW2STpW8/5RJStvgQ9rOXJ0VGB62fdwblJRg8u876a2rq3RV5SKSAgzF5y+P/9awYLiFphPV0
	go4pgpMEPogK8xNlfuFq7ufrtlaTEy6AmlC3rgOT9nc1XYnETkJMC9ItIzPI4xcXkhjntFH5scE
	lYaRnF
X-Received: by 2002:a05:600c:a011:b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-493e6862761mr14186715e9.11.1783499200455;
        Wed, 08 Jul 2026 01:26:40 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fccf2dsm129161115e9.15.2026.07.08.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:26:40 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:27:44 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <ak4J7-W4PhoMKkKp@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <20260703195238.271aa219@jic23-huawei>
 <akt6IDED7qwtkM7t@nsa>
 <20260706164719.3e8196ce@jic23-huawei>
 <akzZKkI_xWGNg4gq@nsa>
 <20260708010213.3e91171d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708010213.3e91171d@jic23-huawei>

On Wed, Jul 08, 2026 at 01:02:13AM +0100, Jonathan Cameron wrote:
> On Tue, 7 Jul 2026 11:51:38 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Mon, Jul 06, 2026 at 04:47:19PM +0100, Jonathan Cameron wrote:
> > > On Mon, 6 Jul 2026 11:07:58 +0100
> > > Nuno Sá <noname.nuno@gmail.com> wrote:
> > >   
> > > > On Fri, Jul 03, 2026 at 07:52:38PM +0100, Jonathan Cameron wrote:  
> > > > > On Thu, 11 Jun 2026 16:28:57 +0100
> > > > > Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > >     
> > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > > 
> > > > > > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > > > > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > > > > > replaying the descriptor.
> > > > > > 
> > > > > > Skip installing the completion callback for cyclic blocks. Since the
> > > > > > transfer is continuously replayed, the callback would fire on every
> > > > > > period, throwing off the block refcount.
> > > > > > 
> > > > > > Because nothing prevents a new cyclic transfer from replacing an
> > > > > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > > > > > correctly terminates the active transfer before loading the new
> > > > > > descriptor.
> > > > > >     
> > > > > I'd like a little more use case stuff in here.  Basically I had
> > > > > same question David did on when this was useful.    
> > > > 
> > > > Alright! I'll re-spin with an improved commit message.
> > > >   
> > > > > 
> > > > > Otherwise, seems fine to me. Sashiko raised a concern about a particular
> > > > > sequence of blocks being added.  
> > > > > https://sashiko.dev/#/patchset/20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c%40analog.com
> > > > > I don't really understand this code well enough to be sure if the issue
> > > > > is real or not!    
> > > > 
> > > > Hmm I mean, for the same block it's not a problem as we return -EBUSY.
> > > > Now for the below:
> > > > 
> > > > "Could an unprivileged user repeatedly attach and enqueue new DMABUFs as
> > > > cyclic"
> > > > 
> > > > Don't think the "unprivileged" part is true but a privileged one could
> > > > in theory just keep the list growing until we disable the buffer. But
> > > > this is part of the choice done in the patch note and AFAIU,
> > > > dmabuf-fences also have this kind of "don't unref me right away"
> > > > behavior.  
> > > Should we perhaps set a defensive cap given we think this is unreasonable
> > > behaviour?  So fail to queue a new one if the backlog is 16 long or something
> > > like that?  
> > 
> > I guess we can add that for some piece of mind. In reality I'm not even
> > aware of any usecase where we enqueue more than one cyclic transfer so a
> > backlog of 16 should be more than enough! I just allowed one cyclic to
> > end another one because I don't see any technical reason for not allowing it.
> > 
> Then maybe cap it at one until we have that usecase.

Fair enough!

> 
> > - Nuno Sá
> > 
> > > 
> > > J  
> > > > 
> > > > - Nuno Sá
> > > >   
> > > > >     
> > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > ---
> > > > > > There's one subtle choice in here. Given that the termination callback
> > > > > > is not set. We will never give the block refcount. That means cyclic
> > > > > > blocks are only completely freed when we disable the buffer and
> > > > > > iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> > > > > > as it makes it more simple to handle. I also think this a fair
> > > > > > expectation from a cyclic transfer. We set it up and let it run until we
> > > > > > disable the buffer.    
> > > > > 
> > > > > To me that seems fine
> > > > >     
> > > > > > 
> > > > > > Alternatively, we can give in the refcount as soon as we give the block
> > > > > > to the DMA layer with dma_async_issue_pending(). But we also need to
> > > > > > make sure that the block is not added to the dmaengine_buffer->active list.
> > > > > > As said, I feel that the current approach is just simpler.
> > > > > > ---
> > > > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
> > > > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > > index 98acce909854..4a78cd3e7c7d 100644
> > > > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > > >  		dma_dir = DMA_MEM_TO_DEV;
> > > > > >  
> > > > > >  	if (block->sg_table) {
> > > > > > +		unsigned long flags;
> > > > > > +
> > > > > >  		sgl = block->sg_table->sgl;
> > > > > >  		nents = sg_nents_for_len(sgl, block->bytes_used);
> > > > > >  		if (nents < 0)
> > > > > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > > >  			sgl = sg_next(sgl);
> > > > > >  		}
> > > > > >  
> > > > > > +		if (block->cyclic)
> > > > > > +			flags = DMA_PREP_REPEAT;
> > > > > > +		else
> > > > > > +			flags = DMA_PREP_INTERRUPT;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * There's nothing preventing a cyclic transfer to replace an active
> > > > > > +		 * cyclic one. So always set the EOT flag.
> > > > > > +		 */
> > > > > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > > > > >  							 vecs, nents, dma_dir,
> > > > > > -							 DMA_PREP_INTERRUPT);
> > > > > > +							 flags | DMA_PREP_LOAD_EOT);
> > > > > >  		kfree(vecs);
> > > > > >  	} else {
> > > > > >  		max_size = min(block->size, dmaengine_buffer->max_size);
> > > > > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > > >  	if (!desc)
> > > > > >  		return -ENOMEM;
> > > > > >  
> > > > > > -	desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > > > -	desc->callback_param = block;
> > > > > > +	if (!block->cyclic) {
> > > > > > +		desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > > > +		desc->callback_param = block;
> > > > > > +	}
> > > > > >  
> > > > > >  	cookie = dmaengine_submit(desc);
> > > > > >  	if (dma_submit_error(cookie))
> > > > > > 
> > > > > > ---
> > > > > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > > > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > > > > --
> > > > > > 
> > > > > > Thanks!
> > > > > > - Nuno Sá
> > > > > > 
> > > > > >     
> > > > >     
> > >   
> 
