Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33860 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeBTNqd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Feb 2018 08:46:33 -0500
Received: from [192.168.1.4] (unknown [181.67.35.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: chrisadr)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 87300335C30
        for <linux-iio@vger.kernel.org>; Tue, 20 Feb 2018 13:46:32 +0000 (UTC)
Message-ID: <1519134383.2505.12.camel@gentoo.org>
Subject: GSoC IIO Project: Christopher =?ISO-8859-1?Q?D=EDaz?= Riveros
From: Christopher =?ISO-8859-1?Q?D=EDaz?= Riveros <chrisadr@gentoo.org>
To: linux-iio@vger.kernel.org
Date: Tue, 20 Feb 2018 08:46:23 -0500
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FeKrodG/B6oGHvP2EMOC"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-FeKrodG/B6oGHvP2EMOC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduction and Task 01 result

Good morning IIO community,=20

My name is Christopher D=C3=ADaz Riveros, I'm living in Lima, Per=C3=BA. I'=
m
starting my last semester of studies, "Software development and Systems
Integration" is the name of the career. Since a couple of months I've
been trying to contribute in the kernel community, I have a couple of
trivial fixes already in the main tree. I hope I'll be able to
contribute here as well and learn more about driver development and
specially the IIO subsystem.

I have previously worked with Arduino and several kinds of sensors as
part of my IoT course in the institute.

If there is any other info that you need me to provide, feel free to
ask please.

Here is the my solution for Task 01:=20


chris@gentoo ~/Repos/linux-next $ grep IIO .config=20
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_IIO=3Dy
CONFIG_IIO_BUFFER=3Dy
# CONFIG_IIO_BUFFER_CB is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=3Dy
CONFIG_IIO_CONFIGFS=3Dy
CONFIG_IIO_TRIGGER=3Dy
CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
CONFIG_IIO_SW_DEVICE=3Dy
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# Hid Sensor IIO Common
# IIO dummy driver
CONFIG_IIO_DUMMY_EVGEN=3Dy
CONFIG_IIO_SIMPLE_DUMMY=3Dy
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=3Dy
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=3Dy
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# CONFIG_IIO_ST_PRESS is not set
--=20
Christopher D=C3=ADaz Riveros
Gentoo Linux Developer
GPG Fingerprint: E517 5ECB 8152 98E4 FEBC  2BAA 4DBB D10F 0FDD 2547
--=-FeKrodG/B6oGHvP2EMOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGTBAABCgB9FiEE5Rdey4FSmOT+vCuqTbvRDw/dJUcFAlqMJq9fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU1
MTc1RUNCODE1Mjk4RTRGRUJDMkJBQTREQkJEMTBGMEZERDI1NDcACgkQTbvRDw/d
JUc6xwf+PL5hY7HTffq+d+aeWCRzXHGW8lJZ3COvnyJspE8fNLjvdEpkMtbWC5+Y
Hg0hxmZlxneC5hEKpGJVSR0vNF7sI5S62xxD6+BZ/gK3loX8fEWTJ0Gk+3OC2r1c
TxobXTNrR1CsXcO79yKslzjwbD6iR6Jn8y85FxH+KK4erSVgUIAsIjfEAQvxFui4
HiOjI6SWFkdKHD2wiJ0PIPheXK7gnsmbsyNYil5CN/fNZy8MMs9kGvU9hK4yN+ZB
ATCdLwhZLUHMo4dFcWaL5mRLZjVZ9QsdTOjw7O2cWrUehc7LwzrdMgZDwUFcSlcS
0LMnD2Knfsmt/qVtdA7jBWn5kxyIaw==
=RM5p
-----END PGP SIGNATURE-----

--=-FeKrodG/B6oGHvP2EMOC--

