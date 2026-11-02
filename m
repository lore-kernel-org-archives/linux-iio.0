Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657489;
	b=3ZRlRgxgtPQeFydq3yRkWYlriT031EyAsun0u5NFMXhnRXS9xZd4XzLlKNf+U0xcIZZ/
	 BE33mYw1uKrNI5+MxRrs7OrjUqlSnuoFcYfLLZEFbhtKmE59b6oFNMwBb7pVOzQ47wyxY
	 bTkh7S3qrG1w2vlGkz8ozpVAkDLqgCp9rHE6rtvA5QO8YN7UjKVK1EUFYwdw7BJY43pQT
	 q9RpBh/XQuxfj5nzLKbi3ZPuoguX25YqwW5XDnXCcI5KMj13eVkLs1Qk/yJ72H5ayXwkp
	 BuCs4RL2HQlh0kWR4WAh4fkwxvaPouGzXyJt49GgH9cOUKnz+H4uHSEQLFL57wIbTEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/NhqVjOKFln0SKgsgamqbhTP6g7g95UWHRnLjeIK1Y4=;
	b=Gldnp/Cjz+TGgYtdFrqSJ3QZ2ZjSpO+BkmJVya/bhjBXVDGLE419nxeZIEr9okhkMylO
	 WJ/B9/DTtKMYEnsYBdYe9aOWbZCU+k567fMtQP9O1aod9t1h8Ho/FzCjyROfHmoHdvafV
	 XFuj28rZJ6PsvEsiXoEDxpZsC4rah4Mrws8dHecC2pqH03ReXt3Upj24hib9ZS0vXPfs7
	 qlCpmsaaRYi4860CqhpjskAGk5k6gaYhuAIZCoxWHve3YgpXCzKnqKFrHP14OEqc05NyX
	 Y5Up1JDU+2gGALgoVaLf/Dzr9HOBLUVJ5cR3wlfy0JGNAKCMw4UKCY6NBmhyv4D4lSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7UvdZsC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C8606A32F;
	Mon,  2 Nov 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7UvdZsC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2277F1F00A17;
	Mon,  2 Nov 2026 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657489;
	bh=/NhqVjOKFln0SKgsgamqbhTP6g7g95UWHRnLjeIK1Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q7UvdZsCFMim2CEHZ/cCLlp3lAr/wnfqXFhVffykEVR5itLs9SQbkDwHZdKsgAN1+
	 WNGjigzyGO3hxjnA5xJPBb9t7FrvCrURbkuQn0afiy5tTJBj7BUk/bWu3NQKKnW52K
	 4cp8mrAyjsdhaegKmTvXHTQ0ifHwOR3lua5k5K3Vf/8x7dzQU59nnZGUr1Ith80/s3
	 3qNqcpiRmiWLLJKwFEjbsYFhFkb/JRTbFJi9R83/BFXn+d/FV5u2RM+S1FbR9nl5Lg
	 Tc+Gr3gidyriiAY+l5n9yLkxkSG7Lt8vTsZSvDRFWwAd0WyMth5H2nA1tGYoBmthuD
	 fzpUUFJJ7adJQ==
Date: Mon, 2 Nov 2026 22:11:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Greg Kroah-Hartman  <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner 
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko  <andy@kernel.org>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, Shi Hao  <i.shihao.999@gmail.com>, Jiri
 Kosina <jikos@kernel.org>
Subject: Re: [PATCH 11/15] iio: hid-sensors: fix a division by zero
Message-ID: <20261102221124.20a7aff2@jic23-hlaptop>
In-Reply-To: <b06c4c02844b9d16dc5bf4dc050687aa4e99094a.camel@linux.intel.com>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-11-0d818334f6c7@linuxfoundation.org>
	<20261101021729.4a0df058@jic23-hlaptop>
	<b06c4c02844b9d16dc5bf4dc050687aa4e99094a.camel@linux.intel.com>
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

On Mon, 02 Nov 2026 09:33:34 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sun, 2026-11-01 at 02:17 +0000, Jonathan Cameron wrote:
> > On Tue, 27 Oct 2026 17:19:15 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > From: Josef Bacik <josef@toxicpanda.com>
> > >=20
> > > convert_to_vtf_format() divides the micro part of a value by
> > > 10^(6 + exp).=C2=A0 The unit exponent of a HID field is a nibble and
> > > goes
> > > down to -8.=C2=A0 For -7 and -8 the argument of int_pow() is negative,
> > > which
> > > the unsigned parameter turns into a huge power of ten: 0 modulo
> > > 2^64.
> > > The division by it is a divide error.=C2=A0 The exponent comes from t=
he
> > > report
> > > descriptor of the sensor hub, the value from a write to the
> > > hysteresis
> > > attribute of the IIO device.
> > >=20
> > > Multiply by 10^(-exp - 6) in these two cases.
> > >=20
> > > Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and
> > > trigger")
> > > Cc: stable <stable@kernel.org>
> > > Cc: David Lechner <dlechner@baylibre.com>
> > > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > > Cc: Andy Shevchenko <andy@kernel.org>
> > > Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > Cc: Shi Hao <i.shihao.999@gmail.com>
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> =20
> > +CC Jiri, and Srinivas given they are co-maintainers of this driver.
> >=20
> >  =20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied.
>=20
>=20
>=20
> > > ---
> > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
> > > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > index 9e7c26e37880..3b0985d500ae 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -140,7 +140,10 @@ static u32 convert_to_vtf_format(int size, int
> > > exp, int val1, int val2)
> > > =C2=A0	if (val1 < 0 || val2 < 0)
> > > =C2=A0		sign =3D -1;
> > > =C2=A0	exp =3D hid_sensor_convert_exponent(exp);
> > > -	if (exp < 0) {
> > > +	if (exp < -6) {
> > > +		value =3D abs(val1) * int_pow(10, -exp);
> > > +		value +=3D abs(val2) * int_pow(10, -exp - 6);
> > > +	} else if (exp < 0) {
> > > =C2=A0		divisor =3D int_pow(10, 6 + exp);
> > > =C2=A0		value =3D abs(val1) * int_pow(10, -exp);
> > > =C2=A0		value +=3D abs(val2) / divisor;
> > >  =20

