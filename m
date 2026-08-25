Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71352E06E4
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621264; cv=none; b=mB8dByoAs3pyBjk7NwnUzx+7igDejXRiN6pQVJNVCGJ5UVRfQRSaXUaXel4Uxe1r9qaXCwJ5UkH6OpLwBVaMZjtPIvBGrQs1Z4BlT8uhVdF7cMpqyYo0qoylTCCzijTAf+7efklu8WVDZEy910C7rfFBZuOzZ+fONa2qfSO5K+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621264; c=relaxed/simple;
	bh=WfBVElqMKzG9ZLe8SyUCXKocSSh6m2JvvQa+DPy++VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISdn5aIGyAF0Bx/19kzmfW5vcE+6Gc6VcTw+TDtVUM/WdRAicUnZcD9e1Il7sl/UGlSyZRRSOrPhdJ+AExu9f3SAULlVK/imusblF9Cw6bdo2ztxxgabh+/v5uaVN8PMBDczz0iwfT6BO44wcLisJgTYPJ2jHFxB15pWIY+LvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5tzZYc5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5tzZYc5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso4273529b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 18:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621262; x=1788226062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vjn+wpkkMzFuh9sILOPDdKZBa80uG+b+W05/ugqTzvk=;
        b=Q5tzZYc59I/X9EHUxjM27pmUfvPW91Z4hninnX1I3yNQqmK8aI5i7oIOZQYJX4jhhO
         On/t9Zs48PV3cH+Pg/lZgqY96zfAgxYE+H6ocGgpYLIaOnz4pNaasw0rc1GvNoV3X8CM
         UMiPjCcYHzpABR3K0A2rW1J7h5hC6Ny6X0o4Drz5lCJ5Tn4O/U+nGa0si+kmDXLSueub
         nxz21VKdnEtJ7UBKERCILY5E97Lub/DDMJa9gSp6dp8i5liW1Ku7P89Ua7FMLViEnfXe
         yLwO3T9u0x0B9Qbjj5gJJaMrZmLKmoDwa2BAep0APxqCHNo+QwRQUjcrehZDfaUXoE8t
         /JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621262; x=1788226062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vjn+wpkkMzFuh9sILOPDdKZBa80uG+b+W05/ugqTzvk=;
        b=SxQrEO3d6EZ/aoWvYH0oeUMt9SEF942jfoGofclRCg5cibpLdQ/w6T4kt+W+uK21Z5
         t16kirlQypcBsgmk4rFzrVrss4Afzz+UgNcyzJtNtC64DalaOk2aTc2gw8ldsVGtrM1c
         DNigC9o8X3hDNE/0DBXhRBza3ttCdIzC1zl2Lsw5ea8pdhP8JIvzS+VkHNiWUutEYvkK
         fOgPpFrLepg/4CgWX97GJQgkkT2jEarE+/BSKZv2c5tv2zg7ZvuGxPBreoVhzENZj7Ym
         FHoVCry+2wQVwKKEV9T9KULbhqXKBPKCsys1Ui4DSp4hNR0TJWE1yWTteg5Z3s0IH3x1
         Vygg==
X-Forwarded-Encrypted: i=1; AHgh+RqdYHgUc8fRMnhc0bIJGtrPtJK4AflXIKtR1uQq9COsAq//jjC50zVWgWNcNjHeGMSKAjFgxsQJ7SA=@vger.kernel.org
X-Gm-Message-State: AFuF++k98tjw13hBYy+qxBzjBfuxv4AftttN0EkyE6Nlq4rP7Ozlx03U
	q8r7q92X1gDuXbZvlxAlrbtLnujiDJGdHgWuv3p5uoyga25V/sjnPZQ=
X-Gm-Gg: AR+sD13Wley+IP6vq6FFN+P3N50veK2TBznGuHNE5P+XUKUJ8HcuhusmSQn+293U0l6
	BZJ6c+zb+kigsJ8aP0bQ96KfpMYi3HfEngqBDgNcmjsUnSiuxUdgtU/GSD3nHc3e0ItfQCuY+9v
	1j4NYURLyQ+F6slGocrvIkO6Ftt7gefpHhZemNL0e2Z3RCJ+pJp50m8MoHZeAVN6eUNt6AtMSjl
	HncXHdQXTz9VjEMDAsTTPCrw/ggSj8OcIg7pK29ulJXssgd+J+1QzRtsv9rZyOx9q3lR0b6XuxK
	O1CrdochqQsiLvkAmOmPyABe4mx0bXwhostkNNrLnOh+7VPO//i0UydAW8Cqn4su+uUN8gZEFVG
	KJVrJe9bHQ347XyvlZ0E79kMsl96mu0+x0dlYWxRxECq9Untayyqkm0bSt/d6WSzSKkxms5S6Jn
	AQfnsM1N5pLfW6l2iwkpkE5RwDeVchRbzdvduhhaLtupVSJwLO1quyW4l6DdJZBs0OQQtMFatbu
	dshgGqZw5O3
X-Received: by 2002:a05:6a00:1814:b0:84a:646f:193 with SMTP id d2e1a72fcca58-8520b06936cmr37618167b3a.0.1787621262149;
        Mon, 24 Aug 2026 18:27:42 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f153c75sm2411181b3a.49.2026.08.24.18.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 18:27:41 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: andy@kernel.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	dlechner@baylibre.com,
	groeck@chromium.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: [PATCH v2] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 25 Aug 2026 08:27:24 +0700
Message-ID: <20260825012725.8908-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callbacks,
and reduces kernel size when CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Use EXPORT_GPL_SIMPLE_DEV_PM_OPS for cros_ec_sensors_pm_ops
- Wrap to 75 ish chars for commit messages.
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

