Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0733CCA02
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939163; cv=none; b=R6HdNPVcmV1Ifutl3tlvXFeXdgwxDKtLIY46uTRAEnGe7mjv0niHQaZDq7H+zKdmvdQWJ+7vnjzPyLTvRRaAJHozGU6iPg76BVFmPIoSZYY8u3WKNCWbNbC9SafDIr0uhMYnIJ4BXkaMeY0/LHLa0zgYTjaJGAmCfDHNhE1rZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939163; c=relaxed/simple;
	bh=IGLnmfgFMKwZElULAx3r6+sk6M7lfI8BDWfOeJbSGNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/4JZk+9tJ+WKMnSkNk1Yq3luVtfNKfQ8wR44Of9RGhskIJoSW6Gzm0GV19jbNxW87UAHSEHdRTAE9/qOIvmINGoRreWXpl4RF4srJyxEVl/Gq0HduOSG7FBUkQ0N7WLVe0pSb0Vm6jL6V3BdgCf0tDakSRTjeA2BgawyYvnIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu3SS/uZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu3SS/uZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so1089112b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939159; x=1774543959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOsVEuWagBjkEvl1rJB4csA4gYY70E9JfDGEptUSAuU=;
        b=Hu3SS/uZHXwLH/qMiO4mrB4VBTCXKEmE5wUitSv/HX+GWMst81IbXs3LpvkeQ5hHGX
         9s0S2G5nAhP/u4BOQpfBRIAbP9QwpwPz7IOh/3KNEfS+Ewshtxrd686NFLvwmUZSPcIf
         7fJyNPk8GOgjoykDRjIvKik2DYh0SQrOLcllnRgSfLzUQ7m8OhmwMfTPssfVX2jHOZXR
         73mufa+XWOMpINRpPr5CNDldzpH+izb7tGEY5jss0Em6+wGfphIe0lf0HmRGE9dwgVaf
         UQtJLAS03dpdWIT1PscR3qPYuynfi61xVdXzSe7Pg9pHkidDmgtm2YRkD1L/uy3Bqs/s
         RlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939159; x=1774543959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOsVEuWagBjkEvl1rJB4csA4gYY70E9JfDGEptUSAuU=;
        b=jqdvTZfzvnAJrVZ0nxQX66Ex25Yi06ne3M7Eac1+RJq4uMkqNjZMgPaWTu+CiKh+Oz
         pc/ZGl3Nhgr2fv5SWyBnKuAM+ZxN/ktj//E3CLPMNE/ADbzoYttEOeCLBX3BV6oVe50j
         dmv8EINaCq4FhGrX5dg4xnDEaOlxZCaulDLHbcdCaXeLeW7p1hlgeS+AaRAfRxIkOpiW
         5uwDQiPmbDyqXmJKX9kiJwqRuEVYYAXMEbwzXoZOv+V8fwgVsUtHlROij3hO3vYI3Gmt
         lpa9B6i91HkIDg256h0qL8KNjgb2Muyk7cyOzp0WF99os1aZZH3eM+fDxX5IjdNa6BER
         zO+w==
X-Gm-Message-State: AOJu0YyCbwLCwl9X8fVQK1ziuVCsHPmdT79QLSYHn3TQUXOyC8x5ayRq
	3IZStc5KRuT2duv4aAbqKpoInn3C6WJXHn2QCMOACOJwFQUHKPvyvHq/xMgf+/IrpA==
X-Gm-Gg: ATEYQzzDBRuYcaTRkNClJc5qnO543CsXQQcCzxpetlZabcQYxGZop6djo7othyKxsq9
	HpIgGRICSl8rlZulvDGYEL0HcBmd0oeXnXakvO4a6Pgt0XZUgrk/VcMgvzzmfHl4aYsDJJNDsk2
	bSVrrdZUsa9zCxDihaUnHefgJPNoIw0mbiOasG+EI6+QKu2MM3xBD0Q6JkTCye0R72hbVrcQhgG
	JYEEks6cCTEN9vVHUwhnbOzEFYJLzK9lOMwk9cVf/x015zrjQ4+EV4NUZDIL+v373FO6yNvkkYR
	JOx/LYmcQRTDyF1qt7KQmwp+ub0X+rCezyZwvDmTV+3rzgio/kdwjOd6amj1Tgog4Jf8ThrrPl6
	fl1EI5mKp22HrIaWgbxpL8QMzfnGWtFf8V7Ydsxy8e8gcbIQDKwbkYRy5dFxgTyiIPX1FIarVc+
	IQgsjIuSUaOKYNQ9BDVW901yHt69E9CGWagcvXInKPa16EpBp3lpW+LbxV0ZM+
X-Received: by 2002:a05:6a00:3916:b0:82a:7aa1:4af7 with SMTP id d2e1a72fcca58-82a8c360004mr11074b3a.55.1773939158887;
        Thu, 19 Mar 2026 09:52:38 -0700 (PDT)
Received: from nik.. ([103.103.162.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bee9a14sm6406590b3a.53.2026.03.19.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:52:38 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	anshulusr@gmail.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: dac: mcp4821: add configurable gain support
Date: Thu, 19 Mar 2026 22:22:16 +0530
Message-ID: <20260319165216.351668-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for configuring the DAC gain using the GA bit.
Expose gain control via IIO_CHAN_INFO_CALIBSCALE.

Scale is updated dynamically based on selected gain:
- 1x gain → 2.048V full-scale
- 2x gain → 4.096V full-scale

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 140 ++++++++++++++++++++++++++++----------
 1 file changed, 104 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964..f9f97917bc9c 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -12,26 +12,43 @@
  *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
  *
  * TODO:
- *	- Configurable gain
  *	- Regulator control
  */
 
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
-
 #include <linux/unaligned.h>
 
 #define MCP4821_ACTIVE_MODE BIT(12)
 #define MCP4802_SECOND_CHAN BIT(15)
+#define MCP4821_GAIN_ENABLE BIT(13)
 
-/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
-#define MCP4821_2X_GAIN_VREF_MV 4096
+/* DAC uses an internal Voltage reference of 2.048V */
+#define MCP4821_VREF_MV 2048
 
-enum mcp4821_supported_drvice_ids {
+/*
+ * MCP48xx DAC output:
+ *
+ * Vout = (Vref * D / 2^N) * G
+ *
+ * where:
+ *  - Vref = 2.048V (internal reference)
+ *  - N = DAC resolution (12 bits for MCP4821)
+ *  - G = gain selection:
+ *        1x when GA bit = 1
+ *        2x when GA bit = 0 (default)
+ *
+ * Therefore full-scale voltage is:
+ *  - 1x gain: 2.048V
+ *  - 2x gain: 4.096V
+ *
+ * Scale = Vfull-scale / 2^N
+ */
+
+enum mcp4821_supported_device_ids {
 	ID_MCP4801,
 	ID_MCP4802,
 	ID_MCP4811,
@@ -43,6 +60,7 @@ enum mcp4821_supported_drvice_ids {
 struct mcp4821_state {
 	struct spi_device *spi;
 	u16 dac_value[2];
+	bool gain_1x;
 };
 
 struct mcp4821_chip_info {
@@ -51,16 +69,19 @@ struct mcp4821_chip_info {
 	const struct iio_chan_spec channels[2];
 };
 
-#define MCP4821_CHAN(channel_id, resolution)                          \
-	{                                                             \
-		.type = IIO_VOLTAGE, .output = 1, .indexed = 1,       \
-		.channel = (channel_id),                              \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-		.scan_type = {                                        \
-			.realbits = (resolution),                     \
-			.shift = 12 - (resolution),                   \
-		},                                                    \
+#define MCP4821_CHAN(channel_id, resolution)					\
+	{															\
+		.type = IIO_VOLTAGE, .output = 1, .indexed = 1,			\
+		.channel = (channel_id),								\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
+	    .info_mask_shared_by_type_available =					\
+			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
+		.scan_type = {											\
+			.realbits = (resolution),							\
+			.shift = 12 - (resolution),							\
+		},														\
 	}
 
 static const struct mcp4821_chip_info mcp4821_chip_info_table[6] = {
@@ -122,13 +143,25 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 		state = iio_priv(indio_dev);
 		*val = state->dac_value[chan->channel];
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
-		*val = MCP4821_2X_GAIN_VREF_MV;
+		state = iio_priv(indio_dev);
+		if (state->gain_1x)
+			*val = MCP4821_VREF_MV;
+		else
+			*val = MCP4821_VREF_MV * 2;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		state = iio_priv(indio_dev);
+		*val = state->gain_1x ? 1 : 2;
+		return IIO_VAL_INT;
+
 	default:
-		return -EINVAL;
+		break;
 	}
+	return -EINVAL;
 }
 
 static int mcp4821_write_raw(struct iio_dev *indio_dev,
@@ -140,34 +173,68 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
 	__be16 write_buffer;
 	int ret;
 
-	if (val2 != 0)
-		return -EINVAL;
+	switch (mask) {
 
-	if (val < 0 || val >= BIT(chan->scan_type.realbits))
-		return -EINVAL;
+	case IIO_CHAN_INFO_RAW:
 
-	if (mask != IIO_CHAN_INFO_RAW)
-		return -EINVAL;
+		if (val2 != 0)
+			return -EINVAL;
+
+		if (val < 0 || val >= BIT(chan->scan_type.realbits))
+			return -EINVAL;
 
-	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
-	if (chan->channel)
-		write_val |= MCP4802_SECOND_CHAN;
+		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
+		if (chan->channel)
+			write_val |= MCP4802_SECOND_CHAN;
+		if (state->gain_1x)
+			write_val |= MCP4821_GAIN_ENABLE;
 
-	write_buffer = cpu_to_be16(write_val);
-	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
-	if (ret) {
-		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
-		return ret;
+		write_buffer = cpu_to_be16(write_val);
+		ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
+		if (ret) {
+			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
+			return ret;
+		}
+
+		state->dac_value[chan->channel] = val;
+		return 0;
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val == 1)
+			state->gain_1x = true;
+		else if (val == 2)
+			state->gain_1x = false;
+		else
+			return -EINVAL;
+		return 0;
+	default:
+		break;
 	}
+	return -EINVAL;
+}
 
-	state->dac_value[chan->channel] = val;
+static const int mcp4821_gain_avail[] = {1, 2};
 
-	return 0;
+static int mcp4821_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = mcp4821_gain_avail;
+		*type = IIO_VAL_INT;
+		*length = 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct iio_info mcp4821_info = {
 	.read_raw = &mcp4821_read_raw,
 	.write_raw = &mcp4821_write_raw,
+	.read_avail = &mcp4821_read_avail,
 };
 
 static int mcp4821_probe(struct spi_device *spi)
@@ -182,6 +249,7 @@ static int mcp4821_probe(struct spi_device *spi)
 
 	state = iio_priv(indio_dev);
 	state->spi = spi;
+	state->gain_1x = false; /* default 2x */
 
 	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
-- 
2.43.0

