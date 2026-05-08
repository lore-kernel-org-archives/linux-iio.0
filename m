Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C93783A8;
	Fri,  8 May 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243258; cv=none; b=opFXgywXkDAl1NQ3is0Nnd8+ZIviUh0jlNUvgtAh35d9qAOQPWJbwBBc+46jFMLu6OAZnVzxVR9POBNOvTMOucKO/qxA51kY+Vr7DUuZOYxIUfQFu6q+VM18YdXlF2BWt+AjZCAgwuTYUGFMNEekgW3VNXr5x6r9PBXsO0wH3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243258; c=relaxed/simple;
	bh=jMYIS7ff8E/7knteldQlkt+Sgf2r95gCzVmHFgh+Ehw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON3iMtx0xGNkZfNMbmfLbLUxV5X0yDAq6tPGdD4oDR+o0bRlp+BKVclVwmRfkVyVp1cfLjowd5rL5kZ/aczbr2EEFT3xTocOQESRAy8fTIb726FpWmBiumaj0s5AENNFFdUS6z2TjE+fpx42tTgiofQzKF/mwU9c0f3G8qC6anE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE5C027u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE5C027u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B947C2BCB0;
	Fri,  8 May 2026 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243257;
	bh=jMYIS7ff8E/7knteldQlkt+Sgf2r95gCzVmHFgh+Ehw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AE5C027u+11XjsPx9+bTIRGc5Ysw5ULMy5/2Mw1PgIApD/kiUmHyMAR/s8o/WrezK
	 ISiLITaz6EbRqSz6zotgJdzeSZArvMaRWwWEplHMoxlKWm0EPuuV7l0FeYbzYuZW6R
	 N+4+kbQ6BIScS9fYOwaHCGuZJM83cmfPLatvbm4bSr/Vri/62NwWgS2GldfatUK8ZK
	 RcGjtfXm0sSQnAOdAFVOtr+AEme8yB0L0zGydQP5q/bQlhozWc86kgHzmOLjrjIgMc
	 3YGx2cnHd7RTEhYZWCldm3lZY1XOsoV6UnfELfj0+u7cBiHQF8DzRf0HmP7/j6o1o9
	 xjTum+9eCeE9Q==
Date: Fri, 8 May 2026 13:27:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] MAINTAINERS: remove unmaintained ADI IIO entries
Message-ID: <20260508132728.1ebe6d52@jic23-huawei>
In-Reply-To: <afzY9ZgmSFIrrd5w@debian-BULLSEYE-live-builder-AMD64>
References: <20260507175132.3063161-1-sanjayembedded@gmail.com>
	<20260507175132.3063161-3-sanjayembedded@gmail.com>
	<afzY9ZgmSFIrrd5w@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2026 15:24:53 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello,
>=20
> On 05/07, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >=20
> > The listed maintainer analog domain email for Cosmin Tanislav is no
> > longer valid, and he would no longer maintain this driver(s). =20
>=20
> I'm fine taking maintainership of the drivers listed below.
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
>=20
> Unless it's preferable to drop the entries to shrink the MAINTAINERS file=
 a
> little bit. By the way, if I get the point of the ADI IIO DRIVERS entry, =
we
> will no longer need to add MAINTAINERS entries for new stuff that match
> ADI IIO DRIVERS regex. Is that correct?
Hi Marcelo

We don't care about reducing size of Maintainers. Here the aim was just
to make sure we didn't orphan stuff!  If you are fine taking these ones on
that's even better. I'll consider patch 1 for now then and expect an update
on this one (either Marcelo or Sanjay can do it as long as I end up
with suitable tags).=20

Thanks,

Jonathan

>=20
> Thanks,
> Marcelo
>=20
> >=20
> > Drop affected driver entries that no longer have an active maintainer
> > or reviewer. The existing "ANALOG DEVICES INC IIO DRIVERS" entry
> > already covers the corresponding files, so no coverage is lost.
> >=20
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  MAINTAINERS | 35 +----------------------------------
> >  1 file changed, 1 insertion(+), 34 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 86b2520d18fc..6f8b61d66f6a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -632,14 +632,6 @@ F:	drivers/iio/accel/adxl355_core.c
> >  F:	drivers/iio/accel/adxl355_i2c.c
> >  F:	drivers/iio/accel/adxl355_spi.c
> > =20
> > -ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> > -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > -L:	linux-iio@vger.kernel.org
> > -S:	Supported
> > -W:	https://ez.analog.com/linux-software-drivers
> > -F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> > -F:	drivers/iio/accel/adxl367*
> > -
> >  ADXL371/ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >  M:	Michael Hennerich <michael.hennerich@analog.com>
> >  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > @@ -1451,15 +1443,6 @@ W:	https://ez.analog.com/linux-software-drivers
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> >  F:	drivers/iio/adc/ad4080.c
> > =20
> > -ANALOG DEVICES INC AD4130 DRIVER
> > -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > -L:	linux-iio@vger.kernel.org
> > -S:	Supported
> > -W:	https://ez.analog.com/linux-software-drivers
> > -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> > -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> > -F:	drivers/iio/adc/ad4130.c
> > -
> >  ANALOG DEVICES INC AD4134 DRIVER
> >  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > @@ -1556,23 +1539,6 @@ W:	https://ez.analog.com/linux-software-drivers
> >  F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> >  F:	drivers/iio/dac/ad7293.c
> > =20
> > -ANALOG DEVICES INC AD74115 DRIVER
> > -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > -L:	linux-iio@vger.kernel.org
> > -S:	Supported
> > -W:	https://ez.analog.com/linux-software-drivers
> > -F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > -F:	drivers/iio/addac/ad74115.c
> > -
> > -ANALOG DEVICES INC AD74413R DRIVER
> > -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > -L:	linux-iio@vger.kernel.org
> > -S:	Supported
> > -W:	https://ez.analog.com/linux-software-drivers
> > -F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> > -F:	drivers/iio/addac/ad74413r.c
> > -F:	include/dt-bindings/iio/addac/adi,ad74413r.h
> > -
> >  ANALOG DEVICES INC AD7625 DRIVER
> >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> >  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > @@ -1877,6 +1843,7 @@ F:	drivers/iio/*/ad*
> >  F:	drivers/iio/adc/ltc249*
> >  F:	drivers/iio/amplifiers/hmc425a.c
> >  F:	drivers/staging/iio/*/ad*
> > +F:	include/dt-bindings/iio/*/adi,*
> >  X:	drivers/iio/*/adjd*
> > =20
> >  ANALOGBITS PLL LIBRARIES
> > --=20
> > 2.34.1
> >=20
> >  =20

