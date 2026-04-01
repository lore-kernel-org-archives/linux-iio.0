Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12C3A9DB2
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032145; cv=none; b=NhfZ2HB3OFgNlf1MSD/kkrjUWt4/Qr3B7JkpXTsx1w7clKd1imy/JYXIusFZy7ducF6LspPPwwOOUTFlUcF2mnenTfgeznH983veVOpRoKXC1VwL4pJBZzs1e9R5LU+dz/Cx9yX+XJqRGubFbNcuBqoVRDTD6QfPGCkDDq/Ob70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032145; c=relaxed/simple;
	bh=QOMIzjNoG38g04AnGIDm8S21dxdqXer8FkrYDdTsXgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiNrl7MSQEokDigx/s+phoM00cqQOVPPd5bYNiGaioTts58wlGKObAZCJeHYBNz+9J0AUgbW8A/E4X2V1m5AQCXPhPxu83UGSJBCvaYox4+LQDAEcFjWTmmJ53OBuAqmOLAshUNOaX+82uAI+yfo2QFAtIsXHd2otcFWEgKFQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbkF0jtz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbkF0jtz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35c206f0481so6185303a91.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032143; x=1775636943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tYVObevDqBuONwH6QGIZanP6IjHHjbyhFuTpehaXTI=;
        b=sbkF0jtzg9draY/4TAGdHQJbH7lQ0pN8CINp1s4CJYYFdur2/J51w7lVtfJ9JO6zrt
         mv4hUSQuxG/FEGqIcDgDsElq0G/6J0mi3u4bf0zRQhU7b8xr8VayYJZunKD5Uhl5JPzG
         rkXnwp3gpKFp9bY+/695zMOhoRVZ3Pwd+otCKL0DPlHJ9BnW/E+RKP+/UMaNXzqaBrp/
         roASOaRfwEFkCXdWNlRPam/W7MGO00nTSode8jvngaqJPvtKiWN0/Dl0MHxAwqFEGAGx
         189OINnHZzpyoePC0JD9DSpU5v9t8Rgy6Amf7PE0fU8I+eLO/EVhClsD+ANM147x49eU
         lkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032143; x=1775636943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tYVObevDqBuONwH6QGIZanP6IjHHjbyhFuTpehaXTI=;
        b=LSfLbWMIO8Zi2QcoA6ooqp/POXcfIaf3Xc7Ieq526yFqLouG/u6O/XTpvCel7gfkQu
         D7XHOf7KEyKV/CzZuN+GMKmX+wYLBCn+z3zY/9CYAFRPbPG8F/WSu+CW0Xv69d2PTCH8
         n2KM+leL1QekGaFmHJsNdo8NvshymBjlXJVnDajK1XH1n1oevf31hxfRCixbsh4MO+6U
         W1gE7h7+VcGmQ1ffvGG9dZSHmzIZm5G//wc9fCRXLlF77ArEA0/VZZmauCNL5Yh2+H4t
         csfbWxs57wDRqbFNXW46Iu0njLULowrWe8b+7B+zEiXghoW8JuQAsga2Uvhy4+BebjDB
         pqIw==
X-Forwarded-Encrypted: i=1; AJvYcCULgFMPfSBEVS8QRJX5Lte4/CdwR/rC9JFCqQh/YbZpv4h/Rx5j4b77CunjerBGzXoN6Vcl5KBILIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLR0Dil8uurXR0nexO2B236ZqKTZqHv3bR3nwFedbMnuh+qIFB
	Y5dfqeoYazOzgkA3sW2SZr51cPTHx1zvuXeXlyQJwXlhnntejT7Hqq+7
X-Gm-Gg: ATEYQzzNOXamp205JBrOnaVLTJj/VPcZMsd0leqRV9g88mwdWiXlYLa+nHt2B5qas6l
	FEjhvA9eCjhE9y6UCJEkTGkbT66dIUM7YhA2fMyr88Jg/TotsDaz9Y6W5wKSolkXmLQwaWBIZr0
	VRMIAlPFxk3Yco18EEtPz+E3SNSHiuYZhZezAYK13dK+37mjWUI2EgFN+79XVVU2gIheV3FuJRO
	PXaCXTtH4EK7MF5q1NO8ed4dUvkLyrAljC2ITmzZRcza5CxkkUJlq3aFRGBAplgLUyBn4LtrhFB
	Rf8Sl89O6pHFyTHZgLHB7/X3memVINtDdBMjI8XAMem/YxKjH3WWhf13KiU+pCNwDH65IN8yHC/
	xy+NygnipOfTdOO7wOgBKPOxC4LNa6kzB3fIHMg8LzqWmY9rU8PuH+ZKePNDC74heKy3CADY780
	DBAZt0HKwXY900HTg7FYgGtTI77ao=
X-Received: by 2002:a17:90b:4ccc:b0:35c:30a8:319 with SMTP id 98e67ed59e1d1-35dc6d2edfemr2859424a91.0.1775032143178;
        Wed, 01 Apr 2026 01:29:03 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e519dsm4118561a91.2.2026.04.01.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:29:02 -0700 (PDT)
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
Subject: [PATCH v2 3/3] iio: imu: inv_mpu6050: fix unbalanced regulator_disable calls, when probe fails
Date: Wed,  1 Apr 2026 11:27:37 +0300
Message-ID: <20260401082737.781018-4-andrej.skvortzov@gmail.com>
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

During a probe functions after all regulators are enabled, runtime pm
is enabled. Before probe function finishes, runtime pm triggers and
disables vddio regulator. When probe function fails after that,
inv_mpu_core_disable_regulator_action tries to disable already
disabled by runtime pm vddio regulator causing following backtrace:

  inv-mpu6050-i2c 1-0068: trigger probe fail -19
  WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
  Call trace:
   _regulator_disable+0x2ac/0x600 (P)
   regulator_disable+0xac/0x148
   inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
   devm_action_release+0x4c/0x88
   release_nodes+0xd8/0x178
   devres_release_group+0x214/0x3c8
   i2c_device_probe+0x6fc/0x9b0
  ...
  inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5

Fix the issue by checking runtime suspend status, when vddio regulator
is disabled. To handle this correctly pm_runtime active status has to
be set early before vddio regulator setup.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 3a57a3f440526..86e4d42c4d3d1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1862,8 +1862,10 @@ static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
 static void inv_mpu_core_disable_regulator_vddio_action(void *_data)
 {
 	struct inv_mpu6050_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
 
-	inv_mpu_core_disable_regulator_vddio(st);
+	if (!pm_runtime_status_suspended(dev))
+		inv_mpu_core_disable_regulator_vddio(st);
 }
 
 
@@ -1953,6 +1955,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	msleep(INV_MPU6050_POWER_UP_TIME);
 
+	/* set pm_runtime active early for disable vddio resource cleanup */
+	result = pm_runtime_set_active(dev);
+	if (result)
+		return result;
+
 	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result)
 		return result;
@@ -1996,9 +2003,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	/* chip init is done, turning on runtime power management */
-	result = pm_runtime_set_active(dev);
-	if (result)
-		goto error_power_off;
 	pm_runtime_get_noresume(dev);
 	result = devm_pm_runtime_enable(dev);
 	if (result)
-- 
2.51.0

