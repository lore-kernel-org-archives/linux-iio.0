Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1733EB17
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148338; cv=none; b=JKEsmoKTdYyrTSYJTdcIR8yx7lS9yy2tgIMKRtFMb6Ei2YGEznBOEhJUuSTF8NChbunBltt64lOMqOvsS7lBXmMoMlZE9SyAb5GsEa9JorK68tsxGQIW6qnhxEdeod6edN0+TrCQxK46QJ9IrMPmZ4ExbWj3zJkIjIMNQ0di6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148338; c=relaxed/simple;
	bh=bANqvlVgXdyPhVHeLwuYcSTVkrqxuajRgC8QA7F6FDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa7Gkosx3L/2TDnvuwHYbEl0uEIRYnzETYLLCxwrvsR72G7qrMebK/JEQRVSyAbK0OHkrrXGEz/tB8x6BsosqZXQiDWD7f4Z2yihTNRTpv5DkybGSPlAcV1yz6utoPozxta+ZRqt4rqqm77mwvDSMbn5cTNJurNWtSbaayHO+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5N3KyMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5N3KyMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587241F000E9;
	Mon, 22 Jun 2026 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148336;
	bh=11xRNzVGhz8ro75g/D5xMU90IXrUCSrbnwVC6qGzBhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D5N3KyMI7vz+wkxSMMYiXYs5SMHWVEeG6sOIEg8B6O+G+8pPFopQ/TXTcX42eERls
	 p+EQYVnzgzEeHNuGs3AurCsfaSNTnTO277lAkyr861lbhQRkmpTMhb6fF5CDieiiM1
	 bqTGhF1jktP1LvxNBUL7x/Lyn2WcK7gXL7BdxoYDlu6dB+HKZa7scVax4BoO76+tFZ
	 IQ1ZJIOSzC3YXCW6+t+Z4lzMk8f2lYWKqmXjZSq0hVcuEJHMbTC0/N8gdF0JY8It4V
	 LVglmMXxi7mZm0sFpY0MTuQAlGlaHKQkaW72uHcwAlFEo3zaamYkB/+mK9qJQyPVVr
	 B0+xlNF5oC4MQ==
Date: Mon, 22 Jun 2026 18:12:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <20260622181209.791dfc6f@jic23-huawei>
In-Reply-To: <ajk1FX-d_KoW14f-@nsa>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
	<e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>
	<ai-0CIqteaSJJkau@nsa>
	<ajk1FX-d_KoW14f-@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 14:15:50 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jun 15, 2026 at 09:21:02AM +0100, Nuno S=C3=A1 wrote:
> > On Sat, Jun 13, 2026 at 11:33:36AM -0500, David Lechner wrote: =20
> > > On 6/11/26 10:28 AM, Nuno S=C3=A1 via B4 Relay wrote: =20
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Allow buffer blocks flagged as cyclic to be submitted as repeating =
DMA
> > > > transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine kee=
ps
> > > > replaying the descriptor. =20
> > >=20
> > > Is this for both directions (e.g ADCs and DACs) or only one? =20
> >=20
> > We just have usecases of TX buffers. IIRC, there should be some
> > validation (some layers above in the call chain) not allowing cyclic RX=
. =20
> > >  =20
> > > >=20
> > > > Skip installing the completion callback for cyclic blocks. Since the
> > > > transfer is continuously replayed, the callback would fire on every
> > > > period, throwing off the block refcount.
> > > >=20
> > > > Because nothing prevents a new cyclic transfer from replacing an
> > > > already active cyclic one, always set DMA_PREP_LOAD_EOT so the engi=
ne
> > > > correctly terminates the active transfer before loading the new
> > > > descriptor. =20
> > >=20
> > > Is there more to come after this to actually make use of it? Or is th=
ere
> > > a way to use this with DMABUF from userspace already? =20
> >=20
> > Yes. One can do TX cyclic DMA transfer today. Some waveforms examples:
> >=20
> > https://github.com/analogdevicesinc/iio-oscilloscope/tree/main/waveforms
> >=20
> > For normal non cyclic transfers, libiio also handles DMABUF just fine.
> > Best way to use it is with USB where we support zero copy between IIO
> > and the USB stack. =20
>=20
> Jonathan,
>=20
> It seems there's not much activity on this one. What do you think about
> the changes?
>=20
> David, from you silence either you forgot about it or I guess you
> are happy with the reply :)
>=20
> Just trying to move this one forward

Fiddly thing so I wanted to leave it till I'm up to date with the easier
stuff. 303 emails to go... Also going to be travelling later this
week and it's always a bit random if that means I have lots of time
to review or none at all.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >  =20
> > >  =20
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > There's one subtle choice in here. Given that the termination callb=
ack
> > > > is not set. We will never give the block refcount. That means cyclic
> > > > blocks are only completely freed when we disable the buffer and
> > > > iio_dmaengine_buffer_abort() get's called. So no leak, we just defe=
r it
> > > > as it makes it more simple to handle. I also think this a fair
> > > > expectation from a cyclic transfer. We set it up and let it run unt=
il we
> > > > disable the buffer. =20
> > >=20
> > > Makes sense.
> > >  =20
> > > >=20
> > > > Alternatively, we can give in the refcount as soon as we give the b=
lock
> > > > to the DMA layer with dma_async_issue_pending(). But we also need to
> > > > make sure that the block is not added to the dmaengine_buffer->acti=
ve list.
> > > > As said, I feel that the current approach is just simpler.
> > > > ---
> > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++=
++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/d=
rivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > index 98acce909854..4a78cd3e7c7d 100644
> > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(stru=
ct iio_dma_buffer_queue *queue,
> > > >  		dma_dir =3D DMA_MEM_TO_DEV;
> > > > =20
> > > >  	if (block->sg_table) {
> > > > +		unsigned long flags;
> > > > +
> > > >  		sgl =3D block->sg_table->sgl;
> > > >  		nents =3D sg_nents_for_len(sgl, block->bytes_used);
> > > >  		if (nents < 0)
> > > > @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(st=
ruct iio_dma_buffer_queue *queue,
> > > >  			sgl =3D sg_next(sgl);
> > > >  		}
> > > > =20
> > > > +		if (block->cyclic)
> > > > +			flags =3D DMA_PREP_REPEAT;
> > > > +		else
> > > > +			flags =3D DMA_PREP_INTERRUPT;
> > > > +
> > > > +		/*
> > > > +		 * There's nothing preventing a cyclic transfer to replace an ac=
tive
> > > > +		 * cyclic one. So always set the EOT flag. =20
> > >=20
> > > What about the non-cyclic case? =20
> >=20
> > Non cyclic will also have DMA_PREP_LOAD_EOT which should stop an ongoing
> > cyclic transfer. If there's an active, non cyclic, it's business as
> > usual. The transfer get's queued and will fire after the current one
> > ends. IOW, DMA_PREP_LOAD_EOT is only meaningful for active cyclic
> > transfers (it's ignored for non-cyclic)
> >=20
> > - Nuno S=C3=A1
> >  =20
> > >  =20
> > > > +		 */
> > > >  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->cha=
n,
> > > >  							 vecs, nents, dma_dir,
> > > > -							 DMA_PREP_INTERRUPT);
> > > > +							 flags | DMA_PREP_LOAD_EOT);
> > > >  		kfree(vecs);
> > > >  	} else {
> > > >  		max_size =3D min(block->size, dmaengine_buffer->max_size);
> > > > @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(s=
truct iio_dma_buffer_queue *queue,
> > > >  	if (!desc)
> > > >  		return -ENOMEM;
> > > > =20
> > > > -	desc->callback_result =3D iio_dmaengine_buffer_block_done;
> > > > -	desc->callback_param =3D block;
> > > > +	if (!block->cyclic) {
> > > > +		desc->callback_result =3D iio_dmaengine_buffer_block_done;
> > > > +		desc->callback_param =3D block;
> > > > +	}
> > > > =20
> > > >  	cookie =3D dmaengine_submit(desc);
> > > >  	if (dma_submit_error(cookie))
> > > >=20
> > > > ---
> > > > base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> > > > change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> > > > --
> > > >=20
> > > > Thanks!
> > > > - Nuno S=C3=A1
> > > >=20
> > > >  =20
> > >  =20

