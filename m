Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE7313E1B
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883272; cv=none; b=e0J9C2IoYuLiA4lTXmbKpTmiWyrLOgwE63iojMvV2zk4LhydfJ07fQFYBOZ5zqGYb+7AWKKSkxA6ADmK/Ery0st1Q28+6RLYq+zF75XLPLtqmePqhJ8jmJ4qkvQxJJXaUlQ2b+5UWJRnCHdVYiEmI3iPVqDMcVdEhgy41VWpKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883272; c=relaxed/simple;
	bh=jxTqiB5pvknMxWIZCebGTM+LY2HU4BCM81AYzWN0suM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/pN4W3VO/Wgv7qT7Zt80gtcUnK+qvpN/0BVbRQg88o9S9FKzOSpbIimP3/OaDhI61MGk1Q7FP0oImHNUhDN6grSCeK7LL30d7Xef9tBezuvTZ18kK/53fDkaS4uZ9Da51Y3/kLgatIq1Rlj3itFhXc+/HjaLY3NLLwKsa6TZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imm+a3M7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imm+a3M7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso8997945ad.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787883270; x=1788488070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsbJC9GZmokgjHFLchvU7C0YDsWFwymb0mCZdNSKvYg=;
        b=imm+a3M7UFBJFld5bn2l0yfgNwMOaYlXNs/3vFgr13YzlTVZ2wfDzHycwpKBWcyg02
         QLsgGJYQRzsc6B31Af2qXPKXOhAPrPaN3rxm8PBtubNhZs93KqNgTr2I8d2zcg8h9fEn
         z1Zg4qO5QioOwjxCBJNDQt+ThHXhMHamPLAjMWM/iY99+plm/vu6ub5UNs7I5WsM8nTt
         hW/pMrHGVeDafGrGYDkEZrXRs3Q8fMyJO02hwqEuhL+gAwvyPXVOFVDZXxD+ez4WWvNO
         4f26reqf0mGZtCoBSr3z7x6Ix7mcUfQcApPOLMqe2OVdEUx+Fs0yApuIk80KAVA9CYam
         Dlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787883270; x=1788488070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsbJC9GZmokgjHFLchvU7C0YDsWFwymb0mCZdNSKvYg=;
        b=GkOaPs3Iw5uDX6A8tFV6S/yZHRjBhxR/VpUjDPbwszyQOy9w/djE45CRrXVCa7wQ7w
         InaOuJC8zkio5BrBmDNK3M+oGMUza+tK4jKyDy77HH4P2SUp1a6KTPCSCaW68exMIIcM
         NT2CghO3IXm9Gc2frQUrX4l4koE2IYChwt+u1sld81NptmyHUdtMFgS6dItw3BR9PL4x
         N3raKVEMfNs7jPkRhdmy5kUqTFX119mQli3+oXDQ9pWQjPvrmQ+i4FA9TSGI61qBdX1c
         Fp0TMoLPGZxGSySUG9Or4Dlr9iZuF+RRS93oF8zsFHPBAFVAPOG55lHiNhCiHJ5rozs5
         R96g==
X-Forwarded-Encrypted: i=1; AHgh+Rod/k5UCcsK/fqYaLp6RgtR5vnpYoJWOH1uowFO2QVzdAHtPd6LqP7DJmvqZecKML8HSPasna+oxyk=@vger.kernel.org
X-Gm-Message-State: AFuF++nKEMBhYveIsoPhCyErQgavztQMxjP/ivRe3u8cv4l5b0wMTsVu
	GBBJNFFCcGa3pGrogFtke8S23auz7jXL6Tasi7uzDoAFER0YktHvYXg=
X-Gm-Gg: AR+sD10n3PUCt8461i47tdIBIYlxSMBnh4OgL/4RKOhfMdW1noM+kRvk/jwpInxrJaM
	6CHG3XkqOjr6xd2qCPjL4zXHSTbu9hb4+QlmvLH4bGZXg04BV8DMtXwJoCTiIowF64du1nMy/Rx
	zjiCTNPkKA75oiN2oS1PS3U7GxW1CIhjlb+IQjGlnswh1YnZo1ig6nKewpjSWi3R/mVovJ5iKqo
	5WxCFvCTwJ94ifdkYZ9QRKYdgh9+WeIILgEaXLEamgbTU2A+844J5pPhhFYn5uGYTgsCjSteF/3
	Gadi97wlZ5dhF1JuI3ie6ndC0f8wDVk02RBQiQLM3HOcCIX3AzmuBmFGrOy9n/IBGpFCAZMFI8Q
	trlct/AIJHFeqJp3JLokCxJXuh86L5uTWcGxNdPIuVirWzRpNsVHp+hKzZ1iRxHtBHA+KJ11RDp
	UF1n8g3e8ABkTSq0JsgRisBjFu9vAODWxAcoL+Ply+3A/IsCSvlAl/Qb4gWTP/PQpOkOEVwAGc
X-Received: by 2002:a17:90b:3ec3:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-396d0ebd7eemr5881409a91.9.1787883270506;
        Thu, 27 Aug 2026 19:14:30 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([113.185.111.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa400c8sm586799eec.30.2026.08.27.19.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:14:29 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	dlechner@baylibre.com,
	groeck@chromium.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	tzungbi@kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v4] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 28 Aug 2026 09:13:49 +0700
Message-ID: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr(). Also replace SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
with EXPORT_GPL_SIMPLE_DEV_PM_OPS().

This allows us to drop the __maybe_unused annotations from the resume callback.
This is a straightforward cleanup with no functional change intended.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Use EXPORT_GPL_SIMPLE_DEV_PM_OPS for cros_ec_sensors_pm_ops
- Wrap to 75 ish chars for commit messages.
Changes in v3:
- Update commit message based on feedback from v2, and added Reviewed-by tags.
Changes in v4:
- Remove the "Reviewed-by" tags.
- Address EXPORT_GPL_SIMPLE_DEV_PM_OPS() usage in cros_ec_sensors_core.c.
---

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++---
 drivers/iio/light/cros_ec_light_prox.c                    | 2 +-
 drivers/iio/pressure/cros_ec_baro.c                       | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index b971f8b646be..551b86236abc 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -311,7 +311,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
 static struct platform_driver cros_ec_sensors_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-sensors",
-		.pm	= &cros_ec_sensors_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_sensors_pm_ops),
 	},
 	.probe		= cros_ec_sensors_probe,
 	.id_table	= cros_ec_sensors_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 5133755c2ea6..d03e40c91582 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -862,7 +862,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
-static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
+static int cros_ec_sensors_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
@@ -879,8 +879,7 @@ static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
 	return ret;
 }
 
-SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
-EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
 
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 7ab565b1fb9f..b1c92de7922a 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -249,7 +249,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
 static struct platform_driver cros_ec_light_prox_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-light-prox",
-		.pm	= &cros_ec_sensors_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_sensors_pm_ops),
 	},
 	.probe		= cros_ec_light_prox_probe,
 	.id_table	= cros_ec_light_prox_ids,
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 6a567b6075d9..e4bc4df48d01 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -192,7 +192,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_baro_ids);
 static struct platform_driver cros_ec_baro_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-baro",
-		.pm	= &cros_ec_sensors_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_sensors_pm_ops),
 	},
 	.probe		= cros_ec_baro_probe,
 	.id_table	= cros_ec_baro_ids,
-- 
2.53.0

