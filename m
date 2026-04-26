Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522835837C
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202690; cv=none; b=hr9qx0COTl1HbM8I3uwrMbjpiIGI6CGYufKdQMBRYMZhYi9GI+YnvX1XQXibStO5vwA/ONqBH1eO4IBj2c+lauDzG/Qho4UgDNMEzHObi2FDh4sQDN0gLu9cSMiYndmV9Hd9YlrVQZSbM5yknTG98YvsmBnrPMoG9YusJ2Rg4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202690; c=relaxed/simple;
	bh=yMNm5zjOxUykvv4PaPRt8aNP4Hd4KD43T5gTpHm3H6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LissiZYU4/e1xpxuLzIppzqrA4FgqNKEYV8r+nt7aUb9N8353QKLH6IAV9rGtmT+8V23uFfnxxu8tTkPtxIq98M7RZoOiEpHK42oT6GmMC6qYKqti0ar9jizw4/aHhg0amnK8W+l250hQA5dia/d3ZSz+bK+b+DtkQCQU5zOh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL1cJsVR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL1cJsVR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d734223e4so6309459f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202687; x=1777807487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6unAoYNjYf00ljt6zTAD3QYR+yt3cVTnuHzBTrptS8=;
        b=BL1cJsVRNXfNySL6dAlIQabv19XABjtZn3IxjdAN6wqvAxuUsk9wM4BO4TO2f/PDsn
         i/1xV2kuR+ywF+aWEp3GwiiQPSICcz7DWmCyVZNAx2ybIZhoAwigCJcQ35WMFqT4uVct
         H2QAPe2iDaZP7fH4AKxOR1ggq/iQ72vWs6Ohz0Z0F8OBxanxDJ7z+eNUyM1MLobUiHSV
         BwLd6cqBjBReurMMk+ersxETOaXAWuVaqGsWg/S2Esz1p+n1FdHo+3keLFuUTWBv51VF
         /jbT+KznoRumPgs/DDeARRoe7uF+3bqVTDglKKZiUFioYZKamrrOLTGIUJTdKis20i9a
         O89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202687; x=1777807487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6unAoYNjYf00ljt6zTAD3QYR+yt3cVTnuHzBTrptS8=;
        b=PPI6SvPnUW2qlTKEfFvDyUm8QjpEDsJL+NNJDIJXJoxeedkdDCW4ImO/aUoTfzkpwA
         e5fzHahIKNCqrFmRt2nCdZJKoV326Y66uNXpNrPR3UdQ/U+JZidTpdkTFRYA9XqGeKkc
         wDwZhdL4AWfqBH+VJru6dUHC9pKsHp5Qv8H0y5yGwZzaXf9jju9dEzoQJMmMEtmAiVyI
         6UQLO05bCPYTprhfgtyOf8wFkMSK3DLrfAmkj4pK4NX/xu5DlRN+B9keO265oDDgyjUS
         dqqKHL3z4sY8eQOxVxohPZqPSltpK5BlImmxjzoUzSFjymqLpPbdaBSJEyIx8dWW9vvm
         wiSw==
X-Forwarded-Encrypted: i=1; AFNElJ8szdEU/2CiEVZWREo5h8DWiYwMW2wfxmVqIQvKtU9GniWioibVMtECU87IUChhMIXghfdk8Ln82O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0k6bJwcw3AWRpHnJZ0hLsXXTsbI2FI7RtgAQptoMNHG6CmtlR
	hGx6fRKWOhYl7YMBkoT19QamHwZj04EAgu6WZj/oQGjSCqA8fS+mMhy/
X-Gm-Gg: AeBDietLcYMaVL/cZJUyGe0SUUs/nHcdYLQpoqvN0awohR/bAAqE9awUJDnX3t/lkTB
	pSgdF1pjy9/m8W3FhK8KbQLhKyeC2IbjdbThjIgETlnnDObc7AtOg9aiv1lyhBk91B19yRGbrty
	BFxgl77M46nvBc1SNLTse/FBNd/aqDEo0WWFOkaxSfgcj28KlCJ81f9BXP3qHHB9j6Op3iZAwns
	NECyS7E+74tyesV4CVfIzczIt+QrbYGKlPEXuORDo/Ap/RP0M9kkdqTCsFXQM3HhRFa0/ROHcwH
	QdjJ1xdiWzYxxhNTUkRhFY4rrtdZXOFDbk0EL9Nkzk9VlFnkCq4wJlTRwDJRFE3IjlzJsAm3oVm
	ubBs5BQ21KrFGA6ANQ+QLezu7xm7AkObmgxkDoRCygeIQrmbFRnBx8HWyi6KXWu6XQLz83J05K5
	p9EYNgOcmwIaebqUTi+FVfO+yiaojIJJcZ77H7
X-Received: by 2002:a05:6000:2305:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-43fe4087e78mr63912555f8f.21.1777202687198;
        Sun, 26 Apr 2026 04:24:47 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm33285999f8f.15.2026.04.26.04.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:24:46 -0700 (PDT)
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
Subject: [PATCH v3 2/3] iio: imu: inv_mpu6050: use devres-enabled version of pm_runtime_enable
Date: Sun, 26 Apr 2026 14:23:33 +0300
Message-ID: <20260426112334.3938774-3-andrej.skvortzov@gmail.com>
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

Usage of devm_pm_runtime_enable allows to remove driver-specific
action, that does the same as default action.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes in v3:
 - remove extra blank lines in "use devres-enabled version of pm_runtime_enable"

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 49fdf33adec99..fc786aaeac5e5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1874,13 +1874,6 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 		inv_mpu_core_disable_regulator_vddio(st);
 }
 
-static void inv_mpu_pm_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev);
-}
-
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -2019,13 +2012,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return dev_err_probe(dev, result,
 				     "Failed to setup regulator cleanup action\n");
 	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+	result = devm_pm_runtime_enable(dev);
+	if (result)
+		return result;
 	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
-	result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
-	if (result)
-		return result;
 
 	switch (chip_type) {
 	case INV_MPU6000:
-- 
2.53.0

