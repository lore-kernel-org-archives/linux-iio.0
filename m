Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34253 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdIKTjk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2017 15:39:40 -0400
Received: by mail-pg0-f45.google.com with SMTP id j16so6799781pga.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Sep 2017 12:39:40 -0700 (PDT)
Date: Mon, 11 Sep 2017 12:39:36 -0700
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
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 7/8] platform/chrome: cros_ec: Add sysfs entry to set
 keyboard wake lid angle
Message-ID: <20170911193936.GA40388@decatoncale.mtv.corp.google.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
 <1502461385-27564-8-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <1502461385-27564-8-git-send-email-thierry.escande@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On Fri, Aug 11, 2017 at 04:23:04PM +0200, Thierry Escande wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
>=20
> This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
> used to set and get the keyboard wake lid angle. This attribute is
> present only if 2 accelerometers are controlled by the EC.
>=20
> This patch also moves the cros_ec features check before the device is
> added so the features map obtained from the EC is ready on time.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

V2 Looks good. Applied. Thanks!

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZtuZ4AAoJEB8J9XsKL+ZY5SkP/j/RBdiol6H+8x8Qf8kSRpV+
VRXoHAthOHRTlJsiYfKt+QMva6YbG+IYty+QgB184p2JprGalsskncopPspKYrXa
ymrttLbysjxC29JYtOHmwwfwdMfSaH8b4ccbZqC03xKGZx3ySMq5DO3b6HRDZzwc
Ey3W95g7QjvrtyYQmF/nIGLrl/90ICvux4hhMQtCE4XKoWsRPHNP6IKTNvfkgjc5
rgmHE8SpczfsBl1rnDEtt9t1FDU92fG4CPeFKb9aeX+yhIClzSwVeKvi/gB2xtsc
K6M8QCwIPCPHozFXnpTrtjfiFDcpDYlnQiJ/r1DEEQ/GLXbOo6ThhgDHil88t3CE
g6HQO08rQRlt2KXzvwi98nQIbnDzwpq2vVzDO4udDPOM19PcHfh43+kAhsWszxEh
9sediSqsWqYWDDKxQILKY4QJJhmqlTKNmup9tUgGnYQl+AvRCHTdZrj4IBtu2nY3
/e+/BAnsjj9u5lEoppI86aZO7z9/P2Rv6/Aq+16ESkl2gxu0cDy/wCcZWElS4qBj
nIEkqTZS1bsMc9NZYJzHYyggT0hAT/ur1tQdOqPgj96+Qa8cycEEUO8Vm2Tqo5PC
aHCZfh161nlSj7v5JJuE1xrGWxVV/LdUbgvEM9eiM9fFidrC81e99icSTYNl/DWJ
B8CVJnapJpie0eGaFNBb
=+b86
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
