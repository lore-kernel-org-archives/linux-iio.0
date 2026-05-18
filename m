Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9B4949F9
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123228; cv=none; b=JCslFX4FFMT9FqUbr3B+QE3kmmeTmca0MAvGI7lvoMntvXy5uah0Bvhx4kTQ5yRVXO4kGcewlR3NAa7XllwKqrU5eu79MEhZmaS6AhVxNIXegslNplP2f+DSvOX3zR+G0NZ4eFLEmPQO8s6gQc9sczdh50Urhkd0mkh7kaxQPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123228; c=relaxed/simple;
	bh=dG4kVSvWvNaTp4Wc5RsmNUMVAqxQvfz3K27Hz3DsMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZ+MJGQiNyOs7vGgKK90KpL6zDCvCVj7zM5SoLhHdZG8ZoqewexVPHPpT2tP8TK+xNJVAORvW9oHTK+LPcY5U1A+TpsmEk2bFrMG0E7/W65M0PqkaR7kN9Pn5mxIWjaMYATMDOxTOt5JIZks5MfbseMhQOlTUceE7ANRpnEkLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGb3afyd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGb3afyd"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39397d63804so33540721fa.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123219; x=1779728019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsuVKqMbCl5FXlAFndQT57RmrJUNmjxW5inu3LJrbGo=;
        b=sGb3afyd7C6G7Lv3lDVo6BojNJtI8WM1/knrZkLKVuKMfwhDBqGwSQSiLfPOkNS6ps
         PtZzXaMJEQgLi5KltkooEojBolf2n4mQweE08fz6LmrB7YOhHeUYinI1W6BqEDGlnGQQ
         yMf4MGqJnkMP/V933W2AzSPU+i6OkzIRmvJJF7FIvAGxrYONMjs3JXd1y1+5ZTFw6XA5
         cWXBndm3fx4xoenAcjnicOp8w8IOpCHgd7kSshpCKgepo6ZKeXKndEG660HOU5QphzOk
         soacnFN1Gyh+Cuq+SGBIuJvgPLtSylWyJuhekug2MNDcaSUF0QFWuJLuqzU7iJRyO02b
         0IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123219; x=1779728019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsuVKqMbCl5FXlAFndQT57RmrJUNmjxW5inu3LJrbGo=;
        b=OjMZAkAx3VEVpK90BpGZrjuNfuVQQ8VIWYbBh/LBQZBWyV7AhtdLFH5sf/zLregW47
         R6usrhBcMS9hRMf8XW6v5lQ0UJowUHF62ayatqWCEUIarfS7YB9k6rLpw/gSyK8qDoWp
         bodI6RBirBxhJzBbXh+VKcMhbtovGNpm/W0GHUhBsUbACeu4LfG6s3kQ8ISNyIyQIdoa
         Zl4A2oVPwxYtaOgL0p3aLD7O1cGGrHfCqrk5GPkyGp8ykhYY1rrOafOS0orEvV8nm8kA
         V5Oq6OHqHoK9K1TJM2LY268GGromkS/gL+6UUfy/ONeGrEvZa1gqebJsqzo4LPOmS9H4
         B5nw==
X-Gm-Message-State: AOJu0YzjPBNCjXxLyEY1LljWzcWSIkB1MN/FYZX1cm1l2uv/u7fpPBIl
	30IQkgphxTiih+PZdsO3cgw91x0oFIKu+tvT7tw9sgtdWb13bXdvmnkvZtm8rof7
X-Gm-Gg: Acq92OHJkfK/3zpQBfEwhNdMgt6VNJxBycMzETRW6519VClyHzIRkEVDZQ/t0ICVipf
	C/Tw/9tno9r7jOAZTgrbYKI1Qzxi8mVrKw5SxG1cthssheWG1MT2FrsPHgNQBsnxQaMYLeuxqeS
	JxpTYBKBQ6bZ0eGP0cgBUQM6cqhXsT2SwR9+8i0bYIUyF8PK7I6CuRDWElminNcStYoKPJXQaku
	DAu69TkltCG/DXUgniCfCrcjqxJ7YmJBnjJ2apgzws7UotIKN+AqVqrwrzFJ46NisPiCOpl0urk
	ofu7CSxeL6ghvyuhQJ+VzquzDVHvvvu3/woYOzSZMNjdbiSLwJ5zXCvLBEQlsMm0aiMLt8/u2e8
	qHthMZYZ+fIm+sLkA8LAk5DgeZ/eL6smVKWJ5TV0vF0JP/bXkW4KWPYRyFVWMY3cE95LqO6QsNY
	+iweWq188Cn/cqTwJw8vJ7jDJBd4Ky0UCy8HYLD2/37oN1Taf6DllUzkNLyfJORW7RbmQSSVB7s
	0m3AhJeDp9Hp19kDrSKzJM=
X-Received: by 2002:a05:6512:1317:b0:5a8:886f:c03d with SMTP id 2adb3069b0e04-5aa0e6143e8mr4943151e87.19.1779123218548;
        Mon, 18 May 2026 09:53:38 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5712sm3385242e87.59.2026.05.18.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:38 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: linux-iio@vger.kernel.org
Cc: eajames@linux.ibm.com,
	jic23@kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH] iio: pressure: dps310: add FIFO support
Date: Mon, 18 May 2026 19:53:20 +0300
Message-ID: <20260518165320.1301071-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPS310 has a 32-sample hardware FIFO that buffers interleaved
pressure and temperature measurements in background mode. The FIFO_EN
bit was already defined but unused.

Add register defines for the FIFO status register and sample type
encoding, implement FIFO enabled/flush helpers, and wire FIFO initialization
into the probe path after dps310_startup() has established background
measurement mode.

FIFO initialization failure is treated as non-fatal so the driver continues
to operate via single reads if FIFO enable fails.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 73 +++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 8edaa4d10a70..5b031c9573d0 100644
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

