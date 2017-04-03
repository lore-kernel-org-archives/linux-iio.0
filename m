Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33884 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdDCTOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 15:14:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id o123so31795177pga.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2017 12:14:22 -0700 (PDT)
Message-ID: <1491246858.17255.10.camel@researchut.com>
Subject: Re: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get poll
 value function order to avoid sensor properties losing after resume from S3
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Song Hongyan <hongyan.song@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc: stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 04 Apr 2017 00:44:18 +0530
In-Reply-To: <1491059661.30396.37.camel@linux.intel.com>
References: <1491035833.10386.1.camel@researchut.com>
         <1491059661.30396.37.camel@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-HkzyOd/UV986XIgtertj"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-HkzyOd/UV986XIgtertj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Stable, LKML and IIO MLs.

Hello Hongyan,

Do you have any feedback ? With the bisected commit reverted, I've been
successfully running the machine without any issues.

Ritesh


On Sat, 2017-04-01 at 08:14 -0700, Srinivas Pandruvada wrote:
> Hello Hongyan,
>=20
> Can you check the findings of Ritesh?
>=20
> Thanks,
> Srinivas
>=20
> On Sat, 2017-04-01 at 14:07 +0530, Ritesh Raj Sarraf wrote:
> > Hello Srinivas,
> >=20
> > With the Linux 4.10.7 release, I have encountered a regression
> > introduced on my
> > Lenovo Yoga 2 13, for the ITE Rotation Sensor.
> >=20
> >=20
> > rrs@learner:~$ lsusb=C2=A0
> > Bus 001 Device 002: ID 8087:8000 Intel Corp.=C2=A0
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 002 Device 006: ID 048d:8350 Integrated Technology Express, Inc.=C2=
=A0
> > Bus 002 Device 005: ID 0bda:b728 Realtek Semiconductor Corp.=C2=A0
> > Bus 002 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd=C2=A0
> > Bus 002 Device 003: ID 04f3:0303 Elan Microelectronics Corp.=C2=A0
> > Bus 002 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
> > Card Reader
> > Controller
> > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > 2017-04-01 / 14:04:49 =E2=99=92=E2=99=92=E2=99=92=C2=A0=C2=A0=E2=98=BA=
=C2=A0=C2=A0
> >=20
> >=20
> > The ITE sensors do not feed any data on the 4.10.7 kernel. Reverting
> > back to
> > 4.10.5, everything works back.
> >=20
> >=20
> > After a git bisect, the culprit reported is:
> >=20
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [6c2aab07d12436af1cd8d9ac1d117a442cc91eec] iio: hid-sensor-trigger:
> > Change get
> > poll value function order to avoid sensor properties losing after
> > resume from S3
> > 1
> >=20
> > Can you please review my findings to confirm that it really is a
> > regression bug
> > ?
> >=20
> >=20
> > Thanks,
> > Ritesh
> >=20
--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-HkzyOd/UV986XIgtertj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAljinwoACgkQpjpYo/Lh
dWnKqxAAjKjgpIwOp81Sojcpicdo57X6JAEJMBNIxcYCuWYEwMuySZzpgE9/e+FE
sratMBO9TtpCmdL97peo80XCz+7Vty5hMvunXRKXvzX+6obN/z+vumn2VHtDFM20
MyoxiQ65tUkK9c7uILT2mNGi45Ygj6nVGClxtdPHv0rsLP/vy5MLUlWVuK7f0Ghe
7RiXM9ewmDYX0pWHWKqD6eLvpt97rZQFgFcxEbNYs5P0GGDCt8K+LtMPIdnC7qLZ
Gk0TONWQoIgjQJSc16zST6+yyvtOt7XXZ2QffuoRegW647o5FouXdAa1QN922rlX
h1k2ArX/7ztri1n/czqyIxQsrqLce3EBLwCwDguPlSqgwjiW2MNjCfGlzerOeGPz
OEEeafU/SI4ixNqoEJo70eHnmy4rO4qaGreKw4IGrJlneGcCokneXlGmsPteADNt
mZWXRkO9tgvSt7R6ZAcNOiToDybZ8cufXPGVdCyP15/nwITR+2/0V7IV/8EudP5i
+g5ozoo4m+AIMZQ821zxqNOQdNKynmiVLKwE1SFh0VqXW6iWNKoBHlmuVpiJ8/wD
JS9vrbj80bMwQX/LYhDLLtkd5ISFEIBH41WXnZtVYQoi6riJ4BVmFWe0sPmdnNbZ
BF1eSI/YvVr5Z5yt+BUBWAxtQISuhpuNCHZPki/gMqIbFR4m5pI=
=wqLt
-----END PGP SIGNATURE-----

--=-HkzyOd/UV986XIgtertj--

