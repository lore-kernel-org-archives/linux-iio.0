Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6025F98B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060597; cv=none; b=tOFwvyFUNLYBBD2RLGAWmnpFbH8wm14GNMlwxsMEYnBFGfduEKGon0RFftKNxWxbLAzOjHWzBt4AEPU0SdegqD3yPnyo6GTk6XE1DARMAj97p0PzCB/r7xrWGqbsaJLcQCGwn/ym5an83wYsqOMhWREFTVV1KedF74o/fRnt1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060597; c=relaxed/simple;
	bh=ysOM9Kct8nbEr9b0Y1azVTfz0Lluey37G1xkKUL+RfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjg3JyX5Ws4L6UsYqGoI0UyIcn0NYxs5MGu09aSB7WYf2lDcfFMkV4e633aitx2sj6fZGSk8XDQu1wvg9FSVFPBzpyIJ7pUg2XK6qG28PTyosgSk7ly/AZ16IZA6/ve95x758c9G+BEx/l6PZv0KMJ0fF6ntfIUvwMB1SQozUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQvcl61k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQvcl61k"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so88656785e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060595; x=1778665395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVJiSaUDY5cXEIWM3/OB6LtH3p4O/jWuhpWa5OWqcmE=;
        b=QQvcl61kDUbagQeronsGIKd5ueiPebTnFB17Ig2WWeBqQKrIVJDZL50vzhcJCjA15l
         M5x6cVjZFlV5ycaVGntvgN545uay3SZ9RpD5lz8605m3QiWBBJ95YHBB8hYYmUWqd89W
         Kp2EuQztYSpuX2nIW3bjhu3LhwgBG2jwmxUxyDFu2A3JzyXBr7TvxSMsEjAV470EJoWw
         J76tVfo2jVVRog+z5ceKndGmB0U/z/2JMyS9qeJV56xYNfrxBHjkA+/3MNyNa7CaiqID
         7F+WBguqyOZwID0p/paw6/qr177ukJLXTZThxfkbqPnvvsJ+NtdZvBMJBwfvcqwgRYgL
         XdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060595; x=1778665395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVJiSaUDY5cXEIWM3/OB6LtH3p4O/jWuhpWa5OWqcmE=;
        b=c/2/ZiD4p7Y1Yv1pdNz+ovZm2mwKjDJU4Co8/7lqcYJ2AxqIw/Lcy4as/NdBWDJG7j
         uWGCx5BEtemD3LHPTicaTTc1UQQRn+m8IbFahjXcDsFBCMm+xKXsksF9kHcNow0e5Xaz
         tvcULmWvQxMCh4Qltsh3f5870Wu72d8H0n0+OqZH6CpXdtIOxMvpf3OgyRQGgtkC9yTk
         b5QLCr9Lv6ud74txA5zvUw16ACE1GOG80ew4mvcf95LETHbN0ChoJt/VXI0NyA8GRVNV
         Ug4+VB2aUxZUN58kQPyRUICkN+tnPbI4VyBiwggESvQZJIjnieHQrvDl8tMIisN0Nq1U
         D5sg==
X-Forwarded-Encrypted: i=1; AFNElJ/eFyf8x4RKcXyqegSUjhCWNeZel4AVBiCBIWQjITTCsqntTL6xqO7h23FA0TOnmPZn52WaWJQWAz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQbibLKOxOv4sSEhjtFXwafdFqTyRDLnTmf2UW3e/YkkEEW98
	/DjLqbOMZgtXH4BCgRrTYliizws7xfMqpPtU+OrmbTSo8JhiXXsW4HOn
X-Gm-Gg: AeBDieuGV+Thpz1G9hUovPelKpfVlse2/21gtcww6tvLliYQo8TbIfo5M1tECh5Yv5w
	vJjcyk2rs9jvoOrVJ5VGr89hJjO3qznrjTIm+GmV/Zje4ek+oHPf9BTUtLtaUL0VCxASKfDr77k
	c2px6GHWTmCvteNb1EGrr60aL94sYSnIi4Pk+lx6XR/+ss6GwyDJbEWmBTUWM/PcHSLShqmwEH8
	9u+KcdSqVVAC8On8dIWnH/WaMAJ5f58QVMrFQWsPPIujtrwPXceaFHBo2inZWuOE2xP+xNBeynV
	IaJFOdTHoVmBXTy518HO5r/GMXW4G854MhYDDhkG+mlgWmlYEe/T/tZ/rtUivKAmtCpeQwjL47C
	Bs0e/iTcsIiT9h/ODz3ig5nbOaBZc6NvQyc+UxXwgBmc+5InpK9u4cWk4k1f5Jm+tXslp2ZjsRZ
	hF5l1/ViFI7+1kZoWdSaLuz6Qsk8G4iL3Dxb/RMie9jrDz1+OXtxRzlgbCysPSblQ=
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48e51f55272mr49914355e9.27.1778060594746;
        Wed, 06 May 2026 02:43:14 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524831cdsm12362230f8f.5.2026.05.06.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:43:14 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 1/3] iio: light: tcs3472: use devm for resource management
Date: Wed,  6 May 2026 11:43:09 +0200
Message-ID: <20260506094311.222500-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506094311.222500-1-aldocontelk@gmail.com>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by code inspection.

Convert the driver to use device-managed resource allocation:
- Add tcs3472_powerdown_action() and register it with
  devm_add_action_or_reset() to ensure the device is powered down on
  cleanup. Before this patch, the chip remained powered if probe
  failed after enabling it.
- Replace iio_triggered_buffer_setup() with
  devm_iio_triggered_buffer_setup().
- Replace request_threaded_irq() with devm_request_threaded_irq().
- Replace iio_device_register() with devm_iio_device_register().
- Remove tcs3472_remove() as all cleanup is now handled by devm.

Compiled with `make drivers/iio/light/tcs3472.o W=1`.

Tested on Raspberry Pi 3B with TCS3472 (Adafruit breakout):
Verified that RGBC channel reads return valid data and that ENABLE
register is cleared to 0x00 on device removal.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/tcs3472.c | 85 ++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 12429a3261b3..6d37a473c420 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -440,6 +440,28 @@ static const struct iio_info tcs3472_info = {
 	.attrs = &tcs3472_attribute_group,
 };
 
+static int tcs3472_powerdown(struct tcs3472_data *data)
+{
+	int ret;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+
+	mutex_lock(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+					data->enable & ~enable_mask);
+	if (!ret)
+		data->enable &= ~enable_mask;
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static void tcs3472_powerdown_action(void *data)
+{
+	tcs3472_powerdown(data);
+}
+
 static int tcs3472_probe(struct i2c_client *client)
 {
 	struct tcs3472_data *data;
@@ -510,61 +532,27 @@ static int tcs3472_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		tcs3472_trigger_handler, NULL);
+	ret = devm_add_action_or_reset(&client->dev,
+				       tcs3472_powerdown_action, data);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      tcs3472_trigger_handler, NULL);
 	if (ret < 0)
 		return ret;
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq, NULL,
-					   tcs3472_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_SHARED |
-					   IRQF_ONESHOT,
-					   client->name, indio_dev);
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, tcs3472_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_SHARED |
+						IRQF_ONESHOT,
+						client->name, indio_dev);
 		if (ret)
-			goto buffer_cleanup;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto free_irq;
-
-	return 0;
-
-free_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int tcs3472_powerdown(struct tcs3472_data *data)
-{
-	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
-
-	mutex_lock(&data->lock);
-
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable & ~enable_mask);
-	if (!ret)
-		data->enable &= ~enable_mask;
-
-	mutex_unlock(&data->lock);
-
-	return ret;
-}
-
-static void tcs3472_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	tcs3472_powerdown(iio_priv(indio_dev));
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static int tcs3472_suspend(struct device *dev)
@@ -608,7 +596,6 @@ static struct i2c_driver tcs3472_driver = {
 		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
-	.remove		= tcs3472_remove,
 	.id_table	= tcs3472_id,
 };
 module_i2c_driver(tcs3472_driver);
-- 
2.54.0

