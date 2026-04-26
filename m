Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FF54723;
	Sun, 26 Apr 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209414; cv=none; b=TT4qtR9ePwWje/T3A17mKyKsS5WIHDa7Z/NbrMhRXN2Svw5KAOMgXn+ly+xWUPEiDuW1ye8sUDyh0+Z/RKe231VFxnuakg9Vb/yB968AghrMuIPCAyuK0RLvHlShyQUJ1OXFG6UO9P8v3eIA9U4aY1mvmRpCINIzRXlMZWrxwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209414; c=relaxed/simple;
	bh=TlQ8hgmzMC9a3TmV/utBx8SdPgHQuF2rSnfMXaQCtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B02qhwkl2GkIxiwpLxoBc6BwCiXEctNrEpIJWMg4gCtF61kMEazB4hk3zuuWNvEZ4//ePNqRiX9qTcp6jpm6RsFhzuydzpwuVnQMD5GC6Bn1LhTIfu2KBd3BX35EgSAFJsgAdoAXMmjxl8ZcFHPkAbwT1fzkPWG6hcih9bbI2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCeFOZhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCeFOZhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D404C2BCAF;
	Sun, 26 Apr 2026 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777209414;
	bh=TlQ8hgmzMC9a3TmV/utBx8SdPgHQuF2rSnfMXaQCtnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCeFOZhEyLTkac1NFmrACfz+OhsUUGydB8OftH4QIF7vrbWuy7wKRQ2yMchBSZ1k5
	 uqwEx0/D9oqVsoc03BsMNGo7p54mUBtlVmmLyFTQ3GzJPba7FPNDNUTIg+9M2m02OI
	 8ZXDNZYzz3mZbTRb0xp0SSHTbFrKSJbbAUJk+14tOKkpvF7DE9ksZ5fBehDUHY2w3n
	 mbDlfA+gbLF6KmDmtMv+aPWVYLvIFlFhNYh8BnvTAGkntUg3Re8K3Gj7j3YlOq10Dd
	 HJBdn9jL5uqb9yGiLJdj90mtn9/AXRzmFEWVwiy27bGPmlBF0NoP8eXQy+wCLpJyP4
	 H9LbPu070BOIA==
Date: Sun, 26 Apr 2026 14:16:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, demonsingur@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <20260426141645.5fb8406a@jic23-huawei>
In-Reply-To: <DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
	<aenU2WZnVJ-esibn@nsa>
	<8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
	<aeskNzhWtKPNYb4R@nsa>
	<20260424202727.1b880766@jic23-huawei>
	<DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 15:21:47 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 25 April 2026 12:57:27=E2=80=AFam IST, Jonathan Cameron <jic23@kernel.=
org> wrote:
> >On Fri, 24 Apr 2026 09:08:37 +0100
> >Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > =20
> >> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote: =20
> >> >=20
> >> >=20
> >> > On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname.nuno=
@gmail.com> wrote:   =20
> >> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:   =
=20
> >> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> > >>=20
> >> > >> The listed maintainer analog domain email for Cosmin Tanislav is =
no
> >> > >> longer valid, and he would no longer maintain this driver(s).
> >> > >>=20
> >> > >> Replacing email maintainer with list, to keep it valid all the ti=
me.
> >> > >>=20
> >> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> > >> ---
> >> > >> Changes in v3:
> >> > >> - Following input from Nuno and confirmation from Jonathan,
> >> > >>   replacing domain specific maintainer with mailing list.
> >> > >> - Link to v1: https://lore.kernel.org/all/20260418211336.1800221-=
1-sanjayembedded@gmail.com/
> >> > >> ---   =20
> >> > >
> >> > >While you're doing this, could you take the opportunity and also up=
date
> >> > >this entry?
> >> > >
> >> > >https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837
> >> > >
> >> > >Thanks!
> >> > >- Nuno S=C3=A1
> >> > >   =20
> >> > Hi Nuno S=C3=A1,
> >> >=20
> >> > Are you suggesting to have separate change to add mailing list in an=
alog devices and iio driver which you pointed ?=20
> >> >=20
> >> > This change is specific to email debounce due to Cosmin analog domai=
n account.   =20
> >>=20
> >> Yes, it makes more sense for it to be a separate patch. I also suggest=
ed
> >> that one because it's an entry covering a lot of driver's and
> >> includes Lars which has been silent for some time now so maybe it's be=
tter no
> >> to "spam" him like that :) =20
> >
> >If we are adding the entry to the catch all, do these individual entries
> >bring any benefit. Maybe we should just drop them?
> > =20
>=20
> Hi Nuno and Jonathan,
>=20
> Here is my view on this,
>=20
> Lars-peter is maintainer of drivers falls in different subsystem, so
> If we can plan to drop/replace would need ack from Lars-peter and
> also mutual agreement from all respective subsystem owner as it won't
> be advisable just to update analog devices IIO drivers maintainer.

Definitely good to get Lars' view on this - though that can be on the
final patch.  He is indeed busy with other thing these days so
for IIO at least, if Lars doesn't respond for a while I can take
a patch dropping him as the maintainer (and move to Credits) anyway.

>=20
> Regarding analog mailing list, we can plan to add list across
> MAINTAINERS where analog devices ownership is there as maintainer or
> reviewer.
No. I'm proposing we add it to

ANALOG DEVICES INC IIO DRIVERS
M:	Lars-Peter Clausen <lars@metafoo.de>
M:	Michael Hennerich <Michael.Hennerich@analog.com>
S:	Supported
W:	http://wiki.analog.com/
W:	https://ez.analog.com/linux-software-drivers
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
F:	Documentation/devicetree/bindings/iio/*/adi,*
F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
F:	Documentation/iio/ad7606.rst
F:	drivers/iio/*/ad*
F:	drivers/iio/adc/ltc249*
F:	drivers/iio/amplifiers/hmc425a.c
F:	drivers/staging/iio/*/ad*
X:	drivers/iio/*/adjd*

Only and for entries that match those wildcards and where there is not
other info (such as the ones here post modification) just delete the
more specific entry.

Where we have maintainers for specific drivers then we keep the entries.
No need to sorry too much about adding this list to all of those ADI
drivers as this catch all should also match.

So end result of the proposed change would be to just remove the entrees
you are updating here as the catch all will cover them.

Thanks,

Jonathan

>=20
> Also, this change would be separate from both above points so we
> shall take it further.
>=20
> Kindly share your thoughts, valuable input and guidance on how should
> we proceed further for this change and other two topics.
>=20
> Thanks,
> Sanjay Chitroda=20
>=20
> >>  =20
> >> >=20
> >> > Also, I had take a glance on MAINTAINERS, it looks there are
> >> > good amount of drivers which are maintained by you and Michael
> >> > Hennerich from analog. If you suggest I can plan to add analog
> >> > mailing list in all respective places in separate change.
> >> >=20
> >> > This way all analog device maintained drivers will have mailing
> >> > list of analog.com   =20
> >>=20
> >> Yeah, I'm not sure if it makes sense to go change all of those. I
> >> would focus on bouncing emails and we (ADI) need to make sure to
> >> also include that list from now on.
> >>=20
> >> - Nuno S=C3=A1
> >>  =20
> >> >=20
> >> > Kindly share your thoughts on the same.
> >> >=20
> >> > Thanks,
> >> > Sanjay Chitroda=20
> >> >=20
> >> >=20
> >> >    =20
> >> > >>  MAINTAINERS | 8 ++++----
> >> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> > >>=20
> >> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> > >> index c981cbdff500..6498f0aed1ff 100644
> >> > >> --- a/MAINTAINERS
> >> > >> +++ b/MAINTAINERS
> >> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> >> > >>  F:	drivers/iio/accel/adxl355_spi.c
> >> > >> =20
> >> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >> +L:	linux@analog.com
> >> > >>  L:	linux-iio@vger.kernel.org
> >> > >>  S:	Supported
> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> > >> @@ -1461,7 +1461,7 @@ F:
> >> > >> Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> >> > >> F:	drivers/iio/adc/ad4080.c=20
> >> > >>  ANALOG DEVICES INC AD4130 DRIVER
> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >> +L:	linux@analog.com
> >> > >>  L:	linux-iio@vger.kernel.org
> >> > >>  S:	Supported
> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> > >> @@ -1549,7 +1549,7 @@ F:
> >> > >> Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> >> > >> F:	drivers/iio/dac/ad7293.c=20
> >> > >>  ANALOG DEVICES INC AD74115 DRIVER
> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >> +L:	linux@analog.com
> >> > >>  L:	linux-iio@vger.kernel.org
> >> > >>  S:	Supported
> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> > >> @@ -1557,7 +1557,7 @@ F:
> >> > >> Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> >> > >> F:	drivers/iio/addac/ad74115.c=20
> >> > >>  ANALOG DEVICES INC AD74413R DRIVER
> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> > >> +L:	linux@analog.com
> >> > >>  L:	linux-iio@vger.kernel.org
> >> > >>  S:	Supported
> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> > >> --=20
> >> > >> 2.34.1
> >> > >>    =20
> > =20

