Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAC26E709
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592278; cv=none; b=fnHKgbmEPY3hC1FdgQq43XAyE94FyYafNg68w9Mjdnv7ir/oy+m5m9s7UaFSCuWifP3kycQH8CV7/ggSSOtx55p+QXrQKAYLcpxzYZTKSWmVYUJesRkZTdoeDCLY3nMOYQ88vjWnfNXLc4Wvzr8nnYaQyxD4OTGMTltzZYV1QhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592278; c=relaxed/simple;
	bh=vlRO8fz3Y7Z3gjxTFYHc1jOH0ZEVel8srKDBPj48td8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdiknITAD2XuuNgHw7g5dRNkbshM6DZme2zWU6dS5tFv7mhMkWDcNrG+xTOuh/vS3aymspc+nDGOurIh9pNgmAOq3oB0W4MpkT4uurD2YRxY8cCwO/aYd2n2dzhjuCyvIAlMr719vSBoO3XyN0Am0iJYFsed0RMxymrHeAHk5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv3URdG3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv3URdG3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a67ce6969so1337809b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774592276; x=1775197076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay9PCtGNQoL7LOWqeEaI1OzTCaO/93pal7QlVNlPYo4=;
        b=Dv3URdG3h7rgDAqlEKrJw38EqBt17qhsXEZwylKvDMS6GLJ45xeO2vo4mypZZr4du4
         oRkRC0zUrW73zTbxA5pLF1yQzmzLjiL8Kcmk1Lv+gxbQm8ajoXU978kCDtJ16G/fJJXE
         qtIjmW67OnfQ4CzGru1+Nyv0P4ui8Z+wkLQgnko5gz51Ueq2gwk1XO+JZkV3KHEE0rmQ
         sqNA2HwZW/l+BGfLC8/8hxU9L3wyVOY8dMNM48YM3ROJHSIcdvX7B3MmiOJUV8TKJL37
         i5imttApJgVLBIgdEVD6Fd2AnR2gfOrucmseszH56XGFrVWXy0ZEqYCe0welCVFEPICm
         gszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774592276; x=1775197076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ay9PCtGNQoL7LOWqeEaI1OzTCaO/93pal7QlVNlPYo4=;
        b=IxLtzIeesV/vVNlfbKsKjucIZrU6sN/+HAjmGBwCd661NvV/Grzpo885vHZdSr9Ene
         h4C9GR309nH0WFDUzwgWHfkp09CT53dvIFEBs2w3XIxS/hAWUZApayjEjZLM0BfO2vV0
         cbjOWnY/w3rx9UEyNCtSl1ZZZs2XuUtQ2xe6W8yGrIv1GJzevlRfj8yHYfv80yyekFun
         XpnqOcn/g2F5pFEcwaqSHy+uLYhZorO44p72w4ay9nzveYyGf+VFCG/mhKEswKsYB+A1
         P19Xfb9gpNTIsc0+QjDVoS1MzUKPmzKM9kmn/l6BI9J7ZAhlHnWtLjIW6MuNgweldglM
         3KWw==
X-Forwarded-Encrypted: i=1; AJvYcCW3aRILaeeQUgUTQ62yfaWdN84v/X1gX96RmkPyIKEtayB89Mb8VVUYcahsw3ohhKhQBWTUiYSWM6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuM/xaxzmZIW3CmWcu3holAyh+JiyIW+i29KwEoRnAytHhOpW
	vKO/OUlyS3xkRqjnHsBu97NAi+cpzynKgUqyjlnrqoYuZ/voDDDbEL0phsfLaktPjM1D
X-Gm-Gg: ATEYQzxOTecEU+8cGbxCLwUoe0IKSMpEY0pNb01jyLTTz5WKNV+HmWDjfavdnKEZtYu
	qU5vGgSqBMmn+3VpBP4csC5rv9xf/jXv1Jz1T/1aJSI3CiMLGR/harm+LBzDSHBhp2n6a2flm7o
	itUC/ft8BT+YWgz4K2HGGM0deyhIZ72hM8EPVIOC1hm35fReZMytwKe/RzrOdwPzcKT6tU2GyAI
	CxkoCXiz3VPeRU7kMP7Kc8CGjEUZ1esrCCpLoNtDVRpJ4m4ob0TwUFACWjumT+UEjggCaq1hhAQ
	lhGTCRU/D5VhG124g2Bw2OkKJtiWCTrBBEsQWooh2M+KUar4/Or453KKqID+gA0jxSiRmnIUryF
	YRG7ThqeXFZNf5MaIRKFr7BSCxTsJXYz1YQjf7nH54JH+Rw6o9fDxg2DApGZCL/H/wgwxmpAZFy
	XujhoZmT+cMq+A8/RiwsI505BGLkS5EPckM/O4N2RfPCy7O3cv8Zn3TE0uT/n7k6Z8YNOmPTowk
	zOhbyaSefqut+FZByL1gFtTbXixEaiJnYELsEonywJ1lUI3ZUSK5Bgb
X-Received: by 2002:a05:6a00:3486:b0:829:7d31:dd9a with SMTP id d2e1a72fcca58-82c96002073mr1322389b3a.51.1774592276142;
        Thu, 26 Mar 2026 23:17:56 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3f76e3sm4569546b3a.52.2026.03.26.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:17:55 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: anshulusr@gmail.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3] iio: dac: mcp4821: add configurable gain support
Date: Fri, 27 Mar 2026 11:48:02 +0530
Message-ID: <20260327061802.13043-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acYb1XOmw1yoyu_4@nik>
References: <acYb1XOmw1yoyu_4@nik>
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
Changes in v2:
- Drop header reordering
- Move MCP4821_GAIN_ENABLE define before MCP4802_SECOND_CHAN
- Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE since full scale changes
- Restore original -EINVAL handling in default cases

Changes in v3:
- Restored NULL check in indio_dev alloc
---
 drivers/iio/dac/mcp4821.c | 103 ++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964..9160812219f9 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -12,7 +12,6 @@
  *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
  *
  * TODO:
- *	- Configurable gain
  *	- Regulator control
  */
 
@@ -26,12 +25,32 @@
 #include <linux/unaligned.h>
 
 #define MCP4821_ACTIVE_MODE BIT(12)
+#define MCP4821_GAIN_ENABLE BIT(13)
 #define MCP4802_SECOND_CHAN BIT(15)
 
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
@@ -43,6 +62,7 @@ enum mcp4821_supported_drvice_ids {
 struct mcp4821_state {
 	struct spi_device *spi;
 	u16 dac_value[2];
+	bool gain_1x;
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
@@ -122,8 +143,13 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
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
 	default:
@@ -140,34 +166,66 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
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
+		if (state->gain_1x)
+			write_val |= MCP4821_GAIN_ENABLE;
 
-	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
-	if (chan->channel)
-		write_val |= MCP4802_SECOND_CHAN;
+		write_buffer = cpu_to_be16(write_val);
+		ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
+		if (ret) {
+			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
+			return ret;
+		}
 
-	write_buffer = cpu_to_be16(write_val);
-	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
-	if (ret) {
-		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
-		return ret;
+		state->dac_value[chan->channel] = val;
+		return 0;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (val == 1)
+			state->gain_1x = true;
+		else if (val == 2)
+			state->gain_1x = false;
+		else
+			return -EINVAL;
+		return 0;
+	default:
+		return -EINVAL;
 	}
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
+	case IIO_CHAN_INFO_SCALE:
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
@@ -183,6 +241,9 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
+	/* default gain is 2x as GA bit is active low*/
+	state->gain_1x = false;
+
 	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
-- 
2.43.0

