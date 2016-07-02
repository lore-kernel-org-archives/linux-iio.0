Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35377 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751360AbcGBNqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 09:46:19 -0400
Date: Sat, 2 Jul 2016 15:46:17 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
Message-ID: <20160702134617.GC4604@lukather>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
 <20160702110227.GB4604@lukather>
 <9b02394e-b38b-c804-780b-e9707c292486@redhat.com>
 <20160702133243.GB20045@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
In-Reply-To: <20160702133243.GB20045@piout.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 02, 2016 at 03:32:43PM +0200, Alexandre Belloni wrote:
> > > > I believe that the best way to deal with this is to add an
> > > > "allwinner,general-purpose-mode" flag to the existing binding
> > > > (as well as document general purpose mode in the existing
> > > > binding rather then in a new binding doc).
> > > >=20
> > > > That seems to be the right thing to do purely looking at this
> > > > from a dt binding pov.
> > >=20
> > > There's a way simpler solution: if there's no child nodes, it's meant
> > > to be used as an ADC, otherwise, as input.
> > >=20
> > > The logic will have to be a bit more complex than that, since there's
> > > two channels, and you could only require one for the buttons, leaving
> > > the other one available as an ADC.
> > >=20
> > > But that doesn't require any new property.
> >=20
> > True, if there are no button nodes, then go general-purpose will
> > work too.
>=20
> Well, I'd still argue that we need two different compatibles because
> encoding the usage of an IP in its compatible string is less than ideal.

That's true, but it's what we have.

So feel free to add a new compatible if you want, but we'll have to
support the old one anyway.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXd8WpAAoJEBx+YmzsjxAgKmIP/jLcwghrR3hMD92AS3oAoPmu
1bnv+hWQpY06WmW+82RTCKNvH/D0kdXKR1C9PnE371WkaTTslNCzdjO+mWMoSxUq
e0eQn+z0hAP76h03woQBWOHA7St5vcIXGz/Vt3AOidDrN0otSCUpa1/lvi31jDZP
XBzqf9wg0iDDvic1Wfo0/EeNSKYdwHoHzgxW7Y1ByJ09DonTEe/wpr5UhDP2WjZd
p2h0tcgUqUat5HvlcPIcf2tpjk+r4hYXwzTGviULNj45jIfjr8NTGIRDqXnQcNXK
QcStwX72SzUQC/nWDRUU/NFIJgCN4wGjm/zcV9KanNwBGogLZ90EtgT9jyDKHsRi
nT2QvWYhY1jN7VeXbSZ4EZUpbwwq6KVNPy9ATAl6TVedilRI9zBRq/oya6XfYxMl
ljcqryTos65hV42Jbyo9qHXZaKzdMuSUuyh/GSP7ONHlIDJuG2BSe4x4zpRTqi0W
iMKf7zQqJqLjk0DDhSNlgOM9MLC9LTgqeLC8r94g6m+6i6/celTMc7HZSmwjlWPZ
FX1rft4f7F8+J4vFt9XuYXBEbLV+/O2jeZItA7D3TWJwy1Db0x5riFWZwAHQOls3
G1LxIBCqhbIaM40obife9SU0NLVNRrpKQFDiiko57kJuyUuSeyL5IDU6k2kdurBM
mSCayid6asQQstBiOiMl
=6Pnk
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
