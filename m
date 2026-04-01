Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F893AC0D7
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032130; cv=none; b=NRnfjp7vJGd5RGQstOVSFaB6MqOr7cl7comm4RtSwZE/hU3NnTSJqSOVFRhkGbeMYRlt2ORgNhIAbkLf6zQ8hH6OFaaWzIvBSRzf+Uu1eYuj8qClFOsaDNhYqEIUtBA2pUdmhuTW3uko5yT8O/bwHOqAJF5ElM6Ypa7toRIHR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032130; c=relaxed/simple;
	bh=R5fP4xTxZM/9up478ZlsTaU1nCoDtVH+kpDHEznHI48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE/WwfuPYlAvcqt6nj6fqZGLKDbMQB76LDfRcqhbql2vKvLzWtEi3zxv61ZH8stZ5byrtRrSGlhepYYRjJSBzI116BSMc0mFASRH/Bg5F+YjDCIqZTp73xXIQAHrB4s6mwynu4l0egdSsdXw9z9oDxuuyDRDa6EaQl1aoosiQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnCXonfV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnCXonfV"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2294493a91.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032128; x=1775636928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhhDNnRqqVXHXNROywoQo/qEmpe6kFmc1oHcpmB9pT0=;
        b=AnCXonfVoFd56jowLqK7JIYg5MnAtYnsbiX0B41rlV3BoOT8Cu1i8cZc9idEvYECW4
         rwa+v4gCdyVvuCVqXmsmXoDdumROfapPQb0lmCG2YMPP3LXMnKaetOQKhGeyEwYsixyw
         S1FR73oTpC0/VJfMSd20PJe3ZWafqfQuZ8KCsQcX+WWZeHqTipw6IRLVjsY0ACobDtPV
         Z3Y0Cf/E5GgMKX97qHJlxTr36aY9OqUYi5Uo2ICMPTi4XRAy9p68eiWcNxrY5ez04VyW
         YWzsMf21wc23VSSS4vuu8mWe1cOz3CN+qiZGkHVgANVWWbSlQLPaelOPCckUgdG8qvWK
         9M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032128; x=1775636928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhhDNnRqqVXHXNROywoQo/qEmpe6kFmc1oHcpmB9pT0=;
        b=ndcnXVnDONubPE22HY9Kt9gXlinDBI4EZZk1CqtI+7httViCqulIr3m1gojj8+Aamk
         EdeaOS4Zw66IMlag8Cjv68ZWn1/OvqAKUN/HrmXD2rGC3syVOchyHKuiW5hjPIK5zqzi
         9zhZRzNz6sGea6ZdXnqOpVHLPhXyjVAOel8w+nD1Fx8k4hRwDZiFsxZaSy1z2Osyxlxa
         CTgXwk0PRSNg0CvI0wQ8tYkH7pfBuQ9de56m08983nUS7iJbgBMupvXY107iBL4XIhQg
         RcAybOxhobjyEBiCeMporh9WuWcMn2KPlDhGbqsPnqsU+MspRP+8wNrJZWObu+NZAsM3
         HEaA==
X-Forwarded-Encrypted: i=1; AJvYcCXRy5m8cUfqQ6CQg01m+NhFiNmEb/YQzC3JZHRIpAlf64WHx2nWeqA2OHsyqsTvZbYb08AkJvY8114=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9aykMPk1SMsaU/dAq6EbJFoATvDkrWzXm7GjUN++wQ+L9EM8
	uAiDbOqmA02r4UvDHDQKoc6f6k/fufZgVHWFTRiAqdD8UuiSENNhSCeo
X-Gm-Gg: ATEYQzwsDwBrvwjOKNWaFD5F3YVoxaGt32w1KdIs0GLDe4GV/R+ycBnIpZVrO9zBvj1
	77rcz0yVs3vHg56scjoSD2xY3aD4XTXOPuuo+VVW2P+6ACGhVKW2KNlSlEKingNVFDsk5fhdqAb
	g710xbs3XboJLEFPlPXbpak2n8tgHU7IpYmQaCUAxqSzLwjFr1prNJW33pgMPp0fl7k7JhVeOYo
	qN0c7+WpBMqdAKzhRGFwLRx6ZvTb7TZMpiE5BfrtLUf07oTVXtUpCnsmZqbsRAtpVsVnwIzShPr
	e1sWXLmdwnclcP/iC5iyehaXNCQDaFYbs6e1RUOyOyjLO8Pbaxh4I6wSqNEcEdPs7Jl7CoW/hQD
	BjjmYI4tOux3K3ql3d0mhg+6bh3kgHgiTqKevaRtyshXMyKOBHX9zmhjvRvSOMjdF6e26bY6wm6
	a5DBpQX5mI2t/Xx5jaGEv3mf8gIEBCD+4lfAcDeg==
X-Received: by 2002:a17:90b:4cc6:b0:35b:af3f:3618 with SMTP id 98e67ed59e1d1-35dc7030211mr2426907a91.28.1775032128151;
        Wed, 01 Apr 2026 01:28:48 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e519dsm4118561a91.2.2026.04.01.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:28:47 -0700 (PDT)
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
Subject: [PATCH v2 2/3] iio: imu: inv_mpu6050: control vdd supply using devm-helpers
Date: Wed,  1 Apr 2026 11:27:36 +0300
Message-ID: <20260401082737.781018-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdd supply will be automatically disabled on error condition during a
probe and on driver cleanup. Since the vdd handling is moved to
devm-helpers, only vddio regulator has to be disabled in the
driver-specific cleanup action.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 28 ++++++----------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 84eb0ee770086..3a57a3f440526 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1859,15 +1859,9 @@ static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
 	return result;
 }
 
-static void inv_mpu_core_disable_regulator_action(void *_data)
+static void inv_mpu_core_disable_regulator_vddio_action(void *_data)
 {
 	struct inv_mpu6050_state *st = _data;
-	int result;
-
-	result = regulator_disable(st->vdd_supply);
-	if (result)
-		dev_err(regmap_get_device(st->map),
-			"Failed to disable vdd regulator: %d\n", result);
 
 	inv_mpu_core_disable_regulator_vddio(st);
 }
@@ -1948,30 +1942,22 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
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
+
 	msleep(INV_MPU6050_POWER_UP_TIME);
 
 	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result) {
-		regulator_disable(st->vdd_supply);
+	if (result)
 		return result;
-	}
 
-	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
+	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_vddio_action,
 				 st);
 	if (result) {
 		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
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
2.51.0

