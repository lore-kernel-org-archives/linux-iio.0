Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34647301474
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772967837; cv=none; b=dGlkYbxSvOGpYTqD8qOU4tG4Wb7ARad+YIFZ+qzsNEEHylra9HLQpCV28E6TegyxYurAu5PRS0p+NtHcByVmdInoORPZYjZqqrJtkUOkzLVSAECXoeGyLxFux86qqcal7dmKWDeLENryzUJ7sbpV7jX422JwlCSd2s7On+dGlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772967837; c=relaxed/simple;
	bh=ZR2qFgJfdC2GjW4dyKZjOf8PqW0v0MbDkbDRSr8lLHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrJ/ZcRMhq8mXDWPt5K/4yDzrGG4KbOn2OvDQDM9VMyf5s74KBik9tsK1cOdYNQ3fiCKHZrCvjvNQVcS/w5ncCehQLmngDYJkIYy8DpVOgy+0UWB8X3+gds+zx7kDQ+s+QZgZbkqHrntgxlN6SLa4HM+jVJ6tPlhIzlSvhCYOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW0VtTwz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW0VtTwz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069b3e0c66so154199081cf.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772967835; x=1773572635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq7xBQecNCcWqMyaqx5bcThSviNyfnXB225YIziDf9g=;
        b=QW0VtTwz6FAY3N2/AWNiHHfisZKCVXLvImrzKK8cAURqThgQogQYYrpeM+kwBrGybu
         GONKq1+K7FRswkTcUgFx+KAV4pajsI+oLYF7f8nTROlTekm4AM1EQrUSdKBjspADcwBA
         VtgOmwS+WG18k79jiSf+Q+EOTmpt93nxYE0+pCifYVTgJxTrmPlQy0W3/SZmmnTk1A7/
         hD1kxashcNMS+z0arz1gwKty9bgSPTBbHK5hlkcap/EltIC/0jV/yRsBZhhq7rM7v90E
         zfULukuuCqMsA032EHSb48ovO7awi5RKH8zn+WwP99WBv5+o7WPmPVZk/+tcxl6scNrp
         ifFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772967835; x=1773572635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq7xBQecNCcWqMyaqx5bcThSviNyfnXB225YIziDf9g=;
        b=n1RFTLM0cp3AGkfY2jPGgU7fymGkD5JVal8oMuSGX2rmlbe3H55KnK9DHSLVYs6R8I
         sie0DeXnnsXGP7o7gfqHtQ5Lb5QolexdENSo1JT9QXEvva0rJKY+afqdJg2txnb+pPqi
         4dOsfxyo+DpXv8rz7JJ4DX8GuYgqYfqdjGF4T/plYC37rwbUHEz1wPTH9aouqeHPHNSm
         pn23/lWjX+n0hRXZy8/77nnSjLGDEuKzKdsaknM+JTMEnn/BCod9XaiSkVDQtLk5w+ZX
         kynhhBLC7gllymHISNvMl/DIuq2hPBRX0tNKTsaWBy5/e3INbrL3YP9sXouai83hD26V
         uCtA==
X-Forwarded-Encrypted: i=1; AJvYcCVH/HCdiHgQVgJWIpAuVZsmLuwPgVwJOA03fKBFCgO2HUAaenLRmSoJc958+dmAZ2yML1acSWr6+YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcL/Cv9jdeuimDzbtIbYgiLXtaikPEjRDTLIpM3PPyOF40vNV
	mzKMNudJuE52toJemF54aqAnLeg7agrhWkqDhSBIvhp/BWSKGvxcYh7r
X-Gm-Gg: ATEYQzzJmiJ2mMMrvtRmLUxPiFLZOXOXXeRKJVdzDBk5ymS25c3Ufn3cOcyVtEOiD5q
	clO8oRMHqOtvgaXmDzvWJl4DzLkCpVlDBviJ/0SdGPljO/tWOTpjNfw+gHGSfaespG6RF5q7jV/
	0bdCKyjmYVarY7yyFXSLFH2sBdlqcxM8APOrteFqK4+lfckqZjspqDPY7pEyXwSeLME6tzw+1DG
	bPnbW37cePy7BpLcanS7sIiyoJNchXknte3+uAtvKcTkgu0AWXksUfNBxAC7M2ifFPoQfdXPBfB
	zPjrFhIXKQnSTwMxtzr0jISqZbVWq5OAxAFhdeKYGmSJuTfVC0JJhNyilcDSdGTNYtxurybIk5o
	PgJwdA2xoc/QI5TQETQxR7dqBFsqb0omWWljOl5y/o+noadsJthvfEJjewnN4KzsdUm7hD/XDHB
	M3FT1W3VDheQvER+xvY7VDjZFLm3h9HRT8kapDfg==
X-Received: by 2002:a05:622a:10:b0:506:7049:c768 with SMTP id d75a77b69052e-508e67f5f64mr148242761cf.9.1772967834819;
        Sun, 08 Mar 2026 04:03:54 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-509101c6a55sm13521381cf.23.2026.03.08.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:03:54 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] iio: imu: fix unbalanced regulator_disable calls, when probe fails
Date: Sun,  8 Mar 2026 14:03:28 +0300
Message-ID: <20260308110328.2859831-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 ------------[ cut here ]------------
 unbalanced disables a for vcc-dsi-sensor
 WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x118/0x260, CPU#3: (udev-worker)/357
 Call trace:
  _regulator_disable+0x118/0x260 (P)
  regulator_disable+0x50/0xa0
  inv_mpu_core_disable_regulator_action+0x30/0xa0 [inv_mpu6050]
  devm_action_release+0x1c/0x30
  release_nodes+0x6c/0xa8
  devres_release_group+0x158/0x1a0
  i2c_device_probe+0x33c/0x3a0
  really_probe+0xc8/0x3f0
  __driver_probe_device+0x88/0x170
  driver_probe_device+0x48/0x130
  __driver_attach+0x10c/0x260
  bus_for_each_dev+0x84/0xf0
  driver_attach+0x2c/0x40
  bus_add_driver+0x124/0x258
  driver_register+0x70/0x138
  i2c_register_driver+0x50/0xe8
  inv_mpu_driver_init+0x28/0xfb8 [inv_mpu6050_i2c]
  do_one_initcall+0x5c/0x478
  do_init_module+0x5c/0x268
  load_module+0x1d04/0x2558
  init_module_from_file+0xe8/0x158
  __arm64_sys_finit_module+0x1f8/0x388
  invoke_syscall.constprop.0+0x64/0xe8
  el0_svc_common.constprop.0+0xc0/0xe8
  do_el0_svc+0x24/0x38
  el0_svc+0x3c/0x198
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x198/0x1a0
 ---[ end trace 0000000000000000 ]---
 inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5

This change introduces variable to track state of vddio regulator and
whether it's needed to disable it or not.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd8..7dd09963d5a39 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1843,6 +1843,7 @@ static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
 		/* Give the device a little bit of time to start up. */
 		usleep_range(3000, 5000);
 	}
+	st->vddio_supply_en = !result;
 
 	return result;
 }
@@ -1851,10 +1852,14 @@ static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
 {
 	int result;
 
+	if (!st->vddio_supply_en)
+		return 0;
+
 	result = regulator_disable(st->vddio_supply);
 	if (result)
 		dev_err(regmap_get_device(st->map),
 			"Failed to disable vddio regulator: %d\n", result);
+	st->vddio_supply_en = false;
 
 	return result;
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 6239b1a803f77..1a2fb857f022d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -208,6 +208,7 @@ struct inv_mpu6050_state {
 	struct inv_sensors_timestamp timestamp;
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
+	bool vddio_supply_en;
 	bool magn_disabled;
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
-- 
2.51.0

