Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E33EAC8A
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060599; cv=none; b=gQGjui8wsfB48cHBaMRYOom++jHV/sQdkXzL8eR6J+VagZsMB3N0tyqEnoiHhh4r7lOYzqbQPmS0D0QqWs8dmgPi/3aXkkI1OhkDMP5vmOuEez3f1+2HbX6HadEymj5QYTDDxSifRrCVi46dN3Ibssd7Kt1k7gDi7LkCddHKf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060599; c=relaxed/simple;
	bh=K0ZzDlMSF/TZUll7GK0885r5ENR7KhCrSPg5rkH27bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl/bbCf40UbY8+hLj7HtSs9RYT57PVAEKFaFJS06O8HmwQgQU94V4kyiHlEqNMdKW1P4sksFAwfplIYZ4sku5BK48ZYoX2C8aFJyqBrTqIkmw625nj9WIYDS0XrPkychcxReSbNLWbWcVYiZWr/2s88DGmF4kDlV7uRiTSnI1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbwIcU+F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbwIcU+F"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44e1860558fso2156929f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060596; x=1778665396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpIP3p3SfC47hlzL1+77n9qrEmTKSfZyEerx12Yk+Z4=;
        b=rbwIcU+FOhWc5SYCR8LGHhJYdoeyZDbB1+ZJrdsC1J52uxOwmJfxfDCsoXjus0nO3R
         Pw//dSTA9+njm3YYJ7nqsPVhX5c/0dQuRHC1kcVFlxvIwYXh3B3HM59bIFz1Bmr1XDrB
         qQmQX/1le/amsX22t1i9pkRJUyzaf2JKFC2aaFRpCakehpHe2Wj3tYXTtDTIGAvP0+Y9
         lt0A3hA5rZvNVldcvErhXnk8COYd4wlgNmKzHieY3fwyNKREfkgjroYd3ZO70s6e9gQF
         GJ5QfrHmwE1GHnKHdVnDGDXers6wMvbMJhDnticVFCt376iHIFk5kH+KKOGULJQeQcgN
         F2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060596; x=1778665396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpIP3p3SfC47hlzL1+77n9qrEmTKSfZyEerx12Yk+Z4=;
        b=QH9To8YJztoSwP9S8BEbS9C5GWdfOZaUiKrHs8mGtbpiSGmL4Wfbm6XCDYJtQIN8kf
         2IehNle1iHkN7SjtFKxQNkkLjc88ZB9kyRb1+co4T5OaLnHDr/3S4/EsAKm5Ju3ASxFu
         HsgiAamR1qhnyBPmhV3OchEWSTNWKUFdOUneN9zuepREKFkhXwHlfIo36Z4YeFQ25rAW
         XP50c2DALRC5A1KTn97Aq+F3EhXvOdonO1e+qVGLAk0jhvSON2Fd4Rr2llU95UFkgfTl
         tXhPmJ8N5zrk9dqixlGWf6xE3wZ88Gyxz3eYOr2/lGqn7O7nUgflViQWjKhQEQ/xuNLo
         FYhg==
X-Forwarded-Encrypted: i=1; AFNElJ8tqMVVB1IIgcqBX3888ZuxKATdPv+yuaIXyO/8M/D3PVn7tsKmtZzoB4m19VYWxjITTFvxs8zEThs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpwI6hPIsI30VSC+nGyAXfvsOBuN4iq+sQPESCaHZqTEr6tI5
	Y36klsiRex7zIzn8oDuugOi4S71wLdqVv2AjQgU0Qxanbug40oyPU5hC
X-Gm-Gg: AeBDiesxB4xyY3xyKcqDsdWcvl7jhyZzRnX/rst/tgbfQjg6h0vd7jUdUq/a+TkbI8v
	SchWZAtrpZYDoiISu4qKqHO9GxnIz4CJihXS6ECNN2ywC3hulMOQBdq5HC47mk0jZ0MMyksOigv
	nHwFG0nTGWdmjCmCeJAo1C8cRZtLtzKmpnKj0MW50Iy7u1m33Hr3uSlVzt4KR2Mbw2i1ZsfBhXp
	h9BlCiUCKRrWW8AQMApS14zRUnd+Bc0XACQjoHZsceuk9BREKjRdXyn11nyIMgvhjOVun0PQaKt
	LCotUQ0k0ztDZN6l71/WP3VR0PCV2kIVfdyVbn+Im5CGSJoFuqcaQPReXWS3a8tRRCeZBIbSypL
	p5yHzqqJHRULkYuSFkUrdxOK3GVCgEk9uw+k0/pDz7CdHzLH0Ah0KJ/bmpoKBaKnG/1S8B351JD
	eSMbrQeN5Ie9iBlygzttlfsMZZHbpqCUQ89U0bHb3tmiTUa1SV72UKfId76iDQ2b9qq7yAEFqOI
	Q==
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr4294374f8f.29.1778060595738;
        Wed, 06 May 2026 02:43:15 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524831cdsm12362230f8f.5.2026.05.06.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:43:15 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 2/3] iio: light: tcs3472: implement wait time and sampling frequency
Date: Wed,  6 May 2026 11:43:10 +0200
Message-ID: <20260506094311.222500-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506094311.222500-1-aldocontelk@gmail.com>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
register and the WAIT register, with ad additional WLONG bit in CONFIG
that if set multiplies the wait step by 12. The driver previously
defined TCS3472_WTIME but never used it leaving the TODO comment on
the top of the source file.

Implement sampling frequency control via IIO_CHAN_INFO_SAMP_FREQ:

- Reading sampling_frequancy computes the chip's actual cycle time as
  the sum of ATIME, RGBC initialization time (that is fixed) and the
  WAIT time that depends on WLONG and WEN bits. WEN is used to enable
  the chip to consider the WAIT state (without which it would proceed
  directly to the rgbc init state).

- Writing sampling_frequency programs WTIME accordingly with current
  ATIME in order to obtain a cycle period that approximates as close as
  possible the requested frequency.
   - If the requested frequency is too
     low (and so the cycle is too large) the WLONG bit is asserted.
   - If the requested frequency is too high to be reached with a
     non-zero wait time, WEN is disabled so that wtime_us becomes 0 and
     conversions run back-to-back at the maximum rate accordingly with
     ATIME.

- The user's last requested frequency is saved in the driver's
  private data in order to use it when a new integration time (ATIME)
  is requested: when ATIME changes, the wait time is recalculated to
  ensure that the previous requested frequency is ashered to as closely
  as possible.

- The cycle time computation respects the WEN and WLONG for the
  evaluation of wtime_us.

- Concurrent access to driver's private data into the
  tcs3472_set_sampling_freq function is protected by the guard(mutex).

Tested on a Raspberry Pi 3B with a TCS3472 breakout at I2C address
0x29, by writing values to `sampling_frequency` and veifying the
reported value via `cat sampling_frequency`, and checking that changing
`integration_time` preserves the previusly requested sampling frequency.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/tcs3472.c | 171 ++++++++++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 6d37a473c420..de51eb61f42a 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -9,14 +9,14 @@
  * TCS34727)
  *
  * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
- *
- * TODO: wait time
  */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/math64.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -51,9 +51,11 @@
 #define TCS3472_STATUS_AINT BIT(4)
 #define TCS3472_STATUS_AVALID BIT(0)
 #define TCS3472_ENABLE_AIEN BIT(4)
+#define TCS3472_ENABLE_WEN BIT(3)
 #define TCS3472_ENABLE_AEN BIT(1)
 #define TCS3472_ENABLE_PON BIT(0)
 #define TCS3472_CONTROL_AGAIN_MASK (BIT(0) | BIT(1))
+#define TCS3472_CONFIG_WLONG BIT(1)
 
 struct tcs3472_data {
 	struct i2c_client *client;
@@ -64,6 +66,10 @@ struct tcs3472_data {
 	u8 control;
 	u8 atime;
 	u8 apers;
+	u8 wtime;
+	bool wlong;
+	int target_freq_hz;
+	int target_freq_uhz;
 };
 
 static const struct iio_event_spec tcs3472_events[] = {
@@ -89,6 +95,7 @@ static const struct iio_event_spec tcs3472_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE) | \
 		BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.channel2 = IIO_MOD_LIGHT_##_color, \
 	.address = _addr, \
 	.scan_index = _si, \
@@ -112,6 +119,22 @@ static const struct iio_chan_spec tcs3472_channels[] = {
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
@@ -164,16 +187,118 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = (256 - data->atime) * 2400;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int cycle_us = tcs3472_cycle_time_us(data);
+
+		*val = USEC_PER_SEC / cycle_us;
+		*val2 = (u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC / cycle_us;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	}
 	return -EINVAL;
 }
 
+static int tcs3472_set_sampling_freq(struct tcs3472_data *data,
+				     int val, int val2)
+{
+	unsigned int atime_us = (256 - data->atime) * 2400;
+	unsigned int init_us = 2400;
+	u64 cycle_us;
+	s64 wait_us;
+	int wtime;
+	bool wlong = false;
+	int ret;
+
+	if (val < 0 || (val == 0 && val2 <= 0))
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	cycle_us = div_u64((u64)USEC_PER_SEC * USEC_PER_SEC,
+			   (u64)val * USEC_PER_SEC + val2);
+
+	wait_us = (s64)cycle_us - init_us - atime_us;
+
+	/* Wait state is not needed.
+	 * Requested frequency is too high to be reached with any
+	 * non-zero wait time. Disable WEN so the chip runs at the
+	 * maximum rate allowed by ATIME alone.
+	 */
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
+	wtime = 256 - (int)DIV_ROUND_CLOSEST((unsigned long)wait_us, 2400);
+	if (wtime < 0) {
+		wlong = true;
+		wtime = 256 - (int)DIV_ROUND_CLOSEST((unsigned long)wait_us,
+						     28800);
+		if (wtime < 0)
+			wtime = 0;
+	}
+	if (wtime > 255)
+		wtime = 255;
+
+	if (wlong != data->wlong) {
+		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		if (wlong)
+			ret |= TCS3472_CONFIG_WLONG;
+		else
+			ret &= ~TCS3472_CONFIG_WLONG;
+
+		ret = i2c_smbus_write_byte_data(data->client,
+						TCS3472_CONFIG, ret);
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
 static int tcs3472_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
 	int i;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -195,13 +320,22 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 		for (i = 0; i < 256; i++) {
 			if (val2 == (256 - i) * 2400) {
 				data->atime = i;
-				return i2c_smbus_write_byte_data(
-					data->client, TCS3472_ATIME,
-					data->atime);
+				ret = i2c_smbus_write_byte_data(data->client,
+								TCS3472_ATIME,
+								data->atime);
+				if (ret < 0)
+					return ret;
+				/* since ATIME has changed, recalculate
+				 * WTIME to maintain sampling freq
+				 */
+				return tcs3472_set_sampling_freq(data,
+								 data->target_freq_hz,
+								 data->target_freq_uhz);
 			}
-
 		}
 		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return tcs3472_set_sampling_freq(data, val, val2);
 	}
 	return -EINVAL;
 }
@@ -443,7 +577,8 @@ static const struct iio_info tcs3472_info = {
 static int tcs3472_powerdown(struct tcs3472_data *data)
 {
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
+			TCS3472_ENABLE_WEN;
 
 	mutex_lock(&data->lock);
 
@@ -466,6 +601,7 @@ static int tcs3472_probe(struct i2c_client *client)
 {
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
+	unsigned int cycle_us;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -504,6 +640,16 @@ static int tcs3472_probe(struct i2c_client *client)
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
+	data->wlong = ret & TCS3472_CONFIG_WLONG;
+
 	ret = i2c_smbus_read_word_data(data->client, TCS3472_AILT);
 	if (ret < 0)
 		return ret;
@@ -525,13 +671,19 @@ static int tcs3472_probe(struct i2c_client *client)
 		return ret;
 
 	/* enable device */
-	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
+	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN |
+			TCS3472_ENABLE_WEN;
 	data->enable &= ~TCS3472_ENABLE_AIEN;
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable);
 	if (ret < 0)
 		return ret;
 
+	cycle_us = tcs3472_cycle_time_us(data);
+	data->target_freq_hz = USEC_PER_SEC / cycle_us;
+	data->target_freq_uhz = (u64)(USEC_PER_SEC % cycle_us) *
+				USEC_PER_SEC / cycle_us;
+
 	ret = devm_add_action_or_reset(&client->dev,
 				       tcs3472_powerdown_action, data);
 	if (ret)
@@ -567,7 +719,8 @@ static int tcs3472_resume(struct device *dev)
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
+			TCS3472_ENABLE_WEN;
 
 	mutex_lock(&data->lock);
 
-- 
2.54.0

