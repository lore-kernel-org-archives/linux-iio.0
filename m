Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F358E2B6
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888292; cv=none; b=Cfr/6dTEub7ieJQZ25tIkb8TGx22Pj3gB1mF8m03TJSrlSSUd23HlhhHno8/PzEqGSc+fbO+PRoohoIzSe+RzWACk8BYU6Ddh/pGvDL1oa5cPQv+0ydo7Molt2yun78E7oFOFv8JNbfqV7XcDcBGOZHcLnxCYdrrlr3OQ5xC8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888292; c=relaxed/simple;
	bh=bgK+DZod7mmJgogZgW1zioKzetKNGqoKIW9z56Vpb+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyGa7UcgHP8M/wCfGGe+hhd6GhI/H9J7+qqYk/V/iH8J/uSMOQZbnv+yFhxXb3IdPmuqp6y0Xztlzx+V1V91IRhM8nzcprxNnPsOdirVbyYgtNvBr9z/EDHcgHgCQdr1OCWg+w//jWvgjzU33d6/bnebrQySoqQMNwybG/lAN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS0AYKoM; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS0AYKoM"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso1850435ad.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888290; x=1789493090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=DS0AYKoM/XtIzmvoogEW2zPP8mMC3wPBLkyPVMi+EpTzxEmkY07j/GxQqBkJH3Wrhf
         461MUClpHWrUrOEzHuxY8VloGRupqkIxwhXEbAYIPk6aAaJZhsdN2zC4fvT9b1+xn2N8
         N7+8HHVfBzSWXzokmylQUzsUQoK/gXx68STjdMqHefquti4KNAlq8qq8pZUyMGegMA1z
         JKZ5kscvnHSX1ErGw/EeXapdgTTCjkRYsXLgvG/iI+OHUEnG8QWNEE8wMiKLcfgfWaJh
         9ny+Km/KW0Ahfl64+8+3isN6y//jGg+OQZ2Vk+AEF2eUuwrFP+ZLBifHEfGHlXKuNhCV
         bI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888290; x=1789493090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=WDGs991qC4QNiG4rIP6UAuCwaXe9FntbhfU4b7m2koyDhnSzFTr2RNp5Pry7i2bNMk
         Cwu7KKScQhIbwuFUfStvUqjQs8cprdLiL1FpBQ3m2yFgbV2w/tV7XO3BupWo/TDVOImT
         nB88nLwhiAARnw4Q6FRfzBoK0xXl+dvRdsOiqLyiLmVx+AVqZFz0KrOCXb5DOyrMQh/r
         4vXyEVvgnPwsdnnuO+tM9ckqL6flytGbvB3IIHCzIqdu17HF56mWKvsCgZjdgW3Pko+F
         9nWIHuy2FqRGc/bxRqyl+Z6PAb/Zq+5025yoTpCimJZeIsERmMQkfzaK++8TaKo08I43
         9u3A==
X-Forwarded-Encrypted: i=1; AKwUvByC7tSwIAhRyYqHQ9W6O3fI9RsbFIJm7AJh/80NcTk5YHnt9VNRw8Sk7KUKvsbYhO171OSNSQdt/E8=@vger.kernel.org
X-Gm-Message-State: AFuF++n4l/aHufxtbgEKhVDweVPODHmW5UaNoH5fvUphQxUU3+aW7vCs
	BNnMyKS2MZbeQAuazGu/L8cVinuVw+lZY2hzGxuPv/3antwq3K2yybVe
X-Gm-Gg: AYBFou3jgqGTT3aoj12TIvXOcoQ31FwRj9aWG40CQIY7ETSNBpefkMJNK4Vxe22Q8sv
	wLXyJPdjbaH9dFu362XmfyJP9rOIVOALcurOdBlpvgmyfiiduXIzVMTsipAlk7Q7TNrwxV2rkiV
	lfY4bjBTdcO2p1Ql1i3QLRmfGpqzbNYI8H8vBxL6DgigmGYsKPZ8c43yQ818dEGRLtlQNecqXRR
	34J8jtd4wjbDxCW9gbzIB1hDgXqEBp4LlNDR7dr7kMwZadkejhgxyp9yF8W0zOrbQJWtCka3Vjj
	L22sfPggMq5roPZcuXK27oFt19pOJdXZF1NVjYtHoiymJAxyCJVROHQS+gbzbko/gUH9fGabgqX
	KxtzYCksTOr29Qhp4KyDnHtwa7nxoatGYGv3TIA/jYzIUq0qfMSrHIQ4hLsBGdJNE3hO0MxdhO5
	Em6AqQPzSZPbDgi9TmhpgRzZByCXVtaf52qG/e3jm8v2nxfaFyHG+saz0ARmzDqli6uuLHXg==
X-Received: by 2002:a17:90b:4d84:b0:398:e73e:5a0c with SMTP id 98e67ed59e1d1-39bac138257mr1168410a91.1.1788888290224;
        Tue, 08 Sep 2026 10:24:50 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:24:49 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 1/6] iio: adc: bcm_iproc_adc: sort headers alphabetically
Date: Tue,  8 Sep 2026 22:53:54 +0530
Message-ID: <20260908172359.30003-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Sort the Linux kernel headers alphabetically to improve consistency
and make the include list easier to maintain.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index ab66b97d2f04..e46e3761993a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -3,14 +3,14 @@
  * Copyright 2016 Broadcom
  */
 
-#include <linux/module.h>
-#include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0

