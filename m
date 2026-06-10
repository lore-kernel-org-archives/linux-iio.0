Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602D3019D6
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099939; cv=none; b=UI0FEDnpQfqUaObce8vKxuwdVJrRp3Rkie7ESMxBRa7WOuOEWmpYtl+MeFG62S93ZeP5pkXj+hBp6sJh2hB9Gm2GGCVNmE5Z92jsaJw1nInOSrE/d8qBiW/Ta+044/991qDLvf0rKx+FGQRnpVJrq9+zGikOs67aHnYPw0fMYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099939; c=relaxed/simple;
	bh=1NQBpZDJL9HeGyL0OpWgRe8/LPotXW/J+J3Uc6zHzxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY3bLhRxk3J+c0yNKSIzAv+fFJ09eyiTzK9QsprWWppqeOLIo+4p6sOdFHOH22kBvtQLGjsxOxxIqg1Tvj+wpyfnTrjtZsWH/ZIuJV3ypemJUtGGNQfjImM/EZd5K2xumc0xggaasEXIpeYA61zkBwPKs784sumuqE8bAmkWqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0d/YgsI; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0d/YgsI"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-13810b63a1aso6504281c88.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099937; x=1781704737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nsNMGVqiZh2bCAS3Sl+V8C0PSzFYaWzFbEe5fQ6BhQ=;
        b=H0d/YgsIiGb0daIZiacGO4S8ir1yLqQSIUxyfhbBb/qM6H5HxHuBdRqSz3yx2i9K5Y
         xtIKATCXTOhDUrMyUIVnLoC1O4pmW98ov/PM7YIVA+gMn0GUFAb6WHssN9svU54MrcHM
         +Vl/AihGHLHXGoi9lAtbF0EPVNIyd8vNSchk1mHzGTeYsbpF6nzpFPAIW2TCc+xh8Pr5
         wDRWAddyR4uF0pRZX0JoupbQGawizbI+Niz/kAdy698dXHCMK9KDWdmRvS2YqjUkSC5x
         n6Oj28I5HQjX69m4izk6F6VyTL4msJsjXWS7cIzuDjpKfysBxVlORehl0shMtA6NYIor
         8Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099937; x=1781704737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nsNMGVqiZh2bCAS3Sl+V8C0PSzFYaWzFbEe5fQ6BhQ=;
        b=EYaXcVY4I/bIgjA8U7laYle8s3j/1qKrMrRRbFZf/+eSkINogOLQqSqy8LObNdUsjI
         wcdi+2LrTuyDv7yDl0fiiubxExXfBNoSaVZ8Eyf5N2+XEUaW0pwcuQCJsodZbU7WcvPS
         aeN3OfOrVgwq1/QfCoPOg4QCQVHH0YB3VwmXkZEy9tC28LzB+au+NMsRmbx3XUTKuiEp
         xNC4wiLdBGTBeeaM0aZNaKfkqemGGgXnyV6zFrFPSk8aX4MZTpb793r8RuJdmfbzgU3v
         Xjlk8xTQNs01RhHiWFZ/FPdS8ucjeIWPLUMczFEaJhoxCzaTNKrwgBsGU3p/SrZ84F7n
         VKPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+e1HgA34+cC4CSxFG50tyzlSU8gmAfDRWs2gBvDvwd/aZTyjaL87CvJxaNZNAMPmIQKNXCudGfS9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVIHuZdGdhscXXdRJNJmAlGAHDRh7mqSv7zuPsZXNZqwRUnBk
	UNWHmf+3D9rDIOGQckL9ARclBjq+4G15NQwAIml5xYjmxXnizXkvdCBr
X-Gm-Gg: Acq92OEn+GgSuH/EWxor4+ua5sTikbkQbBZGfUzXEIYMeHR3+/phx3eFZvK4pxYRWtT
	ja4+RXS4ghmYytP4kxgHVOp7Krbgn5AgRhFHyyIvdRxMCsD5t8GNPUb9D5YqZqhAGRyjMJiTJV1
	QuPkQFCkjfd4pZxkq/0liZZmvgFlsjNBSd0kt3Th/D2fGEk/ruc8VC48P/i7khi0op5s79+wPPt
	GgtizZZmmV+Rg+2MLEa/eXSYztynU/3VcYHdKshwKrEbIH73x1Owgethz5BHFEg3CrFw5nC90tT
	dccsIl7Fge2U3fX4JvpasyEUUGPxbIplQ3vWhLMOxaRywJjrF7tom9TDeerO+4EPgRgqVao0xxJ
	Ug+z/gf92K/KRULEAGQvJ7tadylLcfI+tPZWEBHgjrpjI9qNKTTtVON77kEtnum8gjR9+bvSLMI
	2cElzF8qeaOwGG2I0QVDUvDHOUs4ErYVGrfGWd7Qsdk2sdoknnY1y90XJafzn4nG/67A==
X-Received: by 2002:a05:7300:6d07:b0:304:d32e:65e5 with SMTP id 5a478bee46e88-307d5fed0c3mr5682196eec.8.1781099937304;
        Wed, 10 Jun 2026 06:58:57 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm33092237eec.13.2026.06.10.06.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:58:56 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 1/2] iio: magnetometer: bmc150: sort includes
Date: Wed, 10 Jun 2026 13:58:30 +0000
Message-Id: <20260610135831.91739-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610135831.91739-1-dennylin0707@gmail.com>
References: <20260610135831.91739-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include list alphabetically.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bf2551988008..f6639d7fab04 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -9,23 +9,24 @@
  * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 
 #include "bmc150_magn.h"
 
-- 
2.34.1

