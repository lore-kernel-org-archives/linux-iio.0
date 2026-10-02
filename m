Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6163043DE;
	Fri,  2 Oct 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945349; cv=none; b=blardiWXv9wHc7Mtr0guup5VXN/0EIgbbrCXKflGXe5ZaUf4EhMAl8rXj1YRaz0qLs8tETEokW+uLvM++d9/ik4xdFNdCV5nA2gBc8m6OUsPgz4pXCfqOe9e1a5nzDbV6nXf8t+YG4i4Fq5bOWbrGWdlwFDDmdfDzFiXSFC0LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945349; c=relaxed/simple;
	bh=AdROd2ZJ+C0TMdwPnCC4Hlm2QGTkSzIVq45yS8vVKxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vEPOYNz2Tlp1BDyHD+7LC8EiYFh3CSddkg7KbtWvetJsODdga7iS/pHCHhfyCcJoAxQy4lLu4BWbaZPdkBOJzzz6e/kfwI4uqcl05ieq2HTkHGuvGMUzZ9M1sN0cgpGox8sgQb6H2lIdPkeHznENiDMoh48iq0bvQifv8ilLfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyypyfZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyypyfZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D0A1F00893;
	Fri,  2 Oct 2026 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945347;
	bh=H5ZBfkdXjjzu1fPa6uddPe5j/zgA0IS9klOyMGA/rFs=;
	h=From:To:Cc:Subject:Date;
	b=oyypyfZTzGL8ohgd3rfQR6KEGhjgElNCTtjNGJU0WdOcEJVBZ3U9/AotxY+Zi2s1k
	 9MHLAxAcfWzvSDEguVsEPE2P6dT0W7FXydHrH4fvi+hCGWuVpD7yk7KZHoT5STe+jU
	 owmO9z7WuwL5vMGZjLdvOcHgy4S1GrGUzs++odwlM1QWN6G0gUCBL8xnx6ZXQB8snK
	 OqH/hV+4CDmhsfTfAnC/U/R4xBsG430kKsa8QqVaHZwZOKu8+TDbyI/LVe6BP0kswY
	 +wpFnL6eO1P/GYsiC/ihjmdFqC9fVLlbxZTk3GzDW/R9SzzII84PUPerN5b27BonCt
	 uLGPdo+HiD/MA==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: temperature: ltc2983: avoid -Wstring-compare warning
Date: Fri,  2 Oct 2026 14:48:51 +0200
Message-ID: <20261002124902.3703019-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When __ltc2983_custom_sensor_new() is inlined into a caller, gcc notices
that the string compare can never succeed and warns about this being a
possible mistake:

In function '__ltc2983_custom_sensor_new',
    inlined from 'ltc2983_thermistor_new' at drivers/iio/temperature/ltc2983.c:1079:24:
drivers/iio/temperature/ltc2983.c:559:29: error: 'strcmp' of a string of length 24 and an array of size 22 evaluates to nonzero [-Werror=string-compare]
  559 |    if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a false positive warning as the code always works correctly,
though the strcmp() is a somewhat elaborate way of identifying the caller.

Rework this by replacing both the strcmp() and the is_steinhart flag with
the sensor->type that is always available anyway and identifies with
code path gets taken.

Fixes: 3dd0c048409e ("iio: temperature: ltc2983: Add support for ADT7604")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/temperature/ltc2983.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 6655453c9abf..efad747c9e8d 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -482,11 +482,12 @@ static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
 
 static struct ltc2983_custom_sensor *
 __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
-			    const char *propname, const bool is_steinhart,
+			    const char *propname, int type,
 			    const u32 resolution, const bool has_signed)
 {
 	struct ltc2983_custom_sensor *new_custom;
 	struct device *dev = &st->spi->dev;
+	bool is_steinhart = type == LTC2983_SENSOR_THERMISTOR_STEINHART;
 	/*
 	 * For custom steinhart, the full u32 is taken. For all the others
 	 * the MSB is discarded.
@@ -556,7 +557,7 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle
 			 * to µK so __convert_to_raw() produces the correct hardware
 			 * encoding: P + 273.15 K.
 			 */
-			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
+			if ((index % 2) != 0 && type == LTC2983_SENSOR_LEAK_DETECTOR)
 				temp = temp * 1000000 + 273150000;
 
 			if ((index % 2) != 0)
@@ -846,7 +847,8 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		const char *propname = "adi,custom-thermocouple";
 
 		thermo->custom = __ltc2983_custom_sensor_new(st, child,
-							     propname, false,
+							     propname,
+							     sensor->type,
 							     16384, true);
 		if (IS_ERR(thermo->custom))
 			return ERR_CAST(thermo->custom);
@@ -961,7 +963,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	if (sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
 		rtd->custom = __ltc2983_custom_sensor_new(st, child,
 							  "adi,custom-rtd",
-							  false, 2048, false);
+							  sensor->type,
+							  2048, false);
 		if (IS_ERR(rtd->custom))
 			return ERR_CAST(rtd->custom);
 	}
@@ -1066,11 +1069,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
-		bool steinhart = false;
 		const char *propname;
 
 		if (sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART) {
-			steinhart = true;
 			propname = "adi,custom-steinhart";
 		} else {
 			propname = "adi,custom-thermistor";
@@ -1078,7 +1079,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 		thermistor->custom = __ltc2983_custom_sensor_new(st, child,
 								 propname,
-								 steinhart,
+								 sensor->type,
 								 64, false);
 		if (IS_ERR(thermistor->custom))
 			return ERR_CAST(thermistor->custom);
@@ -1195,7 +1196,7 @@ ltc2983_copper_trace_new(const struct fwnode_handle *child, struct ltc2983_data
 						 "adi,custom-copper-trace is required for >1 ohm copper trace\n");
 
 		ct->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-copper-trace",
-							 false, 2048, false);
+							 sensor->type, 2048, false);
 		if (IS_ERR(ct->custom))
 			return ERR_CAST(ct->custom);
 
@@ -1286,7 +1287,7 @@ ltc2983_leak_detector_new(const struct fwnode_handle *child, struct ltc2983_data
 					 "adi,custom-leak-detector is required for leak detectors\n");
 
 	ld->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-leak-detector",
-						 false, 16, false);
+						 sensor->type, 16, false);
 	if (IS_ERR(ld->custom))
 		return ERR_CAST(ld->custom);
 
@@ -1499,7 +1500,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					 sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
-						   false, 4096, true);
+						   sensor->type,
+						   4096, true);
 	if (IS_ERR(temp->custom))
 		return ERR_CAST(temp->custom);
 
-- 
2.53.0

