Received: from mail-lr2-f40.google.com (mail-lr2-f40.google.com [74.125.230.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811A4FD280
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015507; cv=none; b=dkXMy8NO5s8l5t45htDn5nP19yk703Bq/jxLGmQclm/JKhu25rz2LfUA2XzP4S+mdzfBib9BztF0Zh80y2SZVi/NqOUHA03V895o/2zt50EcJO5cRdAVpN2ZUOO4GmUqgiP3uvfABDvB1IjNmKxrUctg1eTDLwcTdlhnBGJWyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015507; c=relaxed/simple;
	bh=kAKm7N7kW+pY4ryE8PsRnOF2vtzhc2jYcOok0noH17I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDAAvv0IHXooyfH4hF/Apcg3oeOrUFFGFbuce8+TReu/uIAIA7r/yTOOC7oSKeZEApV4K0SyeT64NllZ+0DsSgTx9DZwj2pKwfqdeaMU9mMy7UryRSG/OzBUUiiymNJhxirwTmiXmolL0pMUnO1aANLtUckSiMOhfAcgQNsN3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBUhczGu; arc=none smtp.client-ip=74.125.230.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBUhczGu"
Received: by mail-lr2-f40.google.com with SMTP id 38308e7fff4ca-3a5da7416f9so23372341fa.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015504; x=1790620304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPzoWlL9AZKzGiA4qZJwRAzxiEn5+U5KHMCUBLiqDTk=;
        b=sBUhczGuVIqLj2eQvdIVMAcuoQTHXEcElpLEbFkILwgLvFe/HBw8WzbZBWm0XLRmAu
         E52Y8tnVO7ZQ/VLwmlrBB+hIB5/PKg6Ostj0SkE5XK8leugdcdnTi/4LBCBlriGDgUfJ
         eFr9i8GhbfUM+SOQGXFFDf6zjYeVs+44kwaqbXMFSnpnpVoVYPu1GfnmyUUxHLqzDVVS
         AeTkmWNTb2wHGhao/nbaldQkaLRzOhglUtgb+gDonrohTzbFz77EWnflbzXfjtiCg25C
         17zH6aC3Ka1tAa7Q7P/Zj32OULzrYVNnovu6bHLqrxhfUjG1vTTPqO0TyQ0D+WoPju8d
         kRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015504; x=1790620304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPzoWlL9AZKzGiA4qZJwRAzxiEn5+U5KHMCUBLiqDTk=;
        b=h2zkliSZCpLkjj195P/ADREVYaPH8hd3EJ5geNdQoU4IiR8GYtrxenw690jwYNShL2
         yHFEV82gK+WgYOISB75dgcMADp6LfjgsfYzF5ew6DLn+QJTrUz7O4WBx29vERa6QvIKz
         oEdlCkVGdTNajAHyh61b4kikPlQsqwV5NHX5PzxrHrDvjwUkvNGyU+itZp1J1+d71SFJ
         1j87ZblziwrAosygeHcsez0TTNt+XNxIZ4ha3WO4KjngAsQ5ZkpvjTCm5yX0lxEt9kNi
         9ai2s4kyxIes5LUxl69Vllb90fOg0qX6hbC+b3/LsW/s5O0kqcrcwsw7HmssgGDVF5so
         9zYQ==
X-Gm-Message-State: AFuF++lYDc2RNBTM+zMsza18EO5kqvaM+c1AcAlcaZ35CbhHrFvO4Z5Z
	uwaXv9XBFM2d+og+ndw9wE+sTVKIZDidCbUDd+P9KG37R15Nl16OBTg4
X-Gm-Gg: AYBFou20cTafZTezG7oXfhg2nvGy7yVSHvkpa8k6lB9J0lNOnNJiPtL7OP8xgEgtGT8
	ZD1etg407at+kbePF0gk4imZliQAkKjH5CNgMm5rzwef/kjQ8ZxTZitsbtqAw7a/DxdtzBuFQBJ
	XRJwdfkq+D+1U0ns1UeqSPJXnzOKVI3p4Tk7GSvjsky/jsB8790+M4f0VHwA8FVgA0n1J5TrQEU
	hJlWaJ7k11x4nMTOkOmGHsjLF+y/9HkB5qncqGrewGgm8ebxL6lXleJKZIBL1bYZ9U1EzkqEDYL
	vxTaUcsJMmTq6saxtpNIhlqiTxmV61gsvLzLZ6B6zIUHgydigMfAec4YMIn7ssLA/NFbPF4shn0
	XdhVNlO5zDr7sJ9I8/2mxKuw+6NwrQDEOVOJO3voiEAjXbhpenjynEPovJtoN4WYfFbMtP98l98
	SvC/Y6Oe3RykdcFukJnt9dVHlrBpaQH/qRuVef+Gh4J/0nD4YqCs+8kQxV62hu/of/eAGp4ojqE
	NPjM//q/tkXANuMCSlkSpu0R7fFNpLtJZYUapo7rZhDj3VAvZVHSeOJ+nTzTrjb9YbVmQ==
X-Received: by 2002:a05:651c:1443:b0:3a5:defc:81e0 with SMTP id 38308e7fff4ca-3a5fbe87363mr28069021fa.1.1790015503693;
        Mon, 21 Sep 2026 11:31:43 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:43 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v8 05/10] iio: pressure: dps310: add triggered buffer support
Date: Mon, 21 Sep 2026 21:31:27 +0300
Message-ID: <20260921183132.233136-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a triggered buffer to capture continuously on both channels instead
of one sysfs read at a time.

Raw register value is not useful on its own, pressure has to go through
the compensation polynomial and needs a temperature reading. Report raw
in Pa with 1/1000 scale to keep full resolution in the buffer without
changing what the existing processed attribute reports.

Raw and processed reads return -EBUSY while buffer is on, so does any
reconfiguration.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/dps310.c | 152 ++++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 5 deletions(-)

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
index 8cefca928077..85df58ac1809 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -22,8 +22,11 @@
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DPS310_DEV_NAME		"dps310"
 
@@ -94,19 +97,51 @@ struct dps310_data {
 	bool timeout_recovery_failed;
 };
 
+enum dps310_scan_index {
+	DPS310_SCAN_TEMP,
+	DPS310_SCAN_PRESSURE,
+	DPS310_SCAN_TIMESTAMP,
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
+		 * _raw here is already compensated (section 4.9.1, which needs
+		 * a temperature too) and in Pa; _scale converts to the kPa the
+		 * ABI wants. _processed predates buffers and has to stay.
+		 *
+		 * Do not copy this into other drivers. A _raw that is not the
+		 * raw register value is only tolerable because the alternative
+		 * is losing resolution or breaking existing _processed users.
+		 */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = DPS310_SCAN_PRESSURE,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(DPS310_SCAN_TIMESTAMP),
 };
 
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
@@ -586,6 +621,11 @@ static int dps310_write_raw(struct iio_dev *iio,
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
@@ -723,6 +763,13 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
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
@@ -731,6 +778,12 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
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
@@ -812,12 +865,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
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
@@ -830,6 +881,87 @@ static int dps310_read_raw(struct iio_dev *iio,
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
+		/* This consumes the measurement the capture path reads */
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
+static int dps310_fill_channels(struct dps310_data *data,
+				const unsigned long *scan_mask,
+				s32 channels[2])
+	__must_hold(&data->lock)
+{
+	unsigned int i;
+	int rc;
+
+	/* Compensation needs a temperature, so it is sampled either way */
+	rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
+	i = 0;
+	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
+		/* Millidegrees Celsius */
+		rc = dps310_calculate_temp(data, &channels[i++]);
+		if (rc)
+			return rc;
+	}
+
+	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
+		rc = dps310_read_pres_raw_locked(data);
+		if (rc)
+			return rc;
+
+		/* Pascals, see the channel definition */
+		rc = dps310_calculate_pressure(data, &channels[i++]);
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
+	struct {
+		s32 channels[2];
+		aligned_s64 timestamp;
+	} scan = { };
+	int rc;
+
+	mutex_lock(&data->lock);
+	rc = dps310_fill_channels(data, iio->active_scan_mask, scan.channels);
+	mutex_unlock(&data->lock);
+	if (rc)
+		goto err;
+
+	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), iio_get_time_ns(iio));
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
@@ -885,6 +1017,16 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/*
+	 * The device measures continuously in background mode, so a capture is
+	 * just a read of the latest results. The trigger is not aligned with
+	 * the measurements, so the timestamp is taken in the handler.
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

