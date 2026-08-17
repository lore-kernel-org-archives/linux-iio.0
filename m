Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB294657EA
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986500; cv=none; b=Re1sOXEuDyyZVy64emyx6TEAlmQVBEF3U4zLiMZ/wCRXcwhQWqDNWJzTLYhiSXc+yFE7OSI9xsnvgzjvMliI3axvfyPjNoHp6muM9BqpcGizZxhD8tgmWEY0jqJeGXn57dITPDMWfrpzxHEQyZ5kREhB+1Yg6G69JmerLFus40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986500; c=relaxed/simple;
	bh=N1xD8krKnHK5na4SLrnNTQwU9ig0FMp7wmdvaxTlqQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyj/xXOxkCWVfBERy7Bxlscv8JiCFuxj60YCCRUvn+hfxn2x4ODQGscD8H2+PgK70nwTXE7jtZii/2qvcA1QfD5hwm/Kqcs+4wCUPIkl1fJgUKEbQp5kX0taOsaWE63QIm9LLnnZTL0T5SK5jc+tfOguSH11tp/d+v1D+Qskrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+Jc/Rqe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+Jc/Rqe"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so44193131fa.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986496; x=1787591296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHsObEtbSuRZN9bKJ22xjd0JtKFsDuiOyCfU/kVCApU=;
        b=f+Jc/Rqew71DqTFIUQbMI+ZoOXLsqKlQata+c8gbYRI8zFjCGgTLO7k5qCQAgz1gEN
         bERevJX62Ac8J6shgTpYoLa6bTOFhYCAWOX+go1LLVVPFURKTkMyuFQ7w74jVVxyuqke
         4/EZrX/Qu32xjIyA0Zot89WpgzsH6Xcfc+wUPyLeCgHH99w/iUWCOtacT+HRgdtnIsoN
         LEDhDQdM8QWsffPD+baKgvM+0SDUk7rwmBEM/REoO4KeGMqfXDThoTq8ryBE0EcRFakB
         AOHy1tmgQTutZl44JUUYOypB0pwGasGlW20mJDIyXubQPd3nF6WnB5Hfly579eJ8PWNY
         xdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986496; x=1787591296;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHsObEtbSuRZN9bKJ22xjd0JtKFsDuiOyCfU/kVCApU=;
        b=JuIyTwiajEGKZ9QoQFDt9QSy+GLDxLyIY9osKSpAdL6XVz8+wW+O2O6YV13CybyRVL
         p9MBzCNbNRi6uYqTknwMxUHi/jClUknjomLeMZq7Xa8mKZpBTB3Pkx/JjysrmXq8ERKA
         bEAxpKtTRnd2j6MxbiVpiKrinBQWAxx/RUWY8a4qTBuz0tQXQT79CjRVi79pzJOPzBwt
         +dHEf9wnDnMqhALrCjKSHuV+0YMz5R3RxKajLoU1NxtU+rpbQu773giVNdZUOxw79fzF
         DvtDHemHJEexvuG7T3GSvGeB10wbWGDJVhKnQ9asCH6nKE16T0tWfJiXMnLsBDJVjXyX
         I09Q==
X-Gm-Message-State: AOJu0YxWGWisFXu/sfhjXL6PzKEa098JCzQo4rFUoyB9xTOkDCuKJnkC
	qMZvhHQ/oey0G5twAT9zJJxLwVNAylzmIsnlN1gyIDDSa0CUarjoS1Ix
X-Gm-Gg: AR+sD13qRTiSy2/dR9d+3ZvTmJ/hNjS5FchT50X9mRyEk3OM2P3n9Jj7GEYVpkiLpLB
	w3qei25iBW8ExoCrv41bfJ2AhUKK0dx7bYKCbgma9U9i55c9s/6FAeCYOkP79Fh5/xgtcmKWAwG
	U4jXkrABXa5lecKbvRiS3/EGoBkhMndYoDVXhiZ2zlaP9VTQtpqui00rSxCr+xkbHixaHJ0ucEI
	bqYYYSR6XH0CZPua6CuuXPnXjcr8tFcxmLri/Y1DLI/6bIrQrSz/MQ7DtYu/WWB4YDNoq0UDmcx
	dUrpg9qW2vbHAmavEGLIG/aU3MlX5R7TA2qxjZ4Ju0nQu1+QDKJckypMaIl1BnwTY0L/MNbdNyg
	89MulFbaOJa5HW4dSBI8p9oU2wBFtDL0oArH+zMpJq9ks3qTFGLuN06gMMRjuo5VHMawoHei1SX
	vAP81CzM+fKFH1JIJuLdKL+MylArYpz0KVAf3TYKuz0YnFwjQZkAQTUVTA9BZDYCJzp6h5mFsKH
	y8jPrWFzez4YALQML+N5Kkm7PGXpfjAIdJVvUFPuUfy0dI2psab/QODv4Q=
X-Received: by 2002:a2e:bea5:0:b0:39c:6d3a:2dd7 with SMTP id 38308e7fff4ca-3a1324b3f12mr27243991fa.17.1786986495816;
        Mon, 17 Aug 2026 10:08:15 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e54casm6053841fa.15.2026.08.17.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:08:15 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v5 3/3] iio: pressure: dps310: add hardware FIFO support
Date: Mon, 17 Aug 2026 20:07:25 +0300
Message-ID: <20260817170725.1074078-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817170725.1074078-1-zoone.rupert@gmail.com>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DPS310 has a 32 entry FIFO, shared between the pressure and
temperature streams, which the driver has never used. Enable it for
buffered capture so a reader is woken once per batch of samples rather
than once per sample.

The FIFO is used when no external trigger is attached, and left disabled
in favor of the trigger when one is. That selection needs no policy of
its own: iio_verify_update() already picks INDIO_BUFFER_TRIGGERED when a
trigger is present and INDIO_BUFFER_SOFTWARE when it is not, so both
modes are advertised and the buffer setup ops branch on
iio_device_get_current_mode(). This follows
drivers/iio/pressure/rohm-bm1390.c.

The drain is timer driven rather than interrupt driven. The binding has
no interrupts property and no in-tree device tree wires the INT pin, so
there is no interrupt to use. hwfifo_flush_to_buffer alone is not enough
either: iio_buffer_read() sleeps on rb->pollq with no timeout and only a
push wakes it, so a blocking reader would hang with samples sitting in
the hardware. The flush hook is still provided so poll() and
non-blocking readers can pull early. It stops at the read rather than
after it when the caller limits the count, because entries leave the
hardware as they are read and any collected past the limit would have to
be discarded.

Because the hardware stops recording when the FIFO is full instead of
overwriting, a late drain loses the newest samples rather than the
oldest, so the interval is kept below half the time the FIFO takes to
fill. The DPS310 has no configurable hardware watermark, only a
FIFO-full condition, so the value passed to hwfifo_set_watermark() is
taken as the number of scans the user is prepared to wait for and bounds
the interval from the other side.

Entries carry no timestamps. They are synthesised by working back from
the drain at the configured sample period, anchored so that a batch
never starts before the previous one ended. Where a drain collected more
than the configured rate accounts for, the batch is spread across the
window instead so the timestamps stay monotonic. These are estimates,
not hardware timestamps.

Every entry is read through the pressure registers whichever measurement
produced it, with the type tagged in the LSB and 0x800000 returned once
the FIFO is empty. Pressure entries drive the scans and reuse the most
recent temperature entry for compensation, which keeps the two
configured rates independent; pressure entries arriving before any
temperature cannot be compensated and are dropped. With only the
temperature channel enabled there is nothing to pair with, so
temperature drives the scans itself, and both the drain and the
watermark-to-interval conversion follow whichever rate is driving.

The file header still claimed only a single temperature read was
supported, which this patch is the last word against, so it goes too.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 413 +++++++++++++++++++++++++++++++++-
 1 file changed, 404 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0d6e65766469..0a93c64d6db5 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -2,16 +2,11 @@
 // Copyright IBM Corp 2019
 /*
  * The DPS310 is a barometric pressure and temperature sensor.
- * Currently only reading a single temperature is supported by
- * this driver.
  *
  * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
  *
  * Temperature calculation:
  *   c0 * 0.5 + c1 * T_raw / kT °C
- *
- * TODO:
- *  - Optionally support the FIFO
  */
 
 #include <linux/i2c.h>
@@ -19,6 +14,8 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
+#include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -57,9 +54,31 @@
 #define  DPS310_FIFO_EN		BIT(1)
 #define  DPS310_SPI_EN		BIT(0)
 #define DPS310_RESET		0x0c
+#define  DPS310_FIFO_FLUSH	BIT(7)
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
+/*
+ * Section 4.8: the FIFO holds 32 entries shared between the pressure and
+ * temperature streams, and stops recording once full rather than overwriting.
+ * A late drain therefore loses the newest samples, not the oldest.
+ */
+#define DPS310_FIFO_DEPTH	32
+
+/* Read back in place of a sample once the FIFO has been drained */
+#define DPS310_FIFO_EMPTY_VAL	0x800000
+
+/* The LSB of a FIFO entry tags which measurement produced it */
+#define DPS310_FIFO_TAG_PRS	BIT(0)
+
+/*
+ * Bounds on the drain interval. The lower bound keeps a fast rate from
+ * flooding the workqueue; the upper bound keeps the FIFO from filling while
+ * nothing is looking at it.
+ */
+#define DPS310_DRAIN_MIN_MS	20
+#define DPS310_DRAIN_MAX_MS	2000
+
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
@@ -93,6 +112,15 @@ struct dps310_data {
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
+
+	/* FIFO capture state, used only while the hardware FIFO is enabled */
+	struct iio_dev *iio;
+	struct delayed_work fifo_work;
+	unsigned int watermark;
+	unsigned int drain_interval_ms;
+	s64 fifo_timestamp;
+	s32 fifo_temp_raw;
+	bool fifo_temp_valid;
 };
 
 enum dps310_scan_index {
@@ -962,6 +990,344 @@ static int dps310_fill_scan(struct iio_dev *iio, u8 *buffer)
 	return 0;
 }
 
+/* Called with lock held */
+static int dps310_fifo_hw_flush(struct dps310_data *data)
+{
+	return regmap_write(data->regmap, DPS310_RESET, DPS310_FIFO_FLUSH);
+}
+
+/* Called with lock held */
+static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
+{
+	return regmap_write_bits(data->regmap, DPS310_CFG_REG, DPS310_FIFO_EN,
+				 enable ? DPS310_FIFO_EN : 0);
+}
+
+/*
+ * There is no interrupt wired on any in-tree platform and the binding has no
+ * interrupts property, so the FIFO is drained on a timer. The interval has to
+ * stay below the time the FIFO takes to fill, because the hardware stops
+ * recording when full instead of overwriting: draining late loses the newest
+ * samples rather than the oldest.
+ *
+ * Called with lock held.
+ */
+static int dps310_fifo_interval(struct dps310_data *data, unsigned int *ms)
+{
+	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
+					 data->iio->active_scan_mask);
+	unsigned int fill_ms, want_ms;
+	int rc, prs_rate, tmp_rate;
+
+	rc = dps310_get_pres_samp_freq(data, &prs_rate);
+	if (rc)
+		return rc;
+
+	rc = dps310_get_temp_samp_freq(data, &tmp_rate);
+	if (rc)
+		return rc;
+
+	/* Both streams share the same entries, so they fill it together. */
+	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
+
+	/*
+	 * The DPS310 has no configurable hardware watermark, only a FIFO-full
+	 * condition, so the watermark is taken as the number of scans the user
+	 * is prepared to wait for and drives the drain interval instead. Scans
+	 * come at the rate of whichever measurement drives them, which is not
+	 * the pressure rate when only the temperature channel is enabled.
+	 */
+	want_ms = data->watermark * MSEC_PER_SEC /
+		  (pressure_enabled ? prs_rate : tmp_rate);
+
+	*ms = clamp_t(unsigned int, min(want_ms, fill_ms / 2),
+		      DPS310_DRAIN_MIN_MS, DPS310_DRAIN_MAX_MS);
+
+	return 0;
+}
+
+/*
+ * Read a single FIFO entry. Returns 1 if a sample was read, 0 once the FIFO is
+ * empty, or a negative error. Called with lock held.
+ */
+static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value,
+				  bool *is_pressure)
+{
+	u8 val[3];
+	s32 raw;
+	int rc;
+
+	/*
+	 * Every entry is read through the pressure registers regardless of
+	 * which measurement produced it, with the type tagged in the LSB.
+	 */
+	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
+	if (rc < 0)
+		return rc;
+
+	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	if (raw == DPS310_FIFO_EMPTY_VAL)
+		return 0;
+
+	*is_pressure = raw & DPS310_FIFO_TAG_PRS;
+	*value = sign_extend32(raw, 23);
+
+	return 1;
+}
+
+/* Called with lock held */
+static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
+				 s32 pressure_raw, s64 timestamp)
+{
+	struct iio_dev *iio = data->iio;
+	u8 buffer[16] __aligned(8) = { };
+	int pos = 0, rc;
+	s32 value;
+
+	/*
+	 * The compensation helpers read the cached raw values. Sysfs reads take
+	 * the direct-mode claim, so they cannot be looking at these while a
+	 * buffered capture is running.
+	 */
+	data->temp_raw = temp_raw;
+	data->pressure_raw = pressure_raw;
+
+	if (test_bit(DPS310_SCAN_TEMP, iio->active_scan_mask)) {
+		rc = dps310_calculate_temp(data, &value);
+		if (rc)
+			return rc;
+
+		memcpy(&buffer[pos], &value, sizeof(value));
+		pos += sizeof(value);
+	}
+
+	if (test_bit(DPS310_SCAN_PRESSURE, iio->active_scan_mask)) {
+		rc = dps310_calculate_pressure(data, &value);
+		if (rc)
+			return rc;
+
+		memcpy(&buffer[pos], &value, sizeof(value));
+	}
+
+	iio_push_to_buffers_with_ts(iio, buffer, sizeof(buffer), timestamp);
+
+	return 0;
+}
+
+/*
+ * Drain the FIFO and push the samples it held, stopping once max_scans scans
+ * are in hand or draining everything when max_scans is zero. Stopping at the
+ * read rather than after it matters: entries leave the hardware as they are
+ * read, so any collected beyond the caller's limit would have to be discarded.
+ *
+ * Returns the number of scans pushed. Called with lock held.
+ */
+static int dps310_fifo_drain(struct dps310_data *data, s64 now,
+			     unsigned int max_scans)
+{
+	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
+					 data->iio->active_scan_mask);
+	bool temp_valid = data->fifo_temp_valid;
+	bool is_pressure[DPS310_FIFO_DEPTH];
+	s32 raw[DPS310_FIFO_DEPTH];
+	unsigned int i, n = 0, scans = 0, pushed = 0;
+	s64 interval, first;
+	int rc, rate;
+
+	/*
+	 * Empty the hardware first and compensate afterwards, so the time spent
+	 * in the polynomial is not time the FIFO spends filling.
+	 *
+	 * Pressure entries drive the scans and reuse the most recent
+	 * temperature, so the two rates stay independent; entries arriving
+	 * before any temperature cannot be compensated and are dropped. With
+	 * only the temperature channel enabled there is nothing to pair with
+	 * and temperature drives the scans itself.
+	 */
+	for (i = 0; i < DPS310_FIFO_DEPTH; i++) {
+		rc = dps310_fifo_read_entry(data, &raw[n], &is_pressure[n]);
+		if (rc < 0)
+			return rc;
+		if (!rc)
+			break;
+
+		if (!is_pressure[n]) {
+			temp_valid = true;
+			if (!pressure_enabled)
+				scans++;
+		} else if (pressure_enabled && temp_valid) {
+			scans++;
+		}
+		n++;
+
+		if (max_scans && scans >= max_scans)
+			break;
+	}
+
+	if (!scans)
+		return 0;
+
+	/*
+	 * FIFO entries carry no timestamps. They are synthesised by working
+	 * back from the drain with the configured period of whichever
+	 * measurement drives the scans, so the spacing matches the sampling
+	 * frequency the user asked for instead of varying with how much each
+	 * drain happened to collect. These are estimates, not hardware
+	 * timestamps.
+	 */
+	rc = pressure_enabled ? dps310_get_pres_samp_freq(data, &rate) :
+				dps310_get_temp_samp_freq(data, &rate);
+	if (rc)
+		return rc;
+
+	interval = div_s64(NSEC_PER_SEC, rate);
+	first = now - (s64)(scans - 1) * interval;
+
+	/*
+	 * A batch must not start before the previous one ended, or the buffer
+	 * would carry timestamps that go backwards. If this drain collected
+	 * more than the configured rate accounts for, spread it across the
+	 * window since the last sample instead.
+	 */
+	if (data->fifo_timestamp && first <= data->fifo_timestamp) {
+		interval = max_t(s64, div_s64(now - data->fifo_timestamp, scans), 1);
+		first = data->fifo_timestamp + interval;
+	}
+
+	for (i = 0; i < n; i++) {
+		s64 timestamp;
+
+		if (!is_pressure[i]) {
+			data->fifo_temp_raw = raw[i];
+			data->fifo_temp_valid = true;
+
+			if (pressure_enabled)
+				continue;
+		} else if (!pressure_enabled || !data->fifo_temp_valid) {
+			continue;
+		}
+
+		timestamp = first + (s64)pushed * interval;
+
+		rc = dps310_fifo_push_scan(data,
+					   is_pressure[i] ? data->fifo_temp_raw
+							  : raw[i],
+					   is_pressure[i] ? raw[i] : 0,
+					   timestamp);
+		if (rc)
+			return rc;
+
+		data->fifo_timestamp = timestamp;
+		pushed++;
+	}
+
+	return pushed;
+}
+
+static void dps310_fifo_work(struct work_struct *work)
+{
+	struct dps310_data *data = container_of(to_delayed_work(work),
+						struct dps310_data, fifo_work);
+	int rc;
+
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_fifo_drain(data, iio_get_time_ns(data->iio), 0);
+
+	if (rc < 0)
+		dev_dbg(&data->client->dev, "FIFO drain failed: %d\n", rc);
+
+	schedule_delayed_work(&data->fifo_work,
+			      msecs_to_jiffies(data->drain_interval_ms));
+}
+
+static int dps310_hwfifo_set_watermark(struct iio_dev *iio, unsigned int val)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	data->watermark = clamp_t(unsigned int, val, 1, DPS310_FIFO_DEPTH);
+
+	return 0;
+}
+
+static int dps310_hwfifo_flush(struct iio_dev *iio, unsigned int count)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+
+	/*
+	 * With a trigger attached the FIFO is left disabled, and the pressure
+	 * registers then hold the latest measurement rather than queued entries
+	 * with an empty marker to stop on. There is nothing to drain.
+	 */
+	if (iio_device_get_current_mode(iio) != INDIO_BUFFER_SOFTWARE)
+		return 0;
+
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_fifo_drain(data, iio_get_time_ns(iio), count);
+
+	return rc;
+}
+
+static int dps310_buffer_postenable(struct iio_dev *iio)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+
+	/*
+	 * An attached trigger drives the capture instead, so the FIFO stays
+	 * disabled and the two never both feed the buffer.
+	 */
+	if (iio_device_get_current_mode(iio) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	data->fifo_temp_valid = false;
+	data->fifo_timestamp = 0;
+
+	rc = dps310_fifo_interval(data, &data->drain_interval_ms);
+	if (rc)
+		return rc;
+
+	/* Drop whatever accumulated before the buffer was enabled */
+	rc = dps310_fifo_hw_flush(data);
+	if (rc)
+		return rc;
+
+	rc = dps310_fifo_set_enable(data, true);
+	if (rc)
+		return rc;
+
+	schedule_delayed_work(&data->fifo_work,
+			      msecs_to_jiffies(data->drain_interval_ms));
+
+	return 0;
+}
+
+static int dps310_buffer_predisable(struct iio_dev *iio)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+
+	if (iio_device_get_current_mode(iio) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	cancel_delayed_work_sync(&data->fifo_work);
+
+	guard(mutex)(&data->lock);
+
+	rc = dps310_fifo_set_enable(data, false);
+	if (rc)
+		return rc;
+
+	return dps310_fifo_hw_flush(data);
+}
+
+static const struct iio_buffer_setup_ops dps310_buffer_setup_ops = {
+	.postenable = dps310_buffer_postenable,
+	.predisable = dps310_buffer_predisable,
+};
+
 static irqreturn_t dps310_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -994,6 +1360,17 @@ static void dps310_reset(void *action_data)
 	dps310_reset_wait(data);
 }
 
+/*
+ * The drain reschedules itself, so make sure it is stopped before the device
+ * goes away even if the buffer was never disabled cleanly.
+ */
+static void dps310_cancel_fifo_work(void *action_data)
+{
+	struct dps310_data *data = action_data;
+
+	cancel_delayed_work_sync(&data->fifo_work);
+}
+
 static const struct regmap_config dps310_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1006,6 +1383,8 @@ static const struct regmap_config dps310_regmap_config = {
 static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
+	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
 };
 
 static int dps310_probe(struct i2c_client *client)
@@ -1021,13 +1400,22 @@ static int dps310_probe(struct i2c_client *client)
 
 	data = iio_priv(iio);
 	data->client = client;
+	data->iio = iio;
+	data->watermark = 1;
 	mutex_init(&data->lock);
+	INIT_DELAYED_WORK(&data->fifo_work, dps310_fifo_work);
 
 	iio->name = id->name;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
-	iio->modes = INDIO_DIRECT_MODE;
+	/*
+	 * Both buffer modes are advertised so that iio_verify_update() picks
+	 * INDIO_BUFFER_TRIGGERED when a trigger is attached and falls back to
+	 * INDIO_BUFFER_SOFTWARE, which the FIFO path uses, when one is not.
+	 */
+	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED |
+		     INDIO_BUFFER_SOFTWARE;
 
 	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -1043,12 +1431,19 @@ static int dps310_probe(struct i2c_client *client)
 		return rc;
 
 	/*
-	 * The device measures continuously in background mode, so a capture is
-	 * just a read of the latest results and no buffer setup ops are needed.
+	 * The device measures continuously in background mode, so a triggered
+	 * capture is just a read of the latest results. The setup ops start and
+	 * stop the FIFO drain when no trigger is attached.
 	 */
 	rc = devm_iio_triggered_buffer_setup(&client->dev, iio,
 					     iio_pollfunc_store_time,
-					     dps310_trigger_handler, NULL);
+					     dps310_trigger_handler,
+					     &dps310_buffer_setup_ops);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&client->dev, dps310_cancel_fifo_work,
+				      data);
 	if (rc)
 		return rc;
 
-- 
2.43.0

