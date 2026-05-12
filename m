Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929033A9D92
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625146; cv=none; b=h7heSbijxoHVYNp1D4p3faQ/akYbBbhrWwC0nya8eixcaxlvTHBDVAc78FoMZXHntZShwNCEnsIbrlK+f2Bf/JMf/QrjT62k2s48Fy3YW85ZYTxjoxJY4jyF3Qoaaae9lEqs6nkHg0FHpBihqysDniAU7hP39YfuYiibQwJc1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625146; c=relaxed/simple;
	bh=kXmeJZWhjPp3n0Y8pQXNLpXCKoAkMZVyJaWBm7pQu/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuXZdku3whURudYMXvzEVc70AbebauyX/Y+olEu/gE0ASt1mdl1aEGovzJVIci71CRBf5TFWkKMzocQN+4DFABaC9fn61D3pkaBS2YprPdf6m/f+ZiWukO+EBpyEbsdR/MpzTH2hkkwolRNAZSHCpo4x2jLWZ/yfxvabdajOaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFu0Lch3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFu0Lch3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso41791435e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625142; x=1779229942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6w739Ifl/Y6Qjqjo1MQer97vyt9PsvW6lAxp4s+8V4=;
        b=AFu0Lch3SFeB2L0I6HVOTrtdZE07IGtueG3pJlm0pyrziYbC5Je4d//bxgle3Q/dZR
         +qpC/vOOlzgHxHvbG0zLsegZ8wz/j2Z+lFmyAu0nkVFtp2IlTSoDfXpiWveecTrMdLFb
         ijUi1BpnxKUMU7CW/TQChdfggGhonxyISotz3dxvRD3S8yLtGGuYEjYq+pHlJGpuV+qx
         XmWOvQ3nu5JQ2AigT37PRCatKjddqGBwGuP2Z2EJwC1jt2zWBZicwR0c3drQESWvzzen
         i7hooUqIV0xqqJF3jxh81UTTEq/+N1cA9ax4doaSqcvKeJDRolM7TwpZLIAIHJ6+9/0Q
         DK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625142; x=1779229942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6w739Ifl/Y6Qjqjo1MQer97vyt9PsvW6lAxp4s+8V4=;
        b=E/hdGvM9ESNCGFb1AwHnU0nIUBlbkjEdJv9dfV+EYTKmgAWiKXyFpkSW0WlYIENuTS
         TL8IYQ4Y7vcZPQSJLcjIycCRkZ8a6o8GYrpB1DVXYTwiQUKUUfMLPmg/nL9xx4JsBV5c
         Xyi0mSwFH4D5Nr2DTKRf8jXJDL9aJtHprgQPtH2HbVVVA1RSck3P3ZmL0XEWbO3VBJ1+
         PBDZHB4RUzAifUcD3Oc4rGGdWPRhyO2m9xj4I7qgiN51wPnhSe9c98JvyhO0CYIqv4ak
         opCZVYh0qose/iDJZt7gg8oFbRAUDLRQ6y9k1zqhBBOXiQUZjqYq1YTmqvPon5ry2rRA
         BZ1g==
X-Forwarded-Encrypted: i=1; AFNElJ/r/wvvYg9NzyKlTuXHXDIcRYlbEwbb0W5Uy2utL7oE8ZScdWoRUsaNTBhUbKfC4RPa3TiQoNcuU1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqoNkIeAzqbg48CY5FXhQsn9zE4RngYP8S+POgs0adUWDftRD
	fYuRv7/v0r9J1eK+mSvMBOlkafOtww35a0cHYCTuW0mtsTISUtZ5ogNy
X-Gm-Gg: Acq92OE6FNFN18yD2uadYvOKMQW0rtkczZ/PeCv/y+BgILFlxUx2OnHzGrGKWWn+KUx
	TmEWDjMZtn2L75CYd02o+RFWmVLmyd3Ui7ZgMiorM7Q7W+cqwR36hVEPdFzdbieuAdvhz13uwzE
	YqjEBjRcbJuCrMsaWuSB/baEFpFS7mntNq/21jQotcYADegpbSmTnMSLjPwvMZMMHA7TLV7TLcg
	Gxvzl7gSWCi8BjoMP72QxjJHGP+BkIzXFaF/jOFRaQsB2HrmXtde/GT/5rDfTinA8TgggMJU2sm
	XcZz+BSAzcFy42hQFGB8fDsqee/AkOs5Nx4cXJlNmdE+0/wG98VYhZ8v5/LVaNhGJRj3o3Zy+YF
	LKjcodwMSlSmo0noCh0i8UaHvlASxRFkRQhBh6F17uhI/8cNk8jjsGbE4aQ5jWSkntQ1knmObbg
	D/a2v8X7Y8T3KGM5WcemKg+8PaBRPHZIuRt8Da2dwAMyarevDxTtsKCG4=
X-Received: by 2002:a05:600c:3588:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48fc9a39b2amr9061255e9.20.1778625141903;
        Tue, 12 May 2026 15:32:21 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:21 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 4/5] iio: light: tcs3472: implement wait time and sampling frequency
Date: Wed, 13 May 2026 00:32:14 +0200
Message-ID: <20260512223215.25596-5-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
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
tcs3472_probe(), tcs3472_powerdown() and tcs3472_resume().

Remove the "TODO: wait time" comment at the top of the file.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v2:
( Suggested-by Andy )
- Validation also rejects val > 0 with val2 < 0
- cycle_us uses PSEC_PER_SEC (was USEC_PER_SEC * USEC_PER_SEC),
- clamp() replaces manual WTIME bounds checks.
- DIV_ROUND_CLOSEST_ULL() allows to avoid all the castings.
- CONFIG read-modify-write uses a separate 'config' variable instead of the
  ret = foo(ret).
- Multi-line comments now follow kernel style.
- Added comment explaining why wait_us can be negative.
- target_freq_uhz uses div_u64() for 32-bit portability.
- TCS3472_ENABLE_RUN introduced here with AEN | PON | WEN.
- Test details moved to the cover letter.

 drivers/iio/light/tcs3472.c | 189 +++++++++++++++++++++++++++++++++---
 1 file changed, 175 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 7a6dc8360326..f8f70399a4dc 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -9,13 +9,12 @@
  * TCS34727)
  *
  * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
- *
- * TODO: wait time
  */
 
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 
@@ -52,19 +51,27 @@
 #define TCS3472_STATUS_AINT BIT(4)
 #define TCS3472_STATUS_AVALID BIT(0)
 #define TCS3472_ENABLE_AIEN BIT(4)
+#define TCS3472_ENABLE_WEN BIT(3)
 #define TCS3472_ENABLE_AEN BIT(1)
 #define TCS3472_ENABLE_PON BIT(0)
+#define TCS3472_ENABLE_RUN (TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON | \
+			    TCS3472_ENABLE_WEN)
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
@@ -90,6 +97,7 @@ static const struct iio_event_spec tcs3472_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE) | \
 		BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.channel2 = IIO_MOD_LIGHT_##_color, \
 	.address = _addr, \
 	.scan_index = _si, \
@@ -113,6 +121,22 @@ static const struct iio_chan_spec tcs3472_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
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
+	return wtime_us + init_us + atime_us;
+}
+
 static int tcs3472_req_data(struct tcs3472_data *data)
 {
 	int tries = 50;
@@ -135,6 +159,100 @@ static int tcs3472_req_data(struct tcs3472_data *data)
 	return 0;
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
+	cycle_us = div_u64((u64)PSEC_PER_SEC,
+			   (u64)val * USEC_PER_SEC + val2);
+
+	/*
+	 * wait_us can be negative or smaller than the minimum wait step
+	 * (2400 us) when the requested frequency is too high to be reached.
+	 * In that case, disable WEN so that the chip can perform back-to-back
+	 * conversions at the maximum rate permitted by the current ATIME.
+	 */
+	wait_us = (s64)cycle_us - init_us - atime_us;
+
+	if (wait_us < 2400) {
+		if (data->enable & TCS3472_ENABLE_WEN) {
+			data->enable &= ~TCS3472_ENABLE_WEN;
+			ret = i2c_smbus_write_byte_data(data->client,
+							TCS3472_ENABLE,
+							data->enable);
+			if (ret < 0)
+				return ret;
+		}
+
+		data->target_freq_hz = val;
+		data->target_freq_uhz = val2;
+		return 0;
+	}
+
+	/*
+	 * Wait state is needed: make sure WEN is active before
+	 * programming WTIME (and possibly WLONG).
+	 */
+	if (!(data->enable & TCS3472_ENABLE_WEN)) {
+		data->enable |= TCS3472_ENABLE_WEN;
+		ret = i2c_smbus_write_byte_data(data->client,
+						TCS3472_ENABLE,
+						data->enable);
+		if (ret < 0)
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
+		if (ret < 0)
+			return ret;
+
+		data->wlong = wlong;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
+	if (ret < 0)
+		return ret;
+
+	data->wtime = wtime;
+	data->target_freq_hz = val;
+	data->target_freq_uhz = val2;
+
+	return 0;
+}
+
 static int tcs3472_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -165,6 +283,14 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = (256 - data->atime) * 2400;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int cycle_us = tcs3472_cycle_time_us(data);
+
+		*val = USEC_PER_SEC / cycle_us;
+		*val2 = div_u64((u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC,
+				cycle_us);
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	}
 	return -EINVAL;
 }
@@ -175,6 +301,7 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
 	int i;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -194,15 +321,29 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
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
+			if (ret < 0)
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
 	}
 	return -EINVAL;
 }
@@ -429,13 +570,12 @@ static const struct iio_info tcs3472_info = {
 
 static int tcs3472_powerdown(struct tcs3472_data *data)
 {
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 	u8 value;
 	int ret;
 
 	guard(mutex)(&data->lock);
 
-	value = data->enable & ~enable_mask;
+	value = data->enable & ~TCS3472_ENABLE_RUN;
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
 	if (ret)
@@ -456,6 +596,7 @@ static int tcs3472_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
+	unsigned int cycle_us;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -494,6 +635,16 @@ static int tcs3472_probe(struct i2c_client *client)
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
+	data->wlong = !!(ret & TCS3472_CONFIG_WLONG);
+
 	ret = i2c_smbus_read_word_data(data->client, TCS3472_AILT);
 	if (ret < 0)
 		return ret;
@@ -515,13 +666,24 @@ static int tcs3472_probe(struct i2c_client *client)
 		return ret;
 
 	/* enable device */
-	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
+	data->enable = ret | TCS3472_ENABLE_RUN;
 	data->enable &= ~TCS3472_ENABLE_AIEN;
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable);
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Initialize target frequency from the chip's current state so
+	 * that subsequent integration_time changes via IIO_CHAN_INFO_INT_TIME
+	 * can preserve a meaningful sampling rate, even before userspace
+	 * writes sampling_frequency for the first time.
+	 */
+	cycle_us = tcs3472_cycle_time_us(data);
+	data->target_freq_hz = USEC_PER_SEC / cycle_us;
+	data->target_freq_uhz = div_u64((u64)(USEC_PER_SEC % cycle_us) *
+					USEC_PER_SEC, cycle_us);
+
 	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
 	if (ret)
 		return ret;
@@ -555,13 +717,12 @@ static int tcs3472_resume(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 	u8 value;
 	int ret;
 
 	guard(mutex)(&data->lock);
 
-	value = data->enable | enable_mask;
+	value = data->enable | TCS3472_ENABLE_RUN;
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
 	if (ret)
-- 
2.54.0

