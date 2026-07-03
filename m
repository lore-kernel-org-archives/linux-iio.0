Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A601F30A9
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104763; cv=none; b=bmYP7gBYJUeWcVK5mp9LnCCmmyrO4WsijB1QB3GGnxyaAJ9qEfUMv8Wo2MyeDqFCO5/15MF2vizxfD/0VcAbhTGHvO6C9dQlvIauG/7cT8JqkdYqv6s4XtZkCi5nTdOSiDUNQ/RA/bdIihxl+RIso6GAgVxQhFnjbSmYxFo0bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104763; c=relaxed/simple;
	bh=j52IpmtA3W3ELRtxkyjddyf6mmaS9A0qm6Upn9QOhgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R06cVqiFo4bVBLrwRi6q6mmZyLuSN6usX+H/GI1yZuOhh9j2IG5akjeF/4HI4goN1yMuz2ZANLaZqDF/asEdg5huC1gQfCT7tuyb9+JFrfAM/oVNdXEzFeO+AC2BwZRRbAGbX3HfiV0FJb/Mady77A/P3XdB4NqZUHr/VZAAZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5go9rkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5go9rkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12511F000E9;
	Fri,  3 Jul 2026 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783104762;
	bh=KqJx1z/TfjtL8cRjQOzjJ6YOLP57K8u5qUgDfPDOmNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k5go9rkD1bO8U1uc5UuXNkgsN0rX++df6NNHTGtArHB9RP7KslKN+bvTZ8+c3a8eZ
	 PO4QD5LzY6iagtTlHE59VS5wkrqPKAUBDx5rZxN5z2orSZEsmHjoq4SJtl+NSzmhL2
	 NUPFUJD518o0yGbyIdAZZLAPNH6WLrQCiN+54oOsIjbsGqhNMJGc6bvk7WseVygJKV
	 E/mPQKT3fMr5qXjZfEyzIj4LzXBwLx8DvUOMf2f5yHhDcRPE7AkzJ+Br1UeQ7ZqtD3
	 p+/tRI7dEM8EacN9zOsRA+xkWvwLcweRss8xTIef1SK7PfTOm4OFzfbO+ZDE9tN0CS
	 nxOcei6lhtWIw==
Date: Fri, 3 Jul 2026 19:52:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <20260703195238.271aa219@jic23-huawei>
In-Reply-To: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026 16:28:57 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> replaying the descriptor.
>=20
> Skip installing the completion callback for cyclic blocks. Since the
> transfer is continuously replayed, the callback would fire on every
> period, throwing off the block refcount.
>=20
> Because nothing prevents a new cyclic transfer from replacing an
> already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> correctly terminates the active transfer before loading the new
> descriptor.
>=20
I'd like a little more use case stuff in here.  Basically I had
same question David did on when this was useful.

Otherwise, seems fine to me. Sashiko raised a concern about a particular
sequence of blocks being added. =20
https://sashiko.dev/#/patchset/20260611-iio-dma-cyclic-buffer-support-v1-1-=
bcf00e8d802c%40analog.com
I don't really understand this code well enough to be sure if the issue
is real or not!

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
> There's one subtle choice in here. Given that the termination callback
> is not set. We will never give the block refcount. That means cyclic
> blocks are only completely freed when we disable the buffer and
> iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> as it makes it more simple to handle. I also think this a fair
> expectation from a cyclic transfer. We set it up and let it run until we
> disable the buffer.

To me that seems fine

>=20
> Alternatively, we can give in the refcount as soon as we give the block
> to the DMA layer with dma_async_issue_pending(). But we also need to
> make sure that the block is not added to the dmaengine_buffer->active lis=
t.
> As said, I feel that the current approach is just simpler.
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++=
---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index 98acce909854..4a78cd3e7c7d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio=
_dma_buffer_queue *queue,
>  		dma_dir =3D DMA_MEM_TO_DEV;
> =20
>  	if (block->sg_table) {
> +		unsigned long flags;
> +
>  		sgl =3D block->sg_table->sgl;
>  		nents =3D sg_nents_for_len(sgl, block->bytes_used);
>  		if (nents < 0)
> @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
>  			sgl =3D sg_next(sgl);
>  		}
> =20
> +		if (block->cyclic)
> +			flags =3D DMA_PREP_REPEAT;
> +		else
> +			flags =3D DMA_PREP_INTERRUPT;
> +
> +		/*
> +		 * There's nothing preventing a cyclic transfer to replace an active
> +		 * cyclic one. So always set the EOT flag.
> +		 */
>  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
>  							 vecs, nents, dma_dir,
> -							 DMA_PREP_INTERRUPT);
> +							 flags | DMA_PREP_LOAD_EOT);
>  		kfree(vecs);
>  	} else {
>  		max_size =3D min(block->size, dmaengine_buffer->max_size);
> @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct =
iio_dma_buffer_queue *queue,
>  	if (!desc)
>  		return -ENOMEM;
> =20
> -	desc->callback_result =3D iio_dmaengine_buffer_block_done;
> -	desc->callback_param =3D block;
> +	if (!block->cyclic) {
> +		desc->callback_result =3D iio_dmaengine_buffer_block_done;
> +		desc->callback_param =3D block;
> +	}
> =20
>  	cookie =3D dmaengine_submit(desc);
>  	if (dma_submit_error(cookie))
>=20
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20

