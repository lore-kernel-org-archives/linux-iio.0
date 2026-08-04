Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D3483BD6;
	Tue,  4 Aug 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862981; cv=none; b=K/d0GeIUg6tajjOCZ3L/PYy1EMNy3DrGk1Ej7u3wl5xSBL752VkkpK1uz201xtMhdpQiW4fwkyshCS5MQn6zB2QC5ji3a0YeNRm6G/hYnEsufMDJVQQmhpBfN9OgFbObYqJbbY9xvF744FV/44Kks0jv+IpfaY7fKl012NxA3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862981; c=relaxed/simple;
	bh=6+uw9qwI4elu+EKWJGE7x2mViOFuPy7tkAX9JM37H4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQfxNsD73ILHlOwN3F0pqHJamxxP0a2kqhHheqbsdNHGP/0Q8KLBSbvAt4EZwA9ViJDrlTaibJFX8M352tHWpdyYPANwRAqv5N+LEbSawf3tBX6OBR8TO0VT1oyS1Q1cT2tqHoDW75NONNtoO3sSz4PNThvGieoxrsBPqRlPKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SJYjWb+l; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SJYjWb+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862965; x=1786122165;
	bh=ZJ0nnDnFpv+f9+HcFo7GV33ka+iwzZblhxr45R1r7oo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SJYjWb+lwGzduWJcrtzcW6DBgtv4wQZaxp7GOS0oNzubCpGQ8mrXIdJ81038t0NXF
	 fPIG6s7erCwBsO1cnydGlw7k8tSqHiDMRttNezHAFJC4+LRnxSFuIT52yE3f8toU0L
	 0PB2riToDqkEExD05GSrpzB9ux3fm+bt3qzvQfUUJj+SeWeij243w/Sl/OLf10f035
	 3Qw5wj3TGlQ+TZ3Z0hqVLfVXZNDJVzKvsgGmF7EcbEE2n30IVVwXG5AJxtXnhwCriJ
	 Rb9fKd9NIQehAhGoKkuI+BwK/gi8IxbuHyvvilARyUdcYJFbBM+0FsOKMYlmDpggN8
	 axLevO9v0YkMQ==
X-Pm-Submission-Id: 4hF0GW5SfMz1DDrp
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:17 +0200
Subject: [PATCH v3 6/6] iio: light: ltr501: Fix sorting order of device
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-liteon-ltr329-v3-6-c6b768c7c745@geanix.com>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
In-Reply-To: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=4019;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=6+uw9qwI4elu+EKWJGE7x2mViOFuPy7tkAX9JM37H4o=;
 b=PcN7iu5vDPDcFFXyGbrCXi39I2LGbBD/4Om1Lqhf0AiLISabFnWVmmSLSmr3uQg8lf/dKn5k9
 C/UkLayGOfwD3oVDKzqGVqLUuToNQGyJ4ZG42EEYfiQVbbU7s26yBSt
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Using alphanumerical sort order for these should help reduce merge
conflicts.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 70 +++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 9d37872ceec5..dbdd69a90ee6 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -91,11 +91,11 @@ struct ltr501_samp_table {
 #define LTR501_RESERVED_GAIN -1
 
 enum {
-	ltr501 = 0,
-	ltr559,
-	ltr301,
+	ltr301 = 0,
 	ltr303,
 	ltr329,
+	ltr501,
+	ltr559,
 };
 
 struct ltr501_gain {
@@ -1219,34 +1219,6 @@ static const struct iio_info ltr301_info = {
 };
 
 static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
-	[ltr501] = {
-		.partid = 0x08,
-		.als_gain = ltr501_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
-		.ps_gain = ltr501_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
-		.als_mode_active = BIT(0) | BIT(1),
-		.als_gain_mask = BIT(3),
-		.als_gain_shift = 3,
-		.info = &ltr501_info,
-		.info_no_irq = &ltr501_info_no_irq,
-		.channels = ltr501_channels,
-		.no_channels = ARRAY_SIZE(ltr501_channels),
-	},
-	[ltr559] = {
-		.partid = 0x09,
-		.als_gain = ltr559_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
-		.ps_gain = ltr559_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
-		.als_mode_active = BIT(0),
-		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
-		.als_gain_shift = 2,
-		.info = &ltr501_info,
-		.info_no_irq = &ltr501_info_no_irq,
-		.channels = ltr501_channels,
-		.no_channels = ARRAY_SIZE(ltr501_channels),
-	},
 	[ltr301] = {
 		.partid = 0x08,
 		.als_gain = ltr501_als_gain_tbl,
@@ -1283,6 +1255,34 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.channels = ltr301_channels,
 		.no_channels = ARRAY_SIZE(ltr301_channels),
 	},
+	[ltr501] = {
+		.partid = 0x08,
+		.als_gain = ltr501_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+		.ps_gain = ltr501_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
+		.als_mode_active = BIT(0) | BIT(1),
+		.als_gain_mask = BIT(3),
+		.als_gain_shift = 3,
+		.info = &ltr501_info,
+		.info_no_irq = &ltr501_info_no_irq,
+		.channels = ltr501_channels,
+		.no_channels = ARRAY_SIZE(ltr501_channels),
+	},
+	[ltr559] = {
+		.partid = 0x09,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.ps_gain = ltr559_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+		.als_mode_active = BIT(0),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
+		.info = &ltr501_info,
+		.info_no_irq = &ltr501_info_no_irq,
+		.channels = ltr501_channels,
+		.no_channels = ARRAY_SIZE(ltr501_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1631,21 +1631,21 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ .name = "ltr501", .driver_data = ltr501 },
-	{ .name = "ltr559", .driver_data = ltr559 },
 	{ .name = "ltr301", .driver_data = ltr301 },
 	{ .name = "ltr303", .driver_data = ltr303 },
 	{ .name = "ltr329", .driver_data = ltr329 },
+	{ .name = "ltr501", .driver_data = ltr501 },
+	{ .name = "ltr559", .driver_data = ltr559 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
 
 static const struct of_device_id ltr501_of_match[] = {
-	{ .compatible = "liteon,ltr501", },
-	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
 	{ .compatible = "liteon,ltr329", },
+	{ .compatible = "liteon,ltr501", },
+	{ .compatible = "liteon,ltr559", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);

-- 
2.55.0

