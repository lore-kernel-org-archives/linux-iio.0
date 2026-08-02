Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324981B85F8;
	Sun,  2 Aug 2026 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712794; cv=none; b=UuaoZoDl95LwVThMLMSbtONomBk9QyXEzXHzQRWHKww2Wgj3G1nvxnrGzsjTU3dD/tcNdOBCj9XVDBygHJ7kZFRaC6lFBCIXZAqSrNO3vWLUlXApB1fFnqpDTCeT3Mt7Ap7v3Ty78TYUkKt94nFPZVzI1gHm/yNuO9Qq9rVG/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712794; c=relaxed/simple;
	bh=+dg4cM/1sUDRT6npItsFcNKriAveLPOrGSDXZ0wX6as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALF7r+Y03iFmBbCN0ijOczIinx+3Q0o9+WymB+By13r/pDFBqzAkdK10wLeowraxULAv7JjZYeEmC+k5cPkuieeYAmvwoo1Nh39eD6n1nDWzJMVUepRjmNAE5r1G5aQG3PlTnqJpRBWbk9V3pwwscFT9KWlG1lAQExhYYP9Ydjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHSi0a0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHSi0a0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B791F000E9;
	Sun,  2 Aug 2026 23:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785712792;
	bh=eY6VgtIgRMIMVNF+YSKtWPFHsrwxoff5oqA8sV51QoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cHSi0a0euDY1dCGcnR7u9ZJ9kJg8uqvH2pwoey66fnCf4oyx1m/bzMwto15CdOAQ7
	 dmy0FN0GmCa0G9t07m0A1o2aZrvobBEA6Chu/U2/gRob6iEQdsVhrXmnWadlyPGsI1
	 l4qSmgfjTe3N4TZ6xFeolnuXievHooXQWz2fxeGQL+yoCiHzh0vNb+fHn7KlXoGeK/
	 mFM7sHc2YqYGQ/m3EVdZMfOvMLRCjwdRl4yEt2sa4VJQpIA+uSvE7WNTyOWozmbib2
	 QeSyLy9d6wFszXjGChAckNb/VEk1Qzk7NyyeNZdn+26l8ukHLCjUpG+uxy09tka6sz
	 qz2OIucMwJ5SQ==
Date: Mon, 3 Aug 2026 00:19:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Cong Nguyen <congnt264@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: fix sign of raw angular velocity
 readings
Message-ID: <20260803001947.4ca48e75@jic23-huawei>
In-Reply-To: <CAD++jLmdgtA=5z+83jFivgbDNnrh0f5C_YNnHdZw_FmTJc2ZgA@mail.gmail.com>
References: <20260802065540.8120-1-congnt264@gmail.com>
	<CAD++jLmdgtA=5z+83jFivgbDNnrh0f5C_YNnHdZw_FmTJc2ZgA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Aug 2026 23:30:31 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Sun, Aug 2, 2026 at 8:55=E2=80=AFAM Cong Nguyen <congnt264@gmail.com> =
wrote:
>=20
> > The MPU-3050 gyroscope output registers hold 16-bit two's complement
> > values; the angular velocity channels are declared with .sign =3D 's'.
> > When mpu3050_read_raw() handles IIO_CHAN_INFO_RAW it reads the register
> > via a big-endian regmap_bulk_read() and assigns it with:
> >
> >         *val =3D be16_to_cpu(raw_val);
> >
> > be16_to_cpu() yields an unsigned 16-bit quantity, so negative rates
> > (bit 15 set) are reported to userspace as large positive integers
> > (e.g. -1 becomes 65535) instead of the correct negative value.
> >
> > Cast to s16 before the assignment, matching the temperature channel a
> > few lines above which already handles the sign correctly.
> >
> > Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com> =20
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
Applied to the fixes-togreg branch of iio.git

Note this will probably not go upstream until the merge window.

Thanks,

Jonathan

>=20
> Yours,
> Linus Walleij

