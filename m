Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15B46AF01;
	Tue, 28 Apr 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399887; cv=none; b=hMh60eg/ylzJumf8nJ8/c3QqUSpDmloO2TpCMcpupCiHmeA6cuNwMogAbbhQIkjt/0q+9/KC2nempNCgh9TTxw3WLkpdhXIkuLOWkM5c5r9W+1dNvUEotSGmw4e1kJopp4zX45INtFIoDMh1RMfWBO5rNoC4G6iHaaueb6Boe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399887; c=relaxed/simple;
	bh=c+Xwsf6oGp6QDQW2u9rtqjeMKbtlLo/7GD0gfzA6FB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikB1zk3hJhye3PYDhsqkxDTwG3nPNJuJYX1Mp2KfCO4ULChWecIzd6mgi3w+n5obsb4IeZhKXrWNP/ZdM99+r5Jp7xd9gB+KOdkpnWAXYpk5ZLLuHwoZPbX7qy7XRqRsvddnfrAuf+WyxXLoEZJpjU3KCM+eFRv37QQZVODp9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJQteLpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJQteLpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB4C2BCB5;
	Tue, 28 Apr 2026 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399886;
	bh=c+Xwsf6oGp6QDQW2u9rtqjeMKbtlLo/7GD0gfzA6FB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJQteLpLhw8+D1NdcV8n9FKM1fMQqt42YiblVB+etPeQXVlKztnc0dczWgvaPq6nY
	 D02Kv8IEq3d2iDg9OGF59b+JNTxYS54ad4AWv+PhPr5O8NZNqjpEBP99ZtuGuUkUSy
	 0sX4Wa5FB3WYTngZSdIRxA+TOegfzTMJNnS9z9Al3WO1zLtfmzt4T9wQNvQOr9V2a9
	 t5xVmkHLfr2VrcNwiuFYJ9khPnmIaum3lnvEb5Bg5s37siMJ4iBWfEeMPEOJuXqr73
	 SEWDAqlzIx99n1cbh1w7/Huki9QUZAjvqnmdZnR/nbfvGC7d15BSDslWMzd0ql8vRd
	 gDhAChqi23w6Q==
Date: Tue, 28 Apr 2026 19:11:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, demonsingur@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <20260428191118.0270cb0a@jic23-huawei>
In-Reply-To: <577DD2DD-76ED-4A7D-AB13-6008FE2AFCF4@gmail.com>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
	<aenU2WZnVJ-esibn@nsa>
	<8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
	<aeskNzhWtKPNYb4R@nsa>
	<20260424202727.1b880766@jic23-huawei>
	<DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com>
	<20260426141645.5fb8406a@jic23-huawei>
	<577DD2DD-76ED-4A7D-AB13-6008FE2AFCF4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 17:50:26 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 26 April 2026 6:46:45=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >On Sun, 26 Apr 2026 15:21:47 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > =20
> >> On 25 April 2026 12:57:27=E2=80=AFam IST, Jonathan Cameron <jic23@kern=
el.org> wrote: =20
> >> >On Fri, 24 Apr 2026 09:08:37 +0100
> >> >Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >> >   =20
> >> >> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote:   =
=20
> >> >> >=20
> >> >> >=20
> >> >> > On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname.n=
uno@gmail.com> wrote:     =20
> >> >> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:=
     =20
> >> >> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> >> > >>=20
> >> >> > >> The listed maintainer analog domain email for Cosmin Tanislav =
is no
> >> >> > >> longer valid, and he would no longer maintain this driver(s).
> >> >> > >>=20
> >> >> > >> Replacing email maintainer with list, to keep it valid all the=
 time.
> >> >> > >>=20
> >> >> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> >> > >> ---
> >> >> > >> Changes in v3:
> >> >> > >> - Following input from Nuno and confirmation from Jonathan,
> >> >> > >>   replacing domain specific maintainer with mailing list.
> >> >> > >> - Link to v1: https://lore.kernel.org/all/20260418211336.18002=
21-1-sanjayembedded@gmail.com/
> >> >> > >> ---     =20
> >> >> > >
> >> >> > >While you're doing this, could you take the opportunity and also=
 update
> >> >> > >this entry?
> >> >> > >
> >> >> > >https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837
> >> >> > >
> >> >> > >Thanks!
> >> >> > >- Nuno S=C3=A1
> >> >> > >     =20
> >> >> > Hi Nuno S=C3=A1,
> >> >> >=20
> >> >> > Are you suggesting to have separate change to add mailing list in=
 analog devices and iio driver which you pointed ?=20
> >> >> >=20
> >> >> > This change is specific to email debounce due to Cosmin analog do=
main account.     =20
> >> >>=20
> >> >> Yes, it makes more sense for it to be a separate patch. I also sugg=
ested
> >> >> that one because it's an entry covering a lot of driver's and
> >> >> includes Lars which has been silent for some time now so maybe it's=
 better no
> >> >> to "spam" him like that :)   =20
> >> >
> >> >If we are adding the entry to the catch all, do these individual entr=
ies
> >> >bring any benefit. Maybe we should just drop them?
> >> >   =20
> >>=20
> >> Hi Nuno and Jonathan,
> >>=20
> >> Here is my view on this,
> >>=20
> >> Lars-peter is maintainer of drivers falls in different subsystem, so
> >> If we can plan to drop/replace would need ack from Lars-peter and
> >> also mutual agreement from all respective subsystem owner as it won't
> >> be advisable just to update analog devices IIO drivers maintainer. =20
> >
> >Definitely good to get Lars' view on this - though that can be on the
> >final patch.  He is indeed busy with other thing these days so
> >for IIO at least, if Lars doesn't respond for a while I can take
> >a patch dropping him as the maintainer (and move to Credits) anyway.
> > =20
> >>=20
> >> Regarding analog mailing list, we can plan to add list across
> >> MAINTAINERS where analog devices ownership is there as maintainer or
> >> reviewer. =20
> >No. I'm proposing we add it to
> >
> >ANALOG DEVICES INC IIO DRIVERS
> >M:	Lars-Peter Clausen <lars@metafoo.de>
> >M:	Michael Hennerich <Michael.Hennerich@analog.com>
> >S:	Supported
> >W:	http://wiki.analog.com/
> >W:	https://ez.analog.com/linux-software-drivers
> >F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> >F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> >F:	Documentation/devicetree/bindings/iio/*/adi,*
> >F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> >F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> >F:	Documentation/iio/ad7606.rst
> >F:	drivers/iio/*/ad*
> >F:	drivers/iio/adc/ltc249*
> >F:	drivers/iio/amplifiers/hmc425a.c
> >F:	drivers/staging/iio/*/ad*
> >X:	drivers/iio/*/adjd*
> >
> >Only and for entries that match those wildcards and where there is not
> >other info (such as the ones here post modification) just delete the
> >more specific entry.
> > =20
> Hi Jonathan,
>=20
> I agree with your point.
> It make sense to drop redundant entry when we are using catch all.
>=20
> Also, with your suggested approach.
> This change won't make any sense as this entries would also get as driver=
 files are included with wildcard.
>=20
> I would prepare and share changes with your suggested approach:
>=20
> Needs your confirmation/input on two point
> 1. Drop this change and have new with suggested or keep this change and o=
n top of this apply your suggestion=20
Probably spin it as 2 fresh patches - suggested-by fine though minor enough=
 I don't really
care!

1. Add the list to the entry as above and drop Lars-Peter's entry.
2. Delete the ones with stale maintainers, making sure to state in the patc=
h description
   that they are covered by the broader catch all.

> 2. Many entries include Documentation and include files, that also requir=
ed to in-corporate in ADI entry with specific path or wildcard based on fil=
e paths, correct ?

If covered by other entries no need to update anything. If missed by the wi=
ld
cards and not covered elsewhere then we need a wider set of matches for the
one above.

Thanks for sorting this out!
J
>=20
>=20
> >Where we have maintainers for specific drivers then we keep the entries.
> >No need to sorry too much about adding this list to all of those ADI
> >drivers as this catch all should also match.
> >
> >So end result of the proposed change would be to just remove the entrees
> >you are updating here as the catch all will cover them.
> >
> >Thanks,
> >
> >Jonathan
> > =20
> >>=20
> >> Also, this change would be separate from both above points so we
> >> shall take it further.
> >>=20
> >> Kindly share your thoughts, valuable input and guidance on how should
> >> we proceed further for this change and other two topics.
> >>=20
> >> Thanks,
> >> Sanjay Chitroda=20
> >>  =20
> >> >>    =20
> >> >> >=20
> >> >> > Also, I had take a glance on MAINTAINERS, it looks there are
> >> >> > good amount of drivers which are maintained by you and Michael
> >> >> > Hennerich from analog. If you suggest I can plan to add analog
> >> >> > mailing list in all respective places in separate change.
> >> >> >=20
> >> >> > This way all analog device maintained drivers will have mailing
> >> >> > list of analog.com     =20
> >> >>=20
> >> >> Yeah, I'm not sure if it makes sense to go change all of those. I
> >> >> would focus on bouncing emails and we (ADI) need to make sure to
> >> >> also include that list from now on.
> >> >>=20
> >> >> - Nuno S=C3=A1
> >> >>    =20
> >> >> >=20
> >> >> > Kindly share your thoughts on the same.
> >> >> >=20
> >> >> > Thanks,
> >> >> > Sanjay Chitroda=20
> >> >> >=20
> >> >> >=20
> >> >> >      =20
> >> >> > >>  MAINTAINERS | 8 ++++----
> >> >> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >> > >>=20
> >> >> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> > >> index c981cbdff500..6498f0aed1ff 100644
> >> >> > >> --- a/MAINTAINERS
> >> >> > >> +++ b/MAINTAINERS
> >> >> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> >> >> > >>  F:	drivers/iio/accel/adxl355_spi.c
> >> >> > >> =20
> >> >> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> >> > >> +L:	linux@analog.com
> >> >> > >>  L:	linux-iio@vger.kernel.org
> >> >> > >>  S:	Supported
> >> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> >> > >> @@ -1461,7 +1461,7 @@ F:
> >> >> > >> Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> >> >> > >> F:	drivers/iio/adc/ad4080.c=20
> >> >> > >>  ANALOG DEVICES INC AD4130 DRIVER
> >> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> >> > >> +L:	linux@analog.com
> >> >> > >>  L:	linux-iio@vger.kernel.org
> >> >> > >>  S:	Supported
> >> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> >> > >> @@ -1549,7 +1549,7 @@ F:
> >> >> > >> Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> >> >> > >> F:	drivers/iio/dac/ad7293.c=20
> >> >> > >>  ANALOG DEVICES INC AD74115 DRIVER
> >> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> >> > >> +L:	linux@analog.com
> >> >> > >>  L:	linux-iio@vger.kernel.org
> >> >> > >>  S:	Supported
> >> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> >> > >> @@ -1557,7 +1557,7 @@ F:
> >> >> > >> Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> >> >> > >> F:	drivers/iio/addac/ad74115.c=20
> >> >> > >>  ANALOG DEVICES INC AD74413R DRIVER
> >> >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> >> > >> +L:	linux@analog.com
> >> >> > >>  L:	linux-iio@vger.kernel.org
> >> >> > >>  S:	Supported
> >> >> > >>  W:	https://ez.analog.com/linux-software-drivers
> >> >> > >> --=20
> >> >> > >> 2.34.1
> >> >> > >>      =20
> >> >   =20
> > =20
>=20

