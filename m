Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B003226D02;
	Sun, 22 Mar 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180634; cv=none; b=O6G5orQEy4Kf3euAq7gl65A6H5ytDs9fis4Ur5N+K6wYG7/9zna3189kRjfjr9GcAWOOsWlv7vTtE+ARBKpPBN2jBtPK5N6+fRn2eyqMQJ0ls/TRLI2af7kCmzrwfNldxbPt7sVrTjQSZ8/paOUJrldEdPfdTiD1vjSTAidrVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180634; c=relaxed/simple;
	bh=uDdkpNKiU/H9sQNOeRNY+hTbjl0KzXECc5f2+g3mHn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbTr7OBZpcAzATZud+coJPcHliknUOx/oCGxRE2ZyFXjm1vDosszxVBvjdj9lI0L+Ly+bGJFILu9V47v0us+e1QNUdAIWPW0qTBAqBRHY3TGqRE1hrIUHv42JuLnveDhGKMkbZIYYKNUewY+GGM1Tpi2FBP1zU0EiLJ66QRxJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN5aoGJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN5aoGJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6921CC19424;
	Sun, 22 Mar 2026 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774180633;
	bh=uDdkpNKiU/H9sQNOeRNY+hTbjl0KzXECc5f2+g3mHn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vN5aoGJdTBuiMK5mjY2fuGtHPxPL1jEFqfRNbANfeZ5LWIcC15QDEa2rQC2zxIi4w
	 uT0GP8aaoeuhg2Q/RiGasgAD1gVKLZz2P63AVHnEbx3L9AMYFkpmF48Fm1Ml5AWbJC
	 2BzsRr9z3FKCPNLCVBca7PNm0NVUHRqWWwlw/BjPiUaZfwJ6jpJfWNXezeuLZql9yu
	 F7L+jB7NruNBz+b4smX6RSFJSWHOaUSB5pMMoK3+8KIqmB2Rtf5q4Ooryv10gzS6uL
	 Bxuheu6pkpgmv3qUhPem3luUhWcxaD1DX2ngU8+2DIMkwJas9kaUoRSdajmDEdVbQD
	 81tUbLpJy6e1g==
Date: Sun, 22 Mar 2026 11:57:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sirat <email@sirat.me>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260322115704.10b2e0d4@jic23-huawei>
In-Reply-To: <CANn+LWL85Ot6yrfuNB4qw3YoUJPyE1YD2gf9PPPGoAGv8EOJ9w@mail.gmail.com>
References: <20260311224044.21480-1-email@sirat.me>
	<abLNbGUmaA7K0s68@ashevche-desk.local>
	<CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
	<a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com>
	<CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
	<20260315185715.2f97c496@jic23-huawei>
	<CANn+LWL85Ot6yrfuNB4qw3YoUJPyE1YD2gf9PPPGoAGv8EOJ9w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2026 05:20:29 +0600
Sirat <email@sirat.me> wrote:

> On Mon, Mar 16, 2026 at 12:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Sat, 14 Mar 2026 21:25:44 +0600
> > Sirat <email@sirat.me> wrote:
> > =20
> > > On Sat, Mar 14, 2026 at 8:39=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
> > > >
> > > > On 3/12/26 10:12 AM, Sirat wrote: =20
> > > > > On Thu, Mar 12, 2026 at 8:28=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote: =20
> > > > >>
> > > > >> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote: =
=20
> > > > > ... =20
> > > > >>> --- =20
> ...
> > Can make it required in the binding. Just explain clearly why
> > it should be there.  The driver should carry on coping without
> > it though (and leave a comment so we don't break that in the future).
> >
> > Jonathan
> > =20
> > > =20
> > =20
> Just to make sure that I understand this correctly,
>=20
> I will
>   - make vdd-supply required and add a description of what it is.
>   - add a comment in the driver like "vdd-supply is required in the DT
> binding but we continue if missing to support older DTs."
>   - also add reset-gpio description and update the example to include the=
 vdd.
>=20
>  I'll send v6 after a few days.
>=20
Ah sorry. Took me too long to catch up with emails.

Bit late now but for the record, what we were aiming for was:

Make it required and add a note to the commit message to say why
the requirement should always have been there. Devices tend not to work
with no power.

The driver fallback stuff to provide a stub powersupply is very standard
so no specific need to call that out.

Jonathan



> Thanks,
> Sirat
> >
> > =20

