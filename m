Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CF49C4CE
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398994; cv=none; b=jsUyurDxC5u63A2Sz6BKFgbS02rAmtT6eu8usThYa0Sm3PhKUavD0mAcCLP6ehlsckb4u88/aT3qIXqXGwaWWyfFo+TG8qy7xPTnW7HA4f+zEEjsP+PZGRCvZ88ExIzPUb20uCPfgDESLh/G9NUVY/J6l5hb0G2MG94mXPwMLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398994; c=relaxed/simple;
	bh=bPsIjFyp39Z94fBg22xhCS9HmLo6jH1MO8WFti3n2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdJxPPvv0Hc/ryr9V4AbRJgK9HRvfx33J1DDyqbHPa6XuaFi5Am84iq3UtY9i0OI4wIa/kwbpQfT/rekx07+J1P1aR4KrcVTIrGilfJ+JrCYMhRQWxY3ydADRGVE7yKjIYs+kPERNZ6xj0qlZccDKLr+cZHEzN84Wq+ugJWQ4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOZ+P7AZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOZ+P7AZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso245236366b.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792398991; x=1793003791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xr7dewXyeCCEIBwxKlgHkjYVFXC1X9oPOY150s4lZ8=;
        b=UOZ+P7AZw9AJyU/icyEY3XBCluSHAOO479bTlBNz5kFVJYUAnZsHX6zyu4J8fKnQL+
         ClRHzdY+Uc0uynFOIT62dkit75hgDM+jtGQOvpYxAJ4zK4InJ9YD8D5cxIS44UM5h/5m
         A7TvpVoCKT1tc9WgRYBOC9bsRsbLOfsh0v/kdnql0J+BtOdh8NqoTh8gDBtCgO3lqjDP
         U6ycWRGmiVza5HDNzszmc+mdXs2b2BshCc2ZsN/5W33zEM87caERjnQR9GqjFjCtDqz7
         CAazLs3U6hPy3Xjpm1hTRwmv1U9uqcrWKSXrOQV/hewyGGUzQclrUkoTyXZuqtGLsiJN
         eAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398991; x=1793003791;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xr7dewXyeCCEIBwxKlgHkjYVFXC1X9oPOY150s4lZ8=;
        b=QK66KDJ2HM9MTmjFnANGp/IJE+ij6XvCfHlbhn8RMVNwjJcCcx6IUz4TQHjBo+uBTr
         /k+tjwUue6NIGPflHYRWnUpHpKiwYln6C+hyt2PcmhCAepHBJ/cmjy/j1xxWx51Rk7y9
         TBccYA/Zn5GsoQp3xncTot929iyOggvXO/sPj4F6HevWu3BfD/erqAoK+GzbbQ5DL6fM
         6enG4DwuU7pV62XFtdn08BzKXQeLMMHfHYuD3oB/yDc4GXJTyrCOddmuV2EQCiMOo1QE
         1reDOkY4zy5JBgvJOzKu1Jc0HvlrusFZ/JzYtpwcB5pHSG/Z9fKZFyie8mELNbtzbMFw
         Is1Q==
X-Forwarded-Encrypted: i=1; AKwUvBziqBT7PxTEDu/G0MYQhpVXWiRpk6ioSdP5F69JmVnSuswsPbI0pdNIsmPOmV50D44wjnM3HzCS+VI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzEpNidzNQPufOtGcZ7Emv88YyBbfw4sA4RLObGI0B0KrZYQkg
	vHGdKWdIgwKfwypmxz10hmssDn+9rSIqm53YlMJ7kW/Ix5WOd9eZ8fRuZs4fbRt5
X-Gm-Gg: AYBFou3zTM8a25gZt2arKkUvpt0PjlgbBCm6QK+9k637TrVMxH5jE0fxtvlHldjh2Ap
	ApR0XxL25KUHKqOKBWoafe6qCSMkHs6y1/TjomvK37e4dN0uJxaAIDE4ehyCJS4YeYlMC6emGaY
	6B3OmbCW+Ad4TOr1FL8Q5f2fxd7ic/X+fyXcuLck7P56i048tB2DpxSGfvUt0TpAkCsNw+rUlgU
	pEb/aeG9qqglue5GHofVX1CVqPcDsL8aKnnqkcYndcTsVSM3suhwnPFzMinQ/iHY1ZZnOcdHA1a
	oNygOIbWXYrkVh8VYwyjhBt9oaoYGxan4ybM3DIa5QpY2cFU026YnguSrRVyga9ym1G0tlW4sUm
	My8UkG7Uh+y+qC/Mmtep+RmST53CHfG+BffsdhfRUz8LBGi/uiKpofFNVI/wRAwoTSwwkajP8nS
	Od3DQu8Ny7ugXkn32J5ukEIIn2xMdOedtQTkOp6vbrW7QUn2bUsAfvvhD4RyCNNVN4Ozop4qh3b
	kvZSlkR5Rx0iD73CDZwRDxuMQiqhLvx8AaUKGNbzBK6C2PqzCDcc7oXy0CwL0wOrZ387DOXElcp
	GGF9lCckJTQ91OTiVycH/zIcUyI=
X-Received: by 2002:a17:907:3f1f:b0:c36:a4b4:b1ed with SMTP id a640c23a62f3a-c419e039bd1mr507835266b.11.1792398990921;
        Mon, 19 Oct 2026 01:36:30 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dcf98fsm323106966b.13.2026.10.19.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:36:30 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v5 5/5] iio: pressure: dps310: add Zilltek ZTS8032 support
Date: Mon, 19 Oct 2026 11:36:20 +0300
Message-ID: <20261019083620.1285782-6-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Zilltek ZTS8032 has the DPS310 register map, scale factors,
compensation and FIFO, with these differences:

- two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
  c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
- TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
  the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
  bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
  25/16 Hz background rate instead of the external sensor.
- product ID 0x11 instead of 0x10, the driver does not check it

Add its chip data, reading 22 coefficient bytes and with TMP_EXT clear,
a Horner step for each of c40 and c31, and the I2C and OF IDs.

Tested on a ZTS8032 over I2C: in_pressure_input is within 1 Pa of the
datasheet formula evaluated from the raw and coefficient registers at
every oversampling rate from 1 to 128, TMP_CFG reads 0x00 after probe,
and buffered capture through the FIFO returns the same pressure and
temperature as direct reads.

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/Kconfig  |  6 ++++--
 drivers/iio/pressure/dps310.c | 32 +++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 9de63908936f..ffd072e4bb8f 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -115,8 +115,10 @@ config DPS310
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Support for the Infineon DPS310 digital barometric pressure sensor.
-	  It can be accessed over I2C bus.
+	  Support for the following digital barometric pressure sensors:
+	  - Infineon DPS310
+	  - Zilltek ZTS8032
+	  They can be accessed over I2C bus.
 
 	  This driver can also be built as a module.  If so, the module will be
 	  called dps310.
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 999ae4ce73f7..a2ac8101ff31 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -5,6 +5,10 @@
  *
  * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
  *
+ * The Zilltek ZTS8032 is register compatible, with two more pressure
+ * calibration coefficients (c31, c40) and temperature calibrated against
+ * the internal sensor.
+ *
  * Temperature calculation:
  *   c0 * 0.5 + c1 * T_raw / kT °C
  */
@@ -67,8 +71,9 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 #define DPS310_COEF_LEN		18
+#define ZTS8032_COEF_LEN	22
 
-#define MAX_COEF_LEN		18
+#define MAX_COEF_LEN		22
 
 /* Section 4.8: 32 shared entries. Stops when full, so late drains lose data */
 #define DPS310_FIFO_DEPTH	32
@@ -109,6 +114,7 @@ struct dps310_chip_info {
 	const char *name;
 	bool coef_for_ext_sensor;
 	u8 coef_len;
+	bool has_c31_c40;
 };
 
 static const struct dps310_chip_info dps310_chip_info = {
@@ -117,6 +123,13 @@ static const struct dps310_chip_info dps310_chip_info = {
 	.coef_len = DPS310_COEF_LEN,
 };
 
+static const struct dps310_chip_info zts8032_chip_info = {
+	.name = "zts8032",
+	.coef_for_ext_sensor = false,
+	.coef_len = ZTS8032_COEF_LEN,
+	.has_c31_c40 = true,
+};
+
 struct dps310_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -125,6 +138,7 @@ struct dps310_data {
 
 	s32 c0, c1;
 	s32 c00, c10, c20, c30, c01, c11, c21;
+	s32 c31, c40;
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
@@ -244,6 +258,11 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c30 = (coef[16] << 8) | coef[17];
 	data->c30 = sign_extend32(c30, 15);
 
+	if (data->info->has_c31_c40) {
+		data->c31 = sign_extend32(get_unaligned_be16(&coef[18]), 15);
+		data->c40 = sign_extend32(get_unaligned_be16(&coef[20]), 15);
+	}
+
 	return 0;
 }
 
@@ -745,10 +764,15 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	if (rc)
 		return rc;
 
-	/* Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow */
-	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
+	/*
+	 * Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow.
+	 * c40 and c31 are ZTS8032 only and zero on the DPS310.
+	 */
+	if (!dps310_horner_step(&prs, data->c40, p, kp) ||
+	    !dps310_horner_step(&prs, data->c30, p, kp) ||
 	    !dps310_horner_step(&prs, data->c20, p, kp) ||
 	    !dps310_horner_step(&prs, data->c10, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c31, p, kp) ||
 	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
 	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
 	    !dps310_horner_step(&tmp, data->c01, t, kt))
@@ -1418,12 +1442,14 @@ static int dps310_probe(struct i2c_client *client)
 
 static const struct i2c_device_id dps310_id[] = {
 	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
+	{ .name = "zts8032", .driver_data = (kernel_ulong_t)&zts8032_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct of_device_id dps310_of_match[] = {
 	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
+	{ .compatible = "zilltek,zts8032", .data = &zts8032_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dps310_of_match);
-- 
2.55.0

