Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3540912F;
	Fri, 22 May 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461998; cv=none; b=uMv5jor9ans2PFY6M99m+/Xm6C3akg0U9BJG6TvtJPsZEtCsH7RKOGeihrK3LWaGjTFwQWxdknA3h2Qw0iQavJRSc11dSIhZadsF5zKCrGFcPlENwQvp2s92T+VK9JC+jHIxzZtHCPgzMKODTVnWKZHWZaWH4lHzjER8yRSgkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461998; c=relaxed/simple;
	bh=Ujm5ZtpU+ngxjjRI4oVY3FZki5f6Zz2WDOrQ4PsreMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHPXkaPR5Z+YyzQ6D4aRpf51FTMlchvBoZcd6Y8cC8VcjvnK5efC4g1TGzwG0FRfJv8mArdrLHO3AjWTiKZTyM4qZxU1Y54ed5g9ojVAFO+otvV5/L929fSfcDlNXR1tNVQ/DjAPzV54xzLL0iIiE04hSX2aBFQVCOOahTaT2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hddca3Xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hddca3Xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB29E1F00A3E;
	Fri, 22 May 2026 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461996;
	bh=sU5zMps2+4JI5l+dL3b9bvvj9rBs0yGMUYT5a3KUGQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hddca3Xh/IbCC0kaSQFdTn4N3VAVB7gGxdkLeuBERTv4NCnwN5vmKJO3ZRRkf37H0
	 aZ2dBP4EPxFcalEvzPzWJ0d6QRSX7LP3w3dh+Dqmq5ny2gIo9ow5F28Kj/en6PcKF6
	 Nd6L3Fl0J5d/aLXCe9XW/rHOh5IcweIH4MvmdmGyJRreG4Gze6Z+XSYYQmAhscS+dI
	 s+yAytVVcUpmX7zgOiKRl/MybC3FBsQoVouEkEBxX34ZF/0dAOZJyzBKnMfXJk/Y++
	 GhtERyG0U1aZbicfWgbvOYTYqMS1kecrebceIuKZa+h9YvDldlGUOpHz3/A1IsDOJd
	 JcaEQq4Fq6/aw==
Date: Fri, 22 May 2026 15:59:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, andrea.merello@iit.it,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: terminate dev_err() strings with a
 newline
Message-ID: <20260522155948.47c100c5@jic23-huawei>
In-Reply-To: <CAKqfh0EPXX1zh3ScPCyBWhSq70wL3MpnUW9TV0Btn5LSF2EGuA@mail.gmail.com>
References: <20260520190851.11390-1-sozdayvek@gmail.com>
	<CAKqfh0EPXX1zh3ScPCyBWhSq70wL3MpnUW9TV0Btn5LSF2EGuA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 15:13:41 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Wed, May 20, 2026 at 2:27=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.=
com> wrote:
> >
> > Two dev_err() calls in bno055_ser_write_reg() and bno055_ser_read_reg()
> > are missing the trailing newline, so the kernel log buffer continues
> > the next message on the same line.
> >
> > Add the missing \n.
> >
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > ---
> >  drivers/iio/imu/bno055/bno055_ser_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu=
/bno055/bno055_ser_core.c
> > index 48669dabb..733f9112d 100644
> > --- a/drivers/iio/imu/bno055/bno055_ser_core.c
> > +++ b/drivers/iio/imu/bno055/bno055_ser_core.c
> > @@ -288,7 +288,7 @@ static int bno055_ser_write_reg(void *context, cons=
t void *_data, size_t count)
> >         struct bno055_ser_priv *priv =3D context;
> >
> >         if (count < 2) {
> > -               dev_err(&priv->serdev->dev, "Invalid write count %zu", =
count);
> > +               dev_err(&priv->serdev->dev, "Invalid write count %zu\n"=
, count);
> >                 return -EINVAL;
> >         }
> >
> > @@ -306,7 +306,7 @@ static int bno055_ser_read_reg(void *context,
> >         struct bno055_ser_priv *priv =3D context;
> >
> >         if (val_size > 128) {
> > -               dev_err(&priv->serdev->dev, "Invalid read valsize %zu",=
 val_size);
> > +               dev_err(&priv->serdev->dev, "Invalid read valsize %zu\n=
", val_size);
> >                 return -EINVAL;
> >         }
> > =20
>=20
> Sashiko seems fine with it. Also did a quick visual check and looks
> fine (not compiled, but I wouldn't count this as a functional change).
>=20
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Applied.=20
Thanks,

J
>=20
> best regards,
> max
>=20
>=20
> > --
> > 2.43.0
> >
> > =20
>=20

