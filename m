Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694740;
	b=TMIBACYyQ3iqxF0wNmS/w7F8OcRMfH+tkwnJqrhS8Mp64xEjBkJrRu2zlfR65VGzWf3k
	 oLTAqxhKgk+SB8UAd648YJ8WpGRmjK13BdbgSG6Gla6gshyHsOq/2YBIVJN/91CmldzOb
	 MvoK+EWqrhV/2/YKUgN+KWCAZsJRs5JjYyhDCrwMOMmAWGx9+/5WveIMhs/deDECc4W4y
	 mSh9doWwgvMoHbw56QQH/VGw7f3j+knT/KoKOG8Qm6yh62FJCh3xgApZM7GBxe3wS57gv
	 w9xFjFjDowaC1h27yNQ2cRPMqcl6PGFO4YUL2n4qv6Nmja1l+SM5mwPcKUu8S/kVIJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Zh7k1ZPWNc4oLOSJMtDyh6ayo6V35k80jgDoy7jSBAc=;
	b=UccuaG+by9rsdoM4ZZZCp4lYhqg0GITvw33B0WcamytHJOX5/C+tsMgLDIRNvoVlePvI
	 gcYn/jyILovVW1/xBo+HcuuGrrALWM6eEuztw2u96ntjKggO4RSMDv6vBhGntz78+u8fj
	 WfWs37pBoG90uxGhzzlxhQVkT8eEq/gyyXEcO/4jVTJD5MAv8dgsqdeHyDsc7hKNQLdbG
	 XRSWxLdrFuN/mxlbEj3kD3fHIS5Flsh2qU1fWVOjwzCY/v0OVg9SjYoA3srvkN+qVPWQi
	 V74Jq+MKVyI0AaJvU8BvE1KEw03i91wuTwHjyMVam3i67rfzwvUxkeULeTIvbnidofA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIoZttLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76E606A323;
	Sat, 14 Nov 2026 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIoZttLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4971F000C4;
	Sat, 14 Nov 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694740;
	bh=Zh7k1ZPWNc4oLOSJMtDyh6ayo6V35k80jgDoy7jSBAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oIoZttLqRswzn6iGz/YHMxJvnXh5oCTh5rlveoMJONVzGDxpmv4vu9Hc47N1MVRUg
	 PLiY3LcKut384a9dS0wAxA8rSWYSG9DE8rHttbvqtWj7xqZnf39eF9U+iNqnUMP5tO
	 sinEvElAP9yEno3d5xwYTWyI+iYHggL/J66toidutfXqugrrMa14qlSaopyJcNt57S
	 YfXzZo5nVp409kqkHybpUToaHwtNyyPgxzF8ZCDGNrXHrbLMX2EcNFFafeburDHJoN
	 mcv8DkeEptSLuPCYs+5ABJAuQCLxrJXZYWyYv97P6fMaF8kS4tS6PUUTuzcuhOOhmn
	 p9UHhGIt38i9Q==
Date: Sat, 14 Nov 2026 22:18:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Yaohan Li <shunsheng1218@gmail.com>, dlechner@baylibre.com,
 andy@kernel.org, paul@crapouillou.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hold a reference while DMA-BUF is attached
Message-ID: <20261114221854.14f76951@jic23-hlaptop>
In-Reply-To: <avH2RxfPwDrhthA8@nsa>
References: <179378580164.73301.2666197876060323279@gmail.com>
	<avH2RxfPwDrhthA8@nsa>
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

On Mon, 9 Nov 2026 17:18:54 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Wed, Nov 04, 2026 at 05:50:01PM +0800, Yaohan Li wrote:
> > iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
> > attachment without taking a buffer reference. A delayed DMA fence
> > completion can release the attachment after the IIO device has been
> > unbound and its buffer freed. The release callback then dereferences
> > the stale buffer while detaching the DMA-BUF.
> >=20
> > Take a reference when storing the buffer in the attachment, and drop
> > it after the final detach or when the attach operation fails. This
> > keeps the buffer alive for the asynchronous completion path.
> >=20
> > A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
> > the use-after-free on the unmodified kernel. The same delayed
> > completion sequence produced no report with the change applied.
> >=20
> > Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructu=
re")
> > Assisted-by: ZCode:GLM-4
> > Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
Applied to the fixes-togreg branch of iio.git.

> > --- =20
>=20
> Yes, the change looks reasonable to me! Assuming the cdev is closed and
> userspace detaches the block before the unbind we do force all dma to
> terminate on unbind and the cleanup path does shedule_work() for
> the fence and so iio_dev_release() might drop the last reference to the
> buffer before the fence callback is called.
>=20
> The whole thing is a bit hard to reason so unless someone has strong
> evidence the weak reference can be used, I would very much take the
> patch. Hence:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> >  drivers/iio/industrialio-buffer.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index 4294101810fd7..bfa6d19471126 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1597,6 +1597,8 @@ static void iio_buffer_dmabuf_release(struct kref=
 *ref)
> > =20
> >  	buffer->access->detach_dmabuf(buffer, priv->block);
> > =20
> > +	iio_buffer_put(buffer);
> > +
> >  	dma_buf_detach(attach->dmabuf, attach);
> >  	dma_buf_put(dmabuf);
> >  	kfree(priv);
> > @@ -1741,7 +1743,13 @@ static int iio_buffer_attach_dmabuf(struct iio_d=
ev_buffer_pair *ib,
> >  	}
> > =20
> >  	kref_init(&priv->ref);
> > -	priv->buffer =3D buffer;
> > +	/*
> > +	 * Hold a reference for the asynchronous dmabuf completion path
> > +	 * (iio_buffer_cleanup() -> iio_buffer_dmabuf_put() may run from a
> > +	 * work item after the device has been unbound); released in
> > +	 * iio_buffer_dmabuf_release().
> > +	 */
> > +	priv->buffer =3D iio_buffer_get(buffer);
> >  	priv->attach =3D attach;
> >  	attach->importer_priv =3D priv;
> > =20
> > @@ -1789,6 +1797,7 @@ static int iio_buffer_attach_dmabuf(struct iio_de=
v_buffer_pair *ib,
> >  err_dmabuf_put:
> >  	dma_buf_put(dmabuf);
> >  err_free_priv:
> > +	iio_buffer_put(priv->buffer);
> >  	kfree(priv);
> > =20
> >  	return err;
> > --=20
> > 2.34.1
> >  =20

