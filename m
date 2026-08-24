Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45E38E5FF
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602462; cv=none; b=MkxHEYHtYp1IYdMoJI68ZqNIUfCnEqWDkHFCySC1kiBtcIbdNMvsmQFb+1eeRmM3m3Gc1779feKEHBBDklQGUfXT9IeCqz4ZUPBCioRSA9wzdCkEXrWaTXDOmdp19FDH57zhnvQ54MEnrRqNRi8G+TvVcpwAgBDbLJAnvRWFNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602462; c=relaxed/simple;
	bh=csUPRYnD1mZEqYaD+zR8/M55EcN2oznVfK16WyklPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na7nKa/kqryDtNfnTQdIJWSb9Aza35hbBFvDtzT5K2AY/P+GEKnxmK5gEXI5v7rQYqhAnnJ4u7+3wvkcxGAq7TESerySyfoi2QZX9UVWcaZ85kNruikE5E29XSEEYiK81o6S98F6iQrTZ67QO0w3m+3cgvERt3KbGAVEoPA8mMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft9HjAqj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft9HjAqj"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so3703904e87.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602457; x=1788207257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jr7LJu6Ksb6SAGIGzJSc2rS20dUT4t5olBG8OLxTlPA=;
        b=ft9HjAqjmmepc2pUFmqCCp4wIjHsFIUSGUN3CIwcuEdlSGg9MxqOuTlvNCxtc6NK+O
         sclQQ8g+4dCKJWNoX/NpWmw+Czkfzq9n/JFFx//Y+12koz/8zcfbMheol3zr2c9lFKuo
         tuWhDIclY2bfeKeyAGyydCem0jt9DoSUA4J7+0tCxz+9o5haHq1cwP0gSobIwsUM0+lM
         3Re5+dRozDd5rnsK90GhWn0QrUj6ClJNGQQer1t89YtGVx+BDOc2wmYHT2DckmOmi8kq
         hYkMajCqujTuDtmPFaVTwch0ffmGvlx9kF69wcvmMxbY4jEuc8zaytWrGHiYOtGOZTM8
         7dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602457; x=1788207257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jr7LJu6Ksb6SAGIGzJSc2rS20dUT4t5olBG8OLxTlPA=;
        b=eFjNcWwWQ0j+cnbpZB3zTyviWp1a60RVC1ypQWXJIEAnYndpRv8cQPxXJrVHadKrgf
         BRUMuECTgFV96c4K203NJiNN4Fm8PgIUw8mAwb8JCVI/myLkA/CK4VjCvyz/tfZMEEQp
         a5ycMG4SbmBek2Z3ukOp3ITVzoZvcUSaC/18Q8ZJ7Xj+4GDs9LUIzw+vJ/daNQHzgBRV
         roNKoEtMU2CF9xtvAUndbrWN5BtvV4amFlONF9n1GB/C2Fom38Sb4vCzpq7l7AcCJG33
         oJJgY6rPYhl6YpEAaw7pYvj/4v0OhEkC7eHcRSmF6DPn6GJ5KgBsiusbKltWAjOcznEB
         CDOA==
X-Gm-Message-State: AFuF++nGWSCtygqHt+RDMpg9DAC9luUFkJ9H6C6CGed/mxNYkTXLpq4T
	l+gHBgjDuH2Ub7X07b2ze+2vw4bC3Ck7x8u3X+LID8AubwIcehqBHRZN
X-Gm-Gg: AR+sD11+fi0Y2ABNYb3Pu3/z+rEMwB8xIE1xbZIvNgZlGMeK7/m48x9RbDLdQGW1T0J
	UICWLnpVNoRxKs4HRnTOHRIarnCq7KpRXT+o4ULJSxyfcRtYlEwzJZSwkcrFgabC3IE1SQThC/2
	7376IDdQHZlfPPIgk6J/tqpm2SoteBI+CMDRCWaien1fBmSzE4aBjmD+5h3JiJ0PprdOCpDPvzA
	Fm9vc5Jc4hscPiSPkMVz79IhlMbJgMhiR765ZMfybcZUkWJXgodluIoH0ecoXGnil23eH9USLz1
	NsYUKgdGf16a1YNvsdQODCjEsO57BPDzW+8140NrOgVqn+oDuRbNpWBZfKw4/xxRzzD8lDZ8sUx
	rQrnFDwCN8u6qWbB3xAfHZ/Nk+bd/5cI+7bYAGOexJcGNMXFahEpsDCs129uctuWDvTMstu91be
	4sYbaGdcmNmS31kBVxlK/MAch2iP+D7I9VCBG73+l5ajkNK/wZfb74oZzPs9UaoQRmj/61T1zNy
	mPIh3PsWLncO32Q+2re7kWVRvN7Pi7y5bynxK87R5TRsP+N6bZEsFoqfVthe/QVSLLxFA==
X-Received: by 2002:a05:6512:1192:b0:5b3:11a0:968b with SMTP id 2adb3069b0e04-5b48b8979a8mr6248951e87.19.1787602456505;
        Mon, 24 Aug 2026 13:14:16 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:16 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v6 4/6] iio: pressure: dps310: add triggered buffer support
Date: Mon, 24 Aug 2026 23:12:01 +0300
Message-ID: <20260824201203.396651-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824201203.396651-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a triggered buffer in order to capture continuously on both channels
instead of one sysfs read at a time.

Raw register value is not useful on its own, pressure has to go through
the compensation polynomial and needs a temperature reading. Report raw
in Pa with 1/1000 scale to keep full resolution in the buffer without
changing what the existing processed attribute reports.

Raw and processed reads return -EBUSY while buffer is on, so does any
reconfiguration.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/dps310.c | 169 ++++++++++++++++++++++++++++++++--
 2 files changed, 165 insertions(+), 6 deletions(-)

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
index 269a71ea3e7a..f122acd72b0c 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -21,8 +21,11 @@
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DPS310_DEV_NAME		"dps310"
 
@@ -93,19 +96,60 @@ struct dps310_data {
 	bool timeout_recovery_failed;
 };
 
+enum dps310_scan_index {
+	DPS310_SCAN_TEMP,
+	DPS310_SCAN_PRESSURE,
+};
+
+struct dps310_scan {
+	s32 channels[2];
+	aligned_s64 ts;
+};
+
 static const struct iio_chan_spec dps310_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = DPS310_SCAN_TEMP,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_PRESSURE,
+		/*
+		 * Pressure is only meaningful once the raw register value has
+		 * been run through the compensation polynomial in section 4.9.1
+		 * of the datasheet, which needs a temperature reading as well.
+		 * So what is reported as _raw here is already compensated, in
+		 * Pa, and _scale converts it to the kPa the ABI asks for. The
+		 * _processed attribute reports the same value and predates
+		 * buffer support, so it has to stay.
+		 *
+		 * Do not copy this pattern into other drivers. A raw attribute
+		 * that is not the raw register value is only tolerable here
+		 * because the alternative is either losing resolution in the
+		 * buffer or breaking existing users of _processed.
+		 */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_PROCESSED),
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = DPS310_SCAN_PRESSURE,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
@@ -589,6 +633,11 @@ static int dps310_write_raw(struct iio_dev *iio,
 {
 	struct dps310_data *data = iio_priv(iio);
 
+	/* Reconfiguring mid-capture would change the values being captured */
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	ACQUIRE(mutex_intr, lock)(&data->lock);
 	if (ACQUIRE_ERR(mutex_intr, &lock))
 		return -EINTR;
@@ -730,6 +779,13 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_RAW:
+		rc = dps310_read_pressure_value(data, val);
+		if (rc)
+			return rc;
+
+		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_PROCESSED:
 		rc = dps310_read_pressure_value(data, val);
 		if (rc)
@@ -738,6 +794,12 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
+	case IIO_CHAN_INFO_SCALE:
+		/* The raw value is in Pa, the ABI wants kPa */
+		*val = 1;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		rc = dps310_get_pres_precision(data, val);
 		if (rc)
@@ -819,12 +881,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
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
@@ -837,6 +897,92 @@ static int dps310_read_raw(struct iio_dev *iio,
 	}
 }
 
+static int dps310_read_raw(struct iio_dev *iio,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED: {
+		/*
+		 * Sampling here consumes the same measurement the capture path
+		 * reads, so refuse while the buffer is enabled.
+		 */
+		IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return dps310_read_channel(data, chan, val, val2, mask);
+	}
+	default:
+		return dps310_read_channel(data, chan, val, val2, mask);
+	}
+}
+
+static int dps310_fill_scan(struct dps310_data *data,
+			    const unsigned long *scan_mask,
+			    struct dps310_scan *scan)
+	__must_hold(&data->lock)
+{
+	int rc;
+	int i = 0;
+
+	/*
+	 * The pressure compensation needs a temperature reading, so temperature
+	 * is sampled even when only the pressure channel is enabled.
+	 */
+	rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
+	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
+		/* Millidegrees Celsius */
+		rc = dps310_calculate_temp(data, &scan->channels[i]);
+		if (rc)
+			return rc;
+
+		i++;
+	}
+
+	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
+		rc = dps310_read_pres_raw_locked(data);
+		if (rc)
+			return rc;
+
+		/* Pascals, see the comment on the channel definition */
+		rc = dps310_calculate_pressure(data, &scan->channels[i]);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static irqreturn_t dps310_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct dps310_data *data = iio_priv(iio);
+	struct dps310_scan scan = { };
+	int rc;
+
+	mutex_lock(&data->lock);
+	rc = dps310_fill_scan(data, iio->active_scan_mask, &scan);
+	mutex_unlock(&data->lock);
+	if (rc)
+		goto err;
+
+	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan),
+				    iio_get_time_ns(iio));
+
+err:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static void dps310_reset(void *action_data)
 {
 	struct dps310_data *data = action_data;
@@ -893,6 +1039,17 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/*
+	 * The device measures continuously in background mode, so a capture is
+	 * just a read of the latest results and no buffer setup ops are needed.
+	 * The trigger is not aligned with the measurements either way, so the
+	 * timestamp is taken in the handler rather than by a top half.
+	 */
+	rc = devm_iio_triggered_buffer_setup(dev, iio, NULL,
+					     dps310_trigger_handler, NULL);
+	if (rc)
+		return rc;
+
 	rc = devm_iio_device_register(dev, iio);
 	if (rc)
 		return rc;
-- 
2.43.0

