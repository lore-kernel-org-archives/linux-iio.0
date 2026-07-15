Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F0275B03
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128418; cv=none; b=fV0hWPeBuIdesjlKZ8cS2GUPiNQHa0WRh1HoE2R7pKS3dU4uDQbWgNCTcCrF47EYBAjkbo6RltcETIa+KkZD1j+Fohj0hDZJ7hG+ya91cxYn8j9n02oEKaKrtgRIaTbMO3om99VncuJ3YVCHdYClxxCimMMvDmXMbdf6Bb+R9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128418; c=relaxed/simple;
	bh=845KTCC8ncRmvUVMPWkGdnJTjr48CDIr8iXBq5z9WJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyy9NgYvOUGEMDJ+4ZU+nq6B1hqyUnnex4+xQHnQd2rZXkbGIsVcboWCIT9ug6OZkJAKvQpkYRQBfLK/EI7uQRhq7xvzsaclez6dzARH+5uuh+C3MHCTVKjlkOV7QCQR4qkhFy+2lTl1OGStazGz+DF/ZJfjnCidEft+/sCYZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmA49hrE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmA49hrE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47db714766aso463813f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128415; x=1784733215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lT9qs8YyHxnzvHNhE3UqjUnWIyiH3t3fWJEyrEBXwic=;
        b=cmA49hrERlTe7hEc0ZV8+pjt0iwHrpfUUaoiLFATAFaAhGLbt3JAPgqls253QbRmEV
         HWXyDw0A9mIensMvAaNk98s++StzUgIxaGzBUdaZC6wWGEZJ4ajLnSyC7tKuDpufwxqY
         YXtmUShWqGYUX/bNueG2XJMVJoShyoQloCtflIcHpx8duXO0ObGZ8wpjSJn7DmN01jbd
         hmtapDOXG+whk+GOtbKUVBKgW9SkEmNv0x3s2+hBFXie65Ne+ETC5KtKoRLf9OxNWp7g
         AVvggbZSp3MoknTPUizBmRjxFiAlsBGcip/mkEau+tivpD/t3jmMOWZRl5Ju7zMBc4eu
         /qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128415; x=1784733215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lT9qs8YyHxnzvHNhE3UqjUnWIyiH3t3fWJEyrEBXwic=;
        b=LsX/d3mNKULqPckiYlwUQq5KYPpN8LZ2dbGAChik6ZFQxMdloiLRwdfW0Q/2xW+P+S
         S8dZvoQmys3OqHzWe/pXL19b52gNXhjZe6il27KUdMafGPdY4xtNm6/yUFvXrpCb0/Rz
         OXjfkJ6/bo36snK49JkDS4wH1Jd7/G7fJm8aEe8/3JpRtLeLx5tTM2/NhZ5clK8p8WF+
         J4pf0EPq1cwrIaDvSKmR+p2Tc7goine1HxvVkMGOrWXloeWQ2UOU1Kl0Mxx4iIm0UX7R
         wCM9todzVyviWO8G0LgjMBYggldlrlNcYxPE/aPhnjnr5ZPv3SkwC36ndIjQFDIOqBIl
         lG+A==
X-Forwarded-Encrypted: i=1; AHgh+RorQxzl/kJaj8ABkzjMWL3mXL2BYXvT3vgobnOcFr/lQtzbGhHDAbvah9369J4aU+UzbyeATl1V4NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOg7dkfJxmAh642sbArQI8u0rwOnPzkFK+xA9vuOEhUc7C4CmR
	xrqu9qI0rb3S4j6G8f+/qrggIt2n6u4Hma5hQdM0muShJi0n9RjW/3Kb
X-Gm-Gg: AfdE7cluIy67xDbHeTQ+xlbrdivdCc9JkzpM+9seAomHDJmm2GA/7xlRd+j44lWlyTz
	9n4WGVkrice+rCNHXKod68HhmjY35nDOmTrEx6dUkOr06QWZvK6Csxgwv/WwBKIvwyKOLE0P2ZZ
	E+PqUQylwUbyr171dCktng7M2rD9bYXrCMmcYFoQVbT+yM5oW4kq9n85C0ip+/etDvnbY/N3wRQ
	TDn8IiTEwyZpzkSmq7Q0NvcetcVIpbSj8l4kJzRsXGPF65L7loaJE7tqJV+uLgCgsdLUF4pnRnn
	R1vCQI28PS0nk4+RAqmUeIJsa4rvVGyjA+DNfYM6Bnle0q/ngUsENWMx7VMtKaMwnHGX3xi1lhE
	iJ8mY6u89+4DO3sUywpFMffY/UR65P6VYXAuxw3mBmaDhz3JPWvsGd0nZFp8Lwtrr0EQI2SOwxT
	7zLbmtojBMnaH6bEf5VXO65Ui4CXg=
X-Received: by 2002:a05:6000:2886:b0:47f:4834:99cd with SMTP id ffacd0b85a97d-47f48349b01mr9018430f8f.26.1784128415025;
        Wed, 15 Jul 2026 08:13:35 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a9cesm17574054f8f.14.2026.07.15.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:13:34 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:13:32 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
 <aleX0UD96t12s44k@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aleX0UD96t12s44k@ashevche-desk.local>

On Wed, Jul 15, 2026 at 05:23:13PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno Sá via B4 Relay wrote:
> 
> > Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> > replaying the descriptor.
> > 
> > This is useful for output buffers where the same data should be driven
> > continuously without userspace having to requeue it. Examples include
> > continuous RF transmit paths replaying a calibration, test or beacon
> > pattern.
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
> > Limit the DMA buffer queue to one cyclic DMABUF at a time. There is
> > currently no known use case for queueing multiple cyclic blocks, and
> > cyclic blocks stay referenced until the buffer is disabled.
> 
> ...
> 
> >  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  					     struct iio_dma_buffer_block *block)
> 
> > +		if (block->cyclic)
> > +			flags = DMA_PREP_REPEAT;
> > +		else
> > +			flags = DMA_PREP_INTERRUPT;
> > +
> > +		/*
> > +		 * A new transfer may need to end an already active cyclic transfer
> > +		 * before it can run, so always set the EOT flag.
> > +		 */
> >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> >  							 vecs, nents, dma_dir,
> > -							 DMA_PREP_INTERRUPT);
> > +							 flags | DMA_PREP_LOAD_EOT);
> 
> Logically I would expect this to be a separate line with the above comment.

Hmm I can agree to some extent. I guess it makes sense, yes. OTOH, it´s close
enough to be clear what's happening. Anyways, can spin v3 if you feel
strong about it (will anyways wait for Jonathan to take a look to make
sure this the only pending concern).

- Nuno Sá
> 
> 		/*
> 		 * ...comment...
> 		 */
> 		flags |= DMA_PREP_LOAD_EOT;
> 		...
> 							flags);
> 
> >  		kfree(vecs);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
