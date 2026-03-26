Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAE1CD1E4
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509206; cv=none; b=kkVf/uqc3h3lwVQ7kpn5tOzI5FNF5QvqKpCJv1wDLlftVBjYYtY2kfPXkzwPvy6R0JLb3DMTE7kPfDQkGCbLHQgqCroqw/P9/kq4j9lesAjzbpixO2ZScXlYqMMfLt6NJ+RgoiX24a3idHMl8M/GAAl+T15sX54NmIt/faUdxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509206; c=relaxed/simple;
	bh=Z2pK58yD9tGl0rUimG576hBKoNkDtB5eeqQAEX01HRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuVT8R7dBNPOEjgrx75vUPDt4rt5qhOucqocTcFPtXzSByYFbsZcXUjIbvRkaIQpPvnFwKlXSLe8qlwpX8pv8MWqpoz/jeaO0938TQFO+bijiMu3o0paVxSyuDE9NLuNcCwIOqqKQwVjUAX5zj1JPbDh8ONCzuaITghdCvBXaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foYcQh96; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foYcQh96"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c2af7d09533so589975a12.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509203; x=1775114003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQj+ZS7Cpq0zy0VM8gckBrwgZvgCAD6i00LRNff+buA=;
        b=foYcQh96DVy0ki01VCn7ZaTwb0kNYZfeAJefwKuglwRy3f3kwAc/YEZaj18q2wukwx
         eWIn8Q6p0/6rrYEXTHhQD0JPD7WFOf7h26lmrwvOvCm3rrINIPQsZBQX1AVb0b3HV6zS
         qRUa8kJz191xJwJRaK3PI3UWOwr2ElQfWOU2rY8lNOfgRwrJxtpmiqvPjR1EA1uOM55N
         WUbqvRYY8agTcm1RAMZrk9t2tjjEavriStl8SQqEqTWx0224MoEgdlCd64THt9Dm3w0M
         RKSTIxCIgQy2k0N2lYfko7xn5SNaFim7Mxo7dUG9PX7Wad0LGag+Djgc9hRZAFzi2tXf
         an4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509203; x=1775114003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQj+ZS7Cpq0zy0VM8gckBrwgZvgCAD6i00LRNff+buA=;
        b=ld2pJLG72sKQqUrWMrd4YL4StBkZDvOSnROAmnTrHo64YiEjMPp8wP7pF2kbcyYX43
         ICMyop0JUuwZ58IntD4/FyYQEoMCMmeI9T1B7G/TK8XDW5oEZoq/q2b19SRVq7oUca3T
         pVCM9++khCJK/Al5Yc4fXZAGVJOC0FgPYrBof+n2surRAo73YIhuq0tTZXgYXbvehxPz
         SsVJvcYN3fOwqq3vEjS721AKL5fEQfgd4XtJGDc9yY9Re3oH8OCnnOv9+1gUXHPxlJdW
         bkL/Ez7jEAiEbJXW8ULgNxXggbHvwHUMbtlnyO1Gl1txmvUPn3ODUfqW0D5Gjzlknyp3
         pk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz0cEmfv7cXgri3rlvP3X/msUg0/aCSAkucI4Zu+DE2Y39b5blRogowwhV6pU5wScf6EbWTTUD/X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/gw5pFKh1Z7A93VLpATY3A7neSYysitQNZ5IvHQ5fBXQG/By
	OGQ424OYbnaLKHUYRYqL2/RzmjlYFMwSjWOyjmOCAkMLIfxdW0G8LgU=
X-Gm-Gg: ATEYQzzQ5nu9hrZ1EKJK+KqnNB6LpS/lT9/XBWGfiJwxU4QQa/+FFJGlfaWywpH96xY
	Oq7WS/aVcPubzZLolnEa8EqxXox/VaVN9S0rcRFuVBPhoogFMNU6fuNYVGGsdeG05zpj/QxmzuM
	VGBHrr/sYaXmJLJLF0UnibxzYG0/s+kgnN4koYj9nylihLHMVtlcc9+ZWaszuVCh608VG8IXbpw
	H6nNQhU7Wl3YIKZwICrQu2Bu3YxV+GAyJXrMAXf2hOhIpSenvCCcht40NUjt/45uzJPi7YPg8/r
	rJoRJy3OpAw1ibcAU8pZjEuB5pHUPOegB7cKMS5T/MxQYMoQEPlpada3kAUUPdSb7/cuGxZyVfi
	YojeggDRCfHS7mzV+VewH5x/BrpbiYoCIw+92NtLHpwommDAvjQ5GJavSuY9z+QjgcJnGSw3OLP
	zJ4mCvVMuEgU/X7vGMUXE0Z0zswJmZ3W5wi20LaSSUu6VuF2iGDZNe8EWATaj0/r97oeHiNQ==
X-Received: by 2002:a17:903:2309:b0:2b0:c403:5554 with SMTP id d9443c01a7336-2b0c40361a8mr8565485ad.0.1774509202787;
        Thu, 26 Mar 2026 00:13:22 -0700 (PDT)
Received: from nik.qualcomm.com ([101.0.62.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8de61esm25214695ad.65.2026.03.26.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:13:22 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: anshulusr@gmail.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2] iio: dac: mcp4821: add configurable gain support
Date: Thu, 26 Mar 2026 12:42:42 +0530
Message-ID: <20260326071242.9218-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321180707.73a7ad60@jic23-huawei>
References: <20260321180707.73a7ad60@jic23-huawei>
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
---
 drivers/iio/dac/mcp4821.c | 105 ++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964..362ca12988dc 100644
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
@@ -177,12 +235,15 @@ static int mcp4821_probe(struct spi_device *spi)
 	const struct mcp4821_chip_info *info;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
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

