Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417333;
	b=ba4b5hN04qtvT+R6lkYsWSyvJmfI5JQvkw042qZsbcmrBhX8DiCmiIcYsUCJtmnbeMrr
	 u5RKq5yMFufry+5pdYdE3nipHMKHY0LLh2mrHZgf3D8+l/srVXQjAm4orEoaewCBZ1FpO
	 A92rwEebkaJtK+1+q6GKlnu3I4yYZnhWwaKlFTe4WLZo0jEIDUkV2RgfOQNpvNNdrBzyU
	 m8yh/wrPvLoDG9hRT5U+fIlN3bcKueLJr0/3vQnh+PG2BW4Rk1LzdNXc5LWQfbZH49/RZ
	 YKMfS6RWVdtQ/2cftV63o0xOb40cGJP1xxhGbeqOUkRCTafM2QWlnnybWJoTd9mhblQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MS6DmB/ULBdfOhhhYecAUBRl9PiNKo3+G/EHjFt3o2U=;
	b=JySg90uRagQCDabouLUsE/OVlFVCuFwTwS0opJ1UtA73HxDxQiKGssjtzP3FemHIEgDr
	 3AmZJlSovz5X8kdkXa3xQ8zTFFprAC/kx48RhzOa5HwCpXjjw7QZoy4U71pJa9R1TCle2
	 slI9cnoxYgT2/oYBWQN3csnWVA6I0LspJ8DQvJNa/X2sjj01oC0PJvdJ6+x6SlJbkmc93
	 FWpJPJvDXQw4O3ps6IRe3q/yiv5fK5HCE0sP1Lllr/tlsBOPkX8cbqzLvRcLjLNoEn7YY
	 ONYsNrHMPZNaKtDw8aRrnWpwr7gbNxIP2joz2AemLaTzpQdIdYz2B6maO+VOcZrYC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJgNShhB;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46F606A32E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A46F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJgNShhB
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49465892f7bso2129885f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417331; x=1796022131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MS6DmB/ULBdfOhhhYecAUBRl9PiNKo3+G/EHjFt3o2U=;
        b=pJgNShhBPrgLBlaRCOzqSoRSYkU66yOc/HGDwRAVvK2DCrmGb20XChLl1QLoK8H0iN
         rZnXDHj7T4W8G02NAf8W0LWz6Pb0DoKyVgf16ZhJ9uVjL7hUd/GkRCWd8+if+DiqA1Jn
         Kihym0fPctgn90S1mp0gkiEL3ii3/3YmowXVL/NuTuEQryIXy3LoJL6qK+WivzXkoP2S
         ZWSeAfT7U39RAJmCwzX5cIyrc7hMowhZuz0zSv23piFJ9WMG3QPuI0tCCdRlyKQKAZSW
         JAKh4x2N6j0j+35pRBAqspqAGtg3+Yng/yta2jktso38QI6Xeuu+kdulfJw7jwJ62Vr6
         F9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417331; x=1796022131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MS6DmB/ULBdfOhhhYecAUBRl9PiNKo3+G/EHjFt3o2U=;
        b=HQCqO/2bWbuHTkorA9ajXpkSHBq8j3ru8bq7CieUpqnkfpSVCmxC3EZxhW5ZYmo+xT
         3BBYCjkrsT1ED6beuyuAaSbshhKqITM287R0hn53LWz6hkel7kmDTAkBn88fU9fVGOBS
         KV+DT6dKzPjsgaqZ83rYrvG7dWTV5j8qQnFIqLftOZ7VZ0CjrQ3vndS5WAITdzeQ75Vc
         N3/LU6iUnaUlPijo0MJ0wrvL1mqnHEZWuid8oODZBctWX5K55tmUPHOw4ILufR3+LgmG
         dyRoH2Whyh9beujhFDaW7Bp2B3PuTyDjx9qWBJicS3K0g3AN7dLnnt3wL66s77NKYcvH
         YQDw==
X-Forwarded-Encrypted: i=1; AL+hErHNzmLOk79XokzehTtOaCCDYZJ5Vwelb/23nXphYCVcxxLrzxThnmZx3Nq2hnuQlH4yH3V8WXzaWKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OSjo+rBNGjRWBIQ8WQF3T7wyqwXuue4cbEbsNuJqUQp8kPrHi
	XYOEbODM+XEIBvWY5p1zc41S0NK8TuWzl8sP+hL3KTmx6T/Tx6SlF9O5
X-Gm-Gg: AZFdTZckU1WxLKVXFL8LvGYVBqX74iD4lTMhW8727tfPZoxddiW9actOrukt4K/UanX
	l2jS+7UM8O/57uaSZfiXhmOc0qgrMGJghMOg36xEavdnjwNfBviSLAHcI1zEcm+ZMVdVJww3AhF
	Ihosz9ypJHe0zlERrRQakbxE00HJ88Z4jpScr/PhGP79W4nKoI2FIM4G7OXR2WAaYA+tELitQ3b
	L7aSommFwg5+n/eUZMA40u58p8VUzb24bZsDftNtNHVILm9zznpRJQ1RBBIJYaSH6DAMl59UV4s
	8Sc8pNCzof7NMmO8QPQqCM4pj9RyKCUCSWhwoeRlRnITJCYo4ECfTUBwE7NiBRWpQ2nTA7DPjab
	lnFobD0d9pTj2ILQ3fuj4XnXp7FY68eyJKw3TMTLQsgkbc1Zot0Y4I8gNQwvqNu3LBq+ckKCh9+
	lpFtalQo0KQv6yB+UU6g1lC5JcOvcvvSz3tyyquWoVv8qIy2RiFUfBK0MN8lwaqadhJR0IVXLrz
	5ZKhvSmqtXfp5L9J10co206pnWJ5TCSgGPELc7ldTIA9Zugu8d9eazrxj5rrxUZh0e2YTk+mZab
	tURrBriF/2etRKZZIWBuGDIwaMMvua/YpHAa
X-Received: by 2002:adf:e014:0:10b0:48f:bcdf:6f7d with SMTP id ffacd0b85a97d-4abb3c37b20mr15296742f8f.34.1795417331345;
        Sun, 22 Nov 2026 23:02:11 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:10 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 8/8] iio: adc: at91_adc: convert to device-managed resources
Date: Mon, 23 Nov 2026 09:01:01 +0200
Message-ID: <20261123070101.53868-9-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to device-managed APIs so that all resources are
freed automatically on probe failure and on driver detach:
  - allocate and register the IIO triggers directly in at91_adc_probe()
  with devm_iio_trigger_alloc() and devm_iio_trigger_register(),
  dropping at91_adc_allocate_trigger(), at91_adc_trigger_init() and
  at91_adc_trigger_remove() along with their manual rollback paths.
  The st->trig array is no longer needed and is removed as well, since
  the triggers are now owned by devres
  - set up the triggered buffer with devm_iio_triggered_buffer_setup()
  directly in at91_adc_probe(), dropping at91_adc_buffer_init() and
  at91_adc_buffer_remove()
  - allocate the touchscreen input device with
  devm_input_allocate_device(), dropping at91_ts_unregister() and the
  manual input_free_device() error path in at91_ts_register()
  - register the IIO device with devm_iio_device_register()

Redundant allocation error messages ("Failed to allocate TS device!" and
"Couldn't setup the triggers.") are dropped, and at91_ts_register() now
uses dev_err_probe() to report its remaining error.  Errors from
devm_iio_trigger_register() are reported with dev_err_probe() as well.

at91_adc_probe() no longer needs any error unwinding labels and
at91_adc_remove() is removed together with the platform driver's
.remove callback.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 187 +++++++------------------------------
 1 file changed, 34 insertions(+), 153 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 62f8db630640..5163583aa4f8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -230,7 +230,6 @@ struct at91_adc_state {
 	u32			startup_time;
 	u8			sample_hold_time;
 	bool			sleep_mode;
-	struct iio_trigger	**trig;
 	bool			use_external;
 	u32			vref_mv;
 	u32			res;		/* resolution used for conversions */
@@ -607,96 +606,6 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
 	.set_trigger_state = &at91_adc_configure_trigger,
 };
 
-static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
-						     const struct at91_adc_trigger *trigger)
-{
-	struct iio_trigger *trig;
-	int ret;
-
-	trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
-				 iio_device_id(idev), trigger->name);
-	if (trig == NULL)
-		return NULL;
-
-	iio_trigger_set_drvdata(trig, idev);
-	trig->ops = &at91_adc_trigger_ops;
-
-	ret = iio_trigger_register(trig);
-	if (ret) {
-		iio_trigger_free(trig);
-		return NULL;
-	}
-
-	return trig;
-}
-
-static int at91_adc_trigger_init(struct iio_dev *idev)
-{
-	struct at91_adc_state *st = iio_priv(idev);
-	int i, ret;
-
-	st->trig = devm_kcalloc(&idev->dev,
-				st->caps->trigger_number, sizeof(*st->trig),
-				GFP_KERNEL);
-
-	if (st->trig == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	for (i = 0; i < st->caps->trigger_number; i++) {
-		if (st->caps->triggers[i].is_external && !(st->use_external))
-			continue;
-
-		st->trig[i] = at91_adc_allocate_trigger(idev,
-							st->caps->triggers + i);
-		if (st->trig[i] == NULL) {
-			dev_err(&idev->dev,
-				"Could not allocate trigger %d\n", i);
-			ret = -ENOMEM;
-			goto error_trigger;
-		}
-	}
-
-	return 0;
-
-error_trigger:
-	for (i--; i >= 0; i--) {
-		if (!st->trig[i])
-			continue;
-
-		iio_trigger_unregister(st->trig[i]);
-		iio_trigger_free(st->trig[i]);
-	}
-error_ret:
-	return ret;
-}
-
-static void at91_adc_trigger_remove(struct iio_dev *idev)
-{
-	struct at91_adc_state *st = iio_priv(idev);
-	int i;
-
-	for (i = 0; i < st->caps->trigger_number; i++) {
-		if (!st->trig[i])
-			continue;
-
-		iio_trigger_unregister(st->trig[i]);
-		iio_trigger_free(st->trig[i]);
-	}
-}
-
-static int at91_adc_buffer_init(struct iio_dev *idev)
-{
-	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, NULL);
-}
-
-static void at91_adc_buffer_remove(struct iio_dev *idev)
-{
-	iio_triggered_buffer_cleanup(idev);
-}
-
 static int at91_adc_read_raw(struct iio_dev *idev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -930,17 +839,13 @@ static int at91_ts_register(struct iio_dev *idev, struct device *dev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct input_dev *input;
-	int ret;
 
-	input = input_allocate_device();
-	if (!input) {
-		dev_err(&idev->dev, "Failed to allocate TS device!\n");
+	input = devm_input_allocate_device(dev);
+	if (!input)
 		return -ENOMEM;
-	}
 
 	input->name = DRIVER_NAME;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = dev;
 	input->open = atmel_ts_open;
 	input->close = atmel_ts_close;
 
@@ -954,12 +859,9 @@ static int at91_ts_register(struct iio_dev *idev, struct device *dev)
 				     0, 0);
 		input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
 	} else {
-		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
-			dev_err(dev,
-				"This touchscreen controller only support 4 wires\n");
-			ret = -EINVAL;
-			goto err;
-		}
+		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE)
+			return dev_err_probe(dev, -EINVAL,
+					     "This touchscreen controller only support 4 wires\n");
 
 		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,
 				     0, 0);
@@ -970,20 +872,7 @@ static int at91_ts_register(struct iio_dev *idev, struct device *dev)
 	st->ts_input = input;
 	input_set_drvdata(input, st);
 
-	ret = input_register_device(input);
-	if (ret)
-		goto err;
-
-	return ret;
-
-err:
-	input_free_device(input);
-	return ret;
-}
-
-static void at91_ts_unregister(struct at91_adc_state *st)
-{
-	input_unregister_device(st->ts_input);
+	return input_register_device(input);
 }
 
 static int at91_adc_probe(struct platform_device *pdev)
@@ -1142,16 +1031,34 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 * trigger for classic adc.
 	 */
 	if (!st->touchscreen_type) {
-		ret = at91_adc_buffer_init(idev);
-		if (ret < 0)
+		ret = devm_iio_triggered_buffer_setup(dev, idev,
+						      &iio_pollfunc_store_time,
+						      &at91_adc_trigger_handler,
+						      NULL);
+		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Couldn't initialize the buffer.\n");
 
-		ret = at91_adc_trigger_init(idev);
-		if (ret < 0) {
-			dev_err(dev, "Couldn't setup the triggers.\n");
-			at91_adc_buffer_remove(idev);
-			return ret;
+		for (unsigned int i = 0; i < st->caps->trigger_number; i++) {
+			struct iio_trigger *trig;
+
+			if (st->caps->triggers[i].is_external && !st->use_external)
+				continue;
+
+			trig = devm_iio_trigger_alloc(dev, "%s-dev%d-%s",
+						      idev->name,
+						      iio_device_id(idev),
+						      st->caps->triggers[i].name);
+			if (!trig)
+				return -ENOMEM;
+
+			iio_trigger_set_drvdata(trig, idev);
+			trig->ops = &at91_adc_trigger_ops;
+
+			ret = devm_iio_trigger_register(dev, trig);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Couldn't register trigger %u.\n", i);
 		}
 	} else {
 		ret = at91_ts_register(idev, dev);
@@ -1161,36 +1068,11 @@ static int at91_adc_probe(struct platform_device *pdev)
 		at91_ts_hw_init(idev, adc_clk_khz);
 	}
 
-	ret = iio_device_register(idev);
-	if (ret < 0) {
-		dev_err(dev, "Couldn't register the device.\n");
-		goto error_iio_device_register;
-	}
+	ret = devm_iio_device_register(dev, idev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register the device.\n");
 
 	return 0;
-
-error_iio_device_register:
-	if (!st->touchscreen_type) {
-		at91_adc_trigger_remove(idev);
-		at91_adc_buffer_remove(idev);
-	} else {
-		at91_ts_unregister(st);
-	}
-	return ret;
-}
-
-static void at91_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *idev = platform_get_drvdata(pdev);
-	struct at91_adc_state *st = iio_priv(idev);
-
-	iio_device_unregister(idev);
-	if (!st->touchscreen_type) {
-		at91_adc_trigger_remove(idev);
-		at91_adc_buffer_remove(idev);
-	} else {
-		at91_ts_unregister(st);
-	}
 }
 
 static int at91_adc_suspend(struct device *dev)
@@ -1340,7 +1222,6 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove = at91_adc_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-- 
2.56.0

