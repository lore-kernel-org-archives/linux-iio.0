Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237723DB648
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837908; cv=none; b=PbzK1/NqVyeIkcA48aajz28yu96cGZAZi/486E93Jr+f9F4F/O7kSbOshiJNT6RndfGdVkiLW7wlXtIYaXWchzB4w0aVBZIv2qnOlmN7q10JvQPWzlDt6phuG7tG0vq0SrK/PxDUzyXN6vPRquAYu6erl6FY8hF8ZiagL46LWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837908; c=relaxed/simple;
	bh=UWCf9yxUH0KSymAnEJkJ2BEH4P7e3mxEvJRji5s6cPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJQ01YhVORQ4wBVh9DrsvtgdZm+jbKed6D3WBmtRtUiKigoHOTdvi3bYhHmXf/YY0exY4fEBcZk2tkw9GFJxZ+OBYfnDhx8p09w113Q7ZxtykmCC37ymoCO8WOl1JtYKI0zFNdEkxIJlnzA8dTqvrMFW2o//pIlLhT8FRfk50Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV78dHec; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV78dHec"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a60975dc5so25500027b3.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837906; x=1776442706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaDXs1KL4TBYMnF8Pcyas7BLMGtBZ4AvI2WNsZOhvxk=;
        b=XV78dHecI4iYrbMpgmBJV9sSATOL8pA+Ldqj1QRbIfKEt3OYaoAagZxxzqbZ0mAaoV
         a5cZVCUFcfvexeWf9JNWYR+0sPErOzynEjcARcx3JiNY4sAv7bEqlakcI9zODNHn1V3e
         0wNm5tkwpRraZ2kiZJ81c4cYzM3DgkUiooOd01OBGF+VI8MmzGhCLLBGcFaWPE54LoXY
         LiperhN7ig9yNNczPDFGmApHaDd9/Sq4u/J+VbR8o2L9Gw81dcOIJzW5mHU0x6Jyul0T
         8giDBx7mgoNKdWJ2rX98VkB0gl6HVhYI69FaVNpo9X9qtaxQGtMcjzLFNiX/X7aMCVs6
         UXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837906; x=1776442706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EaDXs1KL4TBYMnF8Pcyas7BLMGtBZ4AvI2WNsZOhvxk=;
        b=cvzvtJpsSzTNdNJeJ4XtCZJ/NrnNByQEWMvdtB3uTQ5bN/1mLAVMKy+7aCydu2bukH
         jaSNGcJwYVePxk7hGrx84Y0WSTRn3xGVW6q1qMniigv5IZchxSS2xU3vREYl7xBszBP8
         f4icgX5gCQkohe8Kkdpc6ZSmqEoi2mGdoadzR8xY5kX1TWDJKcjUDrP8wQn59P3vVIsM
         iDcjUOLA/NeBZ1tXMx0j/IOtCrkJztQxR0+V7yL9zezt3oQtQr/WhiUVtA0jo438eGvO
         WD9/iRc6nKUZzJBGBPV6RPqRxviYzfMFnjbkZQFP1CECc6T+rUpr+jS+cb76mUcDJCPF
         eyIw==
X-Gm-Message-State: AOJu0YxpWFdGjfr/iwveONqzWnhXgjvXJPXRL/8zCf3RWKzhgHSPZwVx
	kDHb2vNH1+UJ0BEshkvZbQxjQ7BT2IbNaCKdLsfuLj3wNM/FBgTo57wk
X-Gm-Gg: AeBDieuxatlbDIoLxDqf3HFPsbCAg3pezauZzTkeNRjz69dnDHDfRGCU3ZrZFjja10y
	VRUq298VjdeUYjbX33EeZhnT/Uj/FLGoi0Ga7t3NPHgOmxDzSl3tY8VLC2Z6YgkCRclRjDrRmFL
	gauTskyf1QV9+4rmH5/6PZ4xYCAbV7MyBLF8vvzLH9sTf3/KvTX/O7+jICN8gF9N5AVyIvL7LHG
	3B9mS/ezfkTqZpQH3FhSxdmZkAwcFAyT6QgvRWThYfTJ2Je2AkXI0/td3mCEGbscHv5E9sPLqxD
	JAIkc8A67ki5xRjnH7/WY3ZuyQo1ggDEcuV1ptN/vxuP73ntjjcoay66w11Qgxae0E5MFBmi7ov
	JShX8u9TKcllnhChZ8247fW93Y3IqCMluR/7DKLF5G7ETROU7vDwcmKWoXoQvetyZFIy0tzRxP7
	VwqWA5XVoUmD6foF1dHRdZzYX+cQ==
X-Received: by 2002:a05:690c:e3cd:b0:7a3:20e7:fbd6 with SMTP id 00721157ae682-7af7213ee0bmr41471737b3.45.1775837905872;
        Fri, 10 Apr 2026 09:18:25 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:18:25 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:20 +0300
Subject: [PATCH v3 4/6] iio: light: vcnl4000: move power state function
 into device-managed action
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-4-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Move power state setting into a device-managed action to get rid of
fail_poweroff goto label and remove it from vcnl4000_remove() function.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index bbb84b71f226..1a8672564cc4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1970,6 +1970,18 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	return devm_iio_trigger_register(&client->dev, trigger);
 }
 
+static void vcnl4000_cleanup(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct vcnl4000_data *chip = iio_priv(indio_dev);
+	struct device *dev = &chip->client->dev;
+	int ret;
+
+	ret = chip->chip_spec->set_power_state(chip, false);
+	if (ret)
+		dev_warn(dev, "Failed to power down (%pe)", ERR_PTR(ret));
+}
+
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const char * const regulator_names[] = { "vdd", "vio", "vled" };
@@ -2004,6 +2016,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, vcnl4000_cleanup, indio_dev);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
@@ -2041,19 +2057,20 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		goto fail_register;
 
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
 	return 0;
-fail_poweroff:
-	data->chip_spec->set_power_state(data, false);
+
+fail_register:
+	pm_runtime_set_suspended(dev);
 	return ret;
 }
 
@@ -2073,18 +2090,11 @@ MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
 static void vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
 
 	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
-
-	ret = data->chip_spec->set_power_state(data, false);
-	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
 }
 
 static int vcnl4000_runtime_suspend(struct device *dev)

-- 
2.53.0

