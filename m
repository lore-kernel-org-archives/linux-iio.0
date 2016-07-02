Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33235 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750987AbcGBLCf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 07:02:35 -0400
Date: Sat, 2 Jul 2016 13:02:27 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
Message-ID: <20160702110227.GB4604@lukather>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 02, 2016 at 11:32:07AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 02-07-16 11:12, Chen-Yu Tsai wrote:
> >Hi,
> >
> >On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
> ><alexandre.belloni@free-electrons.com> wrote:
> >>Document the bindings for the Allwinner LRADC.
> >
> >We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys=
=2Etxt
> >and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
> >block.
>=20
> Right, this block is used on many tablets and some dev boards to
> provide buttons (as in the hid type) and the block is designed for
> this purpose, giving an irq when the adc level crosses a certain
> threshold.
>=20
> Sure it can be used in a more generic way, but that is not its
> primary goal.

We've always had a different view on this, but it's a detail :)

> So any generic purpose adc driver must not break the current
> use-case (which is already used in mainline kernel dts files
> in plenty of cases).

Yep.

> I believe that the best way to deal with this is to add an
> "allwinner,general-purpose-mode" flag to the existing binding
> (as well as document general purpose mode in the existing
> binding rather then in a new binding doc).
>=20
> That seems to be the right thing to do purely looking at this
> from a dt binding pov.

There's a way simpler solution: if there's no child nodes, it's meant
to be used as an ADC, otherwise, as input.

The logic will have to be a bit more complex than that, since there's
two channels, and you could only require one for the buttons, leaving
the other one available as an ADC.

But that doesn't require any new property.

> For the implementation of this we can simpy have 2 drivers,
> then both drivers can check the flag and if present return
> -ENODEV from the existing input driver and likewise if not
> present return -ENODEV from the iio driver.
>=20
> We may actually use a similar solution for the touchscreen
> controller which can also be alternatively used as a generic
> purpose adc.

There's no need to keep both drivers as long as we keep the features
and bindings.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXd59CAAoJEBx+YmzsjxAgWv4P/jg8+KnSjbAOd90Zg371Mmly
Go8Zxr/gMfAjliD0ia3eiCWkJPnePLuuG+kvxxJPt9p6LT4X4jxPe7pPEIEW//OU
u83HQhtLvOmIUJvGfO1iGG1B1Z+RtjSZjJReFKx0UD8kPue8HnW+l+aAcWVVPSxj
vdhdcA1LIuKQ6w/dITysQm8ec9vSk8lz/DWKb4BwFxH3AYYAjV/ZndIXBwBmjZmO
xs0glmgeTaE52oStL1SCWt44lTiV+2CdqGeEAAJG/vopCv3KSDgOa+B1zNCz6SWi
+tkbgxZumIXWmdOxr2Kskp2Uo2LxuwLGXp1nM4dh3miHzWCTZmBPj3TL6fgbImyG
4HL6Ih6gb2dgLvEZsA6Ez3UdjH0iYS41XpXoIw9lAPG/FT+1whJFRzhVkyygMuJX
I3QYkOXL7LUDnD8v6074Lwba8MwECCS6Kqsknp6wa6S+4SA3tHa5J1QCyKQKiCkm
Je8Rp1TkMk+nEk2rA9zpPnW1EvqjfCFMryDgf83/I1jr++rx5i/KWY1CCmNDyQ4X
zdtKLLcZLDWi14Xg8M4wG3SpUc3snNjNdPOUEHAAR+3Hs1mS3/6+cPdafHjDOAeh
7a3si+XNf63wWWEhLkR+JH0/PCtnUAWuBPtfQ7KGq6j0ZOrEgCodaRgrKo1NbyF3
5gSb/Iy1g1ErJaxM7WqU
=+gyg
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
