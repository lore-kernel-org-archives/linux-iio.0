Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5824E4A8
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186226; cv=none; b=UnujrndfEyX1X1wq2BF3fFBjWW87D5B5z5Lr/WogFQNPK/AsAIBnkW9ditdSdhazIe+fjc4cBVgmbQTVDTNvEFJCGXyvgc7mwp50Btp1pvSMxXQZFoXyoZaroENcpv4f8l9uMxkvRRy5OvkzOLqSn0PWkkXf8bOtlPmh6WhK2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186226; c=relaxed/simple;
	bh=nyJ+7fYQZYS6587riJcSOl+CkiOrpjXiLGECom5vw7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDMzZwx0t0DMdy1VAnhLbnYvNXpXYrgIF7Y42oZVVU0lZ7P3bc3krEQII6KrH2iU33wghA0JqBvFUXZtWxmk0Xy6i8EQ6fRND/Y/prViNFoRkhyddNqhThc3whM6q23drM9bDLMqEbuVnN+yMT46zd6MPzq9Ek/2zjgf4Km6vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5XRhIS/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5XRhIS/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso3766723b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186224; x=1776791024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MTsl9QufwvdEN3PRYcKxviT0jFcanWIVjEBW+cT/R4=;
        b=l5XRhIS/sWlE9od6ywwcpbXhfOoQsqsmoY15AJNS0eU+188s+c6vQ60RwGNcSoqHuH
         zI8C3pNahusT9AvS/cbExCWRuNhRzs9cMviJkWMpUFV8NmY4D2gMA9H6wFSiO6lYcau1
         NQ2J82BTuUwRCStErVDec60+2F2+wmE/VZMu5f/j6cB8l5sdA3I/1RGwRaBCTCtjSzSB
         vayfeXlR5vkWdhyAwKulb45/PeSZolTPxm7W3chDYaaZLjA5e2zEgOIoK5AfDcE65Ze9
         ofGj87X0lmAfyHD2rRzoRWb3nv+60YJtqTjaHvSmD5T2p0XdaR//kBSIapxBbprlRhoD
         kE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186224; x=1776791024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MTsl9QufwvdEN3PRYcKxviT0jFcanWIVjEBW+cT/R4=;
        b=pF8NIg9i0rAAYEB51DvCwkIoVz/LcNN/woRDzY58VuZJc1cA/vgrVPPuARkuijPqMH
         07CMYLit66JpXy8bFH3lyaouLvXlF29oJUKkRCyMDsno3gC58ksOxDfP8je+Epwgrs2f
         hNsuREVSkyC87iGn24+O11eHb2tcld2jKn41k84Kadp8NkouFL5By52pWsWgDvi8xKJ1
         ZhKOsL4Pt5qpoS4T8A9kanXURdFo0luQxzYqCrQrJIpbDojSOZ745+SOhetiBT0LYABN
         BKR2lq/iJhkH7PtjLJOz5SUJaH8vqtPR3YA1EcjBIX0pZK+9Cb+Gss2uDvv7iz3XrN1e
         K1tw==
X-Gm-Message-State: AOJu0Yz3po+pR5Mu3oSz0u73cpLMw3zP/1pAodbahArV+4yBInsrIo61
	CAQ+5RvG7um4hypH1vvfzEJuKfbsvU7gr10a4nSCynElsvHBDpB9q8rB8D8/DgAuDYej
X-Gm-Gg: AeBDievXwMaVFkxupPVcbGm/w51yDYzUfCA1XLeyP0zKpnHS9RfofA7AjlU18KQBRDc
	6LuNS331RmWAXnFbRsil5lKy/nqmDsh+jXj9hCxNkUlTpo78s5uSry/xaJSQCOd7WVAopyhofr7
	ElvQ3LZGEafcMWXc60vSj+9SY6WMUSyboj6Ua8D37nzemvSzOp4XUzrpayl2DAHuE2W5YXT3A80
	rIU2fBOpIkZmDlg3UzRwuco3QQXl1Xv+OVZcahk7Fk+e+NSRtROJg3rkB22774jHl++AlFpXJ6c
	U6I88MfKGJAb7yHqip8eMXgPkSlu+6gV3tECVb7Cx9IFVbts29nCOSavLD6HBSAqvPV11PAuhyi
	xkuD63v0BX59ic0ipu/FkiNPAJGzZX3aGkdWUWlEqAhLNmr17HQGnK6a1lzMg6JmMvKbiAvC2dq
	8bTIOamdmXPIRWUZiDvGGmjIRQc2QO8cmC057FvAe0mdg=
X-Received: by 2002:a05:6a20:918c:b0:39b:e6af:2d8 with SMTP id adf61e73a8af0-39fe3c78f74mr19433062637.4.1776186224304;
        Tue, 14 Apr 2026 10:03:44 -0700 (PDT)
Received: from nik.. ([101.0.62.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm19077474b3a.48.2026.04.14.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:03:43 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v6 3/3] iio: dac: mcp4821: add configurable gain support
Date: Tue, 14 Apr 2026 22:33:08 +0530
Message-ID: <20260414170309.6151-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414170309.6151-1-nikhilgtr@gmail.com>
References: <20260414170309.6151-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for configuring the DAC gain using the GA bit

The MCP4821 supports two gain settings:
- 1x gain → 2.048V full-scale
- 2x gain → 4.096V full-scale

Scale write support is added in the IIO interface. Only scale
values advertised via the scale_available attribute are accepted,
ensuring consistency between the configured gain and exposed
scale values.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 128 ++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 102ae3718514..18b5934fb8a2 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -12,13 +12,13 @@
  *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
  *
  * TODO:
- *	- Configurable gain
  *	- Regulator control
  */
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
@@ -26,10 +26,30 @@
 #include <linux/unaligned.h>
 
 #define MCP4821_ACTIVE_MODE BIT(12)
+#define MCP4821_GAIN_ENABLE BIT(13)
 #define MCP4802_SECOND_CHAN BIT(15)
 
-/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
-#define MCP4821_2X_GAIN_VREF_MV 4096
+/* DAC uses an internal Voltage reference of 2.048V */
+#define MCP4821_VREF_MV 2048
+
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
 
 enum mcp4821_supported_device_ids {
 	ID_MCP4801,
@@ -43,6 +63,8 @@ enum mcp4821_supported_device_ids {
 struct mcp4821_state {
 	struct spi_device *spi;
 	u16 dac_value[2];
+	int gain;
+	int scale_avail[4];
 };
 
 struct mcp4821_chip_info {
@@ -57,6 +79,7 @@ struct mcp4821_chip_info {
 		.channel = (channel_id),                              \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 		.scan_type = {                                        \
 			.realbits = (resolution),                     \
 			.shift = 12 - (resolution),                   \
@@ -121,8 +144,9 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		*val = state->dac_value[chan->channel];
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
-		*val = MCP4821_2X_GAIN_VREF_MV;
+		*val = MCP4821_VREF_MV * state->gain;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
@@ -130,6 +154,17 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static void mcp4821_calc_scale(int vref_mv, int resolution,
+				int *val, int *val2)
+{
+	s64 tmp;
+	int micro;
+
+	tmp = (s64)vref_mv * MICRO >> resolution;
+	*val = div_s64_rem(tmp, MICRO, &micro);
+	*val2 = micro;
+}
+
 static int mcp4821_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int val,
 			     int val2, long mask)
@@ -138,35 +173,85 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
 	u16 write_val;
 	__be16 write_buffer;
 	int ret;
+	int v, v2;
 
-	if (val2 != 0)
-		return -EINVAL;
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
 
-	if (val < 0 || val >= BIT(chan->scan_type.realbits))
-		return -EINVAL;
+		if (val2 != 0)
+			return -EINVAL;
 
-	if (mask != IIO_CHAN_INFO_RAW)
-		return -EINVAL;
+		if (val < 0 || val >= BIT(chan->scan_type.realbits))
+			return -EINVAL;
+
+		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
+		if (chan->channel)
+			write_val |= MCP4802_SECOND_CHAN;
 
-	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
-	if (chan->channel)
-		write_val |= MCP4802_SECOND_CHAN;
+		/* GA bit = 1 -> 1x gain */
+		if (state->gain == 1)
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
+	case IIO_CHAN_INFO_SCALE:
+		mcp4821_calc_scale(MCP4821_VREF_MV, chan->scan_type.realbits, &v, &v2);
+		if (val == v && val2 == v2) {
+			state->gain = 1;
+			return 0;
+		}
+
+		mcp4821_calc_scale(MCP4821_VREF_MV * 2,
+				chan->scan_type.realbits, &v, &v2);
+		if (val == v && val2 == v2) {
+			state->gain = 2;
+			return 0;
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
 	}
+}
 
-	state->dac_value[chan->channel] = val;
+static inline void mcp4821_init_avail_gain(struct mcp4821_state *state,
+				int resolution)
+{
+	state->scale_avail[0] = MCP4821_VREF_MV;
+	state->scale_avail[1] = resolution;
+	state->scale_avail[2] = MCP4821_VREF_MV * 2;
+	state->scale_avail[3] = resolution;
+}
+
+static int mcp4821_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct mcp4821_state *state = iio_priv(indio_dev);
 
-	return 0;
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = state->scale_avail;
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*length = ARRAY_SIZE(state->scale_avail);
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
@@ -182,12 +267,15 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
+	/* default gain is 2x */
+	state->gain = 2;
 	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
+	mcp4821_init_avail_gain(state, info->channels[0].scan_type.realbits);
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.43.0

