Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846525EF87;
	Sun, 19 Apr 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615855; cv=none; b=aZpnjmtQmHznTUvRIaVwkrvTiVZwVAqN5+d+yd9dI139zwUCf9DGHlW5UP3dyrsnuhkFA0ObBZUO7JS/OGpkQKhqj1YZrlXoTqJ4YkWmMOLGuZuoIt0JTJElSOUrhL8n1GZHKMyDYcdPZi1NVsPSzvnb6ggSmzKWREZSRJN/+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615855; c=relaxed/simple;
	bh=l8rMv0SFzoBGoymMafqLlKUxXkDsnI/QsG6uSsnkHXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYrWknz0OadyCGssklWUIvQDhdQeXv055vzWaeuKKWEg7NJHAYWLGLg9dPqoA5ESirun7hztxyA2oU0+yZHzMHcCofSYUaxl2pkMgBjy9AkVHzSWsannBoM1prbVrWqLbNNm5l+jiQSUmBfcIOyoCblLc6B61EIzwCQ+frcO2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqEAp3eL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqEAp3eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7579DC2BCAF;
	Sun, 19 Apr 2026 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615854;
	bh=l8rMv0SFzoBGoymMafqLlKUxXkDsnI/QsG6uSsnkHXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqEAp3eLI1R40hcAM8EPsuWkjQcuo9CKcjh7Kyy+ME53Li+/fnLGWN3NakVeWw9+d
	 phB/HbcWM1/ARDCpXM60QUVFlU83ibyCsVL1+7fPb1JiSPYMISWUqS/6C+rOyIaxYe
	 gAPbpudGBYFU4ETElarga9R06QzZ9q0K/8emjMC6D7jER0vDiEF5s/U7/T5Pbw7WPM
	 7qAvh1vAMlJeogsUeXrgHb87R4WC9zla2aVR1ruUZKdlNq3Pq4v7OAykZ9sRj/0QLp
	 UCipJ832c+fVm7g7H4Bc37xUJp6JZlpE8le7QkgcxZRB0SIx8enReCqu6XMf93ZBAW
	 A4rPa8ck1SYww==
Date: Sun, 19 Apr 2026 17:24:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago
 APDS9900/9901 ALS/Proximity sensor
Message-ID: <20260419172403.03be2bcd@jic23-huawei>
In-Reply-To: <CAPVz0n1iB9iC+TFrGK5ajXjdk8-g8vzr4ZbXdvW5=F8iukanaA@mail.gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
	<20260419083125.35572-3-clamor95@gmail.com>
	<20260419122950.67355f4c@jic23-huawei>
	<CAPVz0n1iB9iC+TFrGK5ajXjdk8-g8vzr4ZbXdvW5=F8iukanaA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 14:50:55 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14=
:30 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sun, 19 Apr 2026 11:31:23 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 =
so
> > > just add the correct bindings and the appropriate LUX table derived f=
rom
> > > the values in the datasheet. Driver was tested on the LG Optimus Vu P=
895.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com> =20
> > Hi Svyatoslav,
> >
> > Just one small thing.
> >
> > Experience has given me a strong aversion to the use of wildcards
> > in naming within drivers.  They go wrong too often because companies
> > can seem to resist using similar names for very different parts.
> > =20
>=20
> Noted.
>=20
> > > ---
> > >  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > index c8f15ba95267..8dab34bf00ca 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -127,6 +127,7 @@ enum {
> > >       tmd2672,
> > >       tsl2772,
> > >       tmd2772,
> > > +     apds990x, =20
> >
> > As above, just name this after one of the supported parts. apds9900
> > That doesn't stop you using it for multiple compatible devices.
> >
> > Same applies for all the uses of x as a wildcard.
> > =20
>=20
> If this is the only thing keeping you from picking this patchset may I
> resend with apds990x fixed right away?
No. I'm just one reviewer - others may need more time.  You should wait
at least a few days before sending a new version unless I've specifically
requested a rushed version.

I only do that if I'm trying to get something in at the end of a kernel
cycle or there are dependencies on a patch from others.  In this case, neit=
her
applies so please take your time.  I'd normally suggest approximately a wee=
k.

Thanks,

Jonathan

>=20
> > thanks,
> >
> > Jonathan
> > =20
> > >       apds9930,
> > >  }; =20
> > =20

