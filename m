Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3C3368B2
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945153; cv=none; b=JGvvRBVqMBhipvewrgzr2gcck4O1h09q9Lsi7Dg4avEozHqmRIQe+FwRul87VMtGq67rSceHbLkEFtxT1K9ynP9/FSpQDExxk9UOy9RgQmtwrDC2cvgB+H2T6NPIyP4gRV0V4mpBfFSBGsmzNPP3l8OmjM4RTkIrnKXuplXxlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945153; c=relaxed/simple;
	bh=IRckfduLzTrfM6LmA71m7SPDxfyEBnjH7CQWdBg4scQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6qHSNoF+hZtk7qSzMDop9klxU2+OVRt0W3framg0i/+VP1fc2NmG2wvn4l9u8FUW9dBjc/UQj8dDlEHzsSpOx0LI8fsNWOZAhMakpjKMLFigCr66baf7gnKSGIe/pGKl9tZxksBE4mTocE0fpg6WhrrB7yTQRUsp36bSY1qLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeGaVhWV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeGaVhWV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d738fe814cso773170a34.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945146; x=1774549946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4zWFRQiJXRC4uOxEJ1OTAIev3CXmuaCaKD0LH5mlcc=;
        b=CeGaVhWVYxeXo3CkbMEiOPta0jBVHyFRRvJWPx/tn8bxf+OFZbIAxvoARqlFYd7jaQ
         49eNpRAGen1ArV8JCohM7Tonzww8QuIiEcCFd61NObsRWteQ8Mq7Nq6AJwp3EqY9lmgM
         Xia8wtbVxUNq6n+iEvAT2tsvgA6D+zqjANvXbjmUd0VhOwH7WGHOTdBbcb/X+GrQxnW5
         K8vWckynW/XAHwz64zrMBM3urNHUzeLTymuVpiBi7eWQZmJFXb8QYYBR6/fag/Dr16hW
         07L1Fhy8PLG0ymdECbWExWhsHlKlxmGsGis8WNgrnQH+0GwTSAGzInp3regc+w3IG2Wr
         yzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945146; x=1774549946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4zWFRQiJXRC4uOxEJ1OTAIev3CXmuaCaKD0LH5mlcc=;
        b=rcP+tv1tAr9MBmBjPa/KvFeh7FbOrzY5DDlnd9XCkXJcGR4RYnvZDsIQb0TfEjwmny
         UJaj67GhqE15ybHgTPEnyQwyDZdkpMS+slC3xR8VISJzclhXcXujyxkM/btuivx4MsGJ
         Sh3rAo0JeypedcD9MAB8f7Eh72mjs9gffxSwwI/SEyLQRdVohZl0o5WkNjNX0wHjmhHV
         xyl3XaF/Nd5Gwdl/VovlhTRUG8o9qznfLHpoBSfechhag7m8nNDBvWyiQ8K5p8+fuEd9
         avmyN4wdvH55LCQ/OwY2WpGusKdOf6qlkBPdho3EOFQs9jlB2+nLYOF4LiQYH266EArq
         7ddw==
X-Gm-Message-State: AOJu0YzluMUyjyuG4vJvSE7Rwrm5YsPJJQZr8L/1rMNKniZ3v5JwAbyB
	/7o8nW9dvX9NgHx2wk6aSmFGNW9y2ab7pEuJQ0wRSrhE2+S/z2L1tHtEKUO2oQ==
X-Gm-Gg: ATEYQzycun4O2NZf7P98uG0ugi/XxeAyRBO1D8992I9VHTJ1BzZRMnlCfx2E5V/JUf3
	pG6ksOn3JWde4GKBXP3YRqGZ+NFdo5OOMmPGHTC3S+MEcYqJCfploefG/wAYxRBxVUxpvy5/KLZ
	79yuKEQUI9FtkWQqHERONmZIIjvci+fYVyuyc7fU/psnJ6HzdPbqDcgGE8/TtsMJzF0yfSEjkJ5
	QN0QQZ6CigWSUwYC2XTntGbPBgVcaKhHbkLKACe7NKTtwlYns7Cdiu5f6ujrykcNm2mNXZRWPr7
	4HiIVn1M2tvZFpBh3H1pAREGGmrFusERwZZQ2bJ1pnm7oZAD+rJqhzevkuM5t5OE+BLKcRJDSaK
	s+oZzLn+jXE61mp4Jwb2nSJxTojlGkUkUgkQ9c4KEoonGnWhDIYrlskS8qkxxdVwtnr37KcGzDP
	li1gGGLDb6dATzuKhpkeP9
X-Received: by 2002:a05:6830:7301:b0:7d7:ccd6:3cd4 with SMTP id 46e09a7af769-7d7eaff4107mr156936a34.23.1773945146387;
        Thu, 19 Mar 2026 11:32:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb11csm172193a34.13.2026.03.19.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:32:25 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 2/5] iio: imu: inv_icm42600: Add support for using alternate registers
Date: Thu, 19 Mar 2026 13:29:38 -0500
Message-ID: <20260319182956.146976-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319182956.146976-1-macroalpha82@gmail.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support to the existing inv_icm42600 to support similar hardware
with slightly different register layouts. For example the icm42607
and icm42607p has most of the same functionality and even many of
the same registers, but the addresses for indiviual registers differ.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  28 +-
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  15 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 257 ++++++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  13 +-
 4 files changed, 188 insertions(+), 125 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c8b48a5c5ed0..b89078cb5ba0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -143,6 +143,26 @@ struct inv_icm42600_apex {
 	} wom;
 };
 
+typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
+
+struct inv_icm42600_funcs {
+	int (*setup)(struct inv_icm42600_state *st,
+		     inv_icm42600_bus_setup bus_setup);
+
+	/* timestamp_setup optional, not present on icm42607 */
+	int (*timestamp_setup)(struct inv_icm42600_state *st);
+
+	int (*buffer_init)(struct inv_icm42600_state *st);
+	int (*gyro_init)(struct inv_icm42600_state *st,
+			 struct iio_dev *indio_dev);
+	int (*accel_init)(struct inv_icm42600_state *st,
+			  struct iio_dev *indio_dev);
+	int (*suspend)(struct device *dev);
+	int (*resume)(struct device *dev);
+	int (*runtime_suspend)(struct device *dev);
+	int (*runtime_resume)(struct device *dev);
+};
+
 /**
  *  struct inv_icm42600_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
@@ -160,6 +180,7 @@ struct inv_icm42600_apex {
  *  @timestamp:		interrupt timestamps.
  *  @apex:		APEX (Advanced Pedometer and Event detection) management
  *  @fifo:		FIFO management structure.
+ *  @hw_funcs:		Device specific hardware functions.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
@@ -180,6 +201,7 @@ struct inv_icm42600_state {
 	} timestamp;
 	struct inv_icm42600_apex apex;
 	struct inv_icm42600_fifo fifo;
+	struct inv_icm42600_funcs *hw_funcs;
 	u8 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -440,8 +462,6 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_TEMP_STARTUP_TIME_MS	14
 #define INV_ICM42600_SUSPEND_DELAY_MS		2000
 
-typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
-
 extern const struct regmap_config inv_icm42600_regmap_config;
 extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
@@ -472,11 +492,11 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42600_bus_setup bus_setup);
 
-struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
+int inv_icm42600_gyro_init(struct inv_icm42600_state *st, struct iio_dev *indio_dev);
 
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);
 
-struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
+int inv_icm42600_accel_init(struct inv_icm42600_state *st, struct iio_dev *indio_dev);
 
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 0ab6eddf0543..cbb27c4e6b82 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1137,22 +1137,21 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.write_event_value = inv_icm42600_accel_write_event_value,
 };
 
-struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
+int inv_icm42600_accel_init(struct inv_icm42600_state *st, struct iio_dev *indio_dev)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct inv_icm42600_sensor_state *accel_st;
 	struct inv_sensors_timestamp_chip ts_chip;
-	struct iio_dev *indio_dev;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
 	if (!name)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
 	if (!indio_dev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	accel_st = iio_priv(indio_dev);
 
 	switch (st->chip) {
@@ -1189,18 +1188,18 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  &inv_icm42600_buffer_ops);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	/* accel events are wakeup capable */
 	ret = devm_device_init_wakeup(&indio_dev->dev);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return indio_dev;
+	return 0;
 }
 
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76eb22488e5f..29c8c1871e06 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -703,113 +703,11 @@ static void inv_icm42600_disable_vddio_reg(void *_data)
 	regulator_disable(st->vddio_supply);
 }
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip,
-			    inv_icm42600_bus_setup bus_setup)
-{
-	struct device *dev = regmap_get_device(regmap);
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct inv_icm42600_state *st;
-	int irq, irq_type;
-	bool open_drain;
-	int ret;
-
-	if (chip <= INV_CHIP_INVALID || chip >= INV_CHIP_NB) {
-		dev_err(dev, "invalid chip = %d\n", chip);
-		return -ENODEV;
-	}
-
-	/* get INT1 only supported interrupt or fallback to first interrupt */
-	irq = fwnode_irq_get_byname(fwnode, "INT1");
-	if (irq < 0 && irq != -EPROBE_DEFER) {
-		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
-		irq = fwnode_irq_get(fwnode, 0);
-	}
-	if (irq < 0)
-		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
-
-	irq_type = irq_get_trigger_type(irq);
-	if (!irq_type)
-		irq_type = IRQF_TRIGGER_FALLING;
-
-	open_drain = device_property_read_bool(dev, "drive-open-drain");
-
-	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-	if (!st)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, st);
-	mutex_init(&st->lock);
-	st->chip = chip;
-	st->map = regmap;
-	st->irq = irq;
-
-	ret = iio_read_mount_matrix(dev, &st->orientation);
-	if (ret) {
-		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_regulator_get_enable(dev, "vdd");
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to get vdd regulator\n");
-
-	msleep(INV_ICM42600_POWER_UP_TIME_MS);
-
-	st->vddio_supply = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(st->vddio_supply))
-		return PTR_ERR(st->vddio_supply);
-
-	ret = inv_icm42600_enable_regulator_vddio(st);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, st);
-	if (ret)
-		return ret;
-
-	/* setup chip registers */
-	ret = inv_icm42600_setup(st, bus_setup);
-	if (ret)
-		return ret;
-
-	ret = inv_icm42600_timestamp_setup(st);
-	if (ret)
-		return ret;
-
-	ret = inv_icm42600_buffer_init(st);
-	if (ret)
-		return ret;
-
-	st->indio_gyro = inv_icm42600_gyro_init(st);
-	if (IS_ERR(st->indio_gyro))
-		return PTR_ERR(st->indio_gyro);
-
-	st->indio_accel = inv_icm42600_accel_init(st);
-	if (IS_ERR(st->indio_accel))
-		return PTR_ERR(st->indio_accel);
-
-	ret = inv_icm42600_irq_init(st, irq, irq_type, open_drain);
-	if (ret)
-		return ret;
-
-	/* setup runtime power management */
-	ret = devm_pm_runtime_set_active_enabled(dev);
-	if (ret)
-		return ret;
-
-	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
-
 /*
  * Suspend saves sensors state and turns everything off.
  * Check first if runtime suspend has not already done the job.
  */
-static int inv_icm42600_suspend(struct device *dev)
+static int inv_icm42600_hw_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct device *accel_dev;
@@ -867,7 +765,7 @@ static int inv_icm42600_suspend(struct device *dev)
  * System resume gets the system back on and restores the sensors state.
  * Manually put runtime power management in system active state.
  */
-static int inv_icm42600_resume(struct device *dev)
+static int inv_icm42600_hw_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
@@ -920,7 +818,7 @@ static int inv_icm42600_resume(struct device *dev)
 }
 
 /* Runtime suspend will turn off sensors that are enabled by iio devices. */
-static int inv_icm42600_runtime_suspend(struct device *dev)
+static int inv_icm42600_hw_runtime_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
@@ -940,7 +838,7 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
 }
 
 /* Sensors are enabled by iio devices, no need to turn them back on here. */
-static int inv_icm42600_runtime_resume(struct device *dev)
+static int inv_icm42600_hw_runtime_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 
@@ -949,6 +847,153 @@ static int inv_icm42600_runtime_resume(struct device *dev)
 	return inv_icm42600_enable_regulator_vddio(st);
 }
 
+static struct inv_icm42600_funcs inv_icm42600_hw_funcs = {
+	.setup = &inv_icm42600_setup,
+	.timestamp_setup = &inv_icm42600_timestamp_setup,
+	.buffer_init = &inv_icm42600_buffer_init,
+	.gyro_init = &inv_icm42600_gyro_init,
+	.accel_init = &inv_icm42600_accel_init,
+	.suspend = &inv_icm42600_hw_suspend,
+	.resume = &inv_icm42600_hw_resume,
+	.runtime_suspend = &inv_icm42600_hw_runtime_suspend,
+	.runtime_resume = &inv_icm42600_hw_runtime_resume,
+};
+
+int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+			    inv_icm42600_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct inv_icm42600_state *st;
+	int irq, irq_type;
+	bool open_drain;
+	int ret;
+
+	if (chip <= INV_CHIP_INVALID || chip >= INV_CHIP_NB) {
+		dev_err(dev, "invalid chip = %d\n", chip);
+		return -ENODEV;
+	}
+
+	/* get INT1 only supported interrupt or fallback to first interrupt */
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0 && irq != -EPROBE_DEFER) {
+		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
+		irq = fwnode_irq_get(fwnode, 0);
+	}
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
+
+	irq_type = irq_get_trigger_type(irq);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, st);
+	mutex_init(&st->lock);
+	st->chip = chip;
+	st->map = regmap;
+	st->irq = irq;
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret) {
+		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get vdd regulator\n");
+
+	msleep(INV_ICM42600_POWER_UP_TIME_MS);
+
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply))
+		return PTR_ERR(st->vddio_supply);
+
+	ret = inv_icm42600_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, st);
+	if (ret)
+		return ret;
+
+	/* setup chip registers based on hardware */
+	st->hw_funcs = &inv_icm42600_hw_funcs;
+
+	ret = st->hw_funcs->setup(st, bus_setup);
+	if (ret)
+		return ret;
+
+	/* Timestamp setup optional for ICM42607 */
+	if (st->hw_funcs->timestamp_setup) {
+		ret = st->hw_funcs->timestamp_setup(st);
+		if (ret)
+			return ret;
+	}
+
+	ret = st->hw_funcs->buffer_init(st);
+	if (ret)
+		return ret;
+
+	ret = st->hw_funcs->gyro_init(st, st->indio_gyro);
+	if (ret)
+		return ret;
+
+	ret = st->hw_funcs->accel_init(st, st->indio_accel);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42600_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
+	/* setup runtime power management */
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
+
+static int inv_icm42600_suspend(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+
+	return st->hw_funcs->suspend(dev);
+}
+
+static int inv_icm42600_resume(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+
+	return st->hw_funcs->resume(dev);
+}
+
+static int inv_icm42600_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+
+	return st->hw_funcs->runtime_suspend(dev);
+}
+
+static int inv_icm42600_runtime_resume(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+
+	return st->hw_funcs->runtime_resume(dev);
+}
+
 EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
 	SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
 	RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 11339ddf1da3..32aa2e52df2e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -725,22 +725,21 @@ static const struct iio_info inv_icm42600_gyro_info = {
 	.hwfifo_flush_to_buffer = inv_icm42600_gyro_hwfifo_flush,
 };
 
-struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
+int inv_icm42600_gyro_init(struct inv_icm42600_state *st, struct iio_dev *indio_dev)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
 	struct inv_icm42600_sensor_state *gyro_st;
 	struct inv_sensors_timestamp_chip ts_chip;
-	struct iio_dev *indio_dev;
 	int ret;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
 	if (!name)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
 	if (!indio_dev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	gyro_st = iio_priv(indio_dev);
 
 	switch (st->chip) {
@@ -775,13 +774,13 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  &inv_icm42600_buffer_ops);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return indio_dev;
+	return 0;
 }
 
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
-- 
2.43.0

