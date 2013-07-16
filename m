Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34873 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab3GPLUU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 07:20:20 -0400
Date: Tue, 16 Jul 2013 13:20:17 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Josh Wu <josh.wu@atmel.com>, plagnioj@jcrosoft.com,
	jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in MR
 for different IP
Message-ID: <20130716112017.GC3125@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-3-git-send-email-josh.wu@atmel.com>
 <20130715125815.GC2962@lukather>
 <51E505EA.4060502@atmel.com>
 <51E50864.6020904@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
In-Reply-To: <51E50864.6020904@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 10:46:28AM +0200, Nicolas Ferre wrote:
> >>capabilities from which compatible is declared.
> >>
> >>It seems safer.
>=20
> I see it as handier in the sense that a different IP version can be
> compatible with an older IP version: so we do not need to modify the
> driver just to use another SoC.
>=20
> On your side Maxime, what makes you say that it is "safer"?

Well, the register holding the IP version seem to be not programmed in
some cases (or, at least, the driver handles this case).

So, what would happen if one SoC was in such case? You wouldn't be able
to use the ADC/touchscreen, even though the IP in itself might very well
work, which doesn't sound very nice, while the DT will always be there,
and will always have a compatible property.

> >Ok, that make sense. I will use compatible names for the capabilities in
> >next version. Thanks.
>=20
> Hold on a little bit Josh, I know that Jean-Christophe is not in
> favor of the use of multiple compatible strings. So, as the code is
> already there, let's wait and see if we find another argument...

And you know my feeling about this for quite some time already ;)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5SxxAAoJEBx+YmzsjxAgpJ0QAIgmK1LhoTluGXlgkyuZk618
G0cg3HHBm62DwPStYWOpWiL/Vsz50OoWKTf5O4PSFiXnKR7v0D8tLMncnQVPP7Ae
IKajDiDB7lgsA/DeTkM3+QxOXIiB0mPqV6Y6W7RGQ0fCD5hLmnx4chyz80+61VFc
tuAuYIyIxpSZgxEKRlxtDHiNrwu2ynvdixLhOx3UK3qG98CXC+qI0ebElbrHo+sn
YLW5kPKJME7mIaJm+luLYSE+/AIQyvtAkJzbUWjj+I6KJeY3lli0IFs/euE6iwGV
AK6gE+MMb/9dVS37Rwi+dhSe3vbMrJKBOF+4h2Mxn+2BTbNz9vmTthEHGB1m+9Eg
1xKM2GJdlnMlHlsCxKcoIjAX3CX/+q86/OGGYfPuGOE6kcYSFcGLdocS4RsMUbGU
js9jntAyd8gjGzDIDJQ0Pi9QJAkIFY4zPizI0bETIx14gQ+JEPc0nS3oyYa/9yjU
/jKH5uXS/4W8oU8qbMJn/2j/dhlxnCCVGgt08U8VgKQpt1XLOv1E0lsFk65g2eXa
DUv1D0BYy+gWhtFlHnq4ucruqVtxFSHHtPOgqclGue/NRHWPSUX8cK/e+O+qjiCi
img1fgK/neDdyj3Zd1EJ7ps6iLKCUQAx9+fvUVs9eVQnUmGdkJyZPX6/QGzVL7X3
2Wvb6qCCk1aUf5br3ZGS
=sJqn
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
