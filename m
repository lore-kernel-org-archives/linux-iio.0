Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F3371063;
	Wed, 20 May 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276701; cv=none; b=oBrw2OKNQPwva8ZwIKw9SOh07FVUHXlOnhMjSLn9hiC8zCg0Nse+NC+B85XOcKwQhQtBSLS/98OvL1y9Mu7EXlGXZdSimg5AIDWtP/zsxytbIGeRf1a89+zwPvQMAI8QrdIIccCXHsWU27piIEI6V84Vb/Ukkv0uHYSWTkuDkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276701; c=relaxed/simple;
	bh=EvB6gGfDNvT2Ao7Q0FP2fZ1gLkK/2Q87kWN9XljFsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qabz18aTI7bn5utyG3BmFe+dvnV1auT2HJCbodRNYtAkgiPAWGwkS1QMB9OD/RSd4HH6/INocMCBegtj/MwW1/7Ds5H0MnL209z2bvPi488jjTbQsv5OhbWYjfxzyCYfJV0g2mx4oB37jaAAbDjJCRGvdn41zHV0WZ5uwGuR1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/cEav5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/cEav5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA8F1F000E9;
	Wed, 20 May 2026 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779276700;
	bh=jU4RY1MXfxstue/GxrrGI/R6d88bgt3L79phjkKZMvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F/cEav5et0J4vrESdmHTeG45bNaj43c7+k/MXOyikkKJEEhvjM/IZSHvoxmnLhSzM
	 ptgBzeYEmC46Z50IhKctJfFjfWeGuttKfRDXXXrEMRyajEwztAMhN5y7Rl4R0wKC8l
	 +aivf+hPl7MioHsgJtduZQkTTGlZcy1bCCL9acQn+FTuUW0L7/1CfqyIhneSEn6w2G
	 WIlPgRFU2JjwWHo1cYqVnSgKh7xRH10hcHI8mOV+WU67fsveipexcHqholyxbaKmsl
	 /6kGZlyjHj2rlitQ4glHypCgLAG08R21QMXesVr1k3MFe5IOgDSp4wEfC6Y0SsXuUe
	 3ToKllqW9lgwQ==
Date: Wed, 20 May 2026 12:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 02/13] iio: core: support 64-bit register through
 debugfs
Message-ID: <20260520123129.1696f2e3@jic23-huawei>
In-Reply-To: <unsohuo2hfsa7zzhprfpvtbatmu3guew6jpal7k2wvirpzwxfn@rjb4uz3k5dp3>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
	<20260517-ad9910-iio-driver-v5-2-31599c88314a@analog.com>
	<unsohuo2hfsa7zzhprfpvtbatmu3guew6jpal7k2wvirpzwxfn@rjb4uz3k5dp3>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 14:56:06 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/17 06:56PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Silent truncation of 64-bit values when written to a 32-bit =
register access function.
> > --
> >=20
> > commit 64785a0c1416e2cf718b558aa7a2cc9ac39b2d81
> > Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > iio: core: support 64-bit register through debugfs
> >=20
> > This commit introduces a debugfs_reg64_access function pointer to iio_i=
nfo
> > to allow 64-bit register reads and writes through debugfs. The file ope=
ration
> > callbacks are modified to prefer the 64-bit variant when available.
> >  =20
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> > > index e587aca79b8e7..5c8404efd0a56 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c =20
> >=20
> > [ ... ]
> >  =20
> > > @@ -429,7 +439,7 @@ static ssize_t iio_debugfs_write_reg(struct file =
*file,
> > > =20
> > >  	buf[ret] =3D '\0';
> > > =20
> > > -	ret =3D sscanf(buf, "%i %i", &reg, &val);
> > > +	ret =3D sscanf(buf, "%i %lli", &reg, &val64);
> > > =20
> > >  	switch (ret) {
> > >  	case 1:
> > > @@ -437,8 +447,12 @@ static ssize_t iio_debugfs_write_reg(struct file=
 *file,
> > >  		break;
> > >  	case 2:
> > >  		iio_dev_opaque->cached_reg_addr =3D reg;
> > > -		ret =3D indio_dev->info->debugfs_reg_access(indio_dev, reg,
> > > -							  val, NULL);
> > > +		if (indio_dev->info->debugfs_reg64_access)
> > > +			ret =3D indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> > > +								    val64, NULL);
> > > +		else
> > > +			ret =3D indio_dev->info->debugfs_reg_access(indio_dev, reg,
> > > +								  val64, NULL); =20
> >=20
> > Could this introduce a regression where values are silently truncated i=
f the
> > provided input exceeds 32 bits?
> >=20
> > Since the input is now unconditionally parsed as a 64-bit integer, fall=
ing
> > back to debugfs_reg_access (which takes an unsigned int for writeval) w=
ill
> > implicitly cast val64. If a user provides a value larger than UINT_MAX =
to a
> > driver that only provides the 32-bit callback, it appears the value wil=
l be
> > truncated rather than rejected with an error like -EINVAL. =20
>=20
> Maybe -EINVAL can be returned for that case indeed. For a debug interface=
 I
> did not see that as a problem.
Agreed - I don't see this as important either way.
> =20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-ad9910=
-iio-driver-v5-0-31599c88314a@analog.com?part=3D2 =20
>=20

