Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8330FC34;
	Tue, 21 Apr 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784798; cv=none; b=scsyizzV6ycTSfoE9zGhOpQ1wR1AcL3bNLeWC6Gap9iVShtSdmJqWaU2ylUEoD7VwRmXszSmdPOfLuycd9JMPrTmuKlJ9d1v/8Q0W2ulLc/7DDgTBlfYo1IVvPvkRN+0p3QKsWogqUwpO0rp9V2XPoBQ9DmAy5hr72RTQeT5Npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784798; c=relaxed/simple;
	bh=TQjHAUUN14hAMMNQyEXtHvygR34qe5mSJ4/h00NJdi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ik4gslVQt/T0bE0v4X/lWmDVJV36gKHhQwM5Ll4ptr7RC8MoywC172t37A6bayNqwhV7uVNT0le783Dt4MXE3A+8SCVVkhpd+Wbblu1CrqOz8BuyQ7M8HvpyFk0UgMZSO8q6rFWK5LjA9kNlVJ9TYrJcKjMd0cvRYH116pihhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UedHJinW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UedHJinW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D38C2BCB0;
	Tue, 21 Apr 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784798;
	bh=TQjHAUUN14hAMMNQyEXtHvygR34qe5mSJ4/h00NJdi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UedHJinWsfjIcvDOxoOupoYRMFHAWZtDBjCTppIra8/voxzo4IFZiFlRsTh5QQnwY
	 iILwmsVMSrx+c7A7phFUDcdbUwT17iu9Ecu6UzFR2CxitIsgMsvkupeUfyiUBSCOo+
	 /P700UoSU98dSBu3vqR1N1Nu5ar2i4CitG3hghmollGAWmnSDPwgrIPSKaK6qcNoCj
	 9FHrOIQneytDYx5aQBSvevZroVNUg8vhVrGgSq3JOjQ5U+kgyzbzC49ko70fzqUhsh
	 1SqSGsS6zdZRSuKHEyzh1zDtAB9Gn/nD7G9cjieOSrO+PB6rxpH9Lc+SqAjhv8IT77
	 DJBXmbUF0bE8g==
Date: Tue, 21 Apr 2026 16:19:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 demonsingur@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <20260421161950.2f2cb53a@jic23-huawei>
In-Reply-To: <30AD35B9-E7DE-4F9C-AA15-4EEAED583F16@gmail.com>
References: <20260418211336.1800221-1-sanjayembedded@gmail.com>
	<278F44B5-A962-470D-A0F5-CA7C6F11FBDB@gmail.com>
	<aeYGrMh59pQEgWx8@nsa>
	<20260420125035.6a098add@jic23-huawei>
	<30AD35B9-E7DE-4F9C-AA15-4EEAED583F16@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Apr 2026 20:44:37 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 20 April 2026 5:20:35=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >On Mon, 20 Apr 2026 12:00:15 +0100
> >Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > =20
> >> On Sun, Apr 19, 2026 at 02:46:10AM +0530, Sanjay Chitroda wrote: =20
> >> >=20
> >> >=20
> >> > On 19 April 2026 2:43:36=E2=80=AFam IST, Sanjay Chitroda <sanjayembe=
ddedse@gmail.com> wrote:   =20
> >> > >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> > >
> >> > >The listed maintainer analog domain email for Cosmin Tanislav is no
> >> > >longer valid, and he would no longer maintain this driver(s).
> >> > >
> >> > >Cosmin suggested adding Nuno from Analog Devices for further handli=
ng
> >> > >this driver(s). Add Nuno as maintainer.
> >> > >
> >> > >Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> > >---
> >> > > MAINTAINERS | 8 ++++----
> >> > > 1 file changed, 4 insertions(+), 4 deletions(-)
> >> > >
> >> > >diff --git a/MAINTAINERS b/MAINTAINERS
> >> > >index c981cbdff500..f86a398d1a35 100644
> >> > >--- a/MAINTAINERS
> >> > >+++ b/MAINTAINERS
> >> > >@@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> >> > > F:	drivers/iio/accel/adxl355_spi.c
> >> > >=20
> >> > > ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >> > >-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >+M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> >> > > L:	linux-iio@vger.kernel.org
> >> > > S:	Supported
> >> > > W:	https://ez.analog.com/linux-software-drivers
> >> > >@@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/=
adi,ad4080.yaml
> >> > > F:	drivers/iio/adc/ad4080.c
> >> > >=20
> >> > > ANALOG DEVICES INC AD4130 DRIVER
> >> > >-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >+M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> >> > > L:	linux-iio@vger.kernel.org
> >> > > S:	Supported
> >> > > W:	https://ez.analog.com/linux-software-drivers
> >> > >@@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/=
adi,ad7293.yaml
> >> > > F:	drivers/iio/dac/ad7293.c
> >> > >=20
> >> > > ANALOG DEVICES INC AD74115 DRIVER
> >> > >-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >+M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> >> > > L:	linux-iio@vger.kernel.org
> >> > > S:	Supported
> >> > > W:	https://ez.analog.com/linux-software-drivers
> >> > >@@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/adda=
c/adi,ad74115.yaml
> >> > > F:	drivers/iio/addac/ad74115.c
> >> > >=20
> >> > > ANALOG DEVICES INC AD74413R DRIVER
> >> > >-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >+M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> >> > > L:	linux-iio@vger.kernel.org
> >> > > S:	Supported
> >> > > W:	https://ez.analog.com/linux-software-drivers   =20
> >> >=20
> >> > Hi Nuno,
> >> >=20
> >> > As discussed in the previous thread https://lore.kernel.org/all/d6d8=
660e-c5d2-4f02-a5fc-2f8b49d2e0d7@gmail.com, updating the MAINTAINERS entry.
> >> >=20
> >> > Nuno, please let me know if you are okay to be listed as maintainer
> >> > for this drivers, or if someone else would be more appropriate.   =20
> >>=20
> >> I'm ok with it but maybe a better alternative would be to include
> >> linux@analog.com? Jonathan anything against it? Should always have
> >> someone capable of taking over and more important, it should not become
> >> invalid (at least it should be less likely) =20
> >
> >That's fine by me.
> > =20
>=20
> Hi Jonathan,
>=20
> Thank you for the confirmation.
> I hope there won't be any maintainer and also this List should be added l=
ike following, right ?
>=20
> L: linux@analog.com (moderated for non-subacribers)
>=20
> similar to what some company has added or without () also should be fine.
>=20
> Accordingly, I will send next version.
>=20
L yes, not the bracketed bit. I'd imagine it's impossible to read if you ar=
en't in analog
devices?

> >>=20
> >> - Nuno S=C3=A1
> >>  =20
> >> >=20
> >> > Thanks,
> >> > Sanjay Chitroda   =20
> > =20

