Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A24ED198
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734339; cv=none; b=IvvsfK2c2RWmfICuZEHhcbWAv4azKN122aIJ5GzCVIS1NOUqKs7PxcFhbEkF+21VzMIR/GSM4nWZ8jR6TUwMjANndbPXKfVeh/1TkShbsW7YOIeE1rYL/RycjKdu6B4K4fU2FYDjeQX5gmjV7VEF+N0cVCKqmPVfOpJYv9IBFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734339; c=relaxed/simple;
	bh=laksdeSdPu2zA6kfA0TK1uIuDUMTPBAhLTpGoGGPG4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwpdlmddVjNhaq8GeTtTaqbnF5wndl1cXhu3VtTwnIOOlofluYN8uVgOFnDczxyfZnr/7e6YXRHe3V2pC3pZI1y4eUjLk/RMbEEQONp1mXhAbwXZ5v/z5bRYHimgbNGB8UbdGOKywRg7K7JzoRdDFFbm21ISJbYrbHYJ+lw9Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPlGpvja; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPlGpvja"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso6236061fa.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734324; x=1790339124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60p97ewNtG9tKiPuMUOcTc/j/UXlUPAQ6cFtl0QC6Hg=;
        b=NPlGpvjach0+zo82mgGJjz/fcY+/5EzzNVOVwTBB8fDpwARaDz0V0rSKOAuum+7cz4
         tb+4mOC0OimV0WjzIZKcbwQsL8F4xUi9yJUIJjvIfXktk6oDaIg1S0MZgx8EjSxHQN1w
         MVSHeZgHhRMup1PEVSa2loYSaWeTaHZHnZAOW9ohAKXMnhjWwuRYG6M7H1JjjEDb5ilZ
         vGl6PZxiN8Y6ooXMd38UUf39gJhl17SrpbSVPo5yk/DhK4UCi8ogifZgYyTnvzNuEloB
         flRYXxoGZiqMRmI4ZGF2ujiZge3JGr3yZEQPKA1+o3IXDSdH5jJfkKpFICY6wSAlo0/o
         IYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734324; x=1790339124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=60p97ewNtG9tKiPuMUOcTc/j/UXlUPAQ6cFtl0QC6Hg=;
        b=1at5nHJRxrWNQ+kQ+pAmSm/EUB0UzEdPQjIoQ/hIHrtQ4BjiSbOIYBenGBYdOxQAWA
         f8iXVYkEL83uk19AjbwxaNo+IGRLjOiyxpWQU/8cq4FTN653S6pEJA/avVkE1qfMCosE
         5vMtMdlQdDxUiBtT8rnVG52FezLwEcKDaCp7hntZfQHrJDerelWug2ZXa4LgXH07Vbab
         OOpR4T7nW1HJzbkGpfhE8pOrDCUM5jQ0SGKdhvQJH+N7D/MJMa0WFMdm54t1jpYFZxQx
         KHPmYkuPIVs3IDYMX4OjkXG9giF4PQCXo+FuIARwcG6F/p2v8bTDvRrX1nIMW9hJhAl/
         LGzQ==
X-Gm-Message-State: AFuF++le9KHyXbTV02FD+sAMflBJlZuRP1icys9BdKED8+3urhisamJG
	ntm0s/AWwpOei67OaF/ciw4BQt5egzmijSIo57O8EN3Xx002l2ISXukt
X-Gm-Gg: AYBFou01lI3S+LBaMbK84/ZH/K1ZnKCF1n0kBbkZpGbwNSbn1puyBOfRfYf6hK9h9NZ
	ZYtH/kTKNrynydJVtaju3I6bA40T5dwZCqLCub70ZNLInDdiFnc5uNVNFLMrcjRNBM9rOSrvwu2
	HEHDtONEVwsV09gu1MwmOWis2Llb0Tts/KaV0mynFgkVO3S1IsX6b7a2EeCvdwlraYfsfepcNa2
	8fMbvHUgFvoDz1U9ivA04frPl5klglaAFtNRNiXU0S2Hu4aBGPPhbSbJ6q3909LWvowafyjUNBG
	5EiAv/9ilmL/7/kYsnRByc+puojAjoJaWYda0SYsKWUpQeoxqkbZRApvrcAm5KAHwk/RKT1IrM8
	Ndk0TLY4564ZRN1XiF3xg6OndjT9jtKlA44ZUdQ7ptnsK/FlqamU2H35Dl0kB0nfRs7IgitFRjM
	OxH0+gLOP0WqqndoxMv0fqGptw1pxQvpdTUQOpGdexJx+4kcMaLEO8u5Uq9PhVmzFH75apeHy3A
	NYuz2A/5oZi+rrwwQwV9Y6FB2TmkFHNNaDurLDKeM/BzjyVItmdAFeAODWjoiFtqqNpmA==
X-Received: by 2002:a05:6512:1389:b0:5b7:6489:37c7 with SMTP id 2adb3069b0e04-5b8c179d8cdmr728262e87.0.1789734324360;
        Fri, 18 Sep 2026 05:25:24 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:23 -0700 (PDT)
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
Subject: [PATCH v7 05/10] iio: pressure: dps310: add triggered buffer support
Date: Fri, 18 Sep 2026 15:25:12 +0300
Message-ID: <20260918122517.377565-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
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
 drivers/iio/pressure/dps310.c | 151 ++++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 5 deletions(-)

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
index 8cefca928077..dd816d47bbec 100644
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
 
@@ -94,19 +97,50 @@ struct dps310_data {
 	bool timeout_recovery_failed;
 };
 
+enum dps310_scan_index {
+	DPS310_SCAN_TEMP,
+	DPS310_SCAN_PRESSURE,
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
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
@@ -586,6 +620,11 @@ static int dps310_write_raw(struct iio_dev *iio,
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
@@ -723,6 +762,13 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
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
@@ -731,6 +777,12 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
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
@@ -812,12 +864,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
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
@@ -830,6 +880,87 @@ static int dps310_read_raw(struct iio_dev *iio,
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
@@ -885,6 +1016,16 @@ static int dps310_probe(struct i2c_client *client)
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

