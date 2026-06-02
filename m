Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233A3E7BC8
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407003; cv=none; b=FA+qnsrbKGQTS/xqXzBgjse7nDPEiCZA5d+ce5IKED3l+wz16JUuI2t0DU9+1vD1qjeV/CrRuZfHAsb56wIDhzJf197dMyYO2zEzZTRqJsII5gKpuK8qcIMzy6AuczXl4tlFCExNpHUHu5WinIgSeTkUaGrd7AGENwkVtLuLJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407003; c=relaxed/simple;
	bh=UAxysoLOtPXkCKKBbVeZ/NdrEshD67y9hT16xuUyyNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtEmJqV2YPJoNJHiLI8BJ4CsbG+SnC7dlQNwgJesNRgZTuCBSSiZB6OyWEEqVfypKg7JMJw+9ijtseHK3TUxOjjYXtgOyiMw6hpaV/YzaBVK8On5pyAC6Rj5v08TcmgF10l331R2XQbPmwXmhL5AqcXF+JzsjhxZxt1nNKx1kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLIUbTZ3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLIUbTZ3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso24814615ad.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407000; x=1781011800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YboqZEuw+gOjdr1gHfn4j6PrFCUPhfLuODlwaL1RxTs=;
        b=CLIUbTZ3SfaFkdrM9EtRZ3aAvPlQ4eKkih4HIkJNbUplNA0Er2V8jsm94lhmCa83RF
         HutKrN+nj6TgP5LTiMkKNBYj/Ykr6GEdTorCvK2iFKi6x/q22XoceMiaX/wKoHP/rAIV
         BCCO5tIJw7euVBJ8vphaJmFwVT/LNHn2qzlpVZAEa2ktBUaH2mAHGiw7lCCdX+Id/1iq
         RBB6oybw9Tmex6awratzSUrDFLZ2mFuS7fwM5ctzfrDP6XhkgnXllvtoOEKbEhhOKvyM
         iI2qvzk5TB+1Yy/MfAJQiN58bGV4tGve5qjjY3S4Oute1OYzojEqsRr6KCNcwPy29Cvb
         ECYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407000; x=1781011800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YboqZEuw+gOjdr1gHfn4j6PrFCUPhfLuODlwaL1RxTs=;
        b=o/vU+iK1OgPnkkopo3G7x/ByDirTKHgel4g3BmunYTp7htIRvAJ0hZ4rXeSJ10z3lt
         /ZUNngaY9+qs9KAXvY+lbitFwS6AiOz4RMjAzueHfGD4/hcydCnBFwKJV9zU9r6nX7Ry
         QTD0y57BI9XvNcZk9co4OEmABnb1AZCVLI3uKr/5uyhbLVfKn00uJr0kHnYlSzdChMaK
         GFAHCu68KsM7NmXg9usCtFCQRHL7n4nlyaW+dcwPhoiSYHlImCNNM8SVgtrk6cGJks3N
         p5TA6W3q8VXntgBHRAzlF3f56PnBUQY0x++5W5VCyucPG+Kp6xSZQPHLqBmvFBZ/bKX8
         XCKQ==
X-Gm-Message-State: AOJu0YyDwjKQxGz5RrfhCdeM8yrYyHeJp6iYxvTdiF1WKGFcPpvjTiaU
	yXJf6skxbFxnPUSd8Q7QLlmaYfWNxafkyOWkuqEtf/Cku5uk15Ad1PqaNHWuqg==
X-Gm-Gg: Acq92OFzPw78zNUwAsOCj/NEOBRaharcOwKQ/VduvOTWvzpudd6guT64lIY7JjUm7g6
	Nik9RTkKInIG2Jz1PknNtAFtwEWV0Gu83sqnDDZHr66b00QQ4m9ZqiGQfNW6hAubWKkwpx5XHNk
	bLXsYJD2oRCODWzwDmnEHqUt0JM5jlY3rJj2XtBtq+j2Uw7Ujv93ww3RkJDYYNj1DQr+Lc8kUCk
	w3mFN+WGI0SNNoT0owfbQGvHTRsfgRMYCjPMdcpaa8o0GO3UGcJ1WMyF0Z0vPWlwFqCCkVx0May
	B26KOdGtyKrf8tJ6mpq/TGaTetRqziiRopX+Jt3SKxWoVKKyY/8y+rwY7Du4elpOx+t/4YZR22i
	Z8ptZtYnYNq/Cq6+u93Y9+AzuoA47lFaLqsrBrXkexvTGni7kwrWNf8R6uf3wAM/DEn6E2kpigz
	cCxbhtLwECuirWjhgI+We4AEGH57dSxMiJFBj8+WkThoPFOnHcAbNOeMrQStw=
X-Received: by 2002:a17:903:2407:b0:2c0:d1ad:d123 with SMTP id d9443c01a7336-2c0d1add87emr116231755ad.39.1780407000413;
        Tue, 02 Jun 2026 06:30:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:30:00 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 02 Jun 2026 18:59:24 +0530
Subject: [PATCH v4 3/5] iio: accel: mma8452: use pm_ptr() and direct
 runtime PM calls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-3-26d6dff8fc55@gmail.com>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
pointer is automatically handled when CONFIG_PM is enabled or disabled.

Switch to direct PM runtime calls and drop
mma8452_set_runtime_pm_state() wrapper, which is no longer needed.

While at it, fix runtime PM handling in several paths to ensure proper
balancing of pm_runtime_resume_and_get() and pm_runtime_put(), avoiding
usage count leaks on error paths.

This follows modern kernel power-management conventions.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

---
changes in v4:
- fix runtime PM handling by balancing the refcount with input from Jonathan
- v3 link -> https://lore.kernel.org/all/20260505174640.3998281-9-sanjayembedded@gmail.com/
changes in v3:
- Use direct PM runtime calls and drop redundant wrapper along with CONFIG_PM
- v2 link -> https://lore.kernel.org/all/20260422165643.2148195-6-sanjayembedded@gmail.com/
changes in v2:
- Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0-day bot warning
- v1 link -> https://lore.kernel.org/all/20260414192045.3598010-1-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 110 ++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1d4ea614cb57..467e42c2c0dd 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -220,43 +220,21 @@ static int mma8452_drdy(struct mma8452_data *data)
 	return -EIO;
 }
 
-static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
-{
-#ifdef CONFIG_PM
-	struct device *dev = &client->dev;
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev, "failed to change power state to %d\n", on);
-
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 {
+	struct device *dev = &data->client->dev;
 	int ret = mma8452_drdy(data);
 
 	if (ret < 0)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, true);
-	if (ret)
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
 
 	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
 					    3 * sizeof(__be16), (u8 *)buf);
-	if (ret < 0)
-		return ret;
-
-	ret = mma8452_set_runtime_pm_state(data->client, false);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -975,6 +953,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 				      bool state)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	int val, ret;
 	const struct mma8452_event_regs *ev_regs;
 
@@ -982,17 +961,22 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	switch (dir) {
 	case IIO_EV_DIR_FALLING:
-		return mma8452_set_freefall_mode(data, state);
+		ret = mma8452_set_freefall_mode(data, state);
+		goto pm_runtime_put;
 	case IIO_EV_DIR_RISING:
 		val = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
-		if (val < 0)
-			return val;
+		if (val < 0) {
+			ret = val;
+			goto pm_runtime_put;
+		}
 
 		if (state) {
 			if (mma8452_freefall_mode_enabled(data)) {
@@ -1004,19 +988,31 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 			val |= BIT(chan->scan_index +
 					ev_regs->ev_cfg_chan_shift);
 		} else {
-			if (mma8452_freefall_mode_enabled(data))
-				return 0;
-
+			if (mma8452_freefall_mode_enabled(data)) {
+				ret = 0;
+				goto pm_runtime_put;
+			}
 			val &= ~BIT(chan->scan_index +
 					ev_regs->ev_cfg_chan_shift);
 		}
 
 		val |= ev_regs->ev_cfg_ele;
 
-		return mma8452_change_config(data, ev_regs->ev_cfg, val);
+		ret = mma8452_change_config(data, ev_regs->ev_cfg, val);
+		goto pm_runtime_put;
+
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto pm_runtime_put;
 	}
+
+pm_runtime_put:
+	if (state)
+		pm_runtime_put(dev);
+	else
+		pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
@@ -1453,22 +1449,39 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	int reg, ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
-	if (reg < 0)
-		return reg;
+	if (reg < 0) {
+		ret = reg;
+		goto pm_runtime_put;
+	}
 
 	if (state)
 		reg |= MMA8452_INT_DRDY;
 	else
 		reg &= ~MMA8452_INT_DRDY;
 
-	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
+	ret = mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
+	if (ret < 0)
+		goto pm_runtime_put;
+
+	if (!state)
+		return pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+pm_runtime_put:
+	if (state)
+		pm_runtime_put(dev);
+	return ret;
 }
 
 static const struct iio_trigger_ops mma8452_trigger_ops = {
@@ -1737,7 +1750,6 @@ static void mma8452_remove(struct i2c_client *client)
 	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 }
 
-#ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1791,13 +1803,9 @@ static int mma8452_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops mma8452_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
-			   mma8452_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops,
+				 mma8452_runtime_suspend, mma8452_runtime_resume, NULL);
 
 static const struct i2c_device_id mma8452_id[] = {
 	{ .name = "fxls8471", .driver_data = (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
@@ -1814,7 +1822,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
-		.pm	= &mma8452_pm_ops,
+		.pm	= pm_ptr(&mma8452_pm_ops),
 	},
 	.probe = mma8452_probe,
 	.remove = mma8452_remove,

-- 
2.34.1

