Received: from outbound3.mail.transip.nl (outbound3.mail.transip.nl [136.144.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19E3DCD98;
	Fri,  5 Jun 2026 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649198; cv=none; b=cNXmAY49OJAzb+qDd9yzCZXT2OoIJOQgTzEeBFuWi16slRgr+Ood5Qraa1KOlrErPCv5qKdsRbAsvI6Mbr8Nomm6BEq8YqmJvOOrybFlppTlp0B+hyBN+dYrtE7jMvUdku3oLNtu2UFkp5KywGU4Ow07tZTOFYOtECMDx1I39D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649198; c=relaxed/simple;
	bh=LAKDfQzMQDaduL5RTNE0ZZf/tpqxXLoZAgnQCgtoMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErhCaDtF+vP2DwiKTqdtWUb8XYWOsyOx6fVCDu06eym9CTAWNmhRjm0K9vcG/1pR8oOxSN4uR+g82p0WyziydiIX9ZAU4rCS0PgVv6vR5RhM8rhrFT552S5iqoba45BS2Gh4t0O5/oc7lmvsohyLv/oVArfXcGs2O+eo/jqQRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=LfCdJfF9; arc=none smtp.client-ip=136.144.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="LfCdJfF9"
Received: from submission3.mail.transip.nl (unknown [10.100.4.72])
	by outbound3.mail.transip.nl (Postfix) with ESMTP id 4gWw5V0wNFzn2vp;
	Fri,  5 Jun 2026 10:46:22 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission3.mail.transip.nl (Postfix) with ESMTPA id 4gWw5T44gWzf52bM;
	Fri,  5 Jun 2026 10:46:21 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH] iio: gyro: mpu3050: read gyro samples via FIFO in IIO_CHAN_INFO_RAW
Date: Fri,  5 Jun 2026 10:46:21 +0200
Message-ID: <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780648724.git.github.com@herrie.org>
References: <cover.1780648724.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission3.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780649181; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=Uhbu0h+GPCyJpOSDbaDjXY9H/cpd4Skvuu47N+L2tyQ=;
 b=LfCdJfF9Jd9RUsze0TJMbCcFnaKEs3LOdtJohxcBSjX6Wn0rh7DDi8httPi3DJcGtZuuEf
 N7tI7W5Jy7T/ztI1jrPwkdbvtodEVyQM3zuMF6pT5+0WRrnQf4ekTCWBbd9aZdu0vNUibE
 ZQGs8z9wDNto1oGZBF00dJiG8w2GfMYzZiTyfpn++NN7dOAbw7hfu+0wlJt7sbpZB85CvX
 z+GIa3PlP3AAEZDuQHv5sa5e78qf3Jjd7nLW1MkZM5tAAeWb4vljvhaeeIhAu761Qc8ibG
 JsdHSUDpendZ46qbe0IZUQ01f7v6Mu3RWO2ZLWQhfePpUWO1ndrY51tjdmc+Fw==
X-Report-Abuse-To: abuse@transip.nl

The direct gyro register file (XOUT_H..ZOUT_L) returns stale data on
at least the HP TouchPad (apq8060): X high byte is stuck at 0xFF and
Z reads as 0x0000 even when the chip is otherwise sampling and the
userspace i2c-dev path returns sensible values for the same chip from
the same registers. Y reads correctly, suggesting the issue is in how
the on-die register file responds to back-to-back two-byte reads at
specific offsets after the reset / PLL settle that
mpu3050_set_8khz_samplerate() performs immediately before the read.

The chip's on-chip FIFO does not have this hazard because the sample
assembly is performed inside the chip and the host only reads a fully
formed frame from FIFO_R.

Add a small mpu3050_fifo_read_one() helper that:

  - lowers DLPF/SMPLRT to ~250 Hz so exactly one fresh sample lands
    in the FIFO during the wait loop (at the previously-set 8 kHz the
    FIFO accumulates a sample every 125 us and races the FIFO_COUNT_H
    / FIFO_R bulk reads, producing per-axis byte hazards even though
    the oldest 6 bytes are nominally a clean frame);
  - configures FIFO_EN for gyro X / Y / Z only (the FIFO-captured
    TEMP slot occasionally returns stale data while gyro words are
    still consistent; mpu3050_read_raw() reads TEMP_H/L directly
    instead);
  - resets the FIFO and enables FIFO read-out in a single
    USR_CTRL write so the chip atomically resets the write pointer
    with capture already on (two separate writes leave the FIFO in a
    brief transient state where the first sample after re-enable can
    land at a non-zero offset, producing per-byte-shifted frames in
    the readback);
  - waits for one 6-byte sample to land with a generous retry loop;
  - reads one 6-byte X / Y / Z frame from FIFO_R;
  - tears the FIFO capture down so subsequent buffered/triggered
    reads aren't confused by stale FIFO_EN bits.

Route IIO_CHAN_INFO_RAW through this helper for IIO_ANGL_VEL. IIO_TEMP
keeps its existing direct TEMP_H/L read because that register is not
affected by the gyro register-file hazard, and the FIFO-captured TEMP
slot occasionally diverges from the live register by several degrees.
The triggered-buffer path (mpu3050_trigger_handler()) is unchanged
and continues to manage the FIFO itself when the hardware interrupt
trigger is active.

The chip is left at ~250 Hz when the helper returns; mpu3050->lpf and
mpu3050->divisor are unchanged so the sysfs in_anglvel_sampling_-
frequency value resolved via mpu3050_get_freq() keeps reporting the
user-configured rate. The next caller of mpu3050_set_8khz_samplerate()
(any subsequent IIO_CHAN_INFO_RAW read, or the buffered-mode enable
path, or a companion runtime_resume fix sent as a separate patch)
issues a full chip reset and reprograms the hardware from cached
state.

Test results on the HP TouchPad with the chip lying flat, 15
IIO_CHAN_INFO_RAW reads at 200 ms intervals:

  Before this patch (direct XOUT_H/YOUT_H/ZOUT_H reads):
    X = 255             (high byte stuck at 0xFF, permanently)
    Y = -99             (works)
    Z = 0               (low/high bytes both 0x00, permanently)

  After this patch (FIFO read path):
    X = -95..-156       (span 61, mean -127)
    Y =  46..80         (span 34, mean  61)
    Z = -15..23         (span 38, mean   3)
    TEMP = -13440..-13552  (span 112, stable)

Steady-state per-read latency is ~89 ms, dominated by the existing
mpu3050_set_8khz_samplerate() reset + msleep(50) before the FIFO
helper.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/iio/gyro/mpu3050-core.c | 162 ++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..be87053dba54 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -260,6 +260,141 @@ static int mpu3050_set_8khz_samplerate(struct mpu3050 *mpu3050)
 	return ret;
 }
 
+/*
+ * mpu3050_fifo_read_one() - capture and return one combined sample frame
+ *
+ * The MPU-3050's direct gyro register file (XOUT_H..ZOUT_L) exhibits a
+ * stale-byte hazard on at least the apq8060 i2c controller path: on
+ * many devices the first byte of the X high register and the entire Z
+ * pair return constant 0xFF / 0x0000 even when the chip is otherwise
+ * sampling and the userspace i2c-dev path returns sensible values.
+ *
+ * The chip's on-chip FIFO does not have this problem because the
+ * sample assembly happens inside the chip and the host only reads a
+ * fully-formed frame from FIFO_R. Configure the FIFO to capture TEMP
+ * plus all three gyro axes (8 bytes per sample, no footer), drain any
+ * stale data with a FIFO reset, wait one sample period, then read a
+ * single complete frame.
+ */
+/*
+ * Size of one FIFO sample frame captured by mpu3050_fifo_read_one():
+ * three big-endian s16 gyro words (X, Y, Z). Temperature is read
+ * separately from its register file because the FIFO-captured TEMP
+ * occasionally returns a stale/partial value while gyro words remain
+ * consistent.
+ */
+#define MPU3050_FIFO_FRAME_BYTES	6
+
+static int mpu3050_fifo_read_one(struct mpu3050 *mpu3050, __be16 frame[3])
+{
+	__be16 raw_count;
+	u16 fifocnt;
+	int retries;
+	int cleanup_err;
+	int ret;
+
+	/*
+	 * Slow the chip down to 250 Hz for the duration of this read so
+	 * exactly one fresh sample lands in the FIFO during the wait below.
+	 * At the previously-set 8 kHz the FIFO accumulates a sample every
+	 * 125 us and can race the bulk_read of FIFO_COUNT_H / FIFO_R,
+	 * producing per-axis byte hazards in the readback even though the
+	 * oldest 8 bytes are nominally a clean frame.
+	 *
+	 * The chip is left at 250 Hz when this function returns; the next
+	 * caller will run mpu3050_set_8khz_samplerate() again (which does
+	 * a full chip reset) so there is nothing to restore here.
+	 * mpu3050->lpf and mpu3050->divisor remain the user-configured
+	 * values across this function, so sysfs
+	 * in_anglvel_sampling_frequency continues to report the right
+	 * thing via mpu3050_get_freq().
+	 */
+	ret = regmap_write(mpu3050->map, MPU3050_DLPF_FS_SYNC,
+			   mpu3050->fullscale << MPU3050_FS_SHIFT |
+			   MPU3050_DLPF_CFG_20HZ);
+	if (ret)
+		goto disable;
+	ret = regmap_write(mpu3050->map, MPU3050_SMPLRT_DIV, 3);
+	if (ret)
+		goto disable;
+
+	/*
+	 * Capture only gyro X, Y, Z into the FIFO. The temperature slot
+	 * is deliberately omitted: the chip occasionally writes a stale
+	 * TEMP_H/L pair into the FIFO that differs from the live register
+	 * by ~7C, and there's no obvious sync the host can use to detect
+	 * which samples are affected. Reading TEMP straight from the
+	 * register file (which mpu3050_read_raw() does for IIO_TEMP) does
+	 * not have this hazard.
+	 */
+	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
+			   MPU3050_FIFO_EN_GYRO_XOUT |
+			   MPU3050_FIFO_EN_GYRO_YOUT |
+			   MPU3050_FIFO_EN_GYRO_ZOUT);
+	if (ret)
+		goto disable;
+
+	/*
+	 * Enable FIFO read-out and assert FIFO_RST in a single write so the
+	 * chip atomically resets the write pointer with capture already on.
+	 * Two separate writes (FIFO_RST then FIFO_EN) leave the FIFO in a
+	 * brief transient state where the first sample after re-enable can
+	 * land at a non-zero offset, producing per-byte-shifted frames in
+	 * the readback below. This matches the mpu3050_trigger_handler()
+	 * pattern.
+	 */
+	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
+			   MPU3050_USR_CTRL_FIFO_EN |
+			   MPU3050_USR_CTRL_FIFO_RST);
+	if (ret)
+		goto disable;
+
+	/*
+	 * Wait for at least one sample to land. At 250 Hz that's nominally
+	 * 4 ms; the retry loop gives a generous margin so a stretched i2c
+	 * clock or NEW sample-rate-change settle time doesn't trip the
+	 * timeout.
+	 */
+	for (retries = 0; retries < 10; retries++) {
+		usleep_range(2000, 4000);
+		ret = regmap_bulk_read(mpu3050->map, MPU3050_FIFO_COUNT_H,
+				       &raw_count, sizeof(raw_count));
+		if (ret)
+			goto disable;
+		fifocnt = be16_to_cpu(raw_count);
+		if (fifocnt >= MPU3050_FIFO_FRAME_BYTES)
+			break;
+	}
+
+	if (fifocnt < MPU3050_FIFO_FRAME_BYTES) {
+		dev_dbg(mpu3050->dev, "FIFO timeout (%u bytes)\n", fifocnt);
+		ret = -ETIMEDOUT;
+		goto disable;
+	}
+
+	ret = regmap_bulk_read(mpu3050->map, MPU3050_FIFO_R, frame,
+			       MPU3050_FIFO_FRAME_BYTES);
+
+disable:
+	/*
+	 * Tear FIFO capture down so the next _raw read starts clean and a
+	 * subsequent buffered/triggered mode setup isn't confused by stale
+	 * FIFO_EN bits. Cleanup write failures are logged but not
+	 * propagated: we prefer to return the original read error (if
+	 * any) rather than mask it with a teardown error, and there is no
+	 * useful recovery path from a transport failure here anyway.
+	 */
+	cleanup_err = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
+	if (cleanup_err)
+		dev_dbg(mpu3050->dev,
+			"FIFO_EN teardown write failed: %d\n", cleanup_err);
+	cleanup_err = regmap_write(mpu3050->map, MPU3050_USR_CTRL, 0);
+	if (cleanup_err)
+		dev_dbg(mpu3050->dev,
+			"USR_CTRL teardown write failed: %d\n", cleanup_err);
+	return ret;
+}
+
 static int mpu3050_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2,
@@ -267,6 +402,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 	int ret;
+	__be16 frame[3];
 	__be16 raw_val;
 
 	switch (mask) {
@@ -333,6 +469,13 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 
 		switch (chan->type) {
 		case IIO_TEMP:
+			/*
+			 * TEMP_H/L is read directly from the register file.
+			 * The FIFO-captured TEMP slot occasionally returns
+			 * stale data while gyro words are still consistent,
+			 * so we deliberately do not pipe TEMP through the
+			 * FIFO path used by IIO_ANGL_VEL below.
+			 */
 			ret = regmap_bulk_read(mpu3050->map, MPU3050_TEMP_H,
 					       &raw_val, sizeof(raw_val));
 			if (ret) {
@@ -340,25 +483,24 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 					"error reading temperature\n");
 				goto out_read_raw_unlock;
 			}
-
 			*val = (s16)be16_to_cpu(raw_val);
 			ret = IIO_VAL_INT;
-
 			goto out_read_raw_unlock;
 		case IIO_ANGL_VEL:
-			ret = regmap_bulk_read(mpu3050->map,
-				       MPU3050_AXIS_REGS(chan->scan_index-1),
-				       &raw_val,
-				       sizeof(raw_val));
+			ret = mpu3050_fifo_read_one(mpu3050, frame);
 			if (ret) {
 				dev_err(mpu3050->dev,
-					"error reading axis data\n");
+					"error reading sample frame from FIFO: %d\n",
+					ret);
 				goto out_read_raw_unlock;
 			}
-
-			*val = be16_to_cpu(raw_val);
+			/*
+			 * frame[0..2] = XOUT/YOUT/ZOUT in the order the chip
+			 * packs gyro words into the FIFO. scan_index is 1..3
+			 * for X/Y/Z so subtract one to land on the frame.
+			 */
+			*val = (s16)be16_to_cpu(frame[chan->scan_index - 1]);
 			ret = IIO_VAL_INT;
-
 			goto out_read_raw_unlock;
 		default:
 			ret = -EINVAL;
-- 
2.43.0

