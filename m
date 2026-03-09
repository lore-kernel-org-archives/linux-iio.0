Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33101376BEC;
	Mon,  9 Mar 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058393; cv=none; b=kylyrYULDtIterchKNsqHKv47t/NQ2y3n1p0rzZEt0Ev0dkIAa9NdCKNpv8a8cxdps7wmAA8lia4Xifi7/pNRa8zV0jHyKFYNjceslWkIlZJIGA7U+CEax3nPhQgT45+NARq34T2mtx9Cip7mKEmwmv/XD3p2ndSIuxyQBiWusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058393; c=relaxed/simple;
	bh=lmww/AnRT4CLgt5Rdb6gYI6yta72w2KvFetRCs2bDTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SjuCHgvVNixm9YKojyp+TrQwYTl/K5JXj/Kpqup+5jPXFXXV6ymSke64RHXAz7vUHbHZdlLNLqjAyAruMBl/AFap33qcaX5enDfOtBXBudDZN/IxzFGazgXMJhUlm636XLM0iVBUauaXoE5bnP4MaQiyCQVO7sK1I5yNjGoXMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KjO/liJ5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KjO/liJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773058392; x=1804594392;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=lmww/AnRT4CLgt5Rdb6gYI6yta72w2KvFetRCs2bDTE=;
  b=KjO/liJ5bdVr4QrlGzrE6tFmB0SZQG0mbMv0dXmuNWBbigBmWh7W+QcT
   nDJ/bfL7bRDnJiMZPL42q7XYrRVynJg+75d8kGL9r7TLo5qEkzcCcxU8N
   zoV8D7mdrm3wyI/KCW8Dxs0rABUZeTlWKDoLArgTXF7kX2xRkBKIeSFR9
   zYOHmf+g6h14TsmdJU3qIq5tNZ51t6pTtvo84zilX84lPlNxn3wn9IqUb
   yswYNsxKLcWrZV5NQHb0h2DmOh8pR9l4Zrz1CsR2j0BLvumjqTYMd5MyI
   s5lVAM3Ctj+Y5xKiDxoXS0GN482L3GAkykE4VVTu1ogzjFPD7dxq1fFjD
   A==;
X-CSE-ConnectionGUID: IN4R9I4iQ/2y5EFaLyde3Q==
X-CSE-MsgGUID: 7gYo2ZEOTLq1STbCspBBaw==
X-IronPort-AV: E=Sophos;i="6.23,109,1770620400"; 
   d="scan'208";a="285784267"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 05:13:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Mar 2026 05:12:31 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Mar 2026 05:12:29 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 9 Mar 2026 14:12:23 +0200
Subject: [PATCH v2] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260309-mcp47feb02-fix1-v2-1-6a5ef30e4b27@microchip.com>
X-B4-Tracking: v=1; b=H4sIACa5rmkC/2WNQQ7CIBREr9L8tRigSFNXvYfpQujH/gWFgCGah
 ruLTVy5fJOZNztkTIQZrt0OCQtlClsDeerArvftgYyWxiC51Lzninkb1eDQcMkcvQSTfFncaAd
 htIa2iglbfhhvc+OV8jOk93FQxDf9uS5/riKYYFoZLfrWQD5OnmwKdqV4tsHDXGv9ACvqshmyA
 AAA
X-Change-ID: 20260304-mcp47feb02-fix1-20ddf9c71b66
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773058348; l=6037;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=lmww/AnRT4CLgt5Rdb6gYI6yta72w2KvFetRCs2bDTE=;
 b=IHC/B/OFNNig9Vt7jwijJ7Iv/lC5jiEQ0Sf8+vXAkBgoKRMei+Q+Z3FkovxmR4GgkuTPOLn2d
 6ctmRfl5pX0Aodz2+v7cyGS+uhWzHj0TSq8ljMf2TzQSefkFx4xqAzy
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Store reference voltages in uV instead of mV to avoid invalid error code
in dev_err_probe() call. Vref variables store the actual value returned by
devm_regulator_get_enable_read_voltage() function instead of the results of
dividing it by MILLI. The corner case [1-999] divided by MILLI of the
voltage reference variable value would become 0 is covered too.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Link: https://lore.kernel.org/all/aYXvP5FLA5BvkoVX@stanley.mountain/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v2:
- add () to functions mentioned in the commit message
- split vref_uV, vref1_uV assigments
- Link to v1: https://lore.kernel.org/r/20260305-mcp47feb02-fix1-v1-1-64b613260e09@microchip.com
---
 drivers/iio/dac/mcp47feb02.c | 49 ++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index b218f0c3a0bd79f43dc9f2da1027f49a04e1975b..5615b4f50e6527023da2f492f12268f64e59fab9 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -65,7 +65,7 @@
 #define MCP47FEB02_MAX_SCALES_CH			3
 #define MCP47FEB02_DAC_WIPER_UNLOCKED			0
 #define MCP47FEB02_NORMAL_OPERATION			0
-#define MCP47FEB02_INTERNAL_BAND_GAP_mV			2440
+#define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
 #define NV_DAC_ADDR_OFFSET				0x10
 
 enum mcp47feb02_vref_mode {
@@ -697,44 +697,40 @@ static const struct iio_chan_spec mcp47febxx_ch_template = {
 };
 
 static void mcp47feb02_init_scale(struct mcp47feb02_data *data, enum mcp47feb02_scale scale,
-				  int vref_mV, int scale_avail[])
+				  int vref_uV, int scale_avail[])
 {
 	u32 value_micro, value_int;
 	u64 tmp;
 
-	/* vref_mV should not be negative */
-	tmp = (u64)vref_mV * MICRO >> data->chip_features->resolution;
+	/* vref_uV should not be negative */
+	tmp = (u64)vref_uV * MILLI >> data->chip_features->resolution;
 	value_int = div_u64_rem(tmp, MICRO, &value_micro);
 	scale_avail[scale * 2] = value_int;
 	scale_avail[scale * 2 + 1] = value_micro;
 }
 
-static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
-					int vref_mV, int vref1_mV)
+static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_uV,
+					int vref_uV, int vref1_uV)
 {
-	struct device *dev = regmap_get_device(data->regmap);
 	int tmp_vref;
 
-	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_uV, data->scale);
 
 	if (data->use_vref)
-		tmp_vref = vref_mV;
+		tmp_vref = vref_uV;
 	else
-		tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
+		tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_uV;
 
 	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
 	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
 
 	if (data->phys_channels >= 4) {
-		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
-
-		if (data->use_vref1 && vref1_mV <= 0)
-			return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_uV, data->scale_1);
 
 		if (data->use_vref1)
-			tmp_vref = vref1_mV;
+			tmp_vref = vref1_uV;
 		else
-			tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
+			tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_uV;
 
 		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1,
 				      tmp_vref, data->scale_1);
@@ -1080,8 +1076,8 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	return 0;
 }
 
-static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_mV,
-				     int vref_mV, int vref1_mV)
+static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
+				     int vref_uV, int vref1_uV)
 {
 	unsigned int i;
 
@@ -1089,7 +1085,7 @@ static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_mV,
 		struct device *dev = regmap_get_device(data->regmap);
 		int ret;
 
-		ret = mcp47feb02_init_scales_avail(data, vdd_mV, vref_mV, vref1_mV);
+		ret = mcp47feb02_init_scales_avail(data, vdd_uV, vref_uV, vref1_uV);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to init scales for ch %u\n", i);
 	}
@@ -1103,10 +1099,7 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp47feb02_data *data;
 	struct iio_dev *indio_dev;
-	int vref1_mV = 0;
-	int vref_mV = 0;
-	int vdd_mV;
-	int ret;
+	int vref1_uV, vref_uV, vdd_uV, ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -1143,11 +1136,12 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	vdd_mV = ret / MILLI;
+	vdd_uV = ret;
 
+	vref_uV = 0;
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
 	if (ret > 0) {
-		vref_mV = ret / MILLI;
+		vref_uV = ret;
 		data->use_vref = true;
 	} else {
 		dev_dbg(dev, "using internal band gap as voltage reference.\n");
@@ -1155,9 +1149,10 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	}
 
 	if (chip_features->have_ext_vref1) {
+		vref1_uV = 0;
 		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
 		if (ret > 0) {
-			vref1_mV = ret / MILLI;
+			vref1_uV = ret;
 			data->use_vref1 = true;
 		} else {
 			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
@@ -1169,7 +1164,7 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Error initialising vref register\n");
 
-	ret = mcp47feb02_init_ch_scales(data, vdd_mV, vref_mV, vref1_mV);
+	ret = mcp47feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);
 	if (ret)
 		return ret;
 

---
base-commit: bfd61205aca379121b1913885d4d06c51857119b
change-id: 20260304-mcp47feb02-fix1-20ddf9c71b66

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

