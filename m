Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9573FDBFC;
	Tue, 26 May 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819596; cv=none; b=RjwoooboP0oGGSbTg0gBxwXcZgmniXtxmmCMPYYO5dmuaOLSDXTHduhzv4kZZAKWsp1Bby8MisUPatoVVGXU4AFqJmhZuBkTN/GEoxZw+tMWqvuuxjn/mC0Cbf52DNHL7083D5ZO1MHmeVEU1RjeXXvZnkYMA5eHobHzpsD2z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819596; c=relaxed/simple;
	bh=ckoeqZafEukKz7LFikoI/69y6RBw4BLtCixmQzSYWv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b04APlFBjx0j5+TXUOS+dZZMGSUSJsSinY8Z1oP9z8kwb58r1zXmwOBkiojnLjfLj6Bko3mFU91LekgvoRMefeUWTymWeg6NqFMD6s5emf6azzWYGB9LAggK+Eu2xmvk6O++gI5IxwBpHhkBgx1y3cr0XqDQp+lcttEZB0G0nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksXUcxKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksXUcxKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDA81F000E9;
	Tue, 26 May 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819595;
	bh=N5dd5988xeBFwQrS56/lS0x22ZQsf4l5Vc75O7S6yYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ksXUcxKtVXOBwlEJIA8BWNr66AtUt+ftKbCCV6EUSrmF4w/u8WRX23XDPnO713Xy3
	 TmXqoRCj9Q/VLIdUc4h4fxdeSvpU0RG4NcgbajJyoWSX1mQvcGzRKhx4CT5ofWFBLZ
	 gEb7HPRwjX9dGRmoaN6MIFKCSXwwXKUABNKKIRwINfvittmf+/bHrNcTk45Vo7K3bs
	 YJUJVqMyCiz3OGE1MRWiA/4GjvKHvAjp1aoWeOijgjT9JQYNLLkfhTomIx0Npk8wPG
	 B3nNUEtRDgbS12tL8FpjEHg2T+jJJ8LXad1p1gelXWvoHV/B/kfRnHqug6Rep1O46d
	 LLN+2idsyoJjw==
Date: Tue, 26 May 2026 19:19:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, Nuno Sa <nuno.sa@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <20260526191946.409160c8@jic23-huawei>
In-Reply-To: <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
	<CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 08:20:31 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Mon, May 25, 2026 at 2:17=E2=80=AFAM Dan Carpenter <error27@gmail.com>=
 wrote:
> >
> > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > going to work at all.  Check for that at the start of the function and
> > return -EINVAL.
> > =20
>=20
> Commit message is incorrect, it looks like you're returning -ENOSPC here.=
..
Tweaked and applied to the fixes-togreg branch of iio.git + marked for stab=
le.

thanks,

J
>=20
> >
> > Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/iio/industrialio-backend.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-backend.c
> > index 138ebebc9c0d..4763e224ebc6 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -156,7 +156,7 @@ static ssize_t iio_backend_debugfs_write_reg(struct=
 file *file,
> >         ssize_t rc;
> >         int ret;
> >
> > -       if (count >=3D sizeof(buf))
> > +       if (*ppos !=3D 0 || count >=3D sizeof(buf))
> >                 return -ENOSPC;
> > =20
>=20
> See above comment.
>=20
> best regards,
> max
>=20
>=20
> >
> >         rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userb=
uf, count);
> > --
> > 2.53.0
> >
> > =20

