Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55230 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeA1IkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jan 2018 03:40:05 -0500
Date: Sun, 28 Jan 2018 09:40:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180128084003.GA23818@amd>
References: <1515197240.26317.65.camel@intel.com>
 <20180118224026.GE17196@amd>
 <20180120151908.1d438aaf@archlinux>
 <1516480282.15527.4.camel@intel.com>
 <20180127220931.GA19668@amd>
 <1517093714.6759.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <1517093714.6759.6.camel@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> > > Correct. This will depend on =A0the firmware expected format . I
> > > think
> > > ultimately it will be standardized.
> > Is it fair to say that "expected" format is some kind of bytecode for
> > CPU in the gesture sensor?
> Not necessarily a byte code to execute on the CPU in the gesture
> sensor, but a format the code running on that CPU understands the way
> gestures are formatted.
> But it can be byte code for some manufacturers, so idea is just pass to
> the firmware and let it process it an opaque format.

It would be really good to figure out common format for different
sensors. Otherwise kernel is not providing proper hardware
abstraction.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlptjGMACgkQMOfwapXb+vLnUgCeJuBoWOUzZFz34NLbhZXGhBWK
kbUAoK2eMRpx3xOmKYV84YsSQwlEDXzr
=XYTV
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
