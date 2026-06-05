Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B14C0401
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650632; cv=none; b=AoZ/U0x1bqhvTgpDeOHE0z9JkUweIA1hmHGdYe2XWGa5edTEpH5rsWgd28sRmneOn84ZEzkG3oNWuPltEOyOmbG7UoPmsfKu+yd0FYew89kFdTp6Jo5U5z//j8nhHjjJywSI634ApTjNdqWwhOlLPMD4TBrC15mEfUUhFp2rbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650632; c=relaxed/simple;
	bh=hAaX4OC0wXHk6GFCEy1dkXtnVAgO039C1INW5BJ2szk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwJs7LXlmW9TONOlRLJVT52eHnFUgoMWJw/DsycSagjXJh6xOMNbyTOh8Q6swFSnigp73HpPlyq3+UKiKUHPpOkIDGBDctndJGN3uJ4z0oENJw9iUu4wo5fpKLhjtzWA5J4kYHeqreGhxgsyhq5FG+7MMmOt1m6nDL0f6/nDm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oV4vJ/D1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV4vJ/D1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so1854664e87.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650629; x=1781255429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIoCcj2Kf6AY0n+CP4wwAAXAkuwxiGksEj0rioxN5Eg=;
        b=oV4vJ/D1+jaQ5mZfpJUxKA/j+9+S0tkBUQZDl1Go0eV+epRK1XjOOs/do0BfHP2DHt
         /sAbV3gb/Hvi7QBNaWtOd5wML7tfhsVdE4sduqRQWM5wakffEjFcaAe5rpPjWN+5lXj5
         E85lSeki58Q3kxFCeApzyFNjDNbKFXfsw/DVFkUdP4P1kN17eIHAtwdFjZo965X1N3l7
         q9e2ZMWfLEKmCQdjNxEM9VVR/CWom8emby1GSSMo6lU5ZgbLjGoTObVAQye9cMO31pF1
         vliYAjT7rT6/MyoAbO3BmfOseY3LXwR37ws741qklKc6pgMnuSvgOy8wpQL+nYYV1/Q/
         GW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650629; x=1781255429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DIoCcj2Kf6AY0n+CP4wwAAXAkuwxiGksEj0rioxN5Eg=;
        b=J+gPty5rlY2SFrKqMbKqgAAoQB4WVZ7QYzWj8e4+CHelVkwhr3NGE0iQ1moRwdGRjB
         JZkJcDiW3SGtFo+xdDZEeFsIYCdlLdkNq7dHId7Nn2PMqrTSfS3llSiYHWccCnm2meST
         JC29TUt8MI0mKWUIvnIp+0d60FRI2WKVEMK1QwIZ9+K8tuoBUFoq6yxGrZiOQ7m779i7
         HzPxbVpEkgbuNVgdKv5CV1Ypwj8Rsgnj9swYKj7/YqgaLe4PhT/kLIL9k/oICkCgC0rh
         UddpybGSUgHt7HRemyYA9vNoaJXOxYgLJbyC+QypPftbRbWcUPw5VSo3S0TH2DUz+EAK
         8RfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VsDTylNurXtB6krIYZaDyB3e4DvIDd4TyqekOeqrAUJIDbDhl4ILb8hZGWLJUoVqZwCPVZoSKZWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBnbIIhfD+9hP8jsiAxVUXr50GSpnpq6jaGdYVgzZiYBpzpE3
	Fc0Fcj7sJffr4YEW+wpLRA69PzHsRjgWBR1VzvmPplnCFnMQVC+3//wJ
X-Gm-Gg: Acq92OE0iosht/Y2rvozVOn/2/neXds4KnJ7UhEKhpUB61nScaRw5Xc8sVv/v+K39x8
	wvvjj7FxDt3s5rdR3m2QdsPbNZVXZKvWNHEOpx3JcR1FJFkzVS0c1pTUfksx9ZRseEByF+yb+By
	aZA8HnqtO9MN8hrPtO016JjeEmSj2ubNRSYyisEjPQtNKcPf73c/bEkkDpGu1a9ej5VvPzfA1Ce
	JEl6YMyCRiOdS7u2royYysEWCLEmBs+VFYOP6PiUiR7OqfNsytEVWsJmEilX4vD4q/UWvlD8y70
	a6RgakfDDPQs5KIedaIX0wT7NhCz52QVorf8mV/UCdr2lkwamet813GByiJuH5mlo1nTyU7GluZ
	FKtMdO21HzG4mHPcdsGhec4cOykGaqkXkt2n7Qoa/WDX7HxYYlCSPB9gwVfxNbFjM1z38NhBEgf
	cKQ1ctOuFolE7ebCLfcLKZ3FA+XWSlYVViCwBmCUZPJZk=
X-Received: by 2002:a05:6512:1513:20b0:5aa:6cfc:a208 with SMTP id 2adb3069b0e04-5aa87b73157mr557508e87.15.1780650629249;
        Fri, 05 Jun 2026 02:10:29 -0700 (PDT)
Received: from new-nest ([2a05:3580:f312:6c00:1b49:dfce:283c:7307])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9903e9sm1705914e87.69.2026.06.05.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:10:28 -0700 (PDT)
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
Subject: [PATCH v4 3/3] iio: imu: inv_mpu6050: control vdd supply using devm-helpers
Date: Fri,  5 Jun 2026 12:09:40 +0300
Message-ID: <20260605090940.1103750-4-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
References: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
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

Changes in v4:
 - no actual changes
 
Changes in v3:
 - no dead code in inv_mpu_core_disable_regulator_action anymore since st variable
   is used to get 'struct device' now

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 23 ++++------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6fd35ea5daabb..c170efce7d31c 100644
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
@@ -1948,21 +1942,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
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
 
 	/* set pm_runtime active early for disable vddio resource cleanup */
@@ -1971,10 +1958,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return result;
 
 	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result) {
-		regulator_disable(st->vdd_supply);
+	if (result)
 		return result;
-	}
 
 	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
 				 st);
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

