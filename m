Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276415A86D
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418864; cv=none; b=XQcPJNwbUiny/Gc+jVbpsdM9pplepfmrVdBeiP1QoHmxJT8WXhw5DmeNvqyEt1zjwqtIIGYZLB51tyhLByCOCgiY+y7D7d3UP8ji3EGilX4o0hXOTy5gD2IsUeUKKaIpMJOScdDLUsC0sdvdfb9Ro2EAdNGNC2x/b2CYTR8wcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418864; c=relaxed/simple;
	bh=Co22W2ue9qnRS+lhyRup2U96IUjl/bd6w+Px1tSC3k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGB2l208vWoWWbl9ji32yRF5dvwJBXO+OiLiXK5tB5F3KnVynx5KpQJ5Q+ErgszS0GSvRjCw+VE2twnkuub5Mi24PEe3oGYWuioJJIGnB07ChL778wq2ISG9ztlggZhnJuYLZBzUymMcuA2zLdIxCECiMwp9bzdA58GS0NGc+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo7D7VTg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo7D7VTg"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so81522581fa.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784418860; x=1785023660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2q65+DC2r/6Txf0Z94ws30H287DZ50UdVjGH6X0cidQ=;
        b=jo7D7VTgXaZS+mHrZOcy7J/A7GKhJ7B/meGqpJVuNl+siST7oO40XnsxFrOJhglvtb
         xWupDSrG3E0UGdfvL1z4ZNx7uAkt+aOk09yeoBZft/rbnRp/xjoL4F2IceAW5wgJrDmg
         BiW5/IrT6hI93qM3tLNheKo62ftUN7X/P1u2NSfS12tGcLko5U+Xe9pDQxCekXUMFv9p
         msMTmYurTH9hPLQfGtlX8D3B/Iyd55vXiBg4CNhmxqfqSZDgrzva/n5IOfTjxuRabqX4
         BaQCfMGS0q0L002cQrXBYxVpmQlAreoqKGrNZBL1oVv6k4aBuDvchJnXnnQFGIcuTQhv
         VxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418860; x=1785023660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2q65+DC2r/6Txf0Z94ws30H287DZ50UdVjGH6X0cidQ=;
        b=j1JJVAp9ys8qi82gXO944sjOK8JTpo5WtrECQM9UzlSnHdc/6EQhKugwHt3ftIhLKR
         Zc7OIFWPJj9uBT7CnKV6aTEhw6iHNZmPTFCOMf9pe8u0pd0kk1Fvy0QrJddgn6DatSnU
         1aOM+d9ct9ptFJ+lHKNO81wheGBbHWn5PsSJNXFlVGQxFfo0VM5dNINAuv27e6WOCfOv
         c01o53BeqEJYGsYLzOfTCgBs4k11KeoaOKEQ5bQuNXpLnStPvw9FN5Na6mP9MT+Ex6IM
         tob8AM8tPRsa9mUWMVNC+3CpXaZPB2mVRch7aIHHLpASC7DC1Zcj1p2KKpHzV/IcaZ6m
         8riA==
X-Forwarded-Encrypted: i=1; AHgh+RoWvhmgx3xiwgc3cDHJNh0CyF7MT97LIFGjg9DcHwrIjUUgUXGY21luuzfBCKzTuT1iKxN1MFydSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zZcd3icVbNZOrdaqNzeZrFZaNbBcbQ6qCOrkNTL9FyvJdy6s
	6GVQ7GcZuuM83erYI7vtCLKHIE/rLAgKy7RCjTNvlj1M+w1OcWO7slkj
X-Gm-Gg: AfdE7cnvMDEdz3nGv2ze9Cog7o/lXuJI5/vLcCcu0tpTBMPR/tKfgchryBQnghJcnPt
	KbmPWB4U9huLphICFIMJleKAJFC63t4Geo8VK240PinAdagNsC+vhsjRVBLLJP0SHZyGBJAbqnN
	1GiDAHU8Yu53+VIjTK/7Yvt185Xa/YzxoZrn3ebjtFPh+IjR2xwDScSeMiGGyhBsy2HNyDMPwyq
	DnFmJF9otzglhhx+DKX/krIzy8ruteOW0AbxL1toauIRmYvx9Oxkxy6QHBfXl9FV+VQasef02y3
	UH6OSZqG0wDlvE6wUjmiIIP3rsfRFz1sZ8AEWpTnhWsKWBjo1A9OWeA4KWL6QgfcGBaQ/Ethaiu
	QqFU0CXV7wbOAX4zOa/J8XhFqrS+uo9pDKFNCnv2hR9BXeVcw/xzM191xVnsArlLJVehhs5uN9+
	O3hS+rL24A0MdCsdr9TK02nJB3JjDRDwNt8/HWxZhgceOOVVj2mIEQ8lSQAIO+SqBVfwgsttgt6
	g==
X-Received: by 2002:a2e:a542:0:b0:39c:84cb:ca79 with SMTP id 38308e7fff4ca-39eb289dae6mr18920081fa.40.1784418860007;
        Sat, 18 Jul 2026 16:54:20 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4e3371dsm7674481fa.1.2026.07.18.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:54:18 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Date: Sun, 19 Jul 2026 02:51:58 +0300
Message-ID: <20260718235203.73699-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718224455.38acd927@jic23-huawei>
References: <20260718224455.38acd927@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add triggered buffer support so pressure and temperature can be captured
into a buffer instead of only through one-shot sysfs reads.

Pressure is a processed value in kPa computed from a non-linear
calibration polynomial. To keep full resolution in the buffer without
disagreeing with the sysfs unit, add raw and scale attributes for
pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the existing
processed attribute is kept for ABI compatibility. Temperature is already
a full-resolution value in its base unit (millidegrees Celsius) and stays
a processed channel.

Pressure compensation depends on a temperature reading, so both channels
are always captured together. The device already runs in continuous
background mode, so no buffer setup ops are needed. Sysfs reads and
reconfiguration return -EBUSY while the buffer is enabled, as they share
the capture path's raw values and configuration.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Changes in v3:
 - Rework from just enabling the FIFO into proper IIO triggered buffer
   support, as suggested by Jonathan.
 - Buffer the pressure and temperature values; add raw + scale for
   pressure (bme680-style) so buffered pressure keeps full resolution
   and stays consistent with the sysfs unit.
 - Drop the unused FIFO enable/flush/read helpers.

v2 was a resend that still contained the v1 FIFO-enable code.

Note: this touches dps310_probe() near the separately-sent fix "iio:
pressure: dps310: fix NULL pointer deref on ACPI probe". It was generated
on a plain base tree, so applying it after that fix needs a trivial
3-way merge/rebase - happy to resend in whatever order or branch you
prefer.

 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/dps310.c | 141 ++++++++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 838a8340c4c0..cef8b90b9ae7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -112,6 +112,8 @@ config DPS310
 	tristate "Infineon DPS310 pressure and temperature sensor"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Support for the Infineon DPS310 digital barometric pressure sensor.
 	  It can be accessed over I2C bus.
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..967a2043550b 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -20,8 +20,11 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DPS310_DEV_NAME		"dps310"
 
@@ -90,6 +93,12 @@ struct dps310_data {
 	s32 pressure_raw;
 	s32 temp_raw;
 	bool timeout_recovery_failed;
+
+	/* Buffer to hold a scan; timestamp is naturally aligned */
+	struct {
+		s32 chan[2];
+		aligned_s64 timestamp;
+	} scan __aligned(8);
 };
 
 static const struct iio_chan_spec dps310_channels[] = {
@@ -98,15 +107,38 @@ static const struct iio_chan_spec dps310_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_PROCESSED),
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+/*
+ * Pressure compensation needs a temperature reading, so the trigger
+ * handler always captures both channels; keep them enabled together.
+ */
+static const unsigned long dps310_scan_masks[] = { GENMASK(1, 0), 0 };
+
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
 static int dps310_get_coefs(struct dps310_data *data)
 {
@@ -583,8 +615,14 @@ static int dps310_write_raw(struct iio_dev *iio,
 	int rc;
 	struct dps310_data *data = iio_priv(iio);
 
-	if (mutex_lock_interruptible(&data->lock))
+	/* Don't reconfigure the sensor while a buffered capture is running */
+	if (!iio_device_claim_direct(iio))
+		return -EBUSY;
+
+	if (mutex_lock_interruptible(&data->lock)) {
+		iio_device_release_direct(iio);
 		return -EINTR;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -625,6 +663,7 @@ static int dps310_write_raw(struct iio_dev *iio,
 	}
 
 	mutex_unlock(&data->lock);
+	iio_device_release_direct(iio);
 	return rc;
 }
 
@@ -735,6 +774,23 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
+	case IIO_CHAN_INFO_RAW:
+		rc = dps310_read_pres_raw(data);
+		if (rc)
+			return rc;
+
+		rc = dps310_calculate_pressure(data, val);
+		if (rc)
+			return rc;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Raw pressure is in Pa; scale to kPa per IIO ABI */
+		*val = 1;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		rc = dps310_get_pres_precision(data, val);
 		if (rc)
@@ -804,12 +860,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_read_raw(struct iio_dev *iio,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int dps310_read_channel(struct dps310_data *data,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
 {
-	struct dps310_data *data = iio_priv(iio);
-
 	switch (chan->type) {
 	case IIO_PRESSURE:
 		return dps310_read_pressure(data, val, val2, mask);
@@ -822,6 +876,32 @@ static int dps310_read_raw(struct iio_dev *iio,
 	}
 }
 
+static int dps310_read_raw(struct iio_dev *iio,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		/*
+		 * Reading a sample uses the same raw values as the buffered
+		 * capture path, so only allow it outside of buffered mode.
+		 */
+		if (!iio_device_claim_direct(iio))
+			return -EBUSY;
+
+		rc = dps310_read_channel(data, chan, val, val2, mask);
+		iio_device_release_direct(iio);
+		return rc;
+
+	default:
+		return dps310_read_channel(data, chan, val, val2, mask);
+	}
+}
+
 static void dps310_reset(void *action_data)
 {
 	struct dps310_data *data = action_data;
@@ -843,6 +923,46 @@ static const struct iio_info dps310_info = {
 	.write_raw = dps310_write_raw,
 };
 
+static irqreturn_t dps310_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct dps310_data *data = iio_priv(iio);
+	int rc, pressure, temp;
+
+	/*
+	 * Don't hold data->lock across these calls: the read helpers take it
+	 * themselves and the mutex is not recursive (dps310_calculate_pressure
+	 * also grabs it with mutex_trylock to refresh the temperature).
+	 */
+	rc = dps310_read_pres_raw(data);
+	if (rc)
+		goto out;
+
+	rc = dps310_read_temp_raw(data);
+	if (rc)
+		goto out;
+
+	rc = dps310_calculate_pressure(data, &pressure);
+	if (rc)
+		goto out;
+
+	rc = dps310_calculate_temp(data, &temp);
+	if (rc)
+		goto out;
+
+	data->scan.chan[0] = temp;	/* millidegrees Celsius */
+	data->scan.chan[1] = pressure;	/* Pascals */
+
+	iio_push_to_buffers_with_ts(iio, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
+
+out:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int dps310_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -863,6 +983,7 @@ static int dps310_probe(struct i2c_client *client)
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
 	iio->modes = INDIO_DIRECT_MODE;
+	iio->available_scan_masks = dps310_scan_masks;
 
 	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -877,6 +998,12 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	rc = devm_iio_triggered_buffer_setup(&client->dev, iio,
+					     iio_pollfunc_store_time,
+					     dps310_trigger_handler, NULL);
+	if (rc)
+		return rc;
+
 	rc = devm_iio_device_register(&client->dev, iio);
 	if (rc)
 		return rc;
-- 
2.43.0

