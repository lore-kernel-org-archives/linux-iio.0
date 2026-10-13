Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42194EDCB6
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890515; cv=none; b=ZpAv7dQ0MqTPXtnMaciZH4okKoE3izBGdGvjBRhjPHSiJ7xG9wSkMKG6GoT6pwd+bzVn1/R7vuCQBBaquwzxHzbywLbh3rxkVr25YfgyLSgQE3uM11B+njIMu8v+Xq15PP1rONrPRSQDv7Kd4SWLCh1Fg25HU+DOqXchJ+kjXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890515; c=relaxed/simple;
	bh=qFZ0MIgMM7az3BaBAJZ8KBYZgJMLll2cuCOh8eUuA4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVN5uUNW1EYvr3I/CIjy9Ta4WY2jU1VzraA4z0R39JbC9ZA427CFM6LKZfIpwszLErzfxgqLjz/7d89PU2RVOKnWWz259lATzE6xcc4ayj1yltAIy/uxKieAZoCdEi7Ryqfxr4wkrKto1bc/HrCTGpsh7SwZyfl+rv6yu6Eslnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8pBX9/G; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8pBX9/G"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so2142388e87.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791890511; x=1792495311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R07AVVjjjFyjVwfkBiPJ3fb8qZtID2Wz+iHVdXgfKW4=;
        b=K8pBX9/GeaVy7m4igGjEjX/AC6/ZRoc0cCFe+Kmx4EUGO23oxuM2q7B7HJ96u7PMc7
         h0BY1il8hIDvmt4Xn4xSsWreGzTntpu7Dioy+VIzwnmOZVpSuqPhney8Et3HgXywuST4
         jNQ08HtQ6HVyjj2wrj9kWZTgfl/bGkbZ2M8JEcRDtXFvYw7XG9SUzWwV7kZQZM8B/1oi
         /BF9Ql7whWBo0sG2pI88DtjwKoJrD95/LIiODV9KzKow20vvGtinAoMVTe1/Soli6OMs
         5QyWmKEWtZjnPEQ4keEYKw6zDRvmw4bjhZjSAEY8WIQfgDr0wO4o2YHi1GBUjpIIyEM3
         D0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890511; x=1792495311;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R07AVVjjjFyjVwfkBiPJ3fb8qZtID2Wz+iHVdXgfKW4=;
        b=tNVe+ASIAo5qAVHA6hTgjSKNMnjD72GVuKQ+PJ4bnf14/KS/lNz6us2WNnNNKIQf9T
         VI7/behy9opbR/pxjKqkxvRHu7MQ9HTllxiUdo//x6gOJPq7jTNcqh8yxtGM9x+vYm1c
         B4peSWnCO79yjrnafFG6lhD95+mdi6FhYXKFSJ1HwN2RmgODZ5DXd1V7ezy15WdZP/0u
         6io+sADj3r2nPtyP1pB0FoNTOMiGpschAVLuVdnjvVJaDIxFTMYrJ7G/6cJefgHdPMLU
         C4hWLd7yghLDrOmhYUoAquMSr/Ib6Knerrm3CJZ9uAhvRJqgZ7N1HYte1inaGi1qjY9M
         wekw==
X-Forwarded-Encrypted: i=1; AKwUvBxWlG9AB0u9ZAA/DYrWNk6EB8u8zQEwz9ymXpvyBpIWO5AobAUEPRdVNfjmItMD30UOSIrhLqgkums=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsnvhZQDMzJOMmgQE6IfSGlyDPe5WQGg0jjhkE01a8xAZoqudL
	toXf+S9OGBULdNmoxYNmUcR5xjGLM0A3SnzuztrusFxCHLQo2DkkkwD/
X-Gm-Gg: AYBFou18No7b9GhdEL6I9hHFkb7IVo5FVSEAHMarjmoTrYr0yLICXx1FW48WKHRaHXM
	n625Kzf1foQm1659Vb36oPlQHPY/2ukFl1ngaWiGQHhBpMohGUWm5YcR8lSnFQGLpqZJ3VS791H
	XZ84UOzxOdikcjOsldB5+UmloCwJgtzOdbKP4JKNzAdRtKL0xeobXWRTgIWpg8F5ygCFFmUoUsa
	0oIRfXvqC/LllAdj9z291HYgMyeQavSXhxXfbz5zVuAL5UMvYYq65QfT5TnqGvo8g6azC6XeBAe
	KBghk9i7FsJvlbAWG4VVpRNEDMBRhCZvxlLPI0g5FOP7251q+CyCUiMch09vkzjqr+u61Jg/YiP
	IXIPBVLLKzITnnnhJtAEw2PQOftYzw3jNOR4vzDemh/6XMWynLNAT35uuFO2hQybxqtymc7Evbc
	nOWsQEBTGRGPsofZVatrm6yQ0cI0l2HR1HF9RQCcA85W3ritbvtnSh1rZuF8y45apisjQ6j5Hqz
	VQr38N6sbvQZ3Luinp/aQ4Xn2A0cwAOWHt1FOT22wXhpu41cq71SB0F7wNdzHOpoSx2db2x18Zv
	hv8Nx09q2we4cRmcMKl/K7tULARp
X-Received: by 2002:a05:6512:3da6:b0:5bc:ef66:9762 with SMTP id 2adb3069b0e04-5bcef669803mr2682703e87.38.1791890510793;
        Tue, 13 Oct 2026 04:21:50 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcf8a3970asm1116148e87.79.2026.10.13.04.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:21:50 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 6/6] iio: pressure: dps310: add Zilltek ZTS8032 support
Date: Tue, 13 Oct 2026 14:21:24 +0300
Message-ID: <20261013112124.1878296-7-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Zilltek ZTS8032 has the DPS310 register map, scale factors and
compensation, with these differences:

- two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
  c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
- TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
  the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
  bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
  25/16 Hz background rate instead of the external sensor.
- product ID 0x11 instead of 0x10, the driver does not check it

Add its chip data, reading 22 coefficient bytes and leaving TMP_CFG at
0, and the I2C and OF IDs.

Tested on a ZTS8032 at 0x76 over I2C: in_pressure_input is within 1 Pa
of the datasheet formula evaluated from the raw and coefficient
registers at every oversampling rate from 1 to 128, and TMP_CFG reads
0x00 after probe.

Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/Kconfig  |  4 ++--
 drivers/iio/pressure/dps310.c | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index cef8b90b9ae7..e407243e131c 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -115,8 +115,8 @@ config DPS310
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Support for the Infineon DPS310 digital barometric pressure sensor.
-	  It can be accessed over I2C bus.
+	  Support for the Infineon DPS310 and Zilltek ZTS8032 digital
+	  barometric pressure sensors. They can be accessed over I2C bus.
 
 	  This driver can also be built as a module.  If so, the module will be
 	  called dps310.
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 3b27a61b70a5..be8b0c053c4a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -7,6 +7,10 @@
  *
  * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
  *
+ * The Zilltek ZTS8032 is register compatible, with two more pressure
+ * calibration coefficients (c31, c40) and temperature calibrated against
+ * the internal sensor.
+ *
  * Temperature calculation:
  *   c0 * 0.5 + c1 * T_raw / kT °C
  *
@@ -62,6 +66,7 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 #define DPS310_COEF_LEN		18
+#define ZTS8032_COEF_LEN	22
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
@@ -98,6 +103,13 @@ static const struct dps310_chip_info dps310_chip_info = {
 	.coef_len = DPS310_COEF_LEN,
 };
 
+/* TMP_CFG bit 7 is a rate bit here; the internal sensor is the default */
+static const struct dps310_chip_info zts8032_chip_info = {
+	.name = "zts8032",
+	.tmp_cfg = 0,
+	.coef_len = ZTS8032_COEF_LEN,
+};
+
 struct dps310_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -106,6 +118,7 @@ struct dps310_data {
 
 	s32 c0, c1;
 	s32 c00, c10, c20, c30, c01, c11, c21;
+	s32 c31, c40;
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
@@ -162,7 +175,7 @@ static const struct iio_chan_spec dps310_channels[] = {
 static int dps310_get_coefs(struct dps310_data *data)
 {
 	int rc;
-	u8 coef[DPS310_COEF_LEN];
+	u8 coef[ZTS8032_COEF_LEN];
 	u32 c0, c1;
 	u32 c00, c10, c20, c30, c01, c11, c21;
 
@@ -208,6 +221,11 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c30 = (coef[16] << 8) | coef[17];
 	data->c30 = sign_extend32(c30, 15);
 
+	if (data->info->coef_len == ZTS8032_COEF_LEN) {
+		data->c31 = sign_extend32((coef[18] << 8) | coef[19], 15);
+		data->c40 = sign_extend32((coef[20] << 8) | coef[21], 15);
+	}
+
 	return 0;
 }
 
@@ -696,6 +714,7 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	s64 ts;
 	s64 x2;
 	s64 x3;
+	s64 x4;
 
 	rc = dps310_get_pres_k(data, &kp);
 	if (rc)
@@ -716,6 +735,7 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	ts = div_s64(t * DPS310_Q_ONE, kt);
 	x2 = dps310_mul_q(ps, ps);
 	x3 = dps310_mul_q(x2, ps);
+	x4 = dps310_mul_q(x3, ps);
 
 	pressure = data->c00 * DPS310_Q_ONE;
 	pressure += div_s64(p * data->c10 * DPS310_Q_ONE, kp);
@@ -723,6 +743,8 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	pressure += dps310_mul_q(data->c11 * ps, ts);
 	pressure += data->c20 * x2 + data->c30 * x3;
 	pressure += dps310_mul_q(data->c21 * x2, ts);
+	/* ZTS8032 only, c31 and c40 are zero on the DPS310 */
+	pressure += data->c40 * x4 + dps310_mul_q(data->c31 * x3, ts);
 	pressure >>= DPS310_Q;
 	if (pressure < 0LL)
 		return -ERANGE;
@@ -1041,12 +1063,14 @@ static int dps310_probe(struct i2c_client *client)
 
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

