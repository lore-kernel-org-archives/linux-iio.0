Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7333A75B8
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625144; cv=none; b=rbLyXVcPV637l6XzyyA9hHNlTqFFsJd+BNuSqHPSoJWOWsJ6tTL/aFy3xD3z840JD3mgtWoHlCA6X7HxeLSmjGIvv0n7fmzPZI6eXd7uNoQtj/Z9RZPZbb2TzYxoifrKqj5yQunQltAeIpC4PtslCvwMJaOaXiEn1b3SFqD4v+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625144; c=relaxed/simple;
	bh=OxzII+fOTTxXBAPQvr40pTgzrSo9pzEfYKV4fx4Ik4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBCOC6Hw2OGk1PhkD/CII/Dg+B7myBioGzTXz/ODjWxJIDgDFlOKvhSHHmZWSjdzQDczFgOrCHZt9njB9R8C0q5hiut0Uhksh/62HW2Rzm+IrARfRZNlra2aPEUchVktR+M9nEkm7iH0OFrFdqsvLDJgi7razQYMH/nDMnoKJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVEFdP7+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVEFdP7+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b150559bso47407145e9.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625141; x=1779229941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZwtfBXvrnH+M3GRfA8qi3bYkua4D8Thb1Hd5ff45dQ=;
        b=bVEFdP7+9TUQ/PBNM+c4sRcR1SqNweYViJsIrhjZR46CigirUo1vhhy+XzL6K3fGSB
         4Rk61YcwbY9w7Hb0bUXygm4NWGTxGo9FrZ2Pbuv1cxJZOF8BqMZnOBRPTzGiRHNKCoRe
         oFt3qFimyQG6F9wv6gR5aA7Y+HiSB0vkJE6KPG/OvWmL11iQ/heUpynYI26lqgviIoY4
         vCyIJacoh6kQB/jrT09EP4Ewr2xz0j5AFoajtTAgsl2zT8mApJ9gU6BNk38zrZE+SYFK
         ZN7NrHy1KxkANXSIySG6G0LB//yew29QG5N+h2iaJPOibtYYyy80sUlsaPcrwS9A7niA
         mDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625141; x=1779229941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZwtfBXvrnH+M3GRfA8qi3bYkua4D8Thb1Hd5ff45dQ=;
        b=Ab8O2NLlKaTFb0brI/j0mBAv71jX0Gq5gkbv2ng4fmAAFyq9zHw2IC4J49Vu+qI04V
         SMgCDkmaHGF+Yan/EkANV22Nh67cz1ogpVygANgz6IhJ8XT/iLV2fRJ02pgp7HC/b8VQ
         bEkuW1FoiO3ByU4s/eT47joztedLXhBKODJ3MxaL8qERtX/bt0QSL3O/IAMv2Hn5sY7i
         YpV0kvSJ1iDW0wSrAWYaM6G1xGsHdv5qrEL8W4eyWML6gvPVuIdXbLM9qSGvo6g0iXTg
         7IMbE+a8y7/5i3BkOQppdb0F90DYZilXCDDNSiXHdtOsWUYMvlcffNLXC/X1PKayPSxd
         zy+g==
X-Forwarded-Encrypted: i=1; AFNElJ9mNO9jGjGwar7l5C87CHWeEWAV+s16+d2orCdZDKZZPaeZ3oOrjuQIRhJwdqwBHw3QcWZTY4+2flI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/nkyJZ7gIh3fajwW65WVZoo44crXf1avOQqKoFApJbX1trAT
	Wb5VCd8sc9eSIgvvV96V8ubyExQJSzaG5Euj9jd0by6XVHkUWdDljFpM
X-Gm-Gg: Acq92OG/XC5a6lPV0VDmvxSWE7a9GDMk4u9yqUoU3hKGMCgpiGtHIru5VEo/ca6ou8t
	Fy4IU80MascC1VPM4Qe1cw4rZEyY/anb1obIF5G+BdV2yFd87GAPw4ku57OdJ8mezotfg9aN1sP
	12xcIG2/Vj5dvHOrGM0f0abEieQsg73/JywbzRhqarU6+avcRxo93XPhLnZ9l9KwAlW6k9pyNxl
	/et4GzNCXcsULdfKywYeLA6IEZKHlUFqa4dA64gaF0xhXW+N/euRK6IMtTu1G7RP6orqgQYwb9s
	LDFQVkwh/xnBcs72cqjEK0+bPbRTOQoBA8RivkAJ21oTUSaR5v65mq4C/GJZkVJKV2vlptr9YjV
	ATcFvTZpCtAwlMlPN1jZ8ll9PHYmyXWxjyu/SOE3eE45SYSn704aj6UBLMZNd58aoZSv93lf9da
	7GVs/RyMy3Qnrku5pSavqj1uwog8DX/lNAyfz0R/GRznZjzsE0rU5A4Nc=
X-Received: by 2002:a05:600c:8b75:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48fc9a3b8e2mr8939265e9.21.1778625141046;
        Tue, 12 May 2026 15:32:21 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:20 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource management
Date: Wed, 13 May 2026 00:32:13 +0200
Message-ID: <20260512223215.25596-4-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Rewrite the read-modify-write pattern in tcs3472_powerdown() and
tcs3472_resume() so the new register value is computed first, written
to the chip, and committed to data->enable only on success.

Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
calls compact.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v2:
(Suggested by Andy)
- Rewrote read-modify-write in tcs3472_powerdown() and tcs3472_resume()
- Use local 'struct device *dev = &client->dev' in probe.
- Dropped "Compiled with W=1" and test details from the commit message.

 drivers/iio/light/tcs3472.c | 107 +++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 4fd4fd74d0d6..7a6dc8360326 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -427,13 +427,38 @@ static const struct iio_info tcs3472_info = {
 	.attrs = &tcs3472_attribute_group,
 };
 
+static int tcs3472_powerdown(struct tcs3472_data *data)
+{
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+	u8 value;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	value = data->enable & ~enable_mask;
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
+	if (ret)
+		return ret;
+
+	data->enable = value;
+
+	return 0;
+}
+
+static void tcs3472_powerdown_action(void *data)
+{
+	tcs3472_powerdown(data);
+}
+
 static int tcs3472_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -453,9 +478,9 @@ static int tcs3472_probe(struct i2c_client *client)
 		return ret;
 
 	if (ret == 0x44)
-		dev_info(&client->dev, "TCS34721/34725 found\n");
+		dev_info(dev, "TCS34721/34725 found\n");
 	else if (ret == 0x4d)
-		dev_info(&client->dev, "TCS34723/34727 found\n");
+		dev_info(dev, "TCS34723/34727 found\n");
 	else
 		return -ENODEV;
 
@@ -497,59 +522,26 @@ static int tcs3472_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		tcs3472_trigger_handler, NULL);
+	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      tcs3472_trigger_handler, NULL);
 	if (ret < 0)
 		return ret;
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq, NULL,
-					   tcs3472_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_SHARED |
-					   IRQF_ONESHOT,
-					   client->name, indio_dev);
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						tcs3472_event_handler,
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
-	guard(mutex)(&data->lock);
-
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable & ~enable_mask);
-	if (!ret)
-		data->enable &= ~enable_mask;
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
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int tcs3472_suspend(struct device *dev)
@@ -563,17 +555,21 @@ static int tcs3472_resume(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
-	int ret;
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+	u8 value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable | enable_mask);
-	if (!ret)
-		data->enable |= enable_mask;
+	value = data->enable | enable_mask;
 
-	return ret;
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
+	if (ret)
+		return ret;
+
+	data->enable = value;
+
+	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend,
@@ -591,7 +587,6 @@ static struct i2c_driver tcs3472_driver = {
 		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
-	.remove		= tcs3472_remove,
 	.id_table	= tcs3472_id,
 };
 module_i2c_driver(tcs3472_driver);
-- 
2.54.0

