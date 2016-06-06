Return-Path: <William.Markezana@te.com>
From: "Markezana, William" <William.Markezana@te.com>
To: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: (ms5637) Add Measurement Specialties explicit MS5805
 and MS5837 support
Date: Mon, 6 Jun 2016 08:12:11 +0000
Message-ID: <CY1PR01MB1947F70E574A7D6F4FEB281A955C0@CY1PR01MB1947.prod.exchangelabs.com>
References: <A02AF0B2-1B1A-477E-952B-AA332C6650FE@te.com>
 <alpine.DEB.2.02.1605312318400.9332@pmeerw.net>
 <CY1PR01MB1947A8160E9C24A9398543EA95470@CY1PR01MB1947.prod.exchangelabs.com>
 <07bdfb5d-5113-2174-a1dd-dec7af0bcf9b@kernel.org>
In-Reply-To: <07bdfb5d-5113-2174-a1dd-dec7af0bcf9b@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

iio: (ms5637) Add Measurement Specialties explicit MS5805 and MS5837 suppor=
t

Signed-off-by: William Markezana <william.markezana@meas-spec.com>
---
 drivers/iio/pressure/ms5637.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index e8d0e0d..66f1a4c 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -1,6 +1,6 @@
 /*
- * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
- *            pressure & temperature sensor
+ * ms5637.c - Support for Measurement-Specialties MS5637, MS5805
+ *            MS5837 and MS8607 pressure & temperature sensor
  *
  * Copyright (c) 2015 Measurement-Specialties
  *
@@ -11,6 +11,10 @@
  * Datasheet:
  *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
  * Datasheet:
+ *  http://www.meas-spec.com/downloads/MS5805-02BA01.pdf
+ * Datasheet:
+ *  http://www.meas-spec.com/downloads/MS5837-30BA.pdf
+ * Datasheet:
  *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
  */
=20
@@ -170,7 +174,9 @@ static int ms5637_probe(struct i2c_client *client,
=20
 static const struct i2c_device_id ms5637_id[] =3D {
 	{"ms5637", 0},
-	{"ms8607-temppressure", 1},
+	{"ms5805", 0},
+	{"ms5837", 0},
+	{"ms8607-temppressure", 0},
 	{}
 };
=20
--=20
2.1.4
