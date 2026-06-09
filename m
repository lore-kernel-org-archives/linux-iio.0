Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCE4963D6
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020523; cv=none; b=irRmGo8tYi0Lo5wpf1/tS3I8vDFsLDKm2ekU4L1RrAOyiP3zVlMkfiWIgmEp77Fjs8QM7xk+5YyPCLhLxGC9L7pj/9CMTFOHBMojCW0IumY8tNwVpYM0ZbWmJ9m6OMW9bz/i5OnLLECcwu1+RyAnIg8HEKE1VvaaNWWZ7C9EuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020523; c=relaxed/simple;
	bh=G8DZ2PE1LmC7sRP4F7OAZjqFju68xsA4AAGIEixoggM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFSCv55k7CZ5zZSxmOthnwaegk23xOM4I0p+m3CVZom+dzUiTod+7yV5ElF9vEQHYLTbdVdI4tJyLqU7Lu/MVWOBt48AC7XxQda7tEixnLhRkfFbBX6DRMiQFZpSkb5QRjdegXkltyX0XrWDcBG+i8z3U0sePnXQ3I/3fp0CNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+HsHw+1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+HsHw+1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so3966256f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020517; x=1781625317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxA6qDHE2O8jKM7fKavDQ0sfY6zL6Nrl9rqmldoMJ9I=;
        b=Y+HsHw+1bdCq1TBLmPgk+9QRRHwpcXK0xeIbUzx4SAsRWtRCPREuoOX/xHZ8uVO6zs
         s22ZUhEcghHaB1wTodxWRVg3jD3I693jjDdzbGlDLenTM1ctYXPoScC8vg2Gl88JKItd
         rFLvmdEzsZyiR3BjYwSA6w1BaH7fsd+aVDay/g3yxx0Miv2QOwpw7x7/uCAYMKZkxORH
         gYQKicgr+adSyV2PKThsuszrbdhIBDfje4krkQxiWpDaayAlFREZbnoKyjzwKggnjayr
         ZBXzzJ05lkIRYDKl/6YvU2dlCE/AJ1xVvf8POijD+ZdY9Bo5FiHq3Kc+sjnTuQSj/tqQ
         v9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020517; x=1781625317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxA6qDHE2O8jKM7fKavDQ0sfY6zL6Nrl9rqmldoMJ9I=;
        b=SoQUcc0SJE+cXROmi64OBwKrmSU2SAgf8TaWA8/TTe+/GvKJF9HoNTxnNqKx1Jn0s6
         yDd1T0m25wazX45Gkknf+ZZoonsi4/Z3y+h+pYdJkEmYBa0pidmjmxAYJARHVIBqAqEI
         72RbPl6inHZ53hRW3oDtjwUn9gg+R1tGxDugiMH86TF+dM3zuGHYQmUz1REgqyIoffzF
         CIq471GubJFZ/yGQ18hBFMcNuWUljPrud/UkL/sth57aCVjatfX+hYpirnuzYhhaxf0u
         ZGUc7ZENnRN3MwF9FU1zdkLA+lxYXTVA0+Pw8N6uzn14VHvNuv2OWdSa8UIHpRDeE7LY
         Zp/w==
X-Forwarded-Encrypted: i=1; AFNElJ+1f7S5zS8VCrZ2RRg+w4QsiH0OU/9ZwXpg96gvjzLc1e8ZQpAPD9gdoH0lxAoPghGqcf3lsn4Y+SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMUHOC6444/nHc2k/HICdzmil8vjpH7gdlL39Cc1LFrFRp8hB
	fzxjBbJ4/kdJOd+o2IqkIsoJxDm/iI3Qn0fHrOaxvaocHETw+OMqHDh9
X-Gm-Gg: Acq92OGcjfr35j5E5+wGtalXgHvG8qBVu8rpEGiGC9xnkZfUx/ZPmN3bBYwKmg04CqP
	1khL8QCbmynDZuXuinM2EC5JIggjGCo7yc1wCONiLIIIKf2My3SoDmBaZftcpVHT0UYwDUs6be6
	iBIu3qX7IZn69oaJqSTMImZnVOo+KdFlAC8/oP85iaYuT5jpJwQz/Ge9d5n+kwz248PrBO74iKj
	3wiyMHnKU7ajIe8zwsQWIgeOQ2C545AcGztcxsxQcF36YMenH3T5N+S1rhHW6rKQCk/8uH7Bj9v
	f0J/xf/sye89D48YML4ceBngqbE9TZ/H4uFZ+tp/6/e6p5VWswDczSRwIsgKPRHj2Dxu/52kUFA
	hja/Md20x53Fp4Wmu7x9dqyZRhtdPmcY+IdWL/CR2a0NzNVwhexPJMtt+7GA2PgmmiPfIbsrQHC
	uFaGpChwhOQsg0iW1b3wd1+xAT3mS55FGdDqN7ToaejsOOWy9DqRoniTSKT5CvDdk=
X-Received: by 2002:a5d:4688:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-4603061e47amr24181243f8f.27.1781020516882;
        Tue, 09 Jun 2026 08:55:16 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm61091716f8f.37.2026.06.09.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:55:16 -0700 (PDT)
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
Subject: [PATCH v5] iio: tcs3472: implement wait time and sampling frequency
Date: Tue,  9 Jun 2026 17:55:15 +0200
Message-ID: <20260609155515.1004545-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a u8 enable_pre_suspend field to struct tcs3472_data:
tcs3472_powerdown() snapshots data->enable into it, and
tcs3472_resume() restores enable register content from the snapshot.
This preserves the user's WEN choice across suspend/resume.

Bound tcs3472_req_data() polling to the worst-case cycle time
(~8 seconds with ATIME=0x00, WTIME=0x00, WLONG=1).

Fix the event period calculation in tcs3472_read_event() and
tcs3472_write_event() to use tcs3472_cycle_time_us() instead of
ATIME alone. With WEN enabled, the chip cycle includes the wait
time now.

Remove the "TODO: wait time" comment at the top of the file.

Reported-by: Sashiko <sashiko@lists.linux.dev>
Closes: https://sashiko.dev/#/patchset/20260607112713.299968-1-aldocontelk%40gmail.com
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v5:
- Use MICROHZ_PER_HZ instead of USEC_PER_SEC in the cycle_us
  computation.
- Add TCS3472_ATIME_TO_US() helper macro for the ATIME-to-us
  conversion (Suggested-by: Andy Shevchenko).
- Add a comment explaining the cycle_us formula.
- Add a comment before the WLONG fallback explaining why wtime
  may be negative.
- Move clamp(wtime, 0, 255) after the WLONG handling, closer to
  the actual use of wtime, with a comment on the saturation
  semantics.
- Increase the polling tries from 400 to 500 to account for
  hardware oscillator tolerance.
- Fix the event period calculation in tcs3472_read_event() and
  tcs3472_write_event() to use tcs3472_cycle_time_us() instead
  of ATIME alone.

 drivers/iio/light/tcs3472.c | 320 +++++++++++++++++++++++++++++++++---
 1 file changed, 293 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 1f597ca93697..78fd9530630a 100644
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
@@ -19,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -53,19 +52,30 @@
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
+
+#define TCS3472_ATIME_TO_US(atime) (((256) - (atime)) * 2400)
 
 struct tcs3472_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	int target_freq_hz;
+	int target_freq_uhz;
 	u16 low_thresh;
 	u16 high_thresh;
 	u8 enable;
+	u8 enable_pre_suspend;
 	u8 control;
 	u8 atime;
 	u8 apers;
+	u8 wtime;
+	bool wlong;
 };
 
 static const struct iio_event_spec tcs3472_events[] = {
@@ -91,6 +101,7 @@ static const struct iio_event_spec tcs3472_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE) | \
 		BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.channel2 = IIO_MOD_LIGHT_##_color, \
 	.address = _addr, \
 	.scan_index = _si, \
@@ -114,9 +125,65 @@ static const struct iio_chan_spec tcs3472_channels[] = {
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
+	unsigned int atime_us = TCS3472_ATIME_TO_US(data->atime);
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
-	int tries = 50;
+	/*
+	 * The worst-case cycle time is reached with ATIME=0x00, WTIME=0x00
+	 * and WLONG=1. So:
+	 *   614 ms (Max Integration Time)
+	 * + 2.4 ms (RGBC Init)
+	 * + 7.37 s (Max Wait Time)
+	 * = ~ 8 s (Total Max cycle time).
+	 * Use that as a polling upper bound; in normal operation the loop
+	 * exits as soon as AVALID is set. So the total number of tries in 8
+	 * seconds considering a polling period of 20 ms is 400.
+	 * Considering a 20% margin due to oscillator tolerance, the total
+	 * duration becomes approximately 9.8 seconds, which corresponds to
+	 * about 480 steps. Therefore, setting it to 500 appears to be a
+	 * reasonable and safe trade-off.
+	 */
+	int tries = 500;
 	int ret;
 
 	while (tries--) {
@@ -164,18 +231,166 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
-		*val2 = (256 - data->atime) * 2400;
+		*val2 = TCS3472_ATIME_TO_US(data->atime);
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int cycle_us;
+
+		guard(mutex)(&data->lock);
+		cycle_us = tcs3472_cycle_time_us(data);
+		tcs3472_cycle_to_freq(cycle_us, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+/*
+ * __tcs3472_set_sampling_freq() - implementation of sampling frequency
+ * configuration. The caller must hold data->lock.
+ */
+static int __tcs3472_set_sampling_freq(struct tcs3472_data *data,
+				       int val, int val2)
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
+	atime_us = TCS3472_ATIME_TO_US(data->atime);
+
+	/*
+	 * cycle_us = 1 / freq, expressed in microseconds.
+	 * Numerator: 1 [s] = PSEC_PER_SEC [ps]
+	 * Denominator: freq [Hz] * MICROHZ_PER_HZ + val2 [uHz] = freq in [uHz]
+	 * Result: ps / uHz = us
+	 */
+	cycle_us = div64_u64(PSEC_PER_SEC,
+			     (u64)val * MICROHZ_PER_HZ + val2);
+
+	/*
+	 * wait_us can be negative when the requested frequency is too high
+	 * to be reached, or very large when the requested frequency is
+	 * close to zero. Use s64 to cover the full range:
+	 *
+	 *   cycle_us = PSEC_PER_SEC / (val * MICROHZ_PER_HZ + val2)
+	 *
+	 * The divisor of the formula above reaches its maximum when
+	 * val = val2 = INT_MAX:
+	 *  INT_MAX * MICROHZ_PER_HZ + INT_MAX = ~2.15e18
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
+	if (wait_us < 2400) {
+		if (data->enable & TCS3472_ENABLE_WEN) {
+			u8 enable = data->enable & ~TCS3472_ENABLE_WEN;
+
+			ret = i2c_smbus_write_byte_data(data->client,
+							TCS3472_ENABLE, enable);
+			if (ret)
+				return ret;
+
+			data->enable = enable;
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
+		u8 enable = data->enable | TCS3472_ENABLE_WEN;
+
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+						enable);
+		if (ret)
+			return ret;
+
+		data->enable = enable;
+	}
+
+	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
+	if (wtime < 0) {
+		/*
+		 * If wait_us is too high (so the requested frequency is too
+		 * low), the resulting wait exceeds what WTIME can represent
+		 * (max 614 ms without WLONG). Enable WLONG, whose step is 12x
+		 * longer (28.8 ms instead of 2.4 ms), and recompute.
+		 */
+		wlong = true;
+		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
+	}
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
+	/*
+	 * If the requested wait is so long that even WLONG cannot
+	 * cover it, wtime may still be negative. Saturate to 0,
+	 * which is the largest possible wait (256 * 28.8 ms = 7.37 s).
+	 */
+	wtime = clamp(wtime, 0, 255);
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
+static int tcs3472_set_sampling_freq(struct tcs3472_data *data,
+				     int val, int val2)
+{
+	guard(mutex)(&data->lock);
+	return __tcs3472_set_sampling_freq(data, val, val2);
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
@@ -196,15 +411,31 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
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
+			guard(mutex)(&data->lock);
+
+			ret = i2c_smbus_write_byte_data(data->client,
+							TCS3472_ATIME, i);
+			if (ret)
+				return ret;
+
+			data->atime = i;
+
+			/*
+			 * ATIME just changed, so the cycle time changed too.
+			 * Re-run the sampling frequency logic to recompute
+			 * WTIME and preserve the user's last requested
+			 * frequency. Lock is already held.
+			 */
+			return __tcs3472_set_sampling_freq(data,
+							 data->target_freq_hz,
+							 data->target_freq_uhz);
 		}
 		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return tcs3472_set_sampling_freq(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -234,7 +465,7 @@ static int tcs3472_read_event(struct iio_dev *indio_dev,
 			data->high_thresh : data->low_thresh;
 		return IIO_VAL_INT;
 	case IIO_EV_INFO_PERIOD:
-		period = (256 - data->atime) * 2400 *
+		period = tcs3472_cycle_time_us(data) *
 			tcs3472_intr_pers[data->apers];
 		*val = period / USEC_PER_SEC;
 		*val2 = period % USEC_PER_SEC;
@@ -279,11 +510,13 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 			data->low_thresh = val;
 
 		return 0;
-	case IIO_EV_INFO_PERIOD:
+	case IIO_EV_INFO_PERIOD:{
+		unsigned int cycle_us;
+
 		period = val * USEC_PER_SEC + val2;
+		cycle_us = tcs3472_cycle_time_us(data);
 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
-			if (period <= (256 - data->atime) * 2400 *
-					tcs3472_intr_pers[i])
+			if (period <= cycle_us * tcs3472_intr_pers[i])
 				break;
 		}
 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
@@ -293,6 +526,7 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 		data->apers = i;
 
 		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -434,17 +668,16 @@ static const struct iio_info tcs3472_info = {
 static int tcs3472_powerdown(struct tcs3472_data *data)
 {
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
 	guard(mutex)(&data->lock);
 
+	data->enable_pre_suspend = data->enable;
+
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-					data->enable & ~enable_mask);
+					data->enable & ~TCS3472_ENABLE_RUN);
 	if (ret)
 		return ret;
 
-	data->enable &= ~enable_mask;
-
 	return 0;
 }
 
@@ -458,7 +691,9 @@ static int tcs3472_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
+	unsigned int cycle_us;
 	int ret;
+	u8 enable;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -498,6 +733,16 @@ static int tcs3472_probe(struct i2c_client *client)
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
@@ -518,14 +763,30 @@ static int tcs3472_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* enable device */
-	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
-	data->enable &= ~TCS3472_ENABLE_AIEN;
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable);
+	/*
+	 * Enable the chip in its full running state, including WEN. The
+	 * actual wait time is controlled by the WTIME and WLONG registers,
+	 * which retain their power-on defaults until userspace writes to
+	 * sampling_frequency.
+	 */
+	enable = (ret | TCS3472_ENABLE_RUN) & ~TCS3472_ENABLE_AIEN;
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, enable);
 	if (ret < 0)
 		return ret;
 
+	data->enable = enable;
+
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
@@ -561,16 +822,21 @@ static int tcs3472_resume(struct device *dev)
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
 	guard(mutex)(&data->lock);
 
+	/*
+	 * Restore the full ENABLE register from the snapshot taken in
+	 * tcs3472_powerdown(). This preserves the user's last
+	 * sampling_frequency configuration (in particular the WEN bit)
+	 * across suspend/resume.
+	 */
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable | enable_mask);
+					data->enable_pre_suspend);
 	if (ret)
 		return ret;
 
-	data->enable |= enable_mask;
+	data->enable = data->enable_pre_suspend;
 
 	return 0;
 }
-- 
2.54.0

