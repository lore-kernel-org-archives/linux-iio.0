Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A33ACF14
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073512; cv=none; b=u6cHLG7/IH5naDlPZAUBdQsK/cPy/k3vs/J6zJeXyMLSHYakZR1OdVSU7dLzSfaLdqNuJRAk1NVRy0U/z8QnLf1zurL7A+jdxoH5D4xworVBVy6+Dq6I7onesmvWq9ZpIlWXw+8Dtj+ULLF8iq5/UC5aKXH9lecpZUndas+Tc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073512; c=relaxed/simple;
	bh=G0daGCzxJE5AHriyQJ34Qyy80obSwyU16Tv62slnlqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Xe1GonHfJK+OBLkKzIk60fgWo45dL52GhnxT5OVWAjQjCqT0VFYz/5EbDieBwWrN8Y4a7Sl4rOqwxKqYhoqXGYQBhpot2QgFcHF2ZWfVAIyzxh4DteMil1e8HEh2mmtAARfrSTNHUKaCvmaxdl+x6yuvvElG09m/DdcrNEgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKqEhwt5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKqEhwt5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2687703a91.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073510; x=1776678310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPH87WUtcvPm4kvtjHt82v+wBMnIwRI8RC3NpFfPaKQ=;
        b=pKqEhwt50HqFJpaJYFVyHLuAwKRVSTroqq99R/okd54IGTdEs6/WyPzugNdc/BR9zi
         qMvFGnApPIZBpncLBiYJ1+F3gaGYyIIoPDfwe3uAcwK585H2Yf5ODNoODmi5KErAkg0g
         OsBrhCsZ/gW/OV5uzVTWIfavGeM14QVy/AY3Gk5wc/QK15A+HUqV1c/9E6c+c/oYaCWl
         tyY4p52hzOijILiZtIuocclJfbuPT4/V1vlCEnGEQMiToJhRfNQxhGlYwLH460GAk31W
         Tt0pnXohTTJJY7GwF/LDX7nBLQLsf8p7I+J/Hovg/iEWgMeLWunvVhlUUAts+qgwjdQ9
         G+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073510; x=1776678310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPH87WUtcvPm4kvtjHt82v+wBMnIwRI8RC3NpFfPaKQ=;
        b=NzpInSh2tp2L/M8PEsXOl50JMdinACwuMgYJJMPAl97RLMu0tRLC+bl9B3V2Drl9dn
         nqQl6qO3yj9ZpMyLBBVgDEd35/plQLYIoVCTc85DQ/pzZoncMyhvWEIwFmMqk3DGqI9A
         qqvgeU5V2NetDiD/CyI8BtCPD6DkqEtwMCRFQifveIMSWamQIoFsqi20po4fgxgoZXkX
         y/U0+Jdx9fACkXLCewQwQOZscgS/UVOkP7NSI3HU4yPayrnnrCFbSI9+wLTojRJTDfSn
         NpzM6oo2la/vSqj8VZdbRkSvxNNn7qYPwxSUWb7bVK/hwRF2ujQ9lIOJBVte2EhBD8FJ
         TO6g==
X-Gm-Message-State: AOJu0YzU4Aepfnfa47dfel3HVzL/nvMv8UPtTiiQpYvxXxPrprr72SZD
	XlDspk5w5+zp6NNvCBWaWgA76WnOvpKfSSgkjB7jgUl3czTCVcG/J+1F6fPdlOQ=
X-Gm-Gg: AeBDievKf9DDKSJZ2t20ApQOqGnoq92E9ScmoDpFe0IlpLY/P8X8IqbQgFylDA3fsH/
	fNTvsMM+EYLesEdPESwvOqc8MW8hnSZ0PV8vF+KsG/Vs7SGysisg8FzakfKDKE0lIr9dVJgPBKh
	T7yVhbK4I1SF8jJ2k6vpi+au3tzyVxwoRsLctMO79iA96F3Oz9xwkHaVhPxAP9INJcu6dWfdRnf
	H4nvpemjsZcxCoUpR3rGt5lUYHsPYeVWxJEkqMT7m4mvbRNjerUaCqEyCNcri/7+/t2I1HTEuga
	QhlNUedABjWUAxhpUAmAKm9/ZKFKIfuj7E1ajqd/CHLAERv0lMHQWhZI5C/gzx378xXcwklbs5o
	BdLYnL1YkNLe3s1oYDz01ERUWrY08nPjy2t4YeSWjp+BMalXkmvGMRZHLF7Dak1+amUSvELu3uQ
	ZjJw+lmhPXaCiGB8GYTC2Pw8zGx5IrUTkuNSbMXsVkCXL5o8JZt3nYGw4spsyiU/UpumnVILP72
	dj6ne9A5gY6mlQcwzYbTj2W/FH8BjEtpFV2+TeEUQmNj00mo7fh3Hth
X-Received: by 2002:a17:90b:28d0:b0:35c:30a8:31f with SMTP id 98e67ed59e1d1-35e4276a26cmr12288072a91.2.1776073510039;
        Mon, 13 Apr 2026 02:45:10 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm4832562a91.3.2026.04.13.02.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:45:09 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 3/3] iio: dac: mcp4821: add configurable gain and fix scale handling
Date: Mon, 13 Apr 2026 15:14:49 +0530
Message-ID: <20260413094449.18837-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094449.18837-1-nikhilgtr@gmail.com>
References: <20260413094449.18837-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for configuring the DAC gain using the GA bit and
update scale handling to follow the IIO ABI.

The MCP4821 supports two gain settings:
- 1x gain → 2.048V full-scale
- 2x gain → 4.096V full-scale

Scale is now exposed via IIO_CHAN_INFO_SCALE and reflects the
selected gain. The driver returns scale using
IIO_VAL_FRACTIONAL_LOG2 and provides scale_available with the
corresponding values.

Writes to the scale attribute are validated and mapped to the
appropriate gain setting. Only supported scale values are accepted,
ensuring consistency between scale and scale_available.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
v4:
- Split changes into separate patches
- Fix scale handling to comply with IIO ABI
- Use IIO_VAL_FRACTIONAL_LOG2 for scale and scale_available
- Ensure scale_available matches scale
- Handle sysfs write inputs correctly (INT+MICRO)
- Reject invalid scale values

v3:
- Restore NULL check in indio_dev allocation

v2:
- Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE
- Fix error handling and cleanup
---
 drivers/iio/dac/mcp4821.c | 103 ++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 6b732db1cf49..db659b5be8f8 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -12,7 +12,6 @@
  *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
  *
  * TODO:
- *	- Configurable gain
  *	- Regulator control
  */
 
@@ -26,10 +25,30 @@
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
@@ -43,6 +62,7 @@ enum mcp4821_supported_device_ids {
 struct mcp4821_state {
 	struct spi_device *spi;
 	u16 dac_value[2];
+	int gain;
 };
 
 struct mcp4821_chip_info {
@@ -57,6 +77,7 @@ struct mcp4821_chip_info {
 		.channel = (channel_id),                              \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 		.scan_type = {                                        \
 			.realbits = (resolution),                     \
 			.shift = 12 - (resolution),                   \
@@ -122,8 +143,9 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
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
@@ -140,34 +162,72 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
 	__be16 write_buffer;
 	int ret;
 
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
+
+		if (val == 0 && val2 == 500000)
+			state->gain = 1;
+		else if (val == 1 && val2 == 0)
+			state->gain = 2;
+		else
+			return -EINVAL;
+		return 0;
+
+	default:
+		return -EINVAL;
 	}
+}
 
-	state->dac_value[chan->channel] = val;
+static const int mcp4821_gain_avail[] = {
+	MCP4821_VREF_MV, 12,
+	MCP4821_VREF_MV * 2, 12,};
 
-	return 0;
+static int mcp4821_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = mcp4821_gain_avail;
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*length = ARRAY_SIZE(mcp4821_gain_avail);
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
@@ -183,6 +243,9 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
+	/* default gain is 2x as GA bit is active low*/
+	state->gain = 2;
+
 	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
-- 
2.43.0

