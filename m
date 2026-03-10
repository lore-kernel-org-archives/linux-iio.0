Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEC35A3B2;
	Tue, 10 Mar 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143865; cv=none; b=sKJboBW2GsseKeBptS+xy3klYkWWd1Va890o8iSS4BsE+XUZZClQOCXWW3oOzj9HluCyH++yzavkD2vLVOdiDjdpN9EAkCkc+sx9qHlqJiJHAp2DlW66gAaZ0qR/X6ernCHxsbEK0xUSG4eqfwUH/TUnJ2nlAKbzRtOvURjnhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143865; c=relaxed/simple;
	bh=hMKQ2Evjbj7C9HJTcZlNoMQQIzDKSwfSEEkWV9Cs9MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UkYNEMSFl/pss0DEWs8rN9rugTqc2gsmdQKDhZmv0cta2Os08xxA+AqTLlD3dWcZ6rhI+7qzMveeL2RaQI2gVFjKdCqTi44103fj+AT7fsSIoFfOL7iY54HsNZ2h73+oOfAZ0cLKgPVZHodR6Pswlel2PAgUS6dKdQe7+/J7RZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0zfyUy0s; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0zfyUy0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773143863; x=1804679863;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=hMKQ2Evjbj7C9HJTcZlNoMQQIzDKSwfSEEkWV9Cs9MA=;
  b=0zfyUy0swOVegfF7Q+GNC46xvKIde5UU19YCsouVFGCJCuwelQKDZ1Ns
   F2397JS+Cm0hoHywAsTbYDreAImU3RNzAdAKX2mWyv1om+HG/ZFW8x+tz
   JMSQxXc2T2cWkdDSNbORB8C413gLOW3DuMUvSlmVb4V7X9P2gVAiKGO3l
   zih+yL7fIdXZbJ54SZQZFJgXOD9kbbhaV2RYAycoNtRiL/NswoMsDo036
   AyRRohyDjMRaNnz/kagtpvdVxVbSLrmd0x0ggOqJbNC7uOkXnH5qelyGq
   CT1yuIKyLXCjBngd5uguB/x2GUzKsdiwtnsi7UYrze1NrIXbZJOsmlfJc
   Q==;
X-CSE-ConnectionGUID: lafOM4VTTAChar/AtX4Tow==
X-CSE-MsgGUID: +ApP+3JuSzmsuJnR8BnT9Q==
X-IronPort-AV: E=Sophos;i="6.23,112,1770620400"; 
   d="scan'208";a="61996598"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2026 04:57:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Mar 2026 04:56:57 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Mar 2026 04:56:55 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 10 Mar 2026 13:56:44 +0200
Subject: [PATCH v3] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260310-mcp47feb02-fix1-v3-1-d46a830055f3@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPsGsGkC/2XNQQqDMBAF0KtI1k1JJjFiV71H6cLESZ2FRpISW
 sS7NwqFUpf/M//NwhJGwsQu1cIiZkoUphLUqWJu6KYHcupLZiDACCU0H92sG49WAPf0khxE3/v
 WNdIaw8pqjlj6XbzdSx4oPUN87w+y3NqvVR+sLLnkRlsjVblA0V5HcjG4geazCyPbvAy/Rns0Y
 DO6Gr0SqC00/8a6rh/INjwZ9gAAAA==
X-Change-ID: 20260304-mcp47feb02-fix1-20ddf9c71b66
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773143814; l=6282;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=hMKQ2Evjbj7C9HJTcZlNoMQQIzDKSwfSEEkWV9Cs9MA=;
 b=lQKR128tohB+/ga8CmA8EeP402wqK07VswTXpr+wqjEVAwwFeAHRFujpvAkSExuuSvwFA9VBY
 0nvBT2zZ8FyDDnLD17LDA2aOFCCjN9UWq/gGaGgLBEadIj+VDCld0DS
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
Changes in v3:
- move assigments on else branch
- Link to v2: https://lore.kernel.org/r/20260309-mcp47feb02-fix1-v2-1-6a5ef30e4b27@microchip.com

Changes in v2:
- add () to functions mentioned in the commit message
- split vref_uV, vref1_uV assigments
- Link to v1: https://lore.kernel.org/r/20260305-mcp47feb02-fix1-v1-1-64b613260e09@microchip.com
---
 drivers/iio/dac/mcp47feb02.c | 49 ++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index b218f0c3a0bd79f43dc9f2da1027f49a04e1975b..e731acb616f58b118335b20659fcda1f4e5ec357 100644
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
@@ -1143,13 +1136,14 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	vdd_mV = ret / MILLI;
+	vdd_uV = ret;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
 	if (ret > 0) {
-		vref_mV = ret / MILLI;
+		vref_uV = ret;
 		data->use_vref = true;
 	} else {
+		vref_uV = 0;
 		dev_dbg(dev, "using internal band gap as voltage reference.\n");
 		dev_dbg(dev, "Vref is unavailable.\n");
 	}
@@ -1157,9 +1151,10 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	if (chip_features->have_ext_vref1) {
 		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
 		if (ret > 0) {
-			vref1_mV = ret / MILLI;
+			vref1_uV = ret;
 			data->use_vref1 = true;
 		} else {
+			vref1_uV = 0;
 			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
 			dev_dbg(dev, "Vref1 is unavailable.\n");
 		}
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

