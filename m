Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E3344D8B
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158595; cv=none; b=LEUUv8lUbhrYZ63MfSEz34cnM7VR35eWhpawnIKYAK6rEmgZaB2CCDa5QEd89hRf+ZdWZLf4yjQ5Xgi07zup4JQrGX4WO9eGvyJrRXgU4ESOSlUUdWumL9FMNoqhLFB2509VvkpmYllOwnXHYdgv2VE34UhdzfXAF6xxd4ziMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158595; c=relaxed/simple;
	bh=/jGxO3LR6gcR5Pp1nVn5ig69S0/NGoLnowyGTxJ83OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1cu4QdLeI+W0KIMiRezsnzgUHifJYk4HzzAHeUPCDwElv1nCGutDSpT+KI2juY5myN6Ps3/KDHth6eV8Nb6uQfd9DM69Hk9BeEhoOA6xx1urFGvjrwMzy7KERmmHJOEMxrITRGGeGES4ic/n0ywD6xGxHYyCjim6OPW2uqYZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mancmY16; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mancmY16"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d965648a2so4480669a91.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158591; x=1776763391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGRVpj2WR/MUFJwgrhy7CV+GThaOd6wtUERPYKlOTz8=;
        b=mancmY16wa9rXNesf4q9JRlh2/CKp4MfFzMpXWAC4KGMpmsT/nnX0np3/5P3hf+Mg2
         5EPt4js5dqDlj53BBUOedWrzQbxWbj9seqtZOPcLD4chRbMZ0F8URD8ausIwGYNFfJxy
         pdWyd7Fqb+3rFwatAbyZRR4Ss/I8OMGNBYbR0x6xSkCXgc7haLjQKfnQqNS92tU3VW2O
         tF1QEIVM5H2voyf7zcZ8FrblcLDy0sIjfw2AEF0VIlUveObWlmBvh6QhvIR/X+6bUg+Z
         qY3a9uUXvUOF2a4ZVTlZC78+wA/2lnlv5dDZof14rpzbB0V0cZmeX3M7/HkjdJ1rOWiP
         ZiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158591; x=1776763391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGRVpj2WR/MUFJwgrhy7CV+GThaOd6wtUERPYKlOTz8=;
        b=XaMkzHGmICKZIK4YP3ghjL8b0kgARifeUPqf7VFHIgTxxhe4/CJx6JDGf6Q8lZjV7P
         AY1K80tKwpOzbIlm++fsYdSG8IxU3RKigZ1c+oca0o8kuyFmi5urpPeLEdBV4IXDG2yY
         nvQu+y4ywPflUvuAOIRDLO7i17CriMDhmO2TjoSibEDSk41+xdJgLALr+URftBuGgsOY
         5mNRtLSM5TSMcJQdq7393bcmf3VUe04XCb2nk52vPtVIGE6rmRJO95K5IFtSzG7AZuFO
         8TF7D/PKvS1TUj975pRCeW3me4lKOVpQEpcRsFa0P4dqmCeCUcfpWsoCcrigWpN/l6iM
         eufA==
X-Gm-Message-State: AOJu0YwjYpsMSst25fMDGjNPfvutf1gFsVNa2CRwLyuIK+aOzRuHMbog
	1nt/P1PB5YyRFUqlO8CZW1ulKr9xrqI98BogisGJfQGs2HAf47taEX9tz+QCLIo=
X-Gm-Gg: AeBDieuLe7vsbuUHMH+vEnVEx7zwKG4bMRPB08Kw1hgqZyXBCQ9BQuM914+seQVxnK/
	PFYa9h3HHzjqsyJ3gXh8RY3X0Rw8gWXnC0C7YDCz65fNSx+kf/uGmyutKZYlxPHuLiuU4IR0yJk
	+kJrb9NzVrGXSZXb3vS22Ii+RQflbxscmpumPbzkq+r77gvEN7U73BnL8yiOR62rP0Bq13Xg/Rg
	/U4LaVBixLdcXnprTxSjuHKHUdib+26ZV2Qy5+2hkJ2ZTRNPpFI/3NAqv+PjAcFr5BGEPCJrkQA
	LEl/62Bq04I05qAOffzZzAddnPArPWT7N6u+E31fRf3rC6yWUbsKC/QEgIDRoT9e+f9muD52lce
	dIuVWn2Xc5b6blcoguTP9T4tDnuTaO3JnvRZ8ztJ6c5a8W7kjngWPIcewJiRIZ1UmhZNE+kGwc4
	UFdbRWHcfZYQN7fl9URwlnrVYMzn5gKKi+ipXo/f6NkvZuAfsy3ABgp+BScPLIjp30vRCMu/XEE
	IGuSBvr2cZfRJay9rRN+OdhIUBn0n5e7PSJdQ8HtHQR9mfq4Hulfpj9
X-Received: by 2002:a17:90a:168f:b0:35f:b137:5a63 with SMTP id 98e67ed59e1d1-35fb1378057mr5263384a91.5.1776158591118;
        Tue, 14 Apr 2026 02:23:11 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e75c38sm1448991a91.11.2026.04.14.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:23:10 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v5 3/3] iio: dac: mcp4821: add configurable gain support
Date: Tue, 14 Apr 2026 14:52:53 +0530
Message-ID: <20260414092254.34883-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414092254.34883-1-nikhilgtr@gmail.com>
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for configuring the DAC gain using the GA bit and
update scale handling

The MCP4821 supports two gain settings:
- 1x gain → 2.048V full-scale
- 2x gain → 4.096V full-scale

Scale write support is added in the IIO interface. Only scale
values advertised via the scale_available attribute are accepted,
ensuring consistency between the configured gain and exposed
scale values.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 132 ++++++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 102ae3718514..c30c320984ce 100644
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
@@ -40,9 +59,16 @@ enum mcp4821_supported_device_ids {
 	ID_MCP4822,
 };
 
+enum gain_modes {
+	MCP4821_GAIN_X1 = 1,
+	MCP4821_GAIN_X2 = 2,
+};
+
 struct mcp4821_state {
 	struct spi_device *spi;
 	u16 dac_value[2];
+	int gain;
+	int avail_gain[4];
 };
 
 struct mcp4821_chip_info {
@@ -57,6 +83,7 @@ struct mcp4821_chip_info {
 		.channel = (channel_id),                              \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 		.scan_type = {                                        \
 			.realbits = (resolution),                     \
 			.shift = 12 - (resolution),                   \
@@ -121,8 +148,9 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
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
@@ -130,6 +158,17 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static void mcp4821_calc_scale(int vref_mv, int resolution,
+				int *val, int *val2)
+{
+	s64 tmp;
+	int micro;
+
+	tmp = (s64)vref_mv * 1000000LL >> resolution;
+	*val = div_s64_rem(tmp, 1000000LL, &micro);
+	*val2 = micro;
+}
+
 static int mcp4821_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int val,
 			     int val2, long mask)
@@ -138,35 +177,85 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
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
 
-	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
-	if (chan->channel)
-		write_val |= MCP4802_SECOND_CHAN;
+		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
+		if (chan->channel)
+			write_val |= MCP4802_SECOND_CHAN;
 
-	write_buffer = cpu_to_be16(write_val);
-	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
-	if (ret) {
-		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
-		return ret;
+		/* GA bit = 1 -> 1x gain */
+		if (state->gain == MCP4821_GAIN_X1)
+			write_val |= MCP4821_GAIN_ENABLE;
+
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
+			state->gain = MCP4821_GAIN_X1;
+			return 0;
+		}
+
+		mcp4821_calc_scale(MCP4821_VREF_MV * MCP4821_GAIN_X2,
+				chan->scan_type.realbits, &v, &v2);
+		if (val == v && val2 == v2) {
+			state->gain = MCP4821_GAIN_X2;
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
+	state->avail_gain[0] = MCP4821_VREF_MV;
+	state->avail_gain[1] = resolution;
+	state->avail_gain[2] = MCP4821_VREF_MV * MCP4821_GAIN_X2;
+	state->avail_gain[3] = resolution;
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
+		*vals = state->avail_gain;
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*length = ARRAY_SIZE(state->avail_gain);
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
@@ -182,12 +271,15 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
+	/* default gain is 2x as GA bit is active low*/
+	state->gain = MCP4821_GAIN_X2;
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

