Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302947;
	b=rKAXePks9WC9YTOo7vVs8rq8U6Nnp5hRkY4x+g/xE+0Nb6wKoc3nK+2+xDfT9FaA/J3N
	 54AUFPLtqbwV8NTE07pMwpSdLCquybhjUcqt4+5l6wpiTE+wSAqiFyq5L8W2kjjdh+z7h
	 RhcjoGvgeDSaupPZBu7DGTXBdmq9gScnOxL6MDO7kjO3f+pfv5+WDw7PCTuAq8sqe8SEE
	 3EOk6wIbxf3hhMc3P8MLMUDhu4XTX1RuImSiMZNA73YfLkWlpKixdepf6S+NpMT+/UFXr
	 deUa62GPCxF0Be6+jCnUbMwT9pOaMm/RdHZFXfI6y00prSClnEa3BOfhai+Q6DaMc6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s1yLVKZqUlNj3njloZ4RcEDWvW8KSQFnV995646mHlk=;
	b=GrAPqgLiuuHVZRQPuydTexlOfMilHksjNTdG11Sw/myTQPMJ4uJmIHmgz8AhQaAdPmHa
	 1+zai6bC4iV/AFiPkdc74p5XB0h/yir6kvFBovRYU430Cua4JxAByvuLdIonP/FZFeY65
	 0wTyf9AEm4f7JdawKjZNQhBPxS1aov/3vsU0mro1hnuwWuASL0sDcfsEXc7R79asIS/QA
	 8XB+tWsnh9JqhMAKM5D2ay4Xc0uTp5b8kVcNFw5sPZsH0h0ElyLFG4ge64hnt2E/uJJdc
	 +X9Ps8ze2rbA5UqGMTGRSn3myQTZU4L60ze5KSjX+sJ3xeL8l1ig63otT+io2i1WMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDxXKQMo;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2D606B157
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 09:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C2D606B157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDxXKQMo
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b001cd92bso856096f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794302945; x=1794907745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1yLVKZqUlNj3njloZ4RcEDWvW8KSQFnV995646mHlk=;
        b=UDxXKQMoogTknpK1OPVncqXSm0G22RJgQ0FxIgPiMQaF2OJT500Q9tbbv+Tv+t5bOv
         4w4+ZxmMhb/fgy0FHH4HvD6vfIxqnkl62PfN6mzqtCgRUnOREeSSWtOQWr/3RpfQuzP9
         Ns9uxY/Hs523nHUL4cXA7tQPO+07rJxzz8OQ2lgiS3l53zWH2iYySdKiJjv9eoPrRR6+
         HG2NtC3puEQ2q0fLaWcsrC35e7r6LIpBPxaymZalvjNPFLK2YQNupKVOcThyOqqmsdXh
         NNTc4B1yrJzTS+OI2uma7W0eA97/oW3fgeNX2ntRzUoAQXjiYZXiIuGxDvrZXR6pSLpl
         001g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302945; x=1794907745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1yLVKZqUlNj3njloZ4RcEDWvW8KSQFnV995646mHlk=;
        b=isex6aGmGZfvnKTLJxuQtvjXjJNvBolIh3gyaifRIrZ/KsW0Cvhq3nTghfeifEAZi6
         mSMr7BkxHsHHqNFHu/y0YuGLtslBGrMRg/P1zjoU1nZ4hv0z7l85HezOhd19hRuXNeo6
         TIupCs6S5rw1uWVDrRQnq4aMP5k4X/ml+8E2TImeft5VCicpAT02lqX9urtAYES03RBl
         fNnmzwd4GCctfFSfxE9qW19EX5PuErOsTecL8iO+0WV4fHuQ1RNHMfMJXf+ctM+Z886M
         x7woIoZHhxh265r+U36qkCc8OpwxkgBlIBv4KBU1/Tf3fhiSNRI24Si0413JXwODslzj
         Acrg==
X-Forwarded-Encrypted: i=1; AL+hErHjPDFKQPLUt+/C/cj3uqt3y3UT+CebZSqAjqumriwv2jvfnkyJ3lc23eOr7t0KT+8f6OYGVHOPBbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GDWiYq3AFrpqZ0gwIOGH0BGoH3G4/E9dCwFjL4VCDSBHJzeox
	fqS+e9IhxL7q5s3wVs8ph2wrQ9Ss0sbupWll4lhIWAnkyGVTjKjElgIU
X-Gm-Gg: AYBFou3mkdxQ6fmjGmchz28fXOZODCEdV82hiyUO4Jmx6eebQkDY5q/OtKf8RNY8PLY
	n6K/dbO54aNDDa/ZHhhG9PMPxIp3CPksvwDaQ/QrYK+jJZSFqzV1Fh62DpFNIGCpcr2mI849mFd
	iTtEl4a9Is/RmpS2Vgm2rA7Lsqc7xOiEv9kXklWW8rscjfsLtKvidEFB/boy+S1FNWvYz9UJniV
	m1EGVRWW8zsjqiqL+zatsS8P+nPqoeruS00YGiDZT1TMBOiMT5UjVaiqi/9H91+GX0VikdHdYwD
	LM+m9PoScexGLXKxBmTxwPYSSXk9VVgUnqYltbfGx6I870SsJ3Q5uEvM1mcpsPRL3hhRjrgbiw+
	cQnfsdcHoW3S6lRtdmH9Uv5yIeQ4YEcht7tsXE89iyykpwAEK8sYqOLnUXg1+F3EbBzj/a4Rett
	nmnpSPar7c15VJew+9pgN+XrTw0CEMu9O/koAiu03GmiYBSxwFG7bsWi5IhRiAOiOzgYq/CI44u
	B+Op0/UiCI5MP9CQLPRmJT+HJBkaYZds5G0oI5qI8xSanpWx9tPEzZe7mkighyx3WRsgjJNH2X4
	0jz7DP26DBBNoCLz8Z4kLSX5lsMTT8hR6358
X-Received: by 2002:a05:6000:3c5:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-4982e641f90mr3524247f8f.11.1794302944660;
        Tue, 10 Nov 2026 01:29:04 -0800 (PST)
Received: from fedora ([154.182.80.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983f7801bbsm3839798f8f.5.2026.11.10.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:29:04 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2] iio: adc: at91_adc: move to devm_* to fix NULL pointer deref
Date: Tue, 10 Nov 2026 11:28:48 +0200
Message-ID: <20261110092848.141854-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
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

If 'atmel,adc-use-external-triggers' is not set in the device tree,
at91_adc_trigger_init() leaves the external trigger slots in st->trig
as NULL. The error paths and remove function unconditionally called
iio_trigger_unregister() and iio_trigger_free() on them, causing a
NULL pointer dereference.

Instead of just checking for NULL, refactor the driver to use the
device-managed (devm_*) API for registration and allocation. This
modernizes the code, eliminates the need for manual cleanup functions
(at91_adc_trigger_remove, at91_adc_buffer_remove, at91_ts_unregister,
and at91_adc_remove), and inherently fixes the NULL pointer dereference
since the core handles the cleanup of properly allocated triggers.

As part of this simplification, the remaining trigger initialization
logic has been inlined into at91_adc_probe().

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
v2:
 - Dropped the simple NULL check approach.
 - Refactored the driver to use devm_* API as suggested by Jonathan Cameron.
 - Removed manual cleanup functions and error paths entirely.
 - Inlined remaining trigger initialization into probe().

 drivers/iio/adc/at91_adc.c | 146 +++++++++----------------------------
 1 file changed, 33 insertions(+), 113 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..911838150116 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -608,85 +608,32 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
 static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
 						     const struct at91_adc_trigger *trigger)
 {
+	struct device *dev = idev->dev.parent;
 	struct iio_trigger *trig;
 	int ret;
 
-	trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
-				 iio_device_id(idev), trigger->name);
-	if (trig == NULL)
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d-%s", idev->name,
+				      iio_device_id(idev), trigger->name);
+	if (!trig)
 		return NULL;
 
 	iio_trigger_set_drvdata(trig, idev);
 	trig->ops = &at91_adc_trigger_ops;
 
-	ret = iio_trigger_register(trig);
-	if (ret) {
-		iio_trigger_free(trig);
+	ret = devm_iio_trigger_register(dev, trig);
+	if (ret)
 		return NULL;
-	}
 
 	return trig;
 }
 
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
-		iio_trigger_unregister(st->trig[i]);
-		iio_trigger_free(st->trig[i]);
-	}
-}
-
 static int at91_adc_buffer_init(struct iio_dev *idev)
 {
-	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, NULL);
-}
+	struct device *dev = idev->dev.parent;
 
-static void at91_adc_buffer_remove(struct iio_dev *idev)
-{
-	iio_triggered_buffer_cleanup(idev);
+	return devm_iio_triggered_buffer_setup(dev, idev,
+					       &iio_pollfunc_store_time,
+					       &at91_adc_trigger_handler, NULL);
 }
 
 static int at91_adc_read_raw(struct iio_dev *idev,
@@ -924,9 +871,8 @@ static int at91_ts_register(struct iio_dev *idev,
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct input_dev *input;
-	int ret;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
 		dev_err(&idev->dev, "Failed to allocate TS device!\n");
 		return -ENOMEM;
@@ -951,8 +897,7 @@ static int at91_ts_register(struct iio_dev *idev,
 		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
 			dev_err(&pdev->dev,
 				"This touchscreen controller only support 4 wires\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,
@@ -964,27 +909,14 @@ static int at91_ts_register(struct iio_dev *idev,
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
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
 	struct device_node *node = pdev->dev.of_node;
-	int ret;
+	int i, ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	u32 reg, prop;
@@ -1140,11 +1072,23 @@ static int at91_adc_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, ret,
 					     "Couldn't initialize the buffer.\n");
 
-		ret = at91_adc_trigger_init(idev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
-			at91_adc_buffer_remove(idev);
-			return ret;
+		st->trig = devm_kcalloc(&pdev->dev,
+					st->caps->trigger_number, sizeof(*st->trig),
+					GFP_KERNEL);
+		if (!st->trig)
+			return -ENOMEM;
+
+		for (i = 0; i < st->caps->trigger_number; i++) {
+			if (st->caps->triggers[i].is_external && !(st->use_external))
+				continue;
+
+			st->trig[i] = at91_adc_allocate_trigger(idev,
+								st->caps->triggers + i);
+			if (!st->trig[i]) {
+				dev_err(&idev->dev,
+					"Could not allocate trigger %d\n", i);
+				return -ENOMEM;
+			}
 		}
 	} else {
 		ret = at91_ts_register(idev, pdev);
@@ -1154,36 +1098,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 		at91_ts_hw_init(idev, adc_clk_khz);
 	}
 
-	ret = iio_device_register(idev);
+	ret = devm_iio_device_register(&pdev->dev, idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_iio_device_register;
+		return ret;
 	}
 
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
@@ -1333,7 +1254,6 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove = at91_adc_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-- 
2.56.0

