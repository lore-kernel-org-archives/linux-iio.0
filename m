Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83A3A4526;
	Wed, 20 May 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291445; cv=none; b=jPaO2kerxzAt1gBzLwoCeGCkuiaAEcCMc1dIQVQc5GB/vm2jg/9K2hK9QvtH2g0XD7mqrOMZJl2VuEJKvVV1dnX9OF/r7RM+ChyWmWgQZ2GC0Is1YsvB0IfsVA5NnKSFco4anXNZkwW5FVr+7mHL7VSY5BUEug8ZlCbNnLuMQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291445; c=relaxed/simple;
	bh=pTRScZ8G/chehdy1sbG7txwPPVfM9r8Alm2cwcxDDo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dd0EnnD4esDtLcn21cWWSn5ZNrc2wW7GSGrytaNGu/3jQtPiohmAvohKQTTOJaUB6p7Dw0hq75N+8hkd4PA1/UngpmzEXtB4uaJfESpc4IIa+7SU/lm71tKs+fVjRKKQYheuH0A8YOQB3T84cgAsiVGFkbYRxzVk3aM+HYk+lJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6zW1OJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6zW1OJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714201F000E9;
	Wed, 20 May 2026 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779291444;
	bh=E5focqGOwndCHURBXlndYMQM4DxHXOJ4zjUuPCRNnDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b6zW1OJzExu8pnTAd7d6q6wa5y+fy34g5r+oW6A61hpyiOGgUo3carbuCm1BneQmj
	 VH0w6/sS8GVSYy7mly5+QQxZgqHofrf/mZEvZbQFU+HBlNpJF0iVjo1r8nMYGmNemW
	 jL5Rct0ccK7L0i8Pb90tpOx2vlqHWA4Cb5eKmBjDKawULrotWt/cVSO47kBPbdXnqg
	 Jfn2uKXrdPXF/PrWLGbHhnffl4LCiDpou1ozeq5R6kiQrf17EwtBWKn9byjJn3ShK1
	 UoIJUHLhCgPmZo6WdxhqRw+CJGpMBe0Rp0wUhTKnulVHms+pppkJs5QQzZLzN+al2v
	 A1rUtMTphf3rw==
Date: Wed, 20 May 2026 16:37:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] iio: magnetometer: ak8975: add scan mask index
 enum
Message-ID: <20260520163715.7d6358b6@jic23-huawei>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-4-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
	<20260518-magnetometer-fixes-post-pickup-v8-4-088d610108a0@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 09:50:28 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> Add an enum to explicitly define scan mask indexes for the X, Y, Z and
> timestamp channels. Also, update the struct iio_chan_spec to use said
> enum for the .scan_index parameter.
>=20
> This prevents magic numbers from obscuring the hardware channel mapping
> and improves code style.
>=20
> No functional change.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
There is one other place we can use this to improve the code:

Replace:
static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
with
static const unsigned long ak8975_scan_masks[] =3D {
	BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),
	0
};

That makes it obvious we are dealing with all the channels.

I only noticed this because I couldn't work out why there weren't
more per things indexing the channel  / addresses stored in channels
or that sort of thing.  Answer was because the driver only does things
one way.

Also, maybe rename....

Jonathan



> ---
>  drivers/iio/magnetometer/ak8975.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 7ab4c4d69d8b73c6f367f6e62fee3017d8691b67..a140d352bad663a138295dc0c=
44084a9a18a4c24 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -238,6 +238,13 @@ enum ak_ctrl_mode {
>  	MODE_END,
>  };
> =20
> +enum ak_scan_index {
> +	AK8975_SCAN_X,
> +	AK8975_SCAN_Y,
> +	AK8975_SCAN_Z,
> +	AK8975_SCAN_TS,
Can we call these
	AK8975_CHAN_X,
etc because they are used both for scan indexes and as chan->address
and putting something called scan index in there feels wrong.

Hence use a vaguer naming.

> +};
> +
>  struct ak_def {
>  	enum asahi_compass_chipset type;
>  	long (*raw_to_gauss)(u16 data);
> @@ -845,8 +852,10 @@ static const struct iio_chan_spec_ext_info ak8975_ex=
t_info[] =3D {
>  	}
> =20
>  static const struct iio_chan_spec ak8975_channels[] =3D {
> -	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	AK8975_CHANNEL(X, AK8975_SCAN_X),
> +	AK8975_CHANNEL(Y, AK8975_SCAN_Y),
> +	AK8975_CHANNEL(Z, AK8975_SCAN_Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
>  };
> =20
>  static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
>=20

