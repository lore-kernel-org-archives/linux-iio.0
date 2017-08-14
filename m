Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:51910 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbdHNMh2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Aug 2017 08:37:28 -0400
Date: Mon, 14 Aug 2017 14:37:26 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Message-ID: <20170814123725.GA2238@katana>
References: <20170814085941.GA9759@arbeit>
 <20170814091106.rvdvebcxfbpggmjd@ninjato>
 <20170814103918.GB3062@imap.1und1.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <20170814103918.GB3062@imap.1und1.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 12:39:18PM +0200, Andreas Klinger wrote:
> Wolfram Sang <wsa@the-dreams.de> schrieb am Mon, 14. Aug 11:11:
> > On Mon, Aug 14, 2017 at 10:59:41AM +0200, Andreas Klinger wrote:
> > > add trivial device tree binding "devantech,srf02" and "devantech,srf1=
0"
> > >=20
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
> >=20
> > Again: This file has moved since v4.12-rc1. Please rebase to v4.12 or
> > even v4.13-rc5.
> >=20
>=20
> Then i split the patch series up in two parts:
> - patch with only device tree binding against >=3D v4.12
> - everything else as patch series against git tree of IIO
>=20
> Ok?

Wooha, the master branch of iio.git is at v4.11? I see. So, this is the
culprit, sorry! @Jonathan: is that the branch people should develop on,
or is it your testing branch?


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRmYEACgkQFA3kzBSg
KbbOig//ROG3M78W1k49GH0hBYMuRUC5RzWKXJkMdgvpUyWLlP1yEJl5CSZpfxf2
TdO3ekU8I69fUxSaX76lr4Z3QIyoFsPzw5ccbtorZY53fb/QyisLWkTqr/xEzzpq
2Wc8Uk+kqy7rZIsrrwlWS8egGxIm6RA5hcPXt9/vJz1CcGCxqVHKcThHq4Q22aiC
IIWX05Cij1Fav/O9xPYwiC988dknR3rDtol1LMDNFKqtAOzdmAL2hwveL6Na7RJe
TaQjG6MbnlLWJ00UrqsRyueHGXgXIEm+9b1fG0kmTtUrpu76PvOgfm4PwrmItm3R
5aBm0CBboQp7GlX/PMxZ8ltK9CDgEpEW9wci1XArzxbtXc4Haiyyynlk9CMM0ocS
LaY9knOwn/PheRoYyI7UMj2avYxy4gsLf84NqsTQzpPqwetuaC38Mp3nS+4g0IM+
/ZgYnfx6rlIlKsvo7nRWoVPFbsDMSYbAsGP+dn4WXhEK+dOAqIq8iv0FFwJTZHQ9
YeVqavuNoQVBtNxltiC+vvN5Nb+CRDhSyCBz2VxlQHcVh8lczmpK8VUgrPzW8Eql
+THyWGv4CTlUpm6uXkyzrm8tQYUyYkosFY7Gfpksl7FQiVsyMb959VjMlIhxkyMR
3TNEctggObTl1CGA6m63GOuTbAd40OjRY/9N07f8/9W7I6olv/s=
=XR9y
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
