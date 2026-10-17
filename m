Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3E3CEBA9;
	Sat, 17 Oct 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274957; cv=none; b=p0gq1Gu22HW+XBywh/3YWDZ58cVZqYTzKy66dJnfZ/6/em3RRJuDsqQ/YfRiaua5xyChs9uTH/mExqi4YnVk4V2Qb8fn204vZP+x879qIiA9aW86tJlinwNeLOWZtctJQSymAsXKekXfXc8LLd7ti3ogZ5Q6z4sDrjlC5M58RB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274957; c=relaxed/simple;
	bh=faV6llRO8CaHdvnOHiJm/DyZ8pHAKov1RneZKmx3TLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZsrQGleGCi4EkiV44w6K4hFhR0IOmj343yyKJ5XWqx+DxY7J9gxHFzDsw/7nydTvZ3pmxFqZSM3l5QSO3oU+fPkZUC+LlR4pnhH/J6aD1tx5SwFgdNvLG/UaYBwmT/Qcotef5/wV5n0hgncM9ykxRwxJeobelJIN/5wJUMFJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO7y+lSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO7y+lSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC03C1F000C4;
	Sat, 17 Oct 2026 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792274955;
	bh=KhTRZDCPpifaW7Sm9z1hzbF40fk1NfbUB9WfmrVLg8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bO7y+lSmxj0SlJM9+CUPvuZElDqByoSHYm/KYQ7tgpv1VvykUM/YDDVylp4K86DkO
	 0yiGcJMJu0Ho40kUy3eR6gvcE8/kE+BKVTGeBEDzi/dUfNMj3J1UoMMMGn45B6x+U4
	 AoYXf4uLZe7HL2mb2CNFnzmw2FiTH8XJvHjsDiY1+bgCFucpb4Apglv/wZhXLXJOUW
	 DcU3KD2zmgkq0WCf482jyBrN/bhDUrx4Wr8HbRJiGPk3wdqczPVTizKlpZ8egxoT6s
	 Rpuwof0yPYMpfsrv3ULOEIM1ghouaOlrNnSTTFdS7d84Q3RYvkPlRCNaWglljCxCz4
	 oaZY4MCjMly3w==
Date: Sat, 17 Oct 2026 23:09:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Viral Patel <viral8854@gmail.com>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: tlv493d: fix magnetic field scale
Message-ID: <20261017230910.77d1637b@jic23-hlaptop>
In-Reply-To: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
References: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2026 23:07:36 +0530
Viral Patel <viral8854@gmail.com> wrote:

> The TLV493D-A1B6 datasheet specifies a magnetic resolution of
> 98 uT/LSB (0.098 mT/LSB). IIO reports magnetic field in Gauss
> (1 mT =3D 10 G), so the scale should be 0.98 G/LSB.
>=20
> The driver currently reports 98/1000 =3D 0.098 G/LSB, which
> under-reports the magnetic field by a factor of 10. The comment
> also gives the resolution as 0.0098 mT (9.8 uT), mixing up units.
>=20
> Correct the scale value and the comment.
>=20
> Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D=
 3D Magentic sensor")
> Signed-off-by: Viral Patel <viral8854@gmail.com>

I'll give some time for Dixit to take a look at this.

Thanks,

Jonathan

> ---
> Found while comparing this driver against the TLE493D-W2B6 register
> map for a new driver I am working on. Compile-tested only; I do not
> have TLV493D-A1B6 hardware.
> ---
>  drivers/iio/magnetometer/tlv493d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetomete=
r/tlv493d.c
> index 03415cc2c9b3..234e3ce63ff7 100644
> --- a/drivers/iio/magnetometer/tlv493d.c
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -299,11 +299,11 @@ static int tlv493d_read_raw(struct iio_dev *indio_d=
ev,
>  		switch (chan->type) {
>  		case IIO_MAGN:
>  			/*
> -			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =C2=B5T)
> -			 * Magnetic field in Gauss: mT * 10 =3D 0.098.
> +			 * Magnetic field scale: 0.098 mTesla (i.e. 98 =C2=B5T) per LSB.
> +			 * In Gauss (1 mT =3D 10 G): 0.98 G per LSB.
>  			 */
>  			*val =3D 98;
> -			*val2 =3D 1000;
> +			*val2 =3D 100;
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_TEMP:
>  			/*
>=20
> ---
> base-commit: ceb05f22e5cdc3f8bd3f7d5dcfc57843942191dd
> change-id: 20261014-tlv493d-scale-fix-5a0b83b52d2a
>=20
> Best regards,

