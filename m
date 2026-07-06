Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E042D0C63
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332417; cv=none; b=RPPcqqlEAM9IZICQCJKK1VNItmEkUlSCJg3GbSUxeXU1VqHsmjJQVLszpAkV+BtM29ROewM+n7HV4ccWpiehrSA+RYXXv7J6TSuecejTuXRAuXZCW2/u2iTa0y718oA7XCpvJqYeSgxcHukUr2HPYU89aaeK3webWG8qRAncE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332417; c=relaxed/simple;
	bh=nD7Bbg+Umb9oYKNZXGnVg17O5fRKEbVbHqznm6hYvGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0OOijvzfAbSjw+jAzmMsf5cxHVX6Xa1+9Aqvh58hPBwBJ6p63YgWOJ8uCIdIWSJPRi9VM70mgB2g7I4VNNVTV0GD/HNbS605V2SRUPc4WOYZ1Rb3aUT1f7P6HT+xJgNfUhalzlL3nFhHDJytlbiJRXLvZH+Ygp/edJ7bQMkVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUGuxvtK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUGuxvtK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47d6c634f45so882063f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783332414; x=1783937214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGSdMXhO4Q6wqiToBOowuoVOvP8JQtESOQ9KXr/FBFE=;
        b=sUGuxvtKF7wrtI5wLZYRFNHMfuaOriCKJHStCzGsWyfPQv6OXnsjvo7zEWljRg6YS+
         Y9seyWXaYPZyMMTt9B3blgnlnChCp62Q/Ml5maEK5bFAo/RBveTU6kq15OsbzUR9TPMf
         uI3YCRyadyE5bB3VujK1SNpsFgmEDRnefG7mF5PbDQ2MNfpVy8LUGkp1/FWjt6BzJe5R
         5aZl3weX07XcdoRoxTHGWgkF0saPVykQ9dOTYYew+yvvZBwXiIUDxwmYk6vJ2jTHSGLT
         BdN419kO1y5vFCPFB7XRRNPQnY69iSzxo7bAzb5yfE0rZ4VfSQEFBf3adtvb9+89aVak
         Z6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332414; x=1783937214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGSdMXhO4Q6wqiToBOowuoVOvP8JQtESOQ9KXr/FBFE=;
        b=R4tRGNfpFxahTygdVOS5AhRLSviWKiKIUHB8zgmPsYErf/wjHcsVA1XRL/0o/kJDBL
         lEC2rpAbbGEPxFj9MzHF7hFP2tu+s/B+0Bhkq4nJPQDQfyT0XQbbmMzt2kHZQR7LVCUT
         l2dYhiR+YKsukmwosLYmXcncigXx9gA8JM4+iYeNba1oldkWGbl5twrdQtrz5wWdgQRC
         MFmWF2N3aWANGEC7i2+fbFhk8mTfxSiw1AJ//GNkfOteZXN/xOZaBRmYe+AzPb81Mc06
         Z3mkV/2PgMcfxDiWY8eSMWKoP3UUSs5xs3eg7v8aJsibQVWAh0YgwzwFJkkjmz3+wjHK
         9dww==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Tm3upfyP8Pl/vCPwG0Ad04GOZ7e75Z95bIoSFMRdtXrPBf3+CGaap5eHE7vkuyBlKrBYcgUJjpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgH5ERM/nLl+Hagq/IZqCd+ledoYcOWYZ/gM9N2CnK3uv2bFn8
	AIIKzWlvZKkRSo2zL8le5Gd5/Doh56i06Xfodby6cFL1ZtteroTtkdvZ
X-Gm-Gg: AfdE7clujJOSh3GyPaRLTai0tvADaJTnIYUrZzL2x9qB2nhgH1YrTlpGWIKOKvrdMHB
	hxt051ocBLXF3IMflz5AfVsDMhT1pmLk2AIrAgK2I78lgobjKS+1Ee/HSVmN7lPeZSljZSkxSJU
	Ayrg9PsHtT4hKceL5E1qt46KBAzLipZTk7Vk8kFKwBONVa8JrhcmcaDQ5S3o2HJBqWuL82yL8xt
	ztUtPxVuxl4sdck3BdRIDNckmIVPy9bJiyACRFr+uJT3JcCP4AYBQsLPM1zuFRaZ5zX+1QMl4uk
	rG/Dy9xi5aLAa/ixVya9gzSpep/i784sswY9erMyLwVzgxPQWJwodiWt046ZyJH4HoKU2uFPZYE
	Msv5ajjMXsuSwMU4zwugjhH0RIOVVuTYqN/703gO9m4SMiVql6QvO84BOtpmThqnCDMaoixuu+w
	OHjzR8gbJUwEd3zE4=
X-Received: by 2002:a05:6000:4687:b0:475:f0c2:5b02 with SMTP id ffacd0b85a97d-47aad54b75dmr6675823f8f.56.1783332413500;
        Mon, 06 Jul 2026 03:06:53 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm24428308f8f.37.2026.07.06.03.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:06:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:07:58 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <akt6IDED7qwtkM7t@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <20260703195238.271aa219@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703195238.271aa219@jic23-huawei>

On Fri, Jul 03, 2026 at 07:52:38PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 16:28:57 +0100
> Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > replaying the descriptor.
> > 
> > Skip installing the completion callback for cyclic blocks. Since the
> > transfer is continuously replayed, the callback would fire on every
> > period, throwing off the block refcount.
> > 
> > Because nothing prevents a new cyclic transfer from replacing an
> > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> > correctly terminates the active transfer before loading the new
> > descriptor.
> > 
> I'd like a little more use case stuff in here.  Basically I had
> same question David did on when this was useful.

Alright! I'll re-spin with an improved commit message.

> 
> Otherwise, seems fine to me. Sashiko raised a concern about a particular
> sequence of blocks being added.  
> https://sashiko.dev/#/patchset/20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c%40analog.com
> I don't really understand this code well enough to be sure if the issue
> is real or not!

Hmm I mean, for the same block it's not a problem as we return -EBUSY.
Now for the below:

"Could an unprivileged user repeatedly attach and enqueue new DMABUFs as
cyclic"

Don't think the "unprivileged" part is true but a privileged one could
in theory just keep the list growing until we disable the buffer. But
this is part of the choice done in the patch note and AFAIU,
dmabuf-fences also have this kind of "don't unref me right away"
behavior.

- Nuno Sá

> 
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
> To me that seems fine
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
