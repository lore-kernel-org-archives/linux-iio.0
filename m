Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04D35674F
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276717; cv=none; b=fHv9EEX+7yA0srPD/f1gBZ+5uOFYUg2ZRB9hQBfzl8xpMJ3isl+0yiy32q134nrZE+f+M5yNjvAFamrVT6TUPZrPytN47ny3naQ5FDb1y297Stl4qdn4xPeRVGYmz5YEOHoikmtn3gMMl0SDFV7inwOeza3N5QX1aKbPtzwT9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276717; c=relaxed/simple;
	bh=sbAF0uqvlZvxsWfWk0SRP6ojJ7r9s4RDxyKqD93t8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW6/UIItZaO03yz80qlmZMGg0b2GvcoEm1Hye0zNKCKLPUVTIT+gNDBE2idgtrI1U6x0FK+iclCHhMro2n1xAHToDUE736memN/TxPg1VpC/ATgBhF0k0YeWeq+e920yol5vaH1EtxHJKOXXz3RG2omXdOeD+0fHbB50NPShBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmC9t3+b; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmC9t3+b"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d530328efbso4735725ad.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276714; x=1787881514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZttsssqOMabZj0EkbaAGqT7Bp9lWTkosvKZrWr3/hA=;
        b=pmC9t3+bT0bqnR6np42scxFfcv5Xq4CZjksmEi++FNeBJOzffmohe72bAygpdrTJkD
         zky/zB5v3+fasBu4hFeP+qeZKPlQ91KfGP37hbyi2NmjrspQx3gEAVajmu3CWunZZmtU
         Da1IPdHG+VzT46MjfBB8EQDsC4WfkL/uulqwTr/VnEkswfpg/LRLAZVQpPlPtqQx7oe0
         ErTyvw8Fb7eAvPEsxENP2OG5wcdeXgMjx1e5Yid2gh/m3LEK30J6fY7FnRE+jZpb7SPu
         MaUWPyUzqoCJ7T5h0Lt0O2MYW8jOCR1JFdXW4eGSFz3le3Xwh4H9JHzb+Pr/HNX1niRg
         9whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276714; x=1787881514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZttsssqOMabZj0EkbaAGqT7Bp9lWTkosvKZrWr3/hA=;
        b=J5bpMzjnSDB+dcQpjd6O56z91kzgeMz/ACHlSUrhhibwFPiO9WHuvF4bMC/PilCcHt
         h3RIUA5kYnAar56T2zKkXAQhbcL1MUWKDzIKkuuayx5dj1lG7P0WhZDbzLTVclBYUaeP
         5GqgITRXIznmeTfUgPPo/fC5OHagYM6tPzy1vGL9uCmY8BmoEI8Nb+Yi+ws4S74sTsrp
         M0AKgmbVCI0JvneO7vcMfl1GM3RAMToG6a+zoSkWEQSG3y+PUpgRHlwZjXn4IUOmh8yX
         zhhLP6E17dTGxrlzsxnxwPr2ysmvlXNTAFgTAEIP6eLgBrxfuFqZOMOOvaQ5zol5s65Z
         f3nA==
X-Forwarded-Encrypted: i=1; AHgh+RpB80pMBADxzhtatwYcAb/lfv3IT1kjwGLSpg8ENgz4oAboiAh8ZJZ4U0vDZMCwYkQVB+Dc8rnvht8=@vger.kernel.org
X-Gm-Message-State: AFuF++mMJi1WXf5cZlGMXD0/x+EOpEsERw4DzM2eb/waN/Nww8dnGT9k
	ir2ybCSVPFSOcY8EkTOGB0VBLm2NowYZgQYojFJ6iPXCdfIMlrs/NRk=
X-Gm-Gg: AR+sD13pv7pJVYOQhNYHuuqLeeA651A17ybG+i8xUXVGv5jKFiSfrjEv5fFk1IkdSuv
	mB1FXJ7GKL7+6dQFfdnbBry7GaeFPXfVjm78QItCgjKwlk19tUrDIdb9ML4C6rt074fE8+Jrg04
	Nm5ZL9kduuuV2dPLDEKnWUz6m7ru45XDFNQi/QOC0IgNF7UfPtbxcdXugAhPHbO9628suTJ/lz0
	WVLLojHP2bxe+TkmxG/ExQJyH/84+7xo0VMDY7jaWqxbSyj39xYDOQKA3L4BfBGma2aB22+zq6s
	LZ9y5WdWQmagJ4z2eUMX+wuYj71x9zjRRow7a+irV/PnseHZKIEL5IDYgiOJ3C671/PnMD5C7MP
	+o5vju07LphTVRZUK7P7COXfM9mRtU1EhbZz3CkX3Ecc00MqBN4UfHMIPwxM8F3dg/l9vrnB9A0
	MdctHSAr7sxu7Odn3S5ilTt3W24WSLLIHixgu1g3bzXK7AqdbHtajHgUL3aXEiwrUCbLYCBWLyy
	Q==
X-Received: by 2002:a17:902:ce08:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d64afe9569mr53845135ad.10.1787276714031;
        Thu, 20 Aug 2026 18:45:14 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3cced8sm12727335ad.75.2026.08.20.18.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:45:13 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	bleung@chromium.org,
	groeck@chromium.org,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 08:44:54 +0700
Message-ID: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations
from the resume callbacks, and reduces kernel size
in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++--
 drivers/iio/light/cros_ec_light_prox.c                    | 2 +-
 drivers/iio/pressure/cros_ec_baro.c                       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
index 5133755c2ea6..7d09f7c7d35c 100644
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
@@ -879,7 +879,7 @@ static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
 	return ret;
 }
 
-SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
 EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
 
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
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

