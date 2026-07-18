Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D83246F4
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784409663; cv=none; b=Ldk1r3lpNtkAOWKtdOzO7NtzPfTKnAXtOwUt4rnOzYxcMyzZIAAL2aZZhvyGZ6ZduaaLExHbnky8gGxs8Yz68s66jdBM/qYxNfY7vCjX7rbf5nYy9jp7/ll1gtXglPX+sT9/A9XZUpWG8aDINNaJS2IRz2SG3Aeh2SBgj/Se5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784409663; c=relaxed/simple;
	bh=i921l1jsOCDCLyYMF16W0nk5gKoZ3r/H7/RETo157bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6lv0LUyDnBXhgW0UTA16l+3uqSr37dKDfj5SUrUmH6CpAbOZ4XGPiIb+Iai9cuY4MDxSABFkEv7wMnkBpzVKkRh59tMtYV2XPp5bqbYQhc04z+n2VHDuE/e1HDFE3mZpLvVdhYReSbA2P7E7UoytK4tcDSoPSjcD3cMk4jRzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlKKQzLU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlKKQzLU"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c953950dfso67645561fa.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784409659; x=1785014459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwkwFaroIRAi1X69YZvYd5vK/tKxvTpddnJvZnz/Qu0=;
        b=KlKKQzLUXkYt0bSHpAE9ZXz6j8cgxEVRCaHT14PEXwu3LIf3FyWKfD1EH2ZWNNUQFC
         I/S1kBEwC8hnjZU0VJx/qFhIGyy9pw8ZvdaPgeEX8ubeSsJCwzzDg8LXJ7KxoCB+DQ2j
         i67AworO4odEMCxXfou6yxSL5D2lK+x7dDmLrYDVb52ETpICyPuDiznVzyr6UxheR4oC
         1eBTef8F0KFvNoRtfKtIxW9zMFwhVoCCP2R7R6mB6tW5xjQO7nAD7CMHq46lY6HoKkZZ
         UDJtiR7Etcd+hJ+TXGUJQuAtmLdg96xdWyhEDdAKmXxodzlBx1IRfisiM1UQtXw7jHRy
         TwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784409659; x=1785014459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwkwFaroIRAi1X69YZvYd5vK/tKxvTpddnJvZnz/Qu0=;
        b=ozOzM/3MSV3jD/GBh1wVtCfHgo8oMkjnqwgNnJnQjvBcKz/A2cG1N7z0aIhfE968O4
         wIn+9OC52DTSmSgsWQA7RTxdoOmkytPZzO+lvgzx0QRjVUjOKKNjQC+SZV/obWlFYjMU
         +O4Ekd8GupE389gFA/3QZN5MCayVOuxlyJUxVBM9a18BKhiMWH4w8kJtxeU100/2SB7e
         Kal/z7M+5paHKZ2xVH76oWoAH9ILF0Aq68zdOlbZcuUNhSMsBnTs7bh6eF8My0HeULWZ
         wQB+MMybxdRYFfFTIzktRxVSQ1UCTT58CETRZ4gx9Hfm+/GO3rH48PiUf22bk/DVmqLN
         l5ug==
X-Forwarded-Encrypted: i=1; AHgh+Ron3Ob3MOGoCpeMmfPgC2uiZ1Lf6zptQJpb/KEjl3VNz72Yroro/u7iIoB3g2p23OnADODKOlM2VK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfGxWW60EwIT0rN6JjSuTCQwf0sX9TJv0BL8d2mUMQFLCjyeY
	QbxewmcZtV/cxtj1/hQCKTnzWMt07R+GuFLyk43EKx3M3QW99tKVm0rA
X-Gm-Gg: AfdE7ckE7JD+OwBe2uWoi26a/vwlKKGpAKpzj9C2RjFmHW4o/kbnMKJ4Ti7imzZiCC1
	c6VT699IJ+YEMaHssPVrFk7+YbU2+mdWsVgydAl3TIdflqqfetX53U+lEZ3eB9pruLYcDYeQFzW
	Ijg0foSkxaI/9ekRlAmQxJVM4g4yxWTbKwZKBKdEF4TF59VK0EytrSKd5oMERWHfnWA47roHRU3
	gCP7s8pGrqHSVagH6W7002uaRdx9QPwYJlx45nu7QlGW417vhDrCmnqbOv8W1G2dEY0kJ6N0MK3
	mG/FQopiWI58HmvcYm0x7j8KcMnQDFoqoDbl65U9f/uO+I8elFgPXNiTdQuLMDoygJGI+3B4kiK
	+H5ldZydMVxJ0rF4/w8aFx/k3Z6+vLoiOM7fmHrwNAkqc528mIWv0nPWah2WhkIUfaq4rOXJmbJ
	3FDdyFCLbuaYGEwTmiXZianGTucKlI3LJF0sWhPHGii0WPLpDVGs/lFPhzgxCn96KS/0pm+aqkj
	w==
X-Received: by 2002:a05:6512:3692:b0:5ae:c099:a92 with SMTP id 2adb3069b0e04-5b28f9ac21fmr1188383e87.42.1784409659133;
        Sat, 18 Jul 2026 14:20:59 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e0e7b1sm1213104e87.49.2026.07.18.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:20:57 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: eajames@linux.ibm.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH] iio: pressure: dps310: add FIFO support
Date: Sun, 19 Jul 2026 00:17:26 +0300
Message-ID: <20260718211727.39752-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPS310 has a 32-sample FIFO that buffers pressure and temperature
readings. The FIFO_EN bit was defined but never used.

This enables the FIFO in the probe after startup. Add the necessary
register defines and init/flush functions. If FIFO init fails, driver
falls back to single-shot mode.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 73 +++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..83f1326f542a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -53,6 +53,19 @@
 #define  DPS310_PRS_SHIFT_EN	BIT(4)
 #define  DPS310_FIFO_EN		BIT(5)
 #define  DPS310_SPI_EN		BIT(6)
+/* FIFO status register */
+#define DPS310_FIFO_STS		0x0B
+#define DPS310_FIFO_EMPTY	BIT(0)
+#define DPS310_FIFO_FULL	BIT(1)
+
+/* FIFO samples are read from DPS310_PRS_BASE (0x00). The lower 2 bits
+ * of the third byte encode the sample type; the remaining bits are
+ * the signed measurement value.
+ */
+#define DPS310_FIFO_TYPE_MASK	GENMASK(0, 0)
+#define DPS310_FIFO_TMP_SAMPLE	0x00
+#define DPS310_FIFO_PRS_SAMPLE	0x01
+
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
@@ -90,6 +103,7 @@ struct dps310_data {
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
+	bool fifo_enabled;
 };
 
 static const struct iio_chan_spec dps310_channels[] = {
@@ -843,6 +857,61 @@ static const struct iio_info dps310_info = {
 	.write_raw = dps310_write_raw,
 };
 
+static int dps310_fifo_flush(struct dps310_data *data)
+{
+	int rc;
+
+	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+			DPS310_FIFO_EN, 0);
+	if (rc)
+		return rc;
+
+	data->fifo_enabled = false;
+	return 0;
+}
+
+static int __maybe_unused dps310_fifo_read_sample(struct dps310_data *data)
+{
+	int rc;
+	u8 val[3];
+	s32 raw;
+	u8 type;
+
+	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE,
+			val, sizeof(val));
+	if (rc)
+		return rc;
+
+	type = val[2] & DPS310_FIFO_TYPE_MASK;
+	raw = (val[0] << 16) | (val[1] << 8) | (val[2] & ~DPS310_FIFO_TYPE_MASK);
+	raw = sign_extend32(raw, 23);
+
+	if (type == DPS310_FIFO_TMP_SAMPLE)
+		data->temp_raw = raw;
+	else
+		data->pressure_raw = raw;
+
+	return 0;
+}
+
+static int dps310_fifo_init(struct dps310_data *data)
+{
+	int rc;
+
+	rc = dps310_fifo_flush(data);
+	if (rc)
+		return rc;
+
+	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+			DPS310_FIFO_EN, DPS310_FIFO_EN);
+
+	if (rc)
+		return rc;
+
+	data->fifo_enabled = true;
+	return 0;
+}
+
 static int dps310_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -877,6 +946,10 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	rc = dps310_fifo_init(data);
+	if (rc)
+		dev_warn(&client->dev,
+			"FIFO init failed (%d), continuing without FIFO\n", rc);
 	rc = devm_iio_device_register(&client->dev, iio);
 	if (rc)
 		return rc;
-- 
2.43.0

