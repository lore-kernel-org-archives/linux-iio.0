Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFA3E315F
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407000; cv=none; b=Pd0GRtFAPoPu0ZrSRTg3iXBp8qcq8lN6v9oHQRZd/SBm0cEK01rqJP1PadI/iyNYI0wcbVPYU9/fB+zAvh5lwWTEECmCpmV51t50pO+C0ym11wJztmDCjTFc5UeCfjhOosN0E4SzDC13B0vO6wqnVo8kW39FAz3kaUgvkUEjGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407000; c=relaxed/simple;
	bh=5luNUag2LdyDi5VqrC1aIszbCLtLxoCrzOEgPLO3Ebg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sspPeoNXgZCUB3Y/OcX8PeJBOgXJHrPpAJfRGjCHMFZwTa6U/mr4WWR7Do2jWTGFQayOwIlhuYAsBjVZ3Hcy6xhly+sezhcDgMn51GcqbX6UsWE3wPo+PxSrM2uGy+dcqCKckAnqd/+tQrE3zn+1Hqh6ELFkOWYzmnr3M5lCjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNDpXUXI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNDpXUXI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso23576225ad.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406997; x=1781011797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4tHaCTkkKCoM4U1oOnmJumPoDSJ1Hmje5FiTiMmUUs=;
        b=dNDpXUXIEqTRkoQUpObTQ0lDt79vtpOnUoL+vo16VFxhcIVVZItLa8uGyjKdFUbArA
         QO7YB753eV+7OeU6FKN6yszZ+LB64ZmhP85+qCQnXE38G2iDjs/5EQ8+dvuArGBHu7mN
         tKOCeaIddM9LJ8c85ur3MK3bHXWvqkfYvl4AvouCO0Vw/B1mydF6AFNc8hfx1PMqYlAt
         D1cqUIapZb6OxRJ/M0w0a1TsYz93TEnDRpX1VWhbTuJ/f7/+hN0GhhGoztb39LdRL0n3
         0e7VT40DF7oKo5HBBEhExEh6we5toc+tJEM9BLSXpK5qZZYZUEKfXBdENJ4xF6KnYjGP
         2gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406997; x=1781011797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y4tHaCTkkKCoM4U1oOnmJumPoDSJ1Hmje5FiTiMmUUs=;
        b=Xwhoum+X2KCXdDg499eQrwxR8LKxmMxJ9JL/iCwlSPQEESvGhTD0j/XXZxqFqRF2os
         ZAAvOfflFjMJW/Dsl5mrucRmHt6mxFHINvKL+o36KO4qcCRFhJo+KdcaJ2lrRaNgIYfg
         wR0YZx+Jq09S8z59p+moO7MKeb8q2eNSXKKBT7+kFpIt3rnwPNcV66PDOKn4BsTFGLZq
         uyuJcgNaHNfrBlF+x6CK4tSvNetkzQkZqingolGTlOgLwTR69bWIdJhOTwoVCWhN45xF
         cAcWiDq07UNm15Yn+b1X+eInIlMVrzTiqjOPbZaa8zWbV9p404o3h5LFXt61FnqejyMr
         28zw==
X-Gm-Message-State: AOJu0Yx80sVzRYuIrcwNb1e1gDGJaHeUFiuf4Z6oGwCCH8EpB5AKqhiC
	SHB/OekqeIC/4hJfLfnkay76GcgFcVaDHvV+x8tkKtmdigAYByMhluPqLDHXNw==
X-Gm-Gg: Acq92OFnytiblxvODvaAsL8SbM0EsHef5JZlv79vz5RPm5NkbC2x4lJUX067hoEkoyd
	Uug8OK+pkQ0qtYqQf6iJFGjELSwjmpUb9H51e0S98L0+OCgYtpfBArlyXrpy7FU19DQ30an3uxm
	iJk2HtG5VKQF+NVKKk5DO5qwFCFOaGy2lEOo2U8pnUPPcv/MAPd4xsnnGed4u1qbycG9EpX8aw2
	4tZ1o2DEffoFx4wRsewwheg9Yn/+XwS6X363YpHbzvPYmqbG4v9IFn5tgjyJUXFPcvgxFx9Dr2S
	O8UoCAVx1b/6BFyrjOx+Tz+phzinDpv/eCht5s7zBeF0PgmCCC3lwuxYapYWh2LxsoMfU9LNMWK
	bsVi6lOkLcC+JVD/5prslNkzHtVoz3+vxF/DsW30107vC+BKbpoycDilsUdOmo8LF2EwP6xehgE
	K44hcw3uvr/LaWaETakPK69lqiaCuJIPy2aO/8Px2NL552eNIC4Ogkf9jJwD8=
X-Received: by 2002:a17:902:e785:b0:2bd:d7b5:83ed with SMTP id d9443c01a7336-2bf368d10d5mr180385505ad.39.1780406997375;
        Tue, 02 Jun 2026 06:29:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:29:57 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 02 Jun 2026 18:59:23 +0530
Subject: [PATCH v4 2/5] iio: accel: mma8452: use local struct device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-2-26d6dff8fc55@gmail.com>
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

Introduce a local struct device pointer derived from &client->dev.
This avoids repeated &client->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

---
changes in v4:
- address coding style comment given by Andy
- v3 link -> https://lore.kernel.org/all/20260505174640.3998281-8-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index a44b2138951e..1d4ea614cb57 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -223,15 +223,15 @@ static int mma8452_drdy(struct mma8452_data *data)
 static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 {
 #ifdef CONFIG_PM
+	struct device *dev = &client->dev;
 	int ret;
 
 	if (on)
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
+		ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
+		dev_err(dev, "failed to change power state to %d\n", on);
 
 		return ret;
 	}
@@ -1553,7 +1553,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1563,10 +1563,9 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
-				     "unknown device model\n");
+		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
@@ -1599,7 +1598,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1632,10 +1631,10 @@ static int mma8452_probe(struct i2c_client *client)
 	if (client->irq) {
 		int irq2;
 
-		irq2 = fwnode_irq_get_byname(dev_fwnode(&client->dev), "INT2");
+		irq2 = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
 
 		if (irq2 == client->irq) {
-			dev_dbg(&client->dev, "using interrupt line INT2\n");
+			dev_dbg(dev, "using interrupt line INT2\n");
 		} else {
 			ret = i2c_smbus_write_byte_data(client,
 							MMA8452_CTRL_REG5,
@@ -1643,7 +1642,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1680,14 +1679,13 @@ static int mma8452_probe(struct i2c_client *client)
 			goto buffer_cleanup;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto free_irq;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
-					 MMA8452_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -1722,11 +1720,12 @@ static void mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &client->dev;
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
@@ -1749,7 +1748,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 

-- 
2.34.1

