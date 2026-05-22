Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B406382367
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453275; cv=none; b=OVVLTMlfAeGSwUrDH8CD1Qo9jMFPVb2P+hjVBo2vBLkH8zoNEBB1ahkNBs44Gl1or3JEg9XTXW3ON7WX6lZ/qAtGsCl6czr7nvJ3FsrWrWboJPFNlYV+Wd26ZnB+rppFVv/YnfYXzxyohdDu+yGPoFQWbbZV50pEhvZr2jTcdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453275; c=relaxed/simple;
	bh=jLIetl3bw+rGRVsSOLu2Ojvxtoke28aurnf/TdWdbpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py0nvE37PXCCQq+pJINgCva72VGJveGI6UiFHxjqenwrMU6E/jCDyjg8TjDlBLqgSEqPJcei0zXanXf3Vh5V7E+7/pEM/TWW+Prm20ZCjDwsc4B7teXipHUqpR9MDCvkodJdURyLTKk/z/RYhLKeWulDSUGV6PyhNXMSRdNPC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0/M0g4f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0/M0g4f"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891b0786beso50079015e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453271; x=1780058071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBHfwNqSSbcbmu1tCJQeuwrmbxj6QOr0hRnUh3SugBs=;
        b=j0/M0g4fQ3JXfPZ7VA43IM6jjj18preqbBN1LDzltrVil6ubo9nagTpKAlNXIzuNZD
         mhXMlui1wI5abL28tpCL+tIuBqpXKbbvgnKFtTeyFthIhyXwH3Q11hqrdtTASyDW1aNC
         8X1o+18P9ftUYwgmIKa1T2cYgvlO79d3K8YhdjZUYy3tIM4ADfOC0F5wHkJIv5nOyUUA
         b68nIsONfi5qxq7NBIQVG++DsOntNYcNIrcEOIf8/CHUmqG75iw5X1DXaZlgQyKroXZ8
         mZN+O8kxHVYxWHrahBWxBAKWjLZbxXaDHq3lF+zvT17+VwNhjNIZG3Lh9uq+oQQWsIOL
         QLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453271; x=1780058071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBHfwNqSSbcbmu1tCJQeuwrmbxj6QOr0hRnUh3SugBs=;
        b=fJBeo0f7f6pzLEq/7tKwAC1JXv5SKBT+RCfck+L9a4dw2AZR4lMStmt0bEw0BHSdgZ
         ySTynPJVB5crk0ESIm1ayAm0v3tGJC0s76GjMehh8bcm/aktD7UW6MeRjvw77ySt4MIU
         3vwJMb4OGuiia/6Ib+QpHz1iGBQZTmvsQ3a8Izb/DXsHglYJAQGO961tt/kvR3WpXFej
         bXy6fiKJnd28IDA2bH1pW/sbdb3Qub4slSvYGx5C/5vyOOkgjH+yyVOgSwuAHRlLJCxs
         SUcKqkrgFTXx++KvA3ns1CmIL/R8WE593R1VaXWZVmKeAB8CaGOzaWYC4Ps5xIjfzPgn
         mTbw==
X-Forwarded-Encrypted: i=1; AFNElJ8OeoTxw7WumI4AiYPYqTvNWvbIaMH37qtYgJkesNAJGZlzHD9PPGUru+ArR7qEcLAQjpeN7CC1XYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhEw05ItQCZ0o3YIsySUJsRKZzccomtnqKK4r2rjHArs+I9ZS
	gpC9EkFPo8AChx0rJNIxvMGeI7iaBlY+XAgOQ6KaNhx5k4MBdvEKneVF
X-Gm-Gg: Acq92OEpeEQuPfQUIt10lQQt/dT2sL9OYCXYqZqmbQCOwbVSlwuUYNycZKtoAQU3EhW
	ba4Yf+V1KMCX++GYxsnuS81ZornCJKcJfGgWyQK3bM1jyrZpObIMZmST8BKpcSZdaeR/3ixa5uo
	/ZGEm171i/7VOy1ccdLFz/dBPzT8tZcJkXvwyDEwELtyTJP3VzZesrjWqWFFk1S2EtT3XpK5bjL
	0SHEIUQNVntwIw6czUCV7RPWs9t4W4ZRlga6PcayThxOCcTDCA2FOgtHK1Jzih3gsv+mF/CrpE0
	vGziz2ZsSnVa9DgIjvGGclzxhThTzJRK0s5Y5jcXeZjLD15TsqzTntacTKx0N1tHpgqSh/PCYp9
	DZKkwvtBgrJipSozoGK5PGoEOqMe9+oG4qUVCT5cFxo4p4ZaGTyWrM3eWVudLVUuSz7DVpZv+ds
	J7CCzg+oG1qTdBNCxwaraOjUvHZi5rgM2BT88f51h1XC/WV2ybeqpq
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id 5b1f17b1804b1-490482c4586mr25441665e9.23.1779453270809;
        Fri, 22 May 2026 05:34:30 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:29 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling frequency
Date: Fri, 22 May 2026 14:34:19 +0200
Message-ID: <20260522123420.45495-9-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
register and the WAIT register, with an additional WLONG bit in CONFIG
that if set multiplies the wait step by 12. The driver previously
defined TCS3472_WTIME but never used it leaving the TODO comment on
the top of the source file.

Implement control of the wait time through IIO_CHAN_INFO_SAMP_FREQ:

  - Reading sampling_frequency returns the chip's current cycle time,
    computed as the sum of ATIME, the fixed RGBC initialization time
    and the wait time (which depends on WEN and WLONG).

  - Writing sampling_frequency programs WTIME so that the resulting
    cycle period approximates the requested frequency. If the
    requested frequency cannot be reached with any
    non-zero wait time, WEN is disabled and the chip runs
    back-to-back conversions at the maximum rate allowed by ATIME.
    If the requested period exceeds the maximum WTIME range, WLONG
    is enabled to extend the wait step from 2.4 ms to 28.8 ms.

  - The user's last requested frequency is stored in the driver's
    private data so that subsequent changes to integration_time
    recompute WTIME and preserve the requested sampling rate as
    closely as possible.

Add TCS3472_ENABLE_WEN, TCS3472_ENABLE_RUN and TCS3472_CONFIG_WLONG
bit definitions. TCS3472_ENABLE_RUN bundles the bits
(AEN | PON | WEN) that are simultaneously set when the chip is in
running state and cleared during powerdown, and is used by
tcs3472_probe(), tcs3472_powerdown().

In tcs3472_resume(), only PON and AEN are re-asserted while WEN is
preserved from data->enable.

Remove the "TODO: wait time" comment at the top of the file.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- Drop Suggested-by: Andy (inappropriate tag).
- TCS3472_ENABLE_RUN: new style.
- cycle_us: use div64_u64().
- cycle_us: cast val to u64 for 32-bit safety.
- wait_us: keep s64; added comment explaining the range bounds.
- Use 'if (ret)' instead of 'if (ret < 0)' after i2c writes.
- New helper tcs3472_cycle_to_freq() deduplicates val/val2 logic.
- !! -> ? 1 : 0 in probe.
- Fix tcs3472_resume(): preserve WEN from data->enable instead of
  forcing TCS3472_ENABLE_RUN.

 drivers/iio/light/tcs3472.c | 245 +++++++++++++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 1f597ca93697..81549d7eba35 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -9,8 +9,6 @@
  * TCS34727)
  *
  * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
- *
- * TODO: wait time
  */
 
 #include <linux/cleanup.h>
@@ -53,19 +51,27 @@
 #define TCS3472_STATUS_AINT BIT(4)
 #define TCS3472_STATUS_AVALID BIT(0)
 #define TCS3472_ENABLE_AIEN BIT(4)
+#define TCS3472_ENABLE_WEN BIT(3)
 #define TCS3472_ENABLE_AEN BIT(1)
 #define TCS3472_ENABLE_PON BIT(0)
+#define TCS3472_ENABLE_RUN						\
+	(TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON | TCS3472_ENABLE_WEN)
 #define TCS3472_CONTROL_AGAIN_MASK (BIT(0) | BIT(1))
+#define TCS3472_CONFIG_WLONG BIT(1)
 
 struct tcs3472_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	int target_freq_hz;
+	int target_freq_uhz;
 	u16 low_thresh;
 	u16 high_thresh;
 	u8 enable;
 	u8 control;
 	u8 atime;
 	u8 apers;
+	u8 wtime;
+	bool wlong;
 };
 
 static const struct iio_event_spec tcs3472_events[] = {
@@ -91,6 +97,7 @@ static const struct iio_event_spec tcs3472_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE) | \
 		BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.channel2 = IIO_MOD_LIGHT_##_color, \
 	.address = _addr, \
 	.scan_index = _si, \
@@ -114,6 +121,47 @@ static const struct iio_chan_spec tcs3472_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+/*
+ * The chip's cycle time is the sum of three components:
+ *   - ATIME: the programmable RGBC integration time.
+ *   - The fixed RGBC initialization time (2400 us).
+ *   - WTIME: the wait time, used only if WEN is set. If WLONG is active,
+ *     the wait step is multiplied by 12 (2400 us -> 28800 us).
+ */
+static unsigned int tcs3472_cycle_time_us(struct tcs3472_data *data)
+{
+	unsigned int atime_us = (256 - data->atime) * 2400;
+	unsigned int init_us = 2400;
+	unsigned int wtime_us;
+
+	if (!(data->enable & TCS3472_ENABLE_WEN))
+		wtime_us = 0;
+	else if (data->wlong)
+		wtime_us = (256 - data->wtime) * 28800;
+	else
+		wtime_us = (256 - data->wtime) * 2400;
+
+	return atime_us + init_us + wtime_us;
+}
+
+/*
+ * Convert a cycle time in microseconds to a frequency in Hz and microhertz.
+ *
+ * Given cycle_us = T (the cycle period in microseconds), the corresponding
+ * frequency is:
+ *   f = 1e6 / T  [Hz]
+ *
+ * The result is split into the IIO_VAL_INT_PLUS_MICRO format:
+ *   val  = floor(1e6 / T)                [Hz]
+ *   val2 = (1e6 mod T) * 1e6 / T         [microhertz]
+ */
+static void tcs3472_cycle_to_freq(unsigned int cycle_us, int *val, int *val2)
+{
+	*val = USEC_PER_SEC / cycle_us;
+	*val2 = div_u64((u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC,
+			cycle_us);
+}
+
 static int tcs3472_req_data(struct tcs3472_data *data)
 {
 	int tries = 50;
@@ -166,16 +214,131 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = (256 - data->atime) * 2400;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int cycle_us = tcs3472_cycle_time_us(data);
+
+		tcs3472_cycle_to_freq(cycle_us, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static int tcs3472_set_sampling_freq(struct tcs3472_data *data,
+				     int val, int val2)
+{
+	unsigned int atime_us;
+	unsigned int init_us = 2400;
+	u64 cycle_us;
+	s64 wait_us;
+	int wtime;
+	bool wlong = false;
+	u8 config;
+	int ret;
+
+	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	atime_us = (256 - data->atime) * 2400;
+	cycle_us = div64_u64(PSEC_PER_SEC,
+			     (u64)val * USEC_PER_SEC + val2);
+
+	/*
+	 * wait_us can be negative when the requested frequency is too high
+	 * to be reached, or very large when the requested frequency is
+	 * close to zero. Use s64 to cover the full range:
+	 *
+	 *   cycle_us = PSEC_PER_SEC / (val * USEC_PER_SEC + val2)
+	 *
+	 * The divisor of the formula above reaches its maximum when
+	 * val = val2 = INT_MAX:
+	 *  INT_MAX * USEC_PER_SEC + INT_MAX = ~2.15e18
+	 * so cycle_us_min = floor(1e12 / 2.15e18) = 0.
+	 *
+	 * The divisor reaches its minimum (1) when val = 0 and val2 = 1,
+	 * so cycle_us_max = 1e12 / 1 = 1e12.
+	 *
+	 * Therefore:
+	 *   wait_us_min = 0 - 2400 - 612000 = -616800
+	 *   wait_us_max = 1e12 - 2400 - 2400 = 999999995200
+	 *
+	 * Both fit comfortably in s64.
+	 */
+	wait_us = (s64)cycle_us - init_us - atime_us;
+
+	if (wait_us < 2400) {
+		if (data->enable & TCS3472_ENABLE_WEN) {
+			data->enable &= ~TCS3472_ENABLE_WEN;
+			ret = i2c_smbus_write_byte_data(data->client,
+							TCS3472_ENABLE,
+							data->enable);
+			if (ret)
+				return ret;
+		}
+
+		data->target_freq_hz = val;
+		data->target_freq_uhz = val2;
+		return 0;
+	}
+
+	/*
+	 * Wait state is needed: make sure WEN is active before programming
+	 * WTIME (and possibly WLONG).
+	 */
+	if (!(data->enable & TCS3472_ENABLE_WEN)) {
+		data->enable |= TCS3472_ENABLE_WEN;
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+						data->enable);
+		if (ret)
+			return ret;
+	}
+
+	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
+	if (wtime < 0) {
+		wlong = true;
+		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
+	}
+	wtime = clamp(wtime, 0, 255);
+
+	if (wlong != data->wlong) {
+		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		config = ret;
+		if (wlong)
+			config |= TCS3472_CONFIG_WLONG;
+		else
+			config &= ~TCS3472_CONFIG_WLONG;
+
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_CONFIG,
+						config);
+		if (ret)
+			return ret;
+
+		data->wlong = wlong;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
+	if (ret)
+		return ret;
+
+	data->wtime = wtime;
+	data->target_freq_hz = val;
+	data->target_freq_uhz = val2;
+
+	return 0;
+}
+
 static int tcs3472_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret;
 	int i;
 
 	switch (mask) {
@@ -196,15 +359,29 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 		if (val != 0)
 			return -EINVAL;
 		for (i = 0; i < 256; i++) {
-			if (val2 == (256 - i) * 2400) {
-				data->atime = i;
-				return i2c_smbus_write_byte_data(
-					data->client, TCS3472_ATIME,
-					data->atime);
-			}
-
+			if (val2 != (256 - i) * 2400)
+				continue;
+
+			data->atime = i;
+			ret = i2c_smbus_write_byte_data(data->client,
+							TCS3472_ATIME,
+							data->atime);
+			if (ret)
+				return ret;
+
+			/*
+			 * ATIME just changed, so the cycle time changed too.
+			 * Re-run the sampling frequency logic to recompute
+			 * WTIME and preserve the user's last requested
+			 * frequency.
+			 */
+			return tcs3472_set_sampling_freq(data,
+							 data->target_freq_hz,
+							 data->target_freq_uhz);
 		}
 		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return tcs3472_set_sampling_freq(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -434,16 +611,15 @@ static const struct iio_info tcs3472_info = {
 static int tcs3472_powerdown(struct tcs3472_data *data)
 {
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
 	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-					data->enable & ~enable_mask);
+					data->enable & ~TCS3472_ENABLE_RUN);
 	if (ret)
 		return ret;
 
-	data->enable &= ~enable_mask;
+	data->enable &= ~TCS3472_ENABLE_RUN;
 
 	return 0;
 }
@@ -458,6 +634,7 @@ static int tcs3472_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
+	unsigned int cycle_us;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -498,6 +675,16 @@ static int tcs3472_probe(struct i2c_client *client)
 		return ret;
 	data->atime = ret;
 
+	ret = i2c_smbus_read_byte_data(data->client, TCS3472_WTIME);
+	if (ret < 0)
+		return ret;
+	data->wtime = ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
+	if (ret < 0)
+		return ret;
+	data->wlong = (ret & TCS3472_CONFIG_WLONG) ? 1 : 0;
+
 	ret = i2c_smbus_read_word_data(data->client, TCS3472_AILT);
 	if (ret < 0)
 		return ret;
@@ -518,14 +705,29 @@ static int tcs3472_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* enable device */
-	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
+	/*
+	 * Enable the chip in its full running state, including WEN. The
+	 * actual wait time is controlled by the WTIME and WLONG registers,
+	 * which retain their power-on defaults until userspace writes to
+	 * sampling_frequency.
+	 */
+	data->enable = ret | TCS3472_ENABLE_RUN;
 	data->enable &= ~TCS3472_ENABLE_AIEN;
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable);
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Initialize target frequency from the chip's current state so that
+	 * subsequent integration_time changes via IIO_CHAN_INFO_INT_TIME can
+	 * preserve a meaningful sampling rate, even before userspace writes
+	 * sampling_frequency for the first time.
+	 */
+	cycle_us = tcs3472_cycle_time_us(data);
+	tcs3472_cycle_to_freq(cycle_us, &data->target_freq_hz,
+			      &data->target_freq_uhz);
+
 	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
 	if (ret)
 		return ret;
@@ -561,16 +763,23 @@ static int tcs3472_resume(struct device *dev)
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+	u8 value;
 
 	guard(mutex)(&data->lock);
 
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable | enable_mask);
+	/*
+	 * On resume, only PON and AEN need to be re-asserted. WEN must not
+	 * be forced on: its desired state was set by the user via
+	 * sampling_frequency and is already stored in data->enable, so we
+	 * read it from there to preserve the user's choice.
+	 */
+	value = data->enable | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
 	if (ret)
 		return ret;
 
-	data->enable |= enable_mask;
+	data->enable = value;
 
 	return 0;
 }
-- 
2.54.0

