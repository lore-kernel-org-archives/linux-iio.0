Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544883D76
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468937; cv=none; b=RkJxfflPlKiV95TRg1ec01u3tE/cq2di+LUOKUHhp1UWA1yafTM2reKg1za7TCyNRfIZg7RwrPxcE/Q7ImQmWufs2rN8GYJtK9SjVTBREgg9bhYRn58j7zVAKtsZ9MI1yUM8hoWKHIE5szArG9iOde6rsC1WaKOOCHS4M9CVRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468937; c=relaxed/simple;
	bh=o7kmvKoW1F2LV/x8ZNDA7ofat3e1fgUcE4DctDmVLQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiSIZgHEo9qOGlaDijmVQ6kXT85mqxsMtB9m4NiHUUius87KYdIeD7+xgWU5rK5aDL8a3wbjyIoU7Wf+E7bzELAzE6dkR8rxmMS7/it1gAf9E23LeVFozeiJoH581eAMIHDEWB30dDt89oBc969dtx9Oq2OYgg+H8z5quotlIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwIlxIt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwIlxIt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697341F000E9;
	Wed,  8 Jul 2026 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468936;
	bh=bE7RyZIPp9Yn8sq4vvjr0u8ob1ZEskHFrOAsxoGZ1mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jwIlxIt0WxepxD1Gs2ZkW8zfkMItiQoyIH4zbvLnp+/Jlp2VAlxHO2GC/FN9sDZ7Q
	 qioN5b5sS0vW1X7oKjXKAoh/YMs5fEnPvKckWcm2NyTQg0WVw8klUVDZAS5tslXJ9x
	 syAgGyrCKJaVdP+S7P5AuiTSo/2mwVYRP4CeR+SFKkiMHVrhAlsw3f9Rzl7YYKtt+o
	 U3M4PGU7LrfZBeilZaKupQ+POuKOk1shWn/ooSrG6XQDII1HpYOARADezTdBTiiFcH
	 /OukwyMa7kS/UU6VqpetbXRm7Ay8WHYQR//RVs/EkZ47PKEcp49sOBczB3BocOrcJ4
	 n2NhJmNJ3i5kg==
Date: Wed, 8 Jul 2026 01:02:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <20260708010213.3e91171d@jic23-huawei>
In-Reply-To: <akzZKkI_xWGNg4gq@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
	<20260703195238.271aa219@jic23-huawei>
	<akt6IDED7qwtkM7t@nsa>
	<20260706164719.3e8196ce@jic23-huawei>
	<akzZKkI_xWGNg4gq@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jul 2026 11:51:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jul 06, 2026 at 04:47:19PM +0100, Jonathan Cameron wrote:
> > On Mon, 6 Jul 2026 11:07:58 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Fri, Jul 03, 2026 at 07:52:38PM +0100, Jonathan Cameron wrote: =20
> > > > On Thu, 11 Jun 2026 16:28:57 +0100
> > > > Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> w=
rote:
> > > >    =20
> > > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > >=20
> > > > > Allow buffer blocks flagged as cyclic to be submitted as repeatin=
g DMA
> > > > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine k=
eeps
> > > > > replaying the descriptor.
> > > > >=20
> > > > > Skip installing the completion callback for cyclic blocks. Since =
the
> > > > > transfer is continuously replayed, the callback would fire on eve=
ry
> > > > > period, throwing off the block refcount.
> > > > >=20
> > > > > Because nothing prevents a new cyclic transfer from replacing an
> > > > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the en=
gine
> > > > > correctly terminates the active transfer before loading the new
> > > > > descriptor.
> > > > >    =20
> > > > I'd like a little more use case stuff in here.  Basically I had
> > > > same question David did on when this was useful.   =20
> > >=20
> > > Alright! I'll re-spin with an improved commit message.
> > >  =20
> > > >=20
> > > > Otherwise, seems fine to me. Sashiko raised a concern about a parti=
cular
> > > > sequence of blocks being added. =20
> > > > https://sashiko.dev/#/patchset/20260611-iio-dma-cyclic-buffer-suppo=
rt-v1-1-bcf00e8d802c%40analog.com
> > > > I don't really understand this code well enough to be sure if the i=
ssue
> > > > is real or not!   =20
> > >=20
> > > Hmm I mean, for the same block it's not a problem as we return -EBUSY.
> > > Now for the below:
> > >=20
> > > "Could an unprivileged user repeatedly attach and enqueue new DMABUFs=
 as
> > > cyclic"
> > >=20
> > > Don't think the "unprivileged" part is true but a privileged one could
> > > in theory just keep the list growing until we disable the buffer. But
> > > this is part of the choice done in the patch note and AFAIU,
> > > dmabuf-fences also have this kind of "don't unref me right away"
> > > behavior. =20
> > Should we perhaps set a defensive cap given we think this is unreasonab=
le
> > behaviour?  So fail to queue a new one if the backlog is 16 long or som=
ething
> > like that? =20
>=20
> I guess we can add that for some piece of mind. In reality I'm not even
> aware of any usecase where we enqueue more than one cyclic transfer so a
> backlog of 16 should be more than enough! I just allowed one cyclic to
> end another one because I don't see any technical reason for not allowing=
 it.
>=20
Then maybe cap it at one until we have that usecase.

> - Nuno S=C3=A1
>=20
> >=20
> > J =20
> > >=20
> > > - Nuno S=C3=A1
> > >  =20
> > > >    =20
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > ---
> > > > > There's one subtle choice in here. Given that the termination cal=
lback
> > > > > is not set. We will never give the block refcount. That means cyc=
lic
> > > > > blocks are only completely freed when we disable the buffer and
> > > > > iio_dmaengine_buffer_abort() get's called. So no leak, we just de=
fer it
> > > > > as it makes it more simple to handle. I also think this a fair
> > > > > expectation from a cyclic transfer. We set it up and let it run u=
ntil we
> > > > > disable the buffer.   =20
> > > >=20
> > > > To me that seems fine
> > > >    =20
> > > > >=20
> > > > > Alternatively, we can give in the refcount as soon as we give the=
 block
> > > > > to the DMA layer with dma_async_issue_pending(). But we also need=
 to
> > > > > make sure that the block is not added to the dmaengine_buffer->ac=
tive list.
> > > > > As said, I feel that the current approach is just simpler.
> > > > > ---
> > > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++=
++++++++---
> > > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b=
/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > index 98acce909854..4a78cd3e7c7d 100644
> > > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(st=
ruct iio_dma_buffer_queue *queue,
> > > > >  		dma_dir =3D DMA_MEM_TO_DEV;
> > > > > =20
> > > > >  	if (block->sg_table) {
> > > > > +		unsigned long flags;
> > > > > +
> > > > >  		sgl =3D block->sg_table->sgl;
> > > > >  		nents =3D sg_nents_for_len(sgl, block->bytes_used);
> > > > >  		if (nents < 0)
> > > > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(=
struct iio_dma_buffer_queue *queue,
> > > > >  			sgl =3D sg_next(sgl);
> > > > >  		}
> > > > > =20
> > > > > +		if (block->cyclic)
> > > > > +			flags =3D DMA_PREP_REPEAT;
> > > > > +		else
> > > > > +			flags =3D DMA_PREP_INTERRUPT;
> > > > > +
> > > > > +		/*
> > > > > +		 * There's nothing preventing a cyclic transfer to replace an =
active
> > > > > +		 * cyclic one. So always set the EOT flag.
> > > > > +		 */
> > > > >  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->c=
han,
> > > > >  							 vecs, nents, dma_dir,
> > > > > -							 DMA_PREP_INTERRUPT);
> > > > > +							 flags | DMA_PREP_LOAD_EOT);
> > > > >  		kfree(vecs);
> > > > >  	} else {
> > > > >  		max_size =3D min(block->size, dmaengine_buffer->max_size);
> > > > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block=
(struct iio_dma_buffer_queue *queue,
> > > > >  	if (!desc)
> > > > >  		return -ENOMEM;
> > > > > =20
> > > > > -	desc->callback_result =3D iio_dmaengine_buffer_block_done;
> > > > > -	desc->callback_param =3D block;
> > > > > +	if (!block->cyclic) {
> > > > > +		desc->callback_result =3D iio_dmaengine_buffer_block_done;
> > > > > +		desc->callback_param =3D block;
> > > > > +	}
> > > > > =20
> > > > >  	cookie =3D dmaengine_submit(desc);
> > > > >  	if (dma_submit_error(cookie))
> > > > >=20
> > > > > ---
> > > > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > > > --
> > > > >=20
> > > > > Thanks!
> > > > > - Nuno S=C3=A1
> > > > >=20
> > > > >    =20
> > > >    =20
> >  =20

