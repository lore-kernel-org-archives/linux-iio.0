Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53810 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbcLMPxc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Dec 2016 10:53:32 -0500
Date: Tue, 13 Dec 2016 16:53:27 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCHv2] iio: adc: Add Maxim MAX11100 driver
Message-ID: <20161213155327.GA1451@katana>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <1481632629-18826-1-git-send-email-jacopo@jmondi.org>
 <CAMuHMdUCuBs9Fm+YvsqEc1J_a_2sgg104DDBf39oUD2JQRxXtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <CAMuHMdUCuBs9Fm+YvsqEc1J_a_2sgg104DDBf39oUD2JQRxXtg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +struct max11100_state {
> > +       const struct max11100_chip_desc *desc;
> > +       struct spi_device *spi;
> > +       int vref_uv;
>=20
> unsi
> It's good practice to move the smaller members to the end of the structur=
e,
> to avoid gaps due to alignment rules (struct mutex needs to be 64-bit ali=
gned
> on 64-bit platforms).

One option. Another idea is to put the most used members to the front to
increase chances of being in the same cacheline.


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUBl3AAoJEBQN5MwUoCm2sicP/1dcOXk44ubnIWRJFlXFhOjw
pnw6awvRdPA79ulDOxxU5/cPOO6+ZMM7rz1Ie0Vf4bbjLcfY7R5Gx3PkYNj5RUgr
T7LszFXnlsQ1usHpc8kt5rB3cjwbarRFXnyegI+GeeSgIxt2CJDduaCKpnMu3rhl
NTKs7XKh8wgnO5R/Ylvw5c6MEKi6twXfrCXMz3uhQtprpyZufKGydk3km/R1qekg
lvUTjbYAIGrZ9EkNJ6DGFF/6McvujMWMtz//BD22qlWM3f2EFXnRcWECNSg+3VwW
+mPNg+7J1VRQNLK4TF0VpyOsfcTOcHWEMgG4vdudPhzN7ausMBaxXOCqrpFQGo4Q
jC4MbZKIuodnGN0WokbpCwGcilhnuTqRd7GDKc+xwyekPzLudA6AezamDMRaoQjH
FwQYW2fzzCuyGeiotF1kk+aX/sG+i88pSrPeFgI430bvEHJsDbR8d99pQBvS76n/
hE58QIGU8zpsEEFdL+iWC1K1Nv5X+sl8NV/ZcLNekJOUY+74Tlu6WY3LtZiqUnMB
hgEt6+jKwWipcvHHptj+zAeQRgLsuJAyR0whwS66k9MXu8W1y/Oasg41w6w76qOr
u5IVmGQt+y4Dxq6fePwdthqQHj+0Tp/8fBjViMcXWFLJZiD+4zLtBUBRi4ILZL8q
/lmtZH+AJqs0/UcQ/g8/
=3a6Q
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
