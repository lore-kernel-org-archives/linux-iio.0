Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3B346E6D;
	Fri, 24 Apr 2026 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058855; cv=none; b=nfTuNCGjVoIet3CrqYonehn2AijiEVC7axT8Q7GxD529/PkrhYq8lZ+Ha5bwPM/aelZJorhh4z7BlUVOv5auXufQNsBT+4S+T40fLZDpxk/freD8YHROqU6yF0j3w2VcVL0XsPmMuzRD38EHkS0iZ/eyH4BKS+Puc0lx3FuhNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058855; c=relaxed/simple;
	bh=31QoA+YPJM3Bol9fh7NBAwIgp0iiAP0PcThEkLmgXIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOS2qDai0dNVpMSqP2W8yN4rQk8AsOdjkjKfEFoMm0VKuEkI4KadZ9OcU69FhhkutPyy63fDSqcR21zIfhS1JEzcYh2XFiL13vdefrI7abXHlDGSLCbrL71pdeBAoHM1vBz9kQo7JDdS8AS4VzusPMA7GRTq4pymXOM8Ngx0U0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs4nSjUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs4nSjUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30697C19425;
	Fri, 24 Apr 2026 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058855;
	bh=31QoA+YPJM3Bol9fh7NBAwIgp0iiAP0PcThEkLmgXIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vs4nSjUbZA79ZD5CxaLkG2bNM7tFiYrixMjZgqbBuDkCxK5pGpzEdrm8RR7AGdhP5
	 H8AQDo+ubNtxv1xbd7Fe6E1/m4x+tawnv66hYgdE9s4XB9lIw1j6t4eqmc3VNWC/ej
	 VI06fuVLXswGjeGUIQFlcTIlF+TQ7Qu2AaUas91QJB8T4HYCsX8kW9FnUGJ67Hl/2B
	 mMMaQAZICBKbVhR0wvSVbyFAD89iZ4MQ4apsqNAz05a10EORFag/ysvYFEIfTj+4/7
	 0KoEgFZ0zBOFJp/7NfSHGSBqEBGaW1Tzh/8vvlhH0DF3PIaX/2l5XaZdtLKiP/2You
	 45eItwvq/U2hA==
Date: Fri, 24 Apr 2026 20:27:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, demonsingur@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <20260424202727.1b880766@jic23-huawei>
In-Reply-To: <aeskNzhWtKPNYb4R@nsa>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
	<aenU2WZnVJ-esibn@nsa>
	<8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
	<aeskNzhWtKPNYb4R@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 09:08:37 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote:
> >=20
> >=20
> > On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname.nuno@gm=
ail.com> wrote: =20
> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote: =20
> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >>=20
> > >> The listed maintainer analog domain email for Cosmin Tanislav is no
> > >> longer valid, and he would no longer maintain this driver(s).
> > >>=20
> > >> Replacing email maintainer with list, to keep it valid all the time.
> > >>=20
> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >> ---
> > >> Changes in v3:
> > >> - Following input from Nuno and confirmation from Jonathan,
> > >>   replacing domain specific maintainer with mailing list.
> > >> - Link to v1: https://lore.kernel.org/all/20260418211336.1800221-1-s=
anjayembedded@gmail.com/
> > >> --- =20
> > >
> > >While you're doing this, could you take the opportunity and also update
> > >this entry?
> > >
> > >https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837
> > >
> > >Thanks!
> > >- Nuno S=C3=A1
> > > =20
> > Hi Nuno S=C3=A1,
> >=20
> > Are you suggesting to have separate change to add mailing list in analo=
g devices and iio driver which you pointed ?=20
> >=20
> > This change is specific to email debounce due to Cosmin analog domain a=
ccount. =20
>=20
> Yes, it makes more sense for it to be a separate patch. I also suggested
> that one because it's an entry covering a lot of driver's and
> includes Lars which has been silent for some time now so maybe it's bette=
r no
> to "spam" him like that :)

If we are adding the entry to the catch all, do these individual entries
bring any benefit. Maybe we should just drop them?

>=20
> >=20
> > Also, I had take a glance on MAINTAINERS, it looks there are good amoun=
t of drivers which are maintained by you and Michael Hennerich from analog.=
 If you suggest I can plan to add analog mailing list in all respective pla=
ces in separate change.
> >=20
> > This way all analog device maintained drivers will have mailing list of=
 analog.com =20
>=20
> Yeah, I'm not sure if it makes sense to go change all of those. I would
> focus on bouncing emails and we (ADI) need to make sure to also include
> that list from now on.
>=20
> - Nuno S=C3=A1
>=20
> >=20
> > Kindly share your thoughts on the same.
> >=20
> > Thanks,
> > Sanjay Chitroda=20
> >=20
> >=20
> >  =20
> > >>  MAINTAINERS | 8 ++++----
> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >>=20
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index c981cbdff500..6498f0aed1ff 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> > >>  F:	drivers/iio/accel/adxl355_spi.c
> > >> =20
> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> +L:	linux@analog.com
> > >>  L:	linux-iio@vger.kernel.org
> > >>  S:	Supported
> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> @@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/a=
di,ad4080.yaml
> > >>  F:	drivers/iio/adc/ad4080.c
> > >> =20
> > >>  ANALOG DEVICES INC AD4130 DRIVER
> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> +L:	linux@analog.com
> > >>  L:	linux-iio@vger.kernel.org
> > >>  S:	Supported
> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> @@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/a=
di,ad7293.yaml
> > >>  F:	drivers/iio/dac/ad7293.c
> > >> =20
> > >>  ANALOG DEVICES INC AD74115 DRIVER
> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> +L:	linux@analog.com
> > >>  L:	linux-iio@vger.kernel.org
> > >>  S:	Supported
> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> @@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac=
/adi,ad74115.yaml
> > >>  F:	drivers/iio/addac/ad74115.c
> > >> =20
> > >>  ANALOG DEVICES INC AD74413R DRIVER
> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> +L:	linux@analog.com
> > >>  L:	linux-iio@vger.kernel.org
> > >>  S:	Supported
> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> --=20
> > >> 2.34.1
> > >>  =20

