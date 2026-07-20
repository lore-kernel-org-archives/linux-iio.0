Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621E426D02
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554920; cv=none; b=hxVV5nXIxACsw9g4JZAYcsOiUXE57ac2hc+CXCGx40BbIdUySYZDmjISaEsI/9LfBvCpEcLwGIuZni9swz5H+RCJkOOC1UvM1jzHvA+2/q2U3Lgh7yz1snXpFxYabiahQticQKbH+Btqg7PAiK/DxSt0D5zfCvRUx5hRIvoIYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554920; c=relaxed/simple;
	bh=Ubv1vkXN8JsVpqvp6b3+uthFb5xOWPRR+fapxvWABpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuOz/E5uPnXDv9+FbGAbgUnRyYBj+X5DCn974q4E/SeE2glBTejPa2Km1b5gKM9dy88CvfMw5PXwvauLTjT2GTwk04jcwyy8/gOVlRhGTK4bhqPkV+R40WdjfQiw2aQZKgnJ8HE4OfPTIRl7oj5oRYZtPWXuv7JNpuFaZnxBp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxnqtGXX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxnqtGXX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954afac04bso26442775e9.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784554917; x=1785159717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UFkvz22ZX/P2Q7LpcAmZVSd4GFtWa1Pyinxxopr91A=;
        b=KxnqtGXX+wXIFtlzp3b6liAYhyRljBPIV9pN46Ssj472NvfjMSpv+Fvg22kcf50bOv
         d7KKIwMYCkr17ZKhN5eblVuRBZ7l1dKuuQt969FiPXOtSnLtSil1+b8lVbC1JRGZUHcL
         SiCZT3A2Y2pKLY6TjUO3Fvq8E2O0eEFbXn5UEAxMGPqbah+YMwPTn8Df/bKRu3H4Wzyn
         dD2NKy4jTWlr/zdTLSOSGgZSCxzcIX/W2dQgzacHNhCGUk8vclcxszArByn5oZLRk2Uy
         zOhmZDncOSBzY2Vmed7vYwqJdT+dIr6WonSIJR71fkEsbDx21SHCyKmcruiIU9xTSF+t
         Hf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784554917; x=1785159717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2UFkvz22ZX/P2Q7LpcAmZVSd4GFtWa1Pyinxxopr91A=;
        b=TGZ1DTUPQEIw+uO3hOcOoOwOSn0TgFpZ5gcAcXPvVUBc9I5GgArfaoxLZRtRQE1v3C
         CAgTbqn5D9QMHl6Xv8Am6e4PXA/d87Mr1EByklYdUrkrQG3JE+FAGfMOP2CDd9+sOZ9L
         u2uNtLX76JrfTDjwkAarVMIFIhxbj3CGVLhroUyeIVw+2bES9heoiQGoeOcgaI6kS+ko
         FyXIKE23NNMYo1x6FaK1YjhIa8GPyjadwgIT1Kk3kJS/QiEYjPV1TfmIOjKjWtzfsXMV
         7xA+systGsD04xImoZioNwK/7HYXVEy5hPCaTKj1Cay5MvQqFO1CC2/sRP5OF/7f/Aw1
         uneA==
X-Forwarded-Encrypted: i=1; AHgh+Rqc8ongh0SQXLcmKfggCDxUhpGaufsb5q3di1rd2v+S8+MlW8Qu9uDtw/dlm/iJ40Fb+NqnXAsTDR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3c/uZT82uNPf/uLx09ODA9qS7mzPeXIc2p4p9fCNFNGotzejU
	kDbQxiNuDtGdiyO3cy04rLQdosR0YmZuqC5pq3qt0q+Hy4gU+tkKoyjt
X-Gm-Gg: AfdE7ckVMzMqBTkzfWeNXSLIT7b0HsyvbQ6y53h4Z0c73IfnegDOEyhoaZLIOR9tx3A
	rzpIgGzpWWJtMDn9QSBLZfy33NUHrdVCHSVkqkcCIzpERTQJpzjd4hItXT7ovNPoZx8RcK3vFak
	B7ijSjaWgQY9ww14Nb84IJVvtOypdmilmJHzitwZjba/hcFNMpMdsq7Ykhyd6JJTnF6mfo8IoK9
	zXeXMY36JGxaUTNTwdqmRytNtX/DWgBo4bIuamrJlfrExZCJ/sToCgDCWLPPb6Nnh4jKj8DU4Dr
	SUrZyLRt4r9UuFgDZzk/DdjBWKEiBOngNygxfyd0nJiR8OdqWNvVfOU4OIzroiqwz0t6v8dlOqg
	1SIjNotnllnHFBcbOZday2uv6eMX5niQYBFeKcN5Z1yd9sh5gAN4KBINqHkcRdVAf7iY2Sc4mxd
	B82+Sy
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4954a3e6e29mr167646285e9.5.1784554916556;
        Mon, 20 Jul 2026 06:41:56 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955d6d9e71sm101469965e9.14.2026.07.20.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:41:56 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:43:03 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <al4kJW8nDllWrBBB@nsa>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
 <aleX0UD96t12s44k@ashevche-desk.local>
 <56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
 <alewxmtqJmEkRfVm@ashevche-desk.local>
 <20260719030057.1c1be07c@jic23-huawei>
 <20260719030346.6fb9670e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260719030346.6fb9670e@jic23-huawei>

On Sun, Jul 19, 2026 at 03:03:46AM +0100, Jonathan Cameron wrote:
> On Sun, 19 Jul 2026 03:00:57 +0100
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> 
> > On Wed, 15 Jul 2026 19:09:42 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > 
> > > On Wed, Jul 15, 2026 at 05:13:32PM +0200, Nuno Sá wrote:  
> > > > On Wed, Jul 15, 2026 at 05:23:13PM +0300, Andy Shevchenko wrote:    
> > > > > On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno Sá via B4 Relay wrote:    
> > > 
> > > ...
> > >   
> > > > > >  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > > > >  					     struct iio_dma_buffer_block *block)    
> > > > >     
> > > > > > +		if (block->cyclic)
> > > > > > +			flags = DMA_PREP_REPEAT;
> > > > > > +		else
> > > > > > +			flags = DMA_PREP_INTERRUPT;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * A new transfer may need to end an already active cyclic transfer
> > > > > > +		 * before it can run, so always set the EOT flag.
> > > > > > +		 */
> > > > > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > > > > >  							 vecs, nents, dma_dir,
> > > > > > -							 DMA_PREP_INTERRUPT);
> > > > > > +							 flags | DMA_PREP_LOAD_EOT);    
> > > > > 
> > > > > Logically I would expect this to be a separate line with the above comment.    
> > > > 
> > > > Hmm I can agree to some extent. I guess it makes sense, yes. OTOH, it´s close
> > > > enough to be clear what's happening.    
> > > 
> > > Close, but not enough in my opinion. This currently is spread over pure flags
> > > manipulation and API calls.
> > >   
> > > > Anyways, can spin v3 if you feel
> > > > strong about it (will anyways wait for Jonathan to take a look to make
> > > > sure this the only pending concern).    
> > > 
> > > Not so strong, but lean towards my version. Let's wait for his review and
> > > decide if it will be tweaked whilst applying or next version.
> > >   
> > Applied with this tweak.  Hopefully I didn't mess it up!
> 
> I'll leave it on tree for now but I forgot to check sashiko and
> it asks about plausible sounding races. Please take a look and
> let me know if they are real and an update is needed:
> https://sashiko.dev/#/patchset/20260715-iio-dma-cyclic-v2-1-268a3a28ff84%40analog.com

"
Does this check allow a non-cyclic transfer to be submitted while a cyclic
transfer is already active?
Since block->cyclic is false for a non-cyclic transfer, this safety check
is bypassed."

The above is the whole point of DMA_PREP_LOAD_EOT (so we can gracefully
"terminate" a cyclic transfer)

I now see that our current cap will never allow for a new cyclic to be
submitted (unless we disable + enable the buffer)  but I would keep things simple
for now (it was also the whole point of having a cyclic cap in the first
place).

"If a non-cyclic file I/O transfer is submitted instead, it lacks the
DMA_PREP_LOAD_EOT flag, which could cause it to hang forever while the DMA
engine continuously repeats the preceding cyclic transfer."

Not sure where AI got the above from. The DMA_PREP_LOAD_EOT is always
set (even for the file IO based approach).

So unless I'm missing nothing, I think we are fine.

- Nuno Sá

> 
> > 
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index 639bac135539..ecc02a427b92 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -132,9 +132,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >                  * A new transfer may need to end an already active cyclic transfer
> >                  * before it can run, so always set the EOT flag.
> >                  */
> > +               flags |= DMA_PREP_LOAD_EOT;
> >                 desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> >                                                          vecs, nents, dma_dir,
> > -                                                        flags | DMA_PREP_LOAD_EOT);
> > +                                                        flags);
> >                 kfree(vecs);
> >         } else {
> >                 max_size = min(block->size, dmaengine_buffer->max_size);
> > 
> > > > > 		/*
> > > > > 		 * ...comment...
> > > > > 		 */
> > > > > 		flags |= DMA_PREP_LOAD_EOT;
> > > > > 		...
> > > > > 							flags);
> > > > >     
> > > > > >  		kfree(vecs);    
> > >   
> > 
> > 
> 
