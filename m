Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D1382F07
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877021; cv=none; b=AVnw06Xg3TomrV2WNtiOmUuAyl5gY8d4SqJ1oFLOpFV5ONobG3IA6X6LI0gZaFkGSEziA8xIuGJMYr7KW1HM1BkVY3FEkWjEdz8Vzyv/XkWMcOjOlZjgwzk8vE54yYh3ThNZ+y3Or9Dv/IApxSY8GsCX8HCm5o3YZ/In2Ye0J4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877021; c=relaxed/simple;
	bh=/DEF03+Ny2zofE3o7sXb1vSvhn7QhkSEjmX8qFoy/Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3Xa+NjqGiEm4gmCxPR3zWB+k7VFmm9mGWf9wV4hxIjJ8IJS8NmEypMyjlPymUNQwXVOap6PkBucBis+Epr9eVaejjEpQYMz7YvJqlBa8J1BXVEG+PATivLUJyBHkXCcnEByxyzI92ghZBtciVFT7S/hYiXi/x2wkpTxsLk2ULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSpm5I+n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSpm5I+n"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c795f096fa5so2306731a12.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877019; x=1777481819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo6cBzpo0BEVINRfHFaDDZPqy/3hvitzq+I6vTy8fqs=;
        b=LSpm5I+nWUkLLeQ2iOujt6YK7DErP6Edqwn8S66oLrJMYFflx/Sr6lXOLX3zz8JJHI
         8yYzZB4Uqoux5rKoO3l9ivGL8mL8wcLshJcpgmjrTnGTHwfeS089aNtFS/BkFZVuKN8c
         yvONtCawh5A+1AWb+Mb98R6c2umZr7THEJJziabPCk5OxBFH5kBH5ZZnqVbIp+4/ozYu
         cetJiDHV75ShRFzbx6DxXkzPNaHTa3Yl02KSEUuKzpJFO143AExZ504epXQ+/WMDGdxj
         yduf2Bg8r4PRcSZoQJzwuGF5ofWaj7n8mmJbhvG8OXKu+lHIIa93mmAVzfff8aRm6HSU
         /p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877019; x=1777481819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zo6cBzpo0BEVINRfHFaDDZPqy/3hvitzq+I6vTy8fqs=;
        b=Scnv3q3WW9KCIuURvIaRBx253/AT9SbNQpUh79nTTxay/kqMvaquG+Ochh5aiCivm/
         m3XvhrQhe4i3WJ3c8JpWTDuqEFmGma4pnD/I0lfPn0ZUw2fOR8vU5PR7VeTy89eovqep
         b74qqtMMbNeYMuMiI+Frox5uGmmnVrh/N8TcaboEaETZBdurOR+cnMtQcIadKNpJT1W7
         2MfgdCzj0nW/k7LUMhkvxBl6sHYBRglFaAsaAZkuV8WwneZI9JF3L8FF2y/m6QUPX64L
         Uh4y/AFshBbUuMh2yOfxa/q1hxDGHhyfDqr16OxvvZPHb0HJFtJUJJTq0HVfwe+hvWsG
         +z9g==
X-Forwarded-Encrypted: i=1; AFNElJ+kEN7G5b3NSyeDChQiyaIv0HwH52w0chh1A6N8NRfax19X5pLmp+tVlYtxzl2Gs5kop7U3l329DpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/OpjvO0NDQi72ZfzSoJgwb57eOjCNmucjRai/+ORQz74E+ZS
	dQqBdWzm66ro2NOEkW4hxHcAumN507aVi9B/MFTg6wSqy5RBfSNu3sJM
X-Gm-Gg: AeBDietqOPTIamWkvnfxrm5aQuz1thhJoLZSZ6WO7bNvrrv+HDC6b+UuxmVVF8H/4LM
	XuLdM1mCmH3A2ASJ8386RXAYZTr8V0/ew3l+WH4Dal9NvMSr9o5VS5uZl5udNOAg44o8VZs/HLC
	mh7s7lRZsffpgWUczD5ZdqlK3wP1HW7EFIWNOzwU0jY+DIyKKpZhdrcguYcnv0anWBlYvjGLDgv
	9S2Ai5TAnng3M1yB9fPnPP1bmhnpuDrHHx6cNcPGt28roR6gT0KnzfvrCqPdt9/0Dh3TBWTs+uB
	YcARk+oLwrByKYilmOQt0Mx4hz7t/eHVXvnL5kwZmrcqcH5IZU++0f+PmPCSZGQebb1FZcaieo6
	Xr9SLlaKxGVmV582X/zIvy5QDAkvPU7L11D95S9wnhiXWvAu42IMuZuSjW4aRu8w0x/1bwm50uO
	xXNXbZWLFAm4AxwazNIJi2v4jVSXooqPu/erppAk0AzwKgi1I5TbFUsc50fbg=
X-Received: by 2002:a05:6a20:4313:b0:398:9379:d04d with SMTP id adf61e73a8af0-3a08d7874a6mr25472562637.24.1776877018924;
        Wed, 22 Apr 2026 09:56:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:56:58 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] iio: accel: mma8452: use local struct device
Date: Wed, 22 Apr 2026 22:26:40 +0530
Message-Id: <20260422165643.2148195-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &client->dev.
This avoids repeated &client->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 51 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index c54c0ea05ac1..99f7763b84ac 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -225,13 +225,14 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 {
 #ifdef CONFIG_PM
 	int ret;
+	struct device *dev = &client->dev;
 
 	if (on)
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
+		ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(dev,
 			"failed to change power state to %d\n", on);
 
 		return ret;
@@ -1548,10 +1549,11 @@ MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
 static int mma8452_probe(struct i2c_client *client)
 {
 	struct mma8452_data *data;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1561,32 +1563,32 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
+		return dev_err_probe(dev, -ENODEV,
 				     "unknown device model\n");
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
-	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	data->vdd_reg = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(data->vdd_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
+		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
 				     "failed to get VDD regulator!\n");
 
-	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
+	data->vddio_reg = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(data->vddio_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
+		return dev_err_probe(dev, PTR_ERR(data->vddio_reg),
 				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
 	if (ret) {
-		dev_err(&client->dev, "failed to enable VDD regulator!\n");
+		dev_err(dev, "failed to enable VDD regulator!\n");
 		return ret;
 	}
 
 	ret = regulator_enable(data->vddio_reg);
 	if (ret) {
-		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
+		dev_err(dev, "failed to enable VDDIO regulator!\n");
 		goto disable_regulator_vdd;
 	}
 
@@ -1609,7 +1611,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1642,10 +1644,10 @@ static int mma8452_probe(struct i2c_client *client)
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
@@ -1653,7 +1655,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1683,7 +1685,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto trigger_cleanup;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev,
+		ret = devm_request_threaded_irq(dev,
 						client->irq,
 						NULL, mma8452_interrupt,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1692,14 +1694,14 @@ static int mma8452_probe(struct i2c_client *client)
 			goto buffer_cleanup;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto buffer_cleanup;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev,
 					 MMA8452_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -1732,12 +1734,13 @@ static int mma8452_probe(struct i2c_client *client)
 static void mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
 	struct mma8452_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
 	mma8452_trigger_cleanup(indio_dev);
@@ -1758,7 +1761,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 
-- 
2.34.1

