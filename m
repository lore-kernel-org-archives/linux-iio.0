Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAC3F39D4
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866847; cv=none; b=qGLc0rknWnJnih6iabk7v7FO9bwiKjMhaDcV3UYNCV5n4vMqulHeKaSm/7cPTjqwGGVj3uGND5ZUMmmxyB4N1OGvw/1R8JgKmv84LNuwtbB4diN0pNi4mROhxpuYaX2GpHEYmzbw2xxYQR4Y7MWSYRoepkJmz2N/Tb8GkYCJdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866847; c=relaxed/simple;
	bh=YI085fm37/ypf/0BfgnyWYfjlnTlCAzVT3T4Drtf7HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxsY0bz3p64+gXEIB2NDH4vPD6rmHeBKvpaGiA8zG0XC0dYFgLt2hB3K3b6I2TuvLDIPExNOoxV4rgcCa0yew5zbn/2o6+VziXsjEclHfpvyGj6x9G4VNYRrX7bBaKy41U1xzkCncZlsi8R3GJ7BiVGzgXLk1rTtDXedUSKXIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHnUm0uq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHnUm0uq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c80227c9572so23951a12.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866845; x=1779471645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kNSilLvGuFX4bD2pG7PVn8FSSIgnqfPybpOGUR9Wlw=;
        b=mHnUm0uqF/pD3a8KEWartGoPp4hb90P0J5+PBdltIcCyIikMryCJtV4Z6h08c+fziv
         KJpwQ/xCc6gah0s7dPiO01f02XguXiIU2UaYK+2v7rX3jtGCKNPk0tY5HbaDQJhrFhWY
         WZWiTfkv34/qrVHbjAv6Dw8+piYn29qYK34EDn6oowSdKu42eXq8o1QZfD5rMfn6qrJi
         xpiwLpfn7U2cy9VvLxTEY95Q++I0zxsOEH0PPHDoocfVK1qaZdROzf7g/GLcoABS45lA
         NUbfw3lZ4aCZhq93JCUEKEfl0tWECdJjtsPReXCUhvNmbvdi6BWt5Yx3w+wFgtE1Yk1D
         mcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866845; x=1779471645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kNSilLvGuFX4bD2pG7PVn8FSSIgnqfPybpOGUR9Wlw=;
        b=o6ej5w6fHfLiTW5aze2IPA1ux0BRNwuhmKtpwlDYrdYjpJzU8pqpJg+//1d3GvBgVN
         vW/gvFe3N8eNVedKp1qR/OlzA2nb8C8x2O4VnjDdK3mBc4D6ePGxoS9+57biqB0FR9KG
         sqQZa/U0wmW0qKwGXuHBrvde+/Ycvm0E9Lh5tgQBXWGcEV1CS8tdrsgACIrkF4rjWY7e
         4pz7yv+JVi8liuNx4mc17bCC4ujP9tUJdD/QZe8goMH0VSf94hFbQ4sLOIxjJwlctI3R
         8C7c+2LjJKSecFV5D3bJWYwYT+J1Pso3wJZ8TgKfg7ejZOj+sLoAj0/yW/HpcX/rI4BZ
         7+AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N8mXsAOVtZ1+5w5frgK0A4VNS7twTRqQW7X0Y4UGP3Uj8LkUb8DGEVuoaqNQCcFKYmH9dLKBE5p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8/yz5mnxBhMmnmRXPdyl4Iixj3rqgF6FTRfhpxRMeQA2M0Rh
	OBk/FzDeKt0heBGWgdW4YQ6ELG3gPV50M8IFheU64EoThejz85xRTzFf
X-Gm-Gg: Acq92OFu14s5bhgWnBB0d7zqm7EddSjwsHA02laLCtRgX1hE1U4j2k2Aqh3FyfWbW+O
	cLnQoXWzE48OTxwwT9/HVp8YB/auRd2uaz+bsAlpMh6GXt4wUHTYRmXAWzYMApOaGq9qklwfM6K
	KBJ23Ys7qrgYGSdvgX5748QudnWvBtGoPAwv2uLaL4DdA+a88Q/wYwdwBLMn4ddkuUjubyVS9ov
	sFblfNxqdLKeXML68NC/SJDHm45ychMtX63lO7+t0or6cMlaUW06VgcnC5l91JcWCQWAPTPsePe
	ycCTckPGz5KauFkQV+yNBd1/75yGAiaEojyIeERl/IuDgUrEmpqLCx3qsRJQ9QoJjwADJem5Yu2
	KmRhvk8x8m0xUrDMvS3InifM1nbMGcgQDbuE0J3SLaf10jAnT52+iw5Kp0GJCImzyz00RoQxErQ
	eUrFAwb8fbssI6bmumq5Cy/l4gbPwj/DewSNRJ9SSLpJ8YyD8M
X-Received: by 2002:a05:6a00:ad5:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-83f33cbf6abmr5447942b3a.14.1778866842002;
        Fri, 15 May 2026 10:40:42 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:41 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/12] iio: ssp_sensors: factor out MCU enable/disable helpers
Date: Fri, 15 May 2026 23:10:09 +0530
Message-Id: <20260515174017.3962168-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Refactor the MCU enable and disable logic into small helper functions.
This simplifies the control flow and improves readability.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v8:
- Following comment from Jonathan, split function to have separate
  changes for each small helper function and demote the log level
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-5-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 43 +++++++++++++-----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 51730dae5871..4280eb590c03 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -89,23 +89,28 @@ static void ssp_sync_available_sensors(struct ssp_data *data)
 			"SSP_MSG2SSP_AP_MCU_SET_DUMPMODE failed\n");
 }
 
-static void ssp_enable_mcu(struct ssp_data *data, bool enable)
+static void ssp_enable_mcu(struct ssp_data *data)
 {
-	dev_info(&data->spi->dev, "current shutdown = %d, old = %d\n", enable,
-		 data->shut_down);
-
-	if (enable && data->shut_down) {
-		data->shut_down = false;
-		enable_irq(data->spi->irq);
-		enable_irq_wake(data->spi->irq);
-	} else if (!enable && !data->shut_down) {
-		data->shut_down = true;
-		disable_irq(data->spi->irq);
-		disable_irq_wake(data->spi->irq);
-	} else {
-		dev_warn(&data->spi->dev, "current shutdown = %d, old = %d\n",
-			 enable, data->shut_down);
-	}
+	dev_dbg(&data->spi->dev, "enabling MCU (was shutdown: %d)\n", data->shut_down);
+
+	if (!data->shut_down)
+		return;
+
+	data->shut_down = false;
+	enable_irq(data->spi->irq);
+	enable_irq_wake(data->spi->irq);
+}
+
+static void ssp_disable_mcu(struct ssp_data *data)
+{
+	dev_dbg(&data->spi->dev, "disabling MCU (was shutdown: %d)\n", data->shut_down);
+
+	if (data->shut_down)
+		return;
+
+	data->shut_down = true;
+	disable_irq(data->spi->irq);
+	disable_irq_wake(data->spi->irq);
 }
 
 /*
@@ -146,10 +151,10 @@ static int ssp_check_fwbl(struct ssp_data *data)
 
 static void ssp_reset_mcu(struct ssp_data *data)
 {
-	ssp_enable_mcu(data, false);
+	ssp_disable_mcu(data);
 	ssp_clean_pending_list(data);
 	ssp_toggle_mcu_reset_gpio(data);
-	ssp_enable_mcu(data, true);
+	ssp_enable_mcu(data);
 }
 
 static void ssp_wdt_work_func(struct work_struct *work)
@@ -584,7 +589,7 @@ static void ssp_remove(struct spi_device *spi)
 		dev_err(&data->spi->dev,
 			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
 
-	ssp_enable_mcu(data, false);
+	ssp_disable_mcu(data);
 	ssp_disable_wdt_timer(data);
 
 	ssp_clean_pending_list(data);
-- 
2.34.1

