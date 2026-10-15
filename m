Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FC515894
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061399; cv=none; b=Grvrg4TZz+bmTqX7YpdJEyCyOzoHaePby8PhV2w3ipaPvIugFEZRwAW8wCOen7N5oyT0w+l5DpnftCB4hvcePCgyHmOg3F1bq5MFMUT9fiBiLkcKlDQEP25ETGyz4uLKSz6He8nsYU3TlAK3Y1SSLkqGkKB848WdWWkQ3XBOkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061399; c=relaxed/simple;
	bh=SFQP2O2rc9PrF1HkOxz3XDNnNvJFTjNshWWoO2KLuuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzB3OJfJYlh4jQRGneIVIjXM0dQupM77Kag7b1q6YpMceVaxqevifAt3OTQJP5qUABbrIHO+ADbt4kpUi/JP7JcRYi5zEvZiAwO6eOH4tQgt70Q82SMnzHo6OuzWscS0CpaOR2EcMDn5jVpDY55EYaGv57Abg2/W/Thv6nwYg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzO3pZrO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzO3pZrO"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1267447a12.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061396; x=1792666196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kKzIJd3FSTUVPyfxVoZRotvQdM6+CYpS0Hp7ZM2/Nns=;
        b=KzO3pZrOPH1aE/6JM0HP5ODQPEJDpvPYdNVo/Oz8WEWFzZ2ApUs08YiPWO07R0tFTr
         el9sQLQSBHfJcDaeLqMMk8ktQbh0o2Qv2pPia2G6GiGhNwZ6T1RsZwrkVd3tzoZEEygQ
         wd1Fd9w2wKFr2ufPDAkh826aWpiu0Z/wsr2UZ4qJ9ZoBExh6SqxM7ygNZVKRaoxllu//
         7qZATUVbX20cvvYRx+AsMYh2ZM+nWgIyYsTyUsoxSRBXco32amRdfJC8f0kB6jlPs/7Z
         VrfjjsoZ5vYqxZ/JPV8yZ09OJZlh1IIwrvf5KAsAa18FoN2MSBPKOSZZ7o1UT0374dfE
         smUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061396; x=1792666196;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKzIJd3FSTUVPyfxVoZRotvQdM6+CYpS0Hp7ZM2/Nns=;
        b=JN0X6S6y1/6ViC1Ma2JFO4ioIyIlN5LtB8nV2OlTioSqe4RZZh2mRRd/gPyfbnORf8
         9QKb0ziShg1jiCon6F16BpvSrJMWiBOATgBm6Wvz+kf+1OUdN14Sox3rAlbB0871AAY6
         vigRuBiOiNKKsNLnewDUZ8BMnn80N3n6VqOiWUxKr80WPqJw+hkuTHIdlSjN4zpGrxHI
         r+TGR3AzCCFE9Z7pxQtU2im2kdRIl5rp5bRjt1hUNGOkPl6A7FLQRYtzBCbKI42u534g
         5E/1+/BYo9379rOw5wvlLjaAZk6lX72cjT4vYdUlFSAH/CUQ8+AtoWWpTOewwFH4LS0X
         Gayw==
X-Forwarded-Encrypted: i=1; AKwUvBxblZ91078qEW54ZrxamjurKpmzHkjWBQQZdEKgspMKcGhnWklEtmYDMIwlQ3FzsX+7oMr7xTdz/mY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtOuFAtPt0kYOXOrCOM2qEJY7I0+hfontLSjnopXtyKWNQigbG
	mib3wa0UMwazhjkJhzJ1/5tQvkBGGH2NJ5kqpnJWRNYWjkUSRylQFReo
X-Gm-Gg: AYBFou2X8eCEyGXFvOKDsJ3WOFsSEKPrcdE3aOHQkPmGdO3i9G/Qa7wbmtqdDFyNElF
	MRmkAf5NFPXsGh5rOiuAabtM4/JW5EneRczddaWFYji5n1rPiWnIsQ/43T+nZWJs0TsEr0PxEAn
	lJ9O0DWcP4x4w+FMf6yUfyNy4FI/PGElQalgPDW4L7x+7hkcItVxQ3E9ILr4eHlMRkJkcCxGZPP
	1yAwX18Xk0WPwL1ENE6Ddh4J/BgSgvTp/821WgauS+NLePQAj/Y0IrVgz1C23Y1tfFHV5CrhHnA
	4AnKc/jroMkXs5lbDDq3G/yWKI6oovHF/UdEsbly6iRb6qxbDEfaxY8sWr86n1iEdEr0h2rr+GG
	YJvjTL5ZDC2Ffasg710YkgZywwDmsGFkr8Hm4QAIWkFC52EdtFgQv57bK0664yZyHvIQm77SBkZ
	SblK4U6VRfS0G3HsuKNPwW0+T2Zdif6qAMdV+PNf3lyBAwxd6JbxXZac/LsZbvZMot6ACPT2uJb
	2nuQBh+zlcONmRawUawwuGrJ7mN3bD2dxWHT6QnR0oLwj+PYjdzVBoieiapHd9Y53UL5BR2y1iM
	sE+MbhahE86UObDhdCueETQzwk+2G+Re34X73g==
X-Received: by 2002:a17:907:6e8c:b0:c2a:46a2:5b57 with SMTP id a640c23a62f3a-c31a9d097fdmr1569452666b.10.1792061395970;
        Thu, 15 Oct 2026 03:49:55 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm107890066b.33.2026.10.15.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:49:55 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v3 5/5] iio: pressure: dps310: add Zilltek ZTS8032 support
Date: Thu, 15 Oct 2026 13:49:45 +0300
Message-ID: <20261015104945.2687162-6-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
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
0, a Horner step for each of c40 and c31, and the I2C and OF IDs.

Tested on a ZTS8032 over I2C: in_pressure_input is within 1 Pa of the
datasheet formula evaluated from the raw and coefficient registers at
every oversampling rate from 1 to 128, and TMP_CFG reads 0x00 after
probe.

Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/Kconfig  |  6 ++++--
 drivers/iio/pressure/dps310.c | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index cef8b90b9ae7..21363d542c38 100644
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
index ad3860d11592..940bde38e8e3 100644
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
@@ -63,7 +67,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 #define DPS310_COEF_LEN		18
-#define DPS310_MAX_COEF_LEN	18
+#define ZTS8032_COEF_LEN	22
+#define DPS310_MAX_COEF_LEN	22
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
@@ -92,6 +97,7 @@ struct dps310_chip_info {
 	const char *name;
 	u8 tmp_cfg;	/* TMP_CFG at startup: sensor the coefficients are for */
 	u8 coef_len;
+	bool has_c31_c40;
 };
 
 static const struct dps310_chip_info dps310_chip_info = {
@@ -100,6 +106,14 @@ static const struct dps310_chip_info dps310_chip_info = {
 	.coef_len = DPS310_COEF_LEN,
 };
 
+/* TMP_CFG bit 7 is a rate bit here; the internal sensor is the default */
+static const struct dps310_chip_info zts8032_chip_info = {
+	.name = "zts8032",
+	.tmp_cfg = 0,
+	.coef_len = ZTS8032_COEF_LEN,
+	.has_c31_c40 = true,
+};
+
 struct dps310_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -108,6 +122,7 @@ struct dps310_data {
 
 	s32 c0, c1;
 	s32 c00, c10, c20, c30, c01, c11, c21;
+	s32 c31, c40;
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
@@ -210,6 +225,11 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c30 = (coef[16] << 8) | coef[17];
 	data->c30 = sign_extend32(c30, 15);
 
+	if (data->info->has_c31_c40) {
+		data->c31 = sign_extend32((coef[18] << 8) | coef[19], 15);
+		data->c40 = sign_extend32((coef[20] << 8) | coef[21], 15);
+	}
+
 	return 0;
 }
 
@@ -711,10 +731,15 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
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
@@ -1038,12 +1063,14 @@ static int dps310_probe(struct i2c_client *client)
 
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

