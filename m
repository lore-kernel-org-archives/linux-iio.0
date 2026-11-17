Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924360;
	b=L2+Kth+3OcTN0SbYnaVzJHJzbi/UFegI7OeLhxI4+LGE1ZCoC4iA98napKolQoWf+Cco
	 asbXUAmoZxfuVMaG0oyFjbFgSrGt73XXF/lwLD24bU9MMLmnge5F7neYEb/eoYKByXgTj
	 vv6OjMs6cpM2Y4A+OmhlAkFSJBZrURm7QpDAjVD6FBbLX69sH/eh2p9Iw0XaBtqmOZf2w
	 me4hGWiJuFNKSnVWZq1WSCj+M6GzeIFV3sbPQFNV/bDbhzptzmxcROqzGPAUittck+z1U
	 pYfshKo+JBPFk7QWquyOh9IIMqqi1xsEdgaBspMlxCBbpNesRWhhjbVuZgAAh1e9EWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YnUCdj0ZJZzzvPnpwhHMUkbSJzZL3zHDWabQB4+Fnv8=;
	b=tH/xtQe3Zph+Tt7vW/hBub8xEGYF7R8i91YFLfs6hrWc8MYLLoDNRXAwqBgGuZMvTIC9
	 U6UF5LIs2MKyIydFojKGAkbhCToLRg2nG7W6xQ4rYd1wHlS+9UPOsK014vrJNKYWm169g
	 Q1dBVrgt4TrsnJE86RKeppZGwRPSKBfIjG8PhWWju9zBuN/CdsVH0eZ8Nct+zFuMAw/Gg
	 Khm7hl87GVF3jPhbTp5nNcOdIPj4l4bi3ywWzys9U0P8PRuut2ZANRlDqyY3fWFmX7PCs
	 9lvkZ6H3uekw+RUe4qscNuKmRcfCQvQXJL5onYnsMCKFrKJKLONJOytcaIP9odwNngg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DTMNlgiw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D608606A33D
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 14:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D608606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DTMNlgiw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb606491faso18007195e9.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794924359; x=1795529159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YnUCdj0ZJZzzvPnpwhHMUkbSJzZL3zHDWabQB4+Fnv8=;
        b=DTMNlgiwLWgjIaLKYHrNNvaGIMrvUBoBL/6IXu8ujmwcdUK9v/2UVooFSQT1nFbS0w
         nN6lysA2fltjqcb/aL8kbzSg9PZ3fv1IHHPikMdgJgXYWG5T5GvYBQXwW3Td388vg9LR
         FKV9e0SNVLMvrX4mh+Gek6CwHfSuSvN0NLUNU5wJOo3a5Yeio4BtuIGNZi+b527rEplf
         YrxXHR0T5Srus4zsmxDPnt8lx4tggHxK4qpcnkgurTN8VeBGHz5/fIH13aJ5NU8qlvV3
         E2M/WZag5ZGsNZ8KBN4Hgqhq/4eE2UY/MiJg3C2GHVqvWdrQvi1xA0PjpjibPDUY2Z3T
         PtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924359; x=1795529159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YnUCdj0ZJZzzvPnpwhHMUkbSJzZL3zHDWabQB4+Fnv8=;
        b=tJTsKCWQ5FMiYLHLE5Fj6io/IoDSRMyMCfZ/CeRZnB/aOpuAj6US0rt8mjdojKp0+O
         HRLg6F+ZfEftNw2+vyHJuy+zgetvNEDSU3KZ5UA/WgsrmWTv9HscKAeZX9cZO5OLzANy
         OsksMyso2V1eyayQflPeCRmdzhhEfM7y277EqHP1EGgyhPkichOgBKU9wHnWpo6+9aRi
         I4U0cU6AFq+L7mJqIumxMosJJbxXIh2Z4p9ekianZxj0yvrJy2y4YZjqP1bLYF5blh0r
         ZfLmgTlGg/zobR2vXnqTbRSZMpJLY7D6hGrOAavRo2hRmOcZI1KylZsPFa1qtcd7gCC0
         WOyg==
X-Forwarded-Encrypted: i=1; AL+hErEjaKQs1EhhSjlWkzkTUjKbNDI/dGvv0ExgOlVthyVvkN/4XvTtRumIU49dOTSX4LadyZXs3d+TTpM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y4OsDpUC6gEY+6no6EFHDiafiY6RWFjdnjzsxE8YAr8yBSsXG
	+XJZiOlVlWvZbt7T1FG0+EJIEkDLqch42kYVblrhbqT8tyr18IyPZ0N8
X-Gm-Gg: AYBFou084hhNMFyygQ3b/bMMHItob+6rC8Fui0tl64C5yFJe7AFgOzd1zYVDCzrMQOw
	vLozWgj4CtWDIsAOgAvec2RCqwSDv6uU7ZSCFE9HtOEmlsOxT1B+gXd7dELExKRk1AKeD1B6lPR
	YDlkhTr+83HCVqBa35VWvw61I4ZncoOGiGUienhIRzfoa8XB4E4cm9k3TWTn+krORxA+oRjN/t3
	xC/EvWzR0u+DNI+NujhzEaJBvospdU49chpy2H+95gyi2w2nfK97uTny9DeTyo36nvR7Z53/jyl
	At2p0sUq1Nw+iCkVzpVMbA1W+iVkZDINnxIxiIBQp+l68ok7m9Izuzv2Bd4AsKgon8fHhR/GMB3
	9NiodcpVarju7vz0RDtzLThAlQU/zTD90i1nXaYk3hdWQTuymbzSKAROcqndJTiCjj/BDqHEggB
	k5lcJoC02H2meBB/GaMIFHUzGRelWMaHP5sz87Fn+OogsK3y+hI6YlbYBPePYC9Gt+gJSEkHvZp
	fRY0rbREG83yWv/oc0DAZdTXKKy818kYPctqKBqfwRwaFYsyGRHv369V4HhJ6+n/1+1mR6L6XHt
	nrxoPk4TZwMQ3Gi+/LXG7e+JIhjD+aPQzFPsFA==
X-Received: by 2002:a05:600c:3f18:b0:4bb:6ac0:6dc0 with SMTP id 5b1f17b1804b1-4bb6ac06e5dmr155099075e9.29.1794924358798;
        Tue, 17 Nov 2026 06:05:58 -0800 (PST)
Received: from fedora ([154.183.162.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm2623032f8f.8.2026.11.17.06.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:05:58 -0800 (PST)
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
Subject: [PATCH v4 3/3] iio: adc: at91_adc: convert to device-managed resources
Date: Tue, 17 Nov 2026 16:05:10 +0200
Message-ID: <20261117140510.391907-4-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
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
    at91_adc_trigger_remove() along with their manual rollback paths
  - set up the triggered buffer with devm_iio_triggered_buffer_setup()
    directly in at91_adc_probe(), dropping at91_adc_buffer_init() and
    at91_adc_buffer_remove()
  - allocate the touchscreen input device with
    devm_input_allocate_device(), dropping at91_ts_unregister() and the
    manual input_free_device() error path in at91_ts_register()
  - register the IIO device with devm_iio_device_register()

at91_adc_probe() no longer needs any error unwinding labels and
at91_adc_remove() is removed together with the platform driver's
.remove callback.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 187 ++++++++-----------------------------
 1 file changed, 39 insertions(+), 148 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0553a08b8d24..e4cf5b1f231e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -605,94 +605,6 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
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
@@ -928,13 +840,10 @@ static int at91_ts_register(struct iio_dev *idev,
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct input_dev *input;
-	int ret;
 
-	input = input_allocate_device();
-	if (!input) {
-		dev_err(&idev->dev, "Failed to allocate TS device!\n");
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
 		return -ENOMEM;
-	}
 
 	input->name = DRIVER_NAME;
 	input->id.bustype = BUS_HOST;
@@ -952,12 +861,9 @@ static int at91_ts_register(struct iio_dev *idev,
 				     0, 0);
 		input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
 	} else {
-		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
-			dev_err(&pdev->dev,
-				"This touchscreen controller only support 4 wires\n");
-			ret = -EINVAL;
-			goto err;
-		}
+		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "This touchscreen controller only support 4 wires\n");
 
 		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,
 				     0, 0);
@@ -968,20 +874,7 @@ static int at91_ts_register(struct iio_dev *idev,
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
@@ -1140,15 +1033,39 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 * trigger for classic adc.
 	 */
 	if (!st->touchscreen_type) {
-		ret = at91_adc_buffer_init(idev);
+		ret = devm_iio_triggered_buffer_setup(dev, idev,
+						      &iio_pollfunc_store_time,
+						      &at91_adc_trigger_handler,
+						      NULL);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Couldn't initialize the buffer.\n");
 
-		ret = at91_adc_trigger_init(idev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
-			at91_adc_buffer_remove(idev);
-			return ret;
+		st->trig = devm_kcalloc(dev, st->caps->trigger_number,
+					sizeof(*st->trig), GFP_KERNEL);
+		if (!st->trig)
+			return -ENOMEM;
+
+		for (int i = 0; i < st->caps->trigger_number; i++) {
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
+				return ret;
+
+			st->trig[i] = trig;
 		}
 	} else {
 		ret = at91_ts_register(idev, pdev);
@@ -1158,36 +1075,11 @@ static int at91_adc_probe(struct platform_device *pdev)
 		at91_ts_hw_init(idev, adc_clk_khz);
 	}
 
-	ret = iio_device_register(idev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_iio_device_register;
-	}
+	ret = devm_iio_device_register(dev, idev);
+	if (ret < 0)
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
@@ -1337,7 +1229,6 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove = at91_adc_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-- 
2.56.0

