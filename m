Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C8250BF2;
	Sun, 20 Sep 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946575; cv=none; b=AgRb7OU10lpBD2vdLGMk6yQ2+Ix1YTfPQItdeFzMZ5iJT0eO8Rm/L4405rHUk9GRQif2xNQ9DIguDm8RSXWwYrktsWRkqNW/0PRy5uVmj37LV8pgGhtF38W9Q5FrwCO2gbzcNAsxk3truIhqwbKDAXwgm5NVurCH3HXNnu7PnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946575; c=relaxed/simple;
	bh=tbYrbE9/vdgi0MuiDCllAu4I5Wu21mcRrXpAYBc27bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joA+yl9MGF7ps6kQPM/tLRrXctH7POSSkMuOvcvbsMTCSbEGzgd+cEz5WCsjUgIZR+G4dM3u6fC3HIodO5PKK/yLP5IFcI4Ky3tPRWPibj1zTf/qZvhNIWkMd+gAMRT6yUe8LfyqsY+WF3u3O+G5McO/nBLWyyeZvZfkA/gEbq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsM9ZOim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsM9ZOim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB591F000FF;
	Sun, 20 Sep 2026 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946573;
	bh=fWgaRhUd/vSWK/0jQH70dZkFlJpdPbYobXh0/MPOE/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WsM9ZOim0N4XFsGWZatm0xP37KUJAV5QdPRclhK+M26vL3xWN7WmIGHrLNGI9RybV
	 7dUvjjjZEghnuK44oqCSj5aANN1LsUfAtsEvadScuAnB6mj19v3LPCdHOrgTJ+dEFL
	 amHbuMKnAB0IRDCfs11CavmlNEt2EHpKyqD/785pTwUfswqZ27WLNLML297Ld5xLDy
	 4YQer4tuE4JHLPtOTxF7Ng2K58hOZiJR9muWdya63NX3phoTgy80eLhVPea7hdUP20
	 QDWhNPrWcDrIurSCHQ6WAUfdV6jlCLiTwvwX7fv5spGRoTT5awBL+sJ+e0PK534vcX
	 GDrgeg37UnjKg==
Date: Mon, 21 Sep 2026 00:22:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <kees+treewide@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Allocate ext_channels with
 ARRAY_SIZE()
Message-ID: <20260921002247.7d7d08b1@jic23-hlaptop>
In-Reply-To: <aqzcxf84JEdoyzwA@lore-qca>
References: <20260917211350.i.934-kees@kernel.org>
	<aqzcxf84JEdoyzwA@lore-qca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026 08:40:05 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Kees Cook <kees+treewide@kernel.org>
> >=20
> > In preparation for making the devm_kmalloc family of allocators type
> > aware, we need to make sure that the returned type from the allocation
> > matches the type of the variable being assigned. (Before, the allocator
> > would always return "void *", which can be implicitly cast to any
> > pointer type.)
> >=20
> > This is allocating a copy of magn_channels, which is an array of struct
> > iio_chan_spec, but the size was taken from the whole array, which would
> > make the allocation type a pointer to the array rather than the
> > "struct iio_chan_spec *" being assigned. Allocate ARRAY_SIZE-many
> > entries instead. The resulting allocation size is the same.
> >=20
> > Build tested ARCH=3Dx86_64 allmodconfig with GCC 16.2.0:
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.o
> >=20
> > Assisted-by: LLM coccinelle
> > Signed-off-by: Kees Cook <kees+treewide@kernel.org> =20
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the testing branch of iio.git (next merge window
material).

Thanks

Jonathan

>=20
> > ---
> > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: <linux-iio@vger.kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index d6a1eeb151ca..cbc47fa5b101 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -766,8 +766,8 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *=
hw,
> >  			IIO_CHAN_SOFT_TIMESTAMP(3),
> >  		};
> > =20
> > -		ext_channels =3D devm_kzalloc(hw->dev, sizeof(magn_channels),
> > -					    GFP_KERNEL);
> > +		ext_channels =3D devm_kcalloc(hw->dev, ARRAY_SIZE(magn_channels),
> > +					    sizeof(*ext_channels), GFP_KERNEL);
> >  		if (!ext_channels)
> >  			return NULL;
> > =20
> > --=20
> > 2.34.1
> >  =20

