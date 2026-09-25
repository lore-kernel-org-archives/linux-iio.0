Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833841E3DDE;
	Fri, 25 Sep 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302594; cv=none; b=cXfm9ruM26wlwhFR8GI5+QpcJFxy4jnV0JwZVpArrwr7jsFHJVYfftTQE7/iMlHnPwu+yxY6Oj7hUhPkbIMc9Ca5pQHdGMaAqQ2JsXa9UT/5SK/SZmxThCxF8+8Ca0iwHhqAw+CaqcPjC5dsAH/9Yn4d3K3d1TVeWMmdjkZrGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302594; c=relaxed/simple;
	bh=nwDZRUpbW+sl/1BlQvKnTjIDOmGZ1WR1a2f9BlhW2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUAXGdmX3lFiYZspkFs77g4rYXSnovBKWEeM7/piHltkBjWxUA8gS1PQEeqJNtIDaePC/LzPbz4fOeKa1/rvWN7mBwwyKJv+b2uUpU9FuWl8hIQjL4cNiByeriGQniizaWyyqAWkR0g99iOaZTLw7fqQRnQA6F3OqFgbwd15NPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdT+VvMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdT+VvMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A281F000FF;
	Fri, 25 Sep 2026 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302593;
	bh=sYeLxyM2j0uA2+JWeo6SIwwPev+dyI/FUSU1mDSdQi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CdT+VvMuu2q6TysO0FeMqM76Iw9eXMFhkMUR3f4OuO+0VQvEjYGlkAb7gs0+mzSsk
	 4Yzqui0/omzJL7Uj6jIfdbQD37bzvZE+evC1om2XC4J6kszF7PAWOwqQ7jRey5vV76
	 T6P2QBST+Ajd8fLSrWE+byjShufGcGSoB0iCzqAqyeBZDdNtWUCK5f3hpAG5Cmzfu9
	 0nxPVYvBXJwISRCy6Cpxkj8N//dFnBch6Tkp9pKRUdf7SV2wG3cUuBcJIM04M4tWFP
	 LyiJGPoidK5cpjM76NVf30OnOt7zNwl8ByupyPDDN8nO/53eicaAp4363pO1kFJGX4
	 y6ElvNn0suGWw==
Date: Fri, 25 Sep 2026 03:16:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Jinseob Kim <kimjinseob88@gmail.com>, dlechner@baylibre.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: serialize buffer teardown with mode claims
Message-ID: <20260925031629.197e233c@jic23-hlaptop>
In-Reply-To: <arTeK0QadzWkI6jH@nsa>
References: <20260921062421.64647-1-kimjinseob88@gmail.com>
	<arTeK0QadzWkI6jH@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2026 09:24:33 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Mon, Sep 21, 2026 at 03:24:21PM +0900, Jinseob Kim wrote:
> > Buffer-mode claims hold mlock to guarantee that the device remains in
> > buffer mode until the claim is released. Normal buffer updates take
> > info_exist_lock followed by mlock in iio_update_buffers().
> >=20
> > However, iio_device_unregister() disables and deactivates all buffers
> > without taking mlock. This can invalidate buffer state, including
> > active_scan_mask, while a buffer-mode claim is held.
> >=20
> > Take mlock in iio_disable_all_buffers() so that unregister honors the
> > mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
> > matches iio_update_buffers().
> >=20
> > Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_b=
uffer_mode() APIs")
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for
stable inclusion. It should be safe enough but I do want to get
some testing on this. Crossed fingers!

Thanks,

Jonathan

>=20
> >  drivers/iio/industrialio-buffer.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index 2c9ec93dff47..d60bad5492e7 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1377,6 +1377,10 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
> > =20
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev)
> >  {
> > +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev=
);
> > +
> > +	guard(mutex)(&iio_dev_opaque->mlock);
> > +
> >  	iio_disable_buffers(indio_dev);
> >  	iio_buffer_deactivate_all(indio_dev);
> >  }
> >=20
> > base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
> > --=20
> > 2.43.0
> >  =20

