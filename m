Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C23A7F4B
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327091; cv=none; b=rSLMIMcBxB45ME/8wyDF7gftWZK0yuIIyMaf8Kv+cDpfHTvz4QPNhdPGD+ZGqhekwe+RVHCBXm0ZCiKT+VWXw4HNHeNBfq+N0ab6vwZ//eFrpx5TfiF2Aadvsoar4Bze1fgsrhDj2l+h6iIl4jg0ZYh5rCVlI3N5tMhhNNIN1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327091; c=relaxed/simple;
	bh=4aY/45S6uu+ueqf0r3Tct1zhYR6DX6LmiB4UWgyy0Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmNam4rV0z8BfhI26SK0JsvY/ONmhW8G6FU3GW51/euqiMD9BschaAsJCtHX2P1OzUk0247mvnWWtYS559TBT+hN/S2wVI1RCbYxOwhrTIAryQwIYumWqL1VcTY5LQN4dRd4UOq/uGTgzBztAPjXuSFYb5II4721/76Qsaofpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfdcndrJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfdcndrJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso88778585e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777327086; x=1777931886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGFEGVArNncRbb7nlEyVjRWdYLiwwjUBeFv4UPUGaDw=;
        b=SfdcndrJq1yx+1EvGa2k0PZuLdUU55gUP9bYC/rRCd1IW7+0LwuUw7p6DGy5j54mvt
         KAQnx+1bjsI47/LTwlhcsbWxWA+HXSEojFG1upbeP8zel3yfD8HDVbM0RrATD20fLSsN
         /60nOuAYHUSAcn0E9k9TG9or50dtRnvLsshp/Go0eHrsm9irORQJstPvUYhdqBpDjw8b
         2CwV3eQsLqAmDtpU0O5SPoVl2qiwxEWrhIWRh/KQ3Ffr8KrpKiLDE+NgMhGY7G1ciI+I
         dzuUpixfgs3tez/NHPfsv9tAMz/aKB6rfbwF0pBwR4PhDySrGCLbd81gc/hxmSxBlcoi
         IGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327086; x=1777931886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGFEGVArNncRbb7nlEyVjRWdYLiwwjUBeFv4UPUGaDw=;
        b=eED0ROaGKVWTGmz8jvUj5XyPoolJpsXe1e3e803y/CdUgFjIT6HCDkkXilk+zt819B
         o0QDlQJ2f6tlJ3lDtcneixxgDUYXXypa8d0cmZiz/zVOa9AABYCEppWZgbzfiNSxWdBt
         +BzxrXJk1AqPcNTs5+hzLUNX7UaJ+AdDHyZRp3qXtrZR2umxwN4PI92rC8+yH7VIhKMV
         f+T7pJuX7fJr/ma3XZilC+XveM+tgPtTSR+PmIcFE/iv12IfNH8Kflsf/70aVY9fXU39
         UIWBA1LTlQwq3WZKx95gauucpmkb2EJd0/iVRLBG5tp8bi9Ub5tWWDAwDoYJOiam2+Rm
         RbrQ==
X-Gm-Message-State: AOJu0YxoPch2kY57lBJfEbhChs/hD1pLY6/a2/cdI7SiJnKFZecd8nMI
	0UMh2bpBc4eqvk72uU064FNtb3GhX6DC5SaI7BSO1aExo86fmJSopWNT
X-Gm-Gg: AeBDieuYATqJPYIHY0fNA4V0HqhJA3bot7IVb3FaI6d/pQgZfVO50JXS9KRvFFofV74
	jZ+4vQ0kv4Ej9qJok6haf2LL2p5QQrx7Uvej2PT4oShROgDurRqMDg8+sOSMOWMSMFVQ8JgSusm
	shr6N5exs3ZWuFcr5+3Q/pxk1fuNygukcmmINjzhHxKu8zo7+7MjMugEaRnz1JaDmcFhK1XV41y
	D6xfQiXgONbVdPARoawvwdjePFedoTKookiFrtZ6QHbO1FdXrBX1qDcjUG3dZVgfLcaLKywAmm+
	K/R9Iq0ey2AQzgmOun96VwNe4bltvD809iGHEVWJmMvb6JY6Pwo2AevnIrH1/80KPb0wVz/tMa/
	/Vt3C0tVQ48togfiU4zkn8tzmdcG1uxIZ4Pm7uwMEyntleyKyZBaXjgU8wK7FSyAiQKh9kY/TxF
	7SafXpzif/w0iOgTp/s4jPt9wqDm0wYIK4zgU2PofsTFAVoGKY
X-Received: by 2002:a05:600c:8b2f:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48a77b178b3mr6765775e9.16.1777327086287;
        Mon, 27 Apr 2026 14:58:06 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb912sm3854655e9.21.2026.04.27.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:58:04 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: mlx90614: fix missing GPIO direction return value checks
Date: Mon, 27 Apr 2026 22:58:00 +0100
Message-ID: <20260427215800.28082-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions gpiod_direction_output() and gpiod_direction_input() can
fail, but their return values were previously ignored.

If an error occurs during the GPIO configuration, the function should
abort the wake-up sequence and return the error code. More importantly,
failing to check these values could lead to the I2C bus remaining
locked if an error occurs after i2c_lock_bus() is called.

Add return value checks and ensure the I2C bus is properly unlocked
via a goto label in case of failure.

Fixes: eb4b07dae4d4 ("iio: mlx90614: Add power management")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/mlx90614.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 1ad21b73e1b4..ce12b44c84e0 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -489,6 +489,7 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 static int mlx90614_wakeup(struct mlx90614_data *data)
 {
 	const struct mlx_chip_info *chip_info = data->chip_info;
+	int ret;
 
 	if (!data->wakeup_gpio) {
 		dev_dbg(&data->client->dev, "Wake-up disabled");
@@ -498,9 +499,17 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 	dev_dbg(&data->client->dev, "Requesting wake-up");
 
 	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
-	gpiod_direction_output(data->wakeup_gpio, 0);
+
+	ret = gpiod_direction_output(data->wakeup_gpio, 0);
+	if (ret)
+		goto out_unlock;
+
 	msleep(chip_info->wakeup_delay_ms);
-	gpiod_direction_input(data->wakeup_gpio);
+
+	ret = gpiod_direction_input(data->wakeup_gpio);
+	if (ret)
+		goto out_unlock;
+
 	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
 	data->ready_timestamp = jiffies +
@@ -515,6 +524,10 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 	i2c_smbus_read_word_data(data->client, chip_info->op_eeprom_config1);
 
 	return 0;
+
+out_unlock:
+	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
+	return ret;
 }
 
 /* Return wake-up GPIO or NULL if sleep functionality should be disabled. */
-- 
2.43.0

