Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
From: Crt Mori <cmo@melexis.com>
Date: Tue, 7 Jul 2015 16:44:54 +0200
Message-ID: <CAKv63usOmHqmaFp1GyPGau+5et1C=+BEYP0T33PpwCtNqkWudg@mail.gmail.com>
Subject: [PATCH 1/1] iio: mlx90614: Added copyright notice
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>,
	Johnathan Iain Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=001a1139ec7017f211051a4a131a
List-ID: <linux-iio@vger.kernel.org>

--001a1139ec7017f211051a4a131a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Added copyright notice.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
diff --git a/drivers/iio/temperature/mlx90614.c
b/drivers/iio/temperature/mlx90614.c
index d767d2f..102ffd6 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  * Copyright (c) 2015 Essensium NV
+ * Copyright (c) 2015 Melexis
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
@@ -667,5 +668,6 @@ module_i2c_driver(mlx90614_driver);

 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_AUTHOR("Vianney le Cl=C3=A9ment de Saint-Marcq <
vianney.leclement@essensium.com>");
+MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
 MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor
driver");
 MODULE_LICENSE("GPL");
--

--001a1139ec7017f211051a4a131a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Added copyright notice.</div><div><br></div><div>Sign=
ed-off-by: Crt Mori &lt;<a href=3D"mailto:cmo@melexis.com">cmo@melexis.com<=
/a>&gt;</div>---=C2=A0<br>diff --git a/drivers/iio/temperature/mlx90614.c b=
/drivers/iio/temperature/mlx90614.c<br>index d767d2f..102ffd6 100644<br>---=
 a/drivers/iio/temperature/mlx90614.c<br>+++ b/drivers/iio/temperature/mlx9=
0614.c<br>@@ -3,6 +3,7 @@<br>=C2=A0 *<br>=C2=A0 * Copyright (c) 2014 Peter =
Meerwald &lt;<a href=3D"mailto:pmeerw@pmeerw.net">pmeerw@pmeerw.net</a>&gt;=
<br>=C2=A0 * Copyright (c) 2015 Essensium NV<br>+ * Copyright (c) 2015 Mele=
xis<br>=C2=A0 *<br>=C2=A0 * This file is subject to the terms and condition=
s of version 2 of<br>=C2=A0 * the GNU General Public License.=C2=A0 See the=
 file COPYING in the main<br>@@ -667,5 +668,6 @@ module_i2c_driver(mlx90614=
_driver);<br>=C2=A0<br>=C2=A0MODULE_AUTHOR(&quot;Peter Meerwald &lt;<a href=
=3D"mailto:pmeerw@pmeerw.net">pmeerw@pmeerw.net</a>&gt;&quot;);<br>=C2=A0MO=
DULE_AUTHOR(&quot;Vianney le Cl=C3=A9ment de Saint-Marcq &lt;<a href=3D"mai=
lto:vianney.leclement@essensium.com">vianney.leclement@essensium.com</a>&gt=
;&quot;);<br>+MODULE_AUTHOR(&quot;Crt Mori &lt;<a href=3D"mailto:cmo@melexi=
s.com">cmo@melexis.com</a>&gt;&quot;);<br>=C2=A0MODULE_DESCRIPTION(&quot;Me=
lexis MLX90614 contactless IR temperature sensor driver&quot;);<br>=C2=A0MO=
DULE_LICENSE(&quot;GPL&quot;);<br>-- </div>

--001a1139ec7017f211051a4a131a--
