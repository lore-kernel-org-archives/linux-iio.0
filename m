Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702208;
	b=C3H4w/83aVSVklc8OEARSOW1p00Rrsrzidgd1AUzIMXg0UiyJCW5tWrQXdsDz1X6KOwL
	 NR9jBMcEpKZO9LvYjRH98ofFDexW4860ti09NjQiDxCka/8r0Mxtlg12/ddX0I/majhr3
	 w8XXhLtXvzGvg8brizqqEUBVCFWBdIZil8zwfzaEyVkuSaFZr3oDRzs+ZX001b752x2VU
	 XJBKtFOhoaM0VaGeKmLCAw8jzKUE5iZ5HWjTMwKyXqzbZ0ZLwdaHtjSKM/bA+nta+wPBN
	 J7+71rWUCh4RW4oiI/qvUwDxj+mAZTTTCOwB9D4RfI9qDNRiq6fIfkDAxGr55aAk9gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=upNdzqa2Yr+dsS/pV1xOv7YPOmRw/ecj+eAdrBYpC0k=;
	b=rBVu5DoKySQo086x42sa1ZYOy/YpmFHOehoJPFu5BNK4NQst80bIRGXsA/SwkRJdP5nu
	 K5mQqLqw6Gyln5j3hR8bXZCX9nny23tBt1XFq47cdMGfNYdtyqbRks1qhvyB+qlxeRV/3
	 syAL3nt2lwGAo4h9QYdLQ1X4j1P7j6fdKRKsEa67Z2YYWsoQGZGzg9lWcmFYYYDjwvLQ7
	 uZuPR2kyzaAyp6GZAn78sMhGla5cly2xJ9RkYBqCYITIT/W0PeEZw77eeoaTKx2GKnG70
	 BsrYuCaflS9pjqmCD0wF0u3uP8fdQH1U0KYaamgG1P2HNAq6r5GfGMFA9fvjsry0rOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btjXOEBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715E606A323;
	Sun, 15 Nov 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btjXOEBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12CC1F000C4;
	Sun, 15 Nov 2026 00:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702208;
	bh=upNdzqa2Yr+dsS/pV1xOv7YPOmRw/ecj+eAdrBYpC0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=btjXOEBZ9004Sp+/BokRY0GmO1d0Dl+Uhz2yMQAEILSt4orkFjrN0Avg3vNZ377lH
	 iiEe/RCVBfAY0VyR9yp1DKOH9bEfrSs9EXVcsNpeHED/ZMk1/SLBdny3Ml33l/OH35
	 cTEyKBX3MIHD2HKZzhhst2qJRJ2CMzz+WJId6B7/o09kkTBCQCNZLIhdAXLm5afAVR
	 3V/n6le+/2g9VDmuyezrvpdwrtHdopxbiG92wW6eU6ZcDCzm9ooLDfsxVdzO81KGBO
	 Nu97dr88GL9Hshc2Gzn5h1d90U3jXgbsDD20MEPqeqERNQxtYf07uszcCzqgonWmu9
	 PC7SLeuDnzErQ==
Date: Sun, 15 Nov 2026 00:23:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/15] iio: buffer: let the block keep its DMA fence
Message-ID: <20261115002320.78ade93e@jic23-hlaptop>
In-Reply-To: <-TPmKHsgTdWh1jJ4sxKceg@bootlin.com>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-1-0d818334f6c7@linuxfoundation.org>
	<-TPmKHsgTdWh1jJ4sxKceg@bootlin.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 16:43:14 +0100
Beno=C3=AEt Monin <benoit.monin@bootlin.com> wrote:

> On Tuesday, 27 October 2026 at 17:19:05 CET, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > iio_buffer_enqueue_dmabuf() hands a plain pointer to the fence to the
> > buffer implementation, which keeps it in block->fence, and since the fix
> > for the fence leak it drops the initial reference right after
> > dma_resv_add_fence(). The only reference left is the one of the
> > reservation object.
> >=20
> > That one does not last until the fence is signalled. dma_resv_add_fence=
()
> > replaces and puts a fence as soon as a later fence of the same context =
and
> > the same usage is added. All the fences of an attachment share a contex=
t,
> > and an enqueue on an output buffer only waits for the writers, not for =
the
> > read fence of the enqueue before it. A second IIO_BUFFER_DMABUF_ENQUEUE=
 of
> > a buffer which is still queued is refused by iio_dma_can_enqueue_block(=
),
> > but by then its fence has taken the place of the first one. When the DMA
> > is done, iio_buffer_signal_dmabuf_done() signals a fence which has been
> > freed and schedules the work item in it.
> >=20
> > The leak came from the reference which iio_buffer_signal_dmabuf_done()
> > takes and iio_buffer_cleanup() drops: with it nobody dropped the initial
> > one. Do not take it, and leave the initial reference to the block until
> > the cleanup.
> >=20
> > Fixes: a09399935508 ("iio: buffer: Fix DMA fence leak in iio_buffer_enq=
ueue_dmabuf()")
> > Cc: stable <stable@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: "Beno=C3=AEt Monin" <benoit.monin@bootlin.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Having the block and the reservation each hold a reference to the fence i=
s a
> better fix than mine.
>=20
> Reviewed-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

I lost track of this one (just doing a check on stuff outstanding in patchw=
ork)
 but seems folk are happy who know more about this bit of code than I do!

Applied to the fixes-togreg branch of iio.git

>=20
> >  drivers/iio/industrialio-buffer.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index 4294101810fd..a2386dba497c 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1931,9 +1931,14 @@ static int iio_buffer_enqueue_dmabuf(struct iio_=
dev_buffer_pair *ib,
> >  	if (ret)
> >  		goto err_queue_unlock;
> > =20
> > +	/*
> > +	 * The reservation object takes a reference of its own, and drops it =
as
> > +	 * soon as a later fence of this attachment takes the place of this
> > +	 * one. The initial reference stays with the block, which points to t=
he
> > +	 * fence until iio_buffer_cleanup() has run.
> > +	 */
> >  	dma_resv_add_fence(dmabuf->resv, &fence->base,
> >  			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
> > -	dma_fence_put(&fence->base);
> >  	dma_resv_unlock(dmabuf->resv);
> > =20
> >  	cookie =3D dma_fence_begin_signalling();
> > @@ -1989,18 +1994,12 @@ void iio_buffer_signal_dmabuf_done(struct dma_f=
ence *fence, int ret)
> >  		container_of(fence, struct iio_dma_fence, base);
> >  	bool cookie =3D dma_fence_begin_signalling();
> > =20
> > -	/*
> > -	 * Get a reference to the fence, so that it's not freed as soon as
> > -	 * it's signaled.
> > -	 */
> > -	dma_fence_get(fence);
> > -
> >  	fence->error =3D ret;
> >  	dma_fence_signal(fence);
> >  	dma_fence_end_signalling(cookie);
> > =20
> >  	/*
> > -	 * The fence will be unref'd in iio_buffer_cleanup.
> > +	 * The reference of the block will be dropped in iio_buffer_cleanup.
> >  	 * It can't be done here, as the unref functions might try to lock the
> >  	 * resv object, which can deadlock.
> >  	 */
> >=20
> >  =20
>=20
>=20
>=20

