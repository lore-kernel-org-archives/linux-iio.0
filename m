Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA535B65D
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202693; cv=none; b=gQPo+wfjjae2YOLfC6rOLgaZIAan07lVgZiIldKazIMWCpUz42uVmOdP4Q1sU5fqq4N9fgtUEl2tWatiogf2pzdHhPMEcWjFwpU0qNkMWYYlhNN2HR34tvI0/IOJc35GYA/aj70FD/8Kx+WdxUctIiSTd26UeF9v5zZIwvRK2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202693; c=relaxed/simple;
	bh=cth7IxMx4vL9wP/1C5eXMoW+1v/9cyIj7UCsykLIt3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7+53k/C8ZyMLc/zC80XkTU86331H7z+QEkJ4yEBwnTq/8k9euSldhsjEecarRy2eXqxKHdQzoXmG3M1ifaTwavwTSkYHRmgwenmI184dpdAeGnFNfr9br3jvU3k6MiB4uR+8a4cIfyAR2yAw3h6ml4vDCgyEiAV7Xc6mONHMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMfv58lR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMfv58lR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so120874195e9.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202690; x=1777807490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEYBGn4RFp3NqRbemrgiMNi+WUGjPXcEfhUYRQfZnUo=;
        b=UMfv58lRbShEXUOz946BRsy3PsJ80lcu969JwSRVziP38l6G/ZvrRsfFEVCV2sLMmF
         n9Ynfu6QwqYiWU5q5WJ6i7KgFns+yjfZo63IuPlR2ACcnllzntJmFrOdUUL3kmOGPB15
         qZjG3DjDGEKeW3hzy7DmwC/+moU6tfaW7CGwyTDT8TWTCfv7Wdc8WOWUYT5ejBrqQq48
         2/q7zK/y7vQCPap7iZuBO8eBDDkbj2cJi/0DMYlhz44s/WDv04uVoglrRnMTcMhoyJDM
         Th4MLKTkV4f/8Foy5L87bTYX+MNhEy7WEc/Izoopa/nvijtcsdnq3Ojdzc9J3YQXggkd
         qViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202690; x=1777807490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEYBGn4RFp3NqRbemrgiMNi+WUGjPXcEfhUYRQfZnUo=;
        b=ACJnad90KbQDh28p3sBO6/AYOmM0Qoy87dfx+DPHbHdWahT4FcV4gqmC6nfUHXjIge
         NL5BfOIuzb/pWSvlNvJJWg8KrX4yoB1NoVHTcaH/MQeJPH+86M1xGVFK73N1asYoDxjy
         8LDBqme9cE25PreJFOVCY7k6szFr/PnFNbg7O/6Y5d9HLqRTmqZyud9+1FGQYioiMJT+
         tolkr/izmNi0d6FZjeZ2iAnUHdjDWf5GiQLnPmK2cggdgT3B3S1peZHyzaFvk6IL5GD8
         qNeTjoEw+icAMI6dqPHW//tiVs6b0YhOQ7oxiR+QchLy8GyPoucmONQ5kEJC3SGa88Pm
         M44w==
X-Forwarded-Encrypted: i=1; AFNElJ+zadcKCjLFINg4Dp+KwighCi3fYlviVeKZyHS+JFHAmVgG4xmW6EdRaA2I9hmV2AGd/F1L4kVUuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyICtm9QnjryDuf34puONmzC6Pr7yJ3x8Ibdq3QU+sr3yiqqO
	cvnM4xu7NkOgsEuuRSvmRgzl3f7QBFOl+mDUIokszcW1+6cXEf3DD6Qm
X-Gm-Gg: AeBDieukAIjnfPykJJVDsiJtfQOVCe2OTEPDisHagYOdoozbxhCqnVBNhPa6tAhz+jk
	TbiuYiZaFo677DEOyn9QJQ7iEhkpVnqUr0L/Hsbm+hkMJEQ5iLmKzds56VzgAuxeefS1Zqk05Kk
	t5O6TYDV+peRrRwepFIkXGXWlQ9qs7lANgnfYArTU0P3ELoY/bMvkhhLBU06PX5914ZivL0qu6O
	naZ+6gkrsPkqBB63McGLHVLKLbYFvmoMKjDkYeTAJ3u9F4BkhOkU+rBgESV4FWSNr5jG7pUGv17
	9b8ISAQu1kO53gPPvBnbcCN4tLNp+cDisq802eL5Gh1R6qkY3MBOTa2T2TNnZK42zTLaIv/ioq9
	7+bjaf9qwUzvKFvg8fL4aVGSS8C7gTprZRf9GKqKaoPMZ2v6FDuxti5G07nsEgVc1ZrFw/oTLyG
	LHIEUJhSxMhKd5CJMRnFsP5X0/Rsm3a/du3j91
X-Received: by 2002:a05:600c:8b28:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48a5c230e78mr267530895e9.19.1777202689993;
        Sun, 26 Apr 2026 04:24:49 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm33285999f8f.15.2026.04.26.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:24:49 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3 3/3] iio: imu: inv_mpu6050: control vdd supply using devm-helpers
Date: Sun, 26 Apr 2026 14:23:34 +0300
Message-ID: <20260426112334.3938774-4-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdd supply will be automatically disabled on error condition during a
probe and on driver cleanup.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes in v3:
 - no dead code in inv_mpu_core_disable_regulator_action anymore since st variable
   is used to get 'struct device' now

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 24 ++++------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index fc786aaeac5e5..880bb7b8b83b1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1863,12 +1863,6 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 {
 	struct inv_mpu6050_state *st = _data;
 	struct device *dev = regmap_get_device(st->map);
-	int result;
-
-	result = regulator_disable(st->vdd_supply);
-	if (result)
-		dev_err(regmap_get_device(st->map),
-			"Failed to disable vdd regulator: %d\n", result);
 
 	if (!pm_runtime_status_suspended(dev))
 		inv_mpu_core_disable_regulator_vddio(st);
@@ -1948,28 +1942,19 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	device_set_wakeup_capable(dev, true);
 
-	st->vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(st->vdd_supply))
-		return dev_err_probe(dev, PTR_ERR(st->vdd_supply),
-				     "Failed to get vdd regulator\n");
-
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(st->vddio_supply))
 		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
 				     "Failed to get vddio regulator\n");
 
-	result = regulator_enable(st->vdd_supply);
-	if (result) {
-		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
-		return result;
-	}
+	result = devm_regulator_get_enable(dev, "vdd");
+	if (result)
+		return dev_err_probe(dev, result, "Failed to enable vdd regulator\n");
 	msleep(INV_MPU6050_POWER_UP_TIME);
 
 	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result) {
-		regulator_disable(st->vdd_supply);
+	if (result)
 		return result;
-	}
 
 	/* fill magnetometer orientation */
 	result = inv_mpu_magn_set_orient(st);
@@ -2108,7 +2093,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	inv_mpu6050_set_power_itg(st, false);
 error_vddio_off:
 	inv_mpu_core_disable_regulator_vddio(st);
-	regulator_disable(st->vdd_supply);
 	return result;
 }
 EXPORT_SYMBOL_NS_GPL(inv_mpu_core_probe, "IIO_MPU6050");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 6239b1a803f77..2c0cf53c9a627 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -206,7 +206,6 @@ struct inv_mpu6050_state {
 	u8 irq_mask;
 	unsigned skip_samples;
 	struct inv_sensors_timestamp timestamp;
-	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	bool magn_disabled;
 	s32 magn_raw_to_gauss[3];
-- 
2.53.0

