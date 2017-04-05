Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32964 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754534AbdDEKwE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 06:52:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id 197so1386505pfv.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Apr 2017 03:52:04 -0700 (PDT)
Message-ID: <1491389519.7588.1.camel@researchut.com>
Subject: Re: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get poll
 value function order to avoid sensor properties losing after resume from S3
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Song Hongyan <hongyan.song@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc: stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 05 Apr 2017 16:21:59 +0530
In-Reply-To: <1491353080.3695.4.camel@linux.intel.com>
References: <1491035833.10386.1.camel@researchut.com>
         <1491059661.30396.37.camel@linux.intel.com>
         <1491246858.17255.10.camel@researchut.com>
         <1491353080.3695.4.camel@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-eZ97G1uHUGi+8GNR68e0"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-eZ97G1uHUGi+8GNR68e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-04-04 at 17:44 -0700, Srinivas Pandruvada wrote:
> Hi Ritesh,
>=20
> Does the attached patch helps?

Thank you Srinivas. I tested your patch on top of 4.10.8 and it is working
perfect.

Ritesh

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-eZ97G1uHUGi+8GNR68e0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAljkzE8ACgkQpjpYo/Lh
dWm+sw//ZWn4KKcM7KMOZ/5m5hQ0217+X6bGSlOLLK10wsyrlJKKFRKUikEAboRt
Wp+qcSoR6uT1sKytsPsONI+/yPTcs5i6wFr1yGwglHgowCv7d+EtB/U9xoS2QhBt
wZDDSC40FQ9cAyFteGdqnTUXyY3S/8edF8BgsfIXWRxwd0wVdB+EhVdvHpyPIzXj
kgquH5N/ZqRlEQHYydJP5Ohf2OEqNomAvr2g/I6DVrU6os0A32lob9HWEawQvsTv
h8nmdDONKgoILefz96kobod4soLk5vUdAPNl1K1wsJxh0tkw/BX/BwFdZeGD2jGl
ViQUpwgBcWTwSz35nlm3+dFWK+GST7UPSimag1RkjWAoLCQF1o7xx33LQr0Unv+W
pozZjS6ClWfrInrEZitUN7KCjP+jdpKDQlGnGMueoGx97jFe9OpoZgxgFrXFY//O
NDrjcEUIYmNH0wGwSg5HLCW/AibHws4IvThhfUnZj+MYc+D5/cHV7S4DddbWTS8f
NEVvkNWqPAjiuJHz9K1vC1zjsozxYSymY4Ntb30SJzH/G/g7xTgWX8xkjuD6B5mw
Z0H2t7EdlkKK4jH/s+mj4npCUTkYLk014dTZI1JtKms3UjMpk+JW1B7j9Zs9mX6n
uUTgawk90ogJybJm1YypqSt1LmYZLR6z6C7hadhUyfynyAfBF9g=
=YKEx
-----END PGP SIGNATURE-----

--=-eZ97G1uHUGi+8GNR68e0--

