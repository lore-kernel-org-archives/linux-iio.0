Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090345;
	b=SFM/wN46c/4iya2AqqZSNUEErNoFrBIGiF4cBLlgv4mv+KdvUc3J+yLgMXv1ujHz04PB
	 sXfryY8sGnO1S/TRaHraZXS22aMPHY/huP5yRxY/iMW1IdSfM7csPfx4KQz1iWMjvcoXh
	 AEUXirsaGbBNmme4+z4RzHDcuwgain/39Czv/imhQ+o+ZaMTgfYrdLtQ1KQoA8JdCx0fM
	 cjd3K4rtikUBTeAdwY+/MkhUASWG2zrDbRdNaQnbEQshpUQHhFhOb0J2OgCAjet9TG2+3
	 5/N5wWJvG1k2WbDWqA+Wg9Hv+8P6IR4YbarFcc+av9091SgZVq0xKuwOs+ecjx3ok/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090345;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mBFj6HRZ+PKa9Xg/C137TLvsgX+kzW3j1rxOvjkmLfg=;
	b=Wd8pAK0n0kq9Wz2J+ZyqoTGoZZTO7ZgXItGt1ZJFGlji5KC/wi3zP1lhi3XAmigp5IiS
	 ebZP7L8R7TIIops2L5HvMJXjakJd1PpRlw2vciNKH+L9B6qib7Lgjw/c2oR8QEwU1htjd
	 Udvl2xrYpS55TUJoefCESZ1Cbz+4SKg+VTXD58GZr7ZA+YbCTELssjd3ba6iqai874Ozl
	 ElGy3/VdgytdQkPu4QwuqhPabp/hJujq0jEJ8vSIqljMcyo2MFSxWPz2Sf3PDy9e/fPfw
	 cOnt0H3ku1vWvhmScF+OeP/io8WHkMhTUtEWbNtidneLo0m4ohk7kHqili9LEm90r1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kjoalouz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4A606A32D;
	Sat,  7 Nov 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kjoalouz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EC81F0089F;
	Sat,  7 Nov 2026 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090344;
	bh=mBFj6HRZ+PKa9Xg/C137TLvsgX+kzW3j1rxOvjkmLfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KjoalouzcbjpLgwAa2Dpm8PHWCGkCqkr0PAVnY5TOQGqpNe/PpHsCAYZ+q2oLRKCz
	 Fz0vH4naOowWH1DDWxiRmMg1AuhSs0DMS3ia29c3nYQiEISRpevAobIx2WqnRn1T4I
	 Lugjs4qSqFJ1hTX5z5E4D9BlPUI9ibwbDj9sH2LK9Yqw8G8QxUJR5Q72A20gQiOK0d
	 8HfkDIVeutQhidlhlgmFRZYtWZJ5HZYXYiho4VrheB8GJCkFsa6jYRhnMpxy357+07
	 d8blK3kF0uL+OFqefQzymoMirwixagzMjWM3xTQgQS3pkR0nSnJ3/3WarB2Vi5TLc0
	 Maf9Rcjj+GcRA==
Date: Sat, 7 Nov 2026 22:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 paul@crapouillou.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hold a reference while DMA-BUF is attached
Message-ID: <20261107222538.6d547259@jic23-hlaptop>
In-Reply-To: <179378580164.73301.2666197876060323279@gmail.com>
References: <179378580164.73301.2666197876060323279@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Nov 2026 17:50:01 +0800
Yaohan Li <shunsheng1218@gmail.com> wrote:

> iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
> attachment without taking a buffer reference. A delayed DMA fence
> completion can release the attachment after the IIO device has been
> unbound and its buffer freed. The release callback then dereferences
> the stale buffer while detaching the DMA-BUF.
> 
> Take a reference when storing the buffer in the attachment, and drop
> it after the final detach or when the attach operation fails. This
> keeps the buffer alive for the asynchronous completion path.
> 
> A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
> the use-after-free on the unmodified kernel. The same delayed
> completion sequence produced no report with the change applied.
> 
> Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
> Assisted-by: ZCode:GLM-4

The guidance on these tags change recently. Now the preference is
for a brief explanation of how the LLM was used under the ---

This seems reasonable to me but there are others who know the
IIO dma buffer stuff better that I do, so I'll wait for them
to take a look

Thanks,

Jonathan

> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
>  drivers/iio/industrialio-buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd7..bfa6d19471126 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1597,6 +1597,8 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
>  
>  	buffer->access->detach_dmabuf(buffer, priv->block);
>  
> +	iio_buffer_put(buffer);
> +
>  	dma_buf_detach(attach->dmabuf, attach);
>  	dma_buf_put(dmabuf);
>  	kfree(priv);
> @@ -1741,7 +1743,13 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
>  	}
>  
>  	kref_init(&priv->ref);
> -	priv->buffer = buffer;
> +	/*
> +	 * Hold a reference for the asynchronous dmabuf completion path
> +	 * (iio_buffer_cleanup() -> iio_buffer_dmabuf_put() may run from a
> +	 * work item after the device has been unbound); released in
> +	 * iio_buffer_dmabuf_release().
> +	 */
> +	priv->buffer = iio_buffer_get(buffer);
>  	priv->attach = attach;
>  	attach->importer_priv = priv;
>  
> @@ -1789,6 +1797,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
>  err_dmabuf_put:
>  	dma_buf_put(dmabuf);
>  err_free_priv:
> +	iio_buffer_put(priv->buffer);
>  	kfree(priv);
>  
>  	return err;

