Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33710 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdHOGfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2017 02:35:34 -0400
Received: by mail-pg0-f47.google.com with SMTP id u5so790360pgn.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Aug 2017 23:35:34 -0700 (PDT)
Date: Mon, 14 Aug 2017 23:35:30 -0700
From: Benson Leung <bleung@google.com>
To: Thierry Escande <thierry.escande@collabora.com>
Cc: Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joseph Lo <josephl@nvidia.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        Wei-Ning Huang <wnhuang@google.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH v2 4/8] platform/chrome: cros_ec: register shutdown
 function for debugfs
Message-ID: <20170815063530.GA100591@decatoncale.mtv.corp.google.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
 <1502461385-27564-5-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <1502461385-27564-5-git-send-email-thierry.escande@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On Fri, Aug 11, 2017 at 04:23:01PM +0200, Thierry Escande wrote:
> From: Daniel Hung-yu Wu <hywu@google.com>
>=20
> Reboot or shutdown during delayed works could corrupt communication with
> EC and certain I2C controller may not be able to recover from the error
> state.
>=20
> This patch registers a shutdown callback used to cancel the debugfs log
> worker thread.
>=20
> Signed-off-by: Daniel Hung-yu Wu <hywu@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

Applied.

Thanks,
Benson


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZkpYyAAoJEB8J9XsKL+ZY2IkQAJc+dl8GbyfARV+gW52X2Mub
X9v+tOiiTUPIGXFphf75kcofJbNBOUDOFIPz+usyvu01XZmrQ+Icq0baD7ub06th
7h9rzqXKN3FE4zxfCTEOUEN9RNoN6rmIuG7dRYKvn4qrLFK4MUv+yCd4SO3R2lWw
VuX2zz+SPSHJ5LKxSzIHeOoTLcmchqJxR5f0J44OUNUXnoh/bOElxVJEBznnVSzq
ZGgdDRO6P1+WZmzRJp48Z6aRUjHyJqsrNSaJWr+Sz967mTCBBJemy2vON7paqP9L
angOUuH6w39LUuHKlc4f+3XEYO1xp/1Ez8clDK9wmxBUyMcMWVPbOuQyFwu5Adpv
Z2m+1HX8l9sshI2dNnwLxvVGpoOdEnvydulype+dV9Dts3D/dYCOgwRxheK8wd0C
8Y/nGGmHgA2nAYtr360Z4dC4KbZgJ+hfmlJVOET86oTAPya6t1NF0rv5L68c6WPI
8aYM8hsP8YUHxCYr2v2q3p6aMqnf+kxR9g0lUJdpotL/ufNPMDdXD/CvV8itx0i/
9Pyzsi8hXSXyj85cW81yUTZ08Gp+hre1MxP/eTTZaV1dcJI1KKLrpeNBvM1GSY9J
VrumKXpRuWU5Aiz7gQkKAFEHJotcuz87Yg/6UHCzEoDMmZYHxt4XBNqzzNT/Zjo6
x25VgG+fcF+s75hSWg9e
=k9Lx
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
