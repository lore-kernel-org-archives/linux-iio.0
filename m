Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05453F3277
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650564; cv=none; b=MDIELzr9QpdKXYWTQ1eYDqy5jyi17cNXd7QYA/iAvXi3oHLrz6YYjOLmXri8wtaKnq0IA40duXxCpMIhVwE4KKRB28u3siqPcLT/gVX3CPAtwRmPinugjXDN+/b8KH7HDpNIuoZMsHVfb4vRN0pXvKlieHGtZVopTMsXJHzIHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650564; c=relaxed/simple;
	bh=Gvcvg7qvN+e+3AHxDv4nYpJTCVFO4SL2dt4x3hWWHWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3LoaAxuNwenpzxFNrTa+qIbYAqQOCNPkTTKQp3zDUrzzmhwTvbkCD2MekHint+hVra98BLBBB7j9ySLXNOZbEWWFYLFZUcqCniQ9dS7Ci78RyReZwy9FiOtD5Uq70sh/1ACw4PPs8ZGV8slMi/LP/l08TZvk+yZq8CsWoy7vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=damR6YOy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="damR6YOy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so5656972a91.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650562; x=1788255362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgglv4QiDBkUh6JReI7gmaCGhqMs03Wj/b9NbtyBBs4=;
        b=damR6YOyKwChCxwlDSPhynpuMSjTiMCP1fF67FkQ3FavG2ViQBoN8diKKyRx9zXTBr
         evIibJePzefhRAAy5aycsd5GBxHYgMi/VUDcpM5rWrDM5SA5bpIyq5ZJg+DeI4I+7y/X
         bVAkDPdFOI6SwEPA/gnKc4aikInQ4PQSTkTRL6L6spLJQRtHx2etpu5HAvFjDYE3hoE1
         z+5sM6Ejb1C6l2mYmYoMwNkRovI7FeZw6zuOnaJYDyHtGhY5PEs2LOgng8m/8BV9IyAo
         nhA1g9gTamSo5JetHGwBRLrx4i9CDdz4qdILKTkAuThOpYW+TXumLwKJXyGlxrt4KA4W
         kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650562; x=1788255362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vgglv4QiDBkUh6JReI7gmaCGhqMs03Wj/b9NbtyBBs4=;
        b=fNc714GeGjNe0Heniisnoa/yn9FOIVXj9GdBweZX05HCwaDSxyyrwv14RPTcrLkUH6
         WvXh3Q7ZbzGE9qzRwiVl5sqfSYeJC+0bSScP3q4SSGVgZUNsac+QbbFeLwli1vEbYmb2
         1P2qakxNyGsYlacPSaC+L9I8i2jS/UD0neBLfNKO/T5OUT2LQ9pOTyEfEGkQu4YRDkrd
         eTUPHtOf0dXBwTygmG2duVZWYgNZqRObXlYt8DNrukY3xbsqv8BB/WAGPlN1vybH8/Z2
         PLcg+hr26mVt6wYIT5AetiNXW6rQS2QwF1ZKPgJlmsjfZJ+5yPOgtah2cJbVE4V7m0ol
         d15A==
X-Forwarded-Encrypted: i=1; AHgh+RpC0xKE5Pi41OByyknrrJ9FvIHFIdpI8sOitM0BlFAGW6UoYeaxCvbn023P9jRg72kRQYlQeqDZWrc=@vger.kernel.org
X-Gm-Message-State: AFuF++lPzafMcvRToaIALY7fIBQwup7Mz6ld18tNFHxvDz/IFKmF09Lx
	FARW9uo1cabvV9qVmfDoN2MmThReAo4EfIlOE3V/ifb2xn0eLsosobE=
X-Gm-Gg: AR+sD13PynzJB5MDZq70IyWaQ0hSFB+NZO5nZ/6UXQ/Svf7NeyFH84VYK05yVAHUE0x
	OlCK/elbTAwrMVj9ECJkG8mga/Qc9yzp1jjmbXhmODjAFzAyFmfNaXwZrRJrSZK19s4pQ9GyzPo
	KviDpDdNCxxqm1cjX4BS3I4QjjafRsX5RaKxN/sqhW6umRpa+e69Tuxx5Py0Wco1sQ5ZI3eaMkp
	vgvXoJ1q0G1+UBV6YgmSFplSsoUQ6eEGKT8hEg8aEtYfz0KsCLsNLan0EOc8rAfFVZWQzoc1xtV
	PMg16H7BpI2IwpZqTy2fGHZSJLgzVR9/EVXnnn9WDji+UJwtn23/ka69JjM+L/HbSkALf3EiVsb
	YSPQzfDxIKWGOrc0jRmAT9Pq1/ivbZa6F+mLpjHIepZC3PaRzYu5fBqf7m0Hbl89ILTuTiiTSBq
	/xDc3DTyzeNkA+s7V3bgboBxNNxivoA3e38pEMQ8z7/E7Hl3sz8e1OfRTwAjSZh5PUxOCUQqQOk
	w==
X-Received: by 2002:a17:90a:c50:b0:396:4729:43fa with SMTP id 98e67ed59e1d1-3964729461amr7294256a91.0.1787650561947;
        Tue, 25 Aug 2026 02:36:01 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396425d286fsm960551a91.2.2026.08.25.02.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:36:01 -0700 (PDT)
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
	nuno.sa@analog.com,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 25 Aug 2026 16:35:24 +0700
Message-ID: <20260825093524.285443-1-triet.hoang.dev@gmail.com>
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

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.
This is a straightforward cleanup with no functional change intended.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v2:
- Use EXPORT_GPL_SIMPLE_DEV_PM_OPS for cros_ec_sensors_pm_ops
- Wrap to 75 ish chars for commit messages.
Changes in v3:
- Update commit message based on feedback from v2, and added Reviewed-by tags.
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

