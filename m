Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21D367F25
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208428; cv=none; b=buGZ7QOPOOqN9DmGEhhct+8ceGDH3zjK81i/2zm1cDgcCXVP8SxOHiEENuA8bvEjgfTnmsRihWii5SjoJmXjJbRaUbRG7jGL3ekJ62N0BmXmUKguHuNexpJADMHXzZLZT8VvcSbq676205GUyECz4TLxCPUihISsAqlG6bZpJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208428; c=relaxed/simple;
	bh=zrxHCEb1YYAwxHWMgXcqiWRejZEN2u5lEKgEdzsSSDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQnbnfaVb5Gya5EMc67jao+r5rppEDu+Yys6wHpzq4J4p1Ba0/cJIZ66mBsy/PzQckvGb6IqA4zrMKI6FgjUdBAByj5Q+nbV1KVJ8L9+ZwTVC1SdXyn9VMPDbGTaHJiI9vYghutYs7qbfPoGXTc3OMKr234UFKnaKyrI9A+VItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A74YO5c1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A74YO5c1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac357c55so58611415e9.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782208425; x=1782813225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P04n1SaD92+9BNlquHR61xonqsYGq3F6LP2UBCvuI9w=;
        b=A74YO5c1Y2jwrdtdUEpWKQ9WIGm67nrH7QHPIzW1DQd7GUzxi8rvMB9fTbGVQRq/Bo
         /5P0B0zTNvx+0dKuQdU524mB22n+WSl+WBIy29gGsIrgR3UfLwYLXjOj9AHNvqzGAhka
         mze2QSpRLgIy0aY3Kt6ftl02wQh7el+uQH+v146hEewXhNfhbpV5Hc4SWxBVYNZblvdr
         zLMoLtNB/pufI4qOI8A2SLPzDPmMSIElSpzvopGfAA375N0RPM38GDb3J14kjsZSRg9l
         a9gp8TId56F6LAIOIm+prCTYX/cC1pIATFBk8OK4Y+/31Isyd7+eyvulwJfcfbl5zw20
         RPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208425; x=1782813225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P04n1SaD92+9BNlquHR61xonqsYGq3F6LP2UBCvuI9w=;
        b=o7nOzz/GGjequNnEWT9P8Ms40V6LzH0e5WGKAOC0uoicNCbt++ahDgLI1y0skeTEb1
         YrJ/nKmJ4LmTC7eib29L9dzRvKaDzKXxrxO5d2nYHHNUvCAy//Ajf0AEATgDZTU46vMr
         AUPdOs3cnrgZyy9UgVuXBSea6puWJIL5uG4C9G6rERiK/xjJo8b4aPAKYqR3aSL2bfZo
         tcn/Tl8mb1SJOal08cdRGmHd2KJNl9XdOQUMRcre+GQsMvhJc2+zv1iiejK6zjOTMQoV
         OPA0MfZMoSV0hKDGqBrCnIaGCezJuR7UUPjP8ZAcsFzxfRgU06S3JZ+ERrU5FvjGfjOi
         +b3g==
X-Forwarded-Encrypted: i=1; AFNElJ9sY6Tr5myvb/F7NwJ3Uu7weWAvg9rghIudvb+bAR1IfjVHUk96rUPW8MAxWZB6ZbEmCVSzjkeL+Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywik04ZNW7r9l4bdH53SYnzToCs3MwSuj5y2xSsC6yIhNGv6f/w
	+n34LrdNa3/iHGSWwu6SpW/0RjX2/eo71TlefftibaEYOr3Poga2DgUv
X-Gm-Gg: AfdE7cmAMybc6fn5QgQ21bbFzHNdNl+Msu4pdrRxYpm8vZDGBa8rWcobCDAQsAuUESO
	UJsZNOHZGPumLLnBX+qAiirk3yPe5GmR1m6Ncb8S6upHbLkoL4GLY1jt4cgaM2jquHJDaqM0X48
	fSzgqGBFUL/cwCIrEwkVCjSxFETmf1CzUOZDEH8LxVORdhY9dArhqJHzmJYCZ31Vb3rhJG1qlm0
	d5yBeqOqvoBBMUNy/IuTpMrkyQddK7boJxgc1fXfqahfP+Kw234w5GghrDxpLTQNLnMa4cqVpgR
	84hGpTNPoft6pfrGuTpbbwWVdahnaWsgQK9QIWjWRSuWNc+iAKGAvyLrt3izamMPhFhdd2IkpDU
	hwEPbUvilI/pUD5wy3Ztlq5Q3440a0s4cHYk9iDjI7RxKQYTVz8yVk7m2Bo78wXqUB0B2D+sRFR
	hVshjXXhq9bb2yIjY=
X-Received: by 2002:a05:600c:a48:b0:490:9df1:f0cf with SMTP id 5b1f17b1804b1-49240df7c34mr322418595e9.2.1782208424578;
        Tue, 23 Jun 2026 02:53:44 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm346246235e9.2.2026.06.23.02.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:53:44 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:54:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <ajpX2DN2atJ3kOPi@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>
 <ai-0CIqteaSJJkau@nsa>
 <ajk1FX-d_KoW14f-@nsa>
 <20260622181209.791dfc6f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622181209.791dfc6f@jic23-huawei>

On Mon, Jun 22, 2026 at 06:12:09PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jun 2026 14:15:50 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Mon, Jun 15, 2026 at 09:21:02AM +0100, Nuno Sá wrote:
> > > On Sat, Jun 13, 2026 at 11:33:36AM -0500, David Lechner wrote:  
> > > > On 6/11/26 10:28 AM, Nuno Sá via B4 Relay wrote:  
> > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > 
> > > > > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > > > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > > > > replaying the descriptor.  
> > > > 
> > > > Is this for both directions (e.g ADCs and DACs) or only one?  
> > > 
> > > We just have usecases of TX buffers. IIRC, there should be some
> > > validation (some layers above in the call chain) not allowing cyclic RX.  
> > > >   
> > > > > 
> > > > > Skip installing the completion callback for cyclic blocks. Since the
> > > > > transfer is continuously replayed, the callback would fire on every
> > > > > period, throwing off the block refcount.
> > > > > 
> > > > > Because nothing prevents a new cyclic transfer from replacing an
> > > > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > > > > correctly terminates the active transfer before loading the new
> > > > > descriptor.  
> > > > 
> > > > Is there more to come after this to actually make use of it? Or is there
> > > > a way to use this with DMABUF from userspace already?  
> > > 
> > > Yes. One can do TX cyclic DMA transfer today. Some waveforms examples:
> > > 
> > > https://github.com/analogdevicesinc/iio-oscilloscope/tree/main/waveforms
> > > 
> > > For normal non cyclic transfers, libiio also handles DMABUF just fine.
> > > Best way to use it is with USB where we support zero copy between IIO
> > > and the USB stack.  
> > 
> > Jonathan,
> > 
> > It seems there's not much activity on this one. What do you think about
> > the changes?
> > 
> > David, from you silence either you forgot about it or I guess you
> > are happy with the reply :)
> > 
> > Just trying to move this one forward
> 
> Fiddly thing so I wanted to leave it till I'm up to date with the easier
> stuff. 303 emails to go... Also going to be travelling later this
> week and it's always a bit random if that means I have lots of time
> to review or none at all.
> 
> Jonathan

Alright then :)

- Nuno Sá

> 
> > 
> > - Nuno Sá
> > 
> > >   
> > > >   
> > > > > 
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > > There's one subtle choice in here. Given that the termination callback
> > > > > is not set. We will never give the block refcount. That means cyclic
> > > > > blocks are only completely freed when we disable the buffer and
> > > > > iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> > > > > as it makes it more simple to handle. I also think this a fair
> > > > > expectation from a cyclic transfer. We set it up and let it run until we
> > > > > disable the buffer.  
> > > > 
> > > > Makes sense.
> > > >   
> > > > > 
> > > > > Alternatively, we can give in the refcount as soon as we give the block
> > > > > to the DMA layer with dma_async_issue_pending(). But we also need to
> > > > > make sure that the block is not added to the dmaengine_buffer->active list.
> > > > > As said, I feel that the current approach is just simpler.
> > > > > ---
> > > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
> > > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > index 98acce909854..4a78cd3e7c7d 100644
> > > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > >  		dma_dir = DMA_MEM_TO_DEV;
> > > > >  
> > > > >  	if (block->sg_table) {
> > > > > +		unsigned long flags;
> > > > > +
> > > > >  		sgl = block->sg_table->sgl;
> > > > >  		nents = sg_nents_for_len(sgl, block->bytes_used);
> > > > >  		if (nents < 0)
> > > > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > >  			sgl = sg_next(sgl);
> > > > >  		}
> > > > >  
> > > > > +		if (block->cyclic)
> > > > > +			flags = DMA_PREP_REPEAT;
> > > > > +		else
> > > > > +			flags = DMA_PREP_INTERRUPT;
> > > > > +
> > > > > +		/*
> > > > > +		 * There's nothing preventing a cyclic transfer to replace an active
> > > > > +		 * cyclic one. So always set the EOT flag.  
> > > > 
> > > > What about the non-cyclic case?  
> > > 
> > > Non cyclic will also have DMA_PREP_LOAD_EOT which should stop an ongoing
> > > cyclic transfer. If there's an active, non cyclic, it's business as
> > > usual. The transfer get's queued and will fire after the current one
> > > ends. IOW, DMA_PREP_LOAD_EOT is only meaningful for active cyclic
> > > transfers (it's ignored for non-cyclic)
> > > 
> > > - Nuno Sá
> > >   
> > > >   
> > > > > +		 */
> > > > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > > > >  							 vecs, nents, dma_dir,
> > > > > -							 DMA_PREP_INTERRUPT);
> > > > > +							 flags | DMA_PREP_LOAD_EOT);
> > > > >  		kfree(vecs);
> > > > >  	} else {
> > > > >  		max_size = min(block->size, dmaengine_buffer->max_size);
> > > > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > >  	if (!desc)
> > > > >  		return -ENOMEM;
> > > > >  
> > > > > -	desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > > -	desc->callback_param = block;
> > > > > +	if (!block->cyclic) {
> > > > > +		desc->callback_result = iio_dmaengine_buffer_block_done;
> > > > > +		desc->callback_param = block;
> > > > > +	}
> > > > >  
> > > > >  	cookie = dmaengine_submit(desc);
> > > > >  	if (dma_submit_error(cookie))
> > > > > 
> > > > > ---
> > > > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > > > --
> > > > > 
> > > > > Thanks!
> > > > > - Nuno Sá
> > > > > 
> > > > >   
> > > >   
> 
