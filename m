Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20B43D517
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392855; cv=none; b=heDBbgPjylYHBZz/j5I5xQupfMi360gLUw+ul6j8qmiQ0xuC/ccE7F+naF0TYb1TN5aTMuBxon01sdvVNZvbnmC7RFwV/YZi4WZM4MgP5HmxRDX6jKaVTkIr6pe+oVvFk4iVw/emRAkWkFk+hnt1glqd2Bx0Wybfa84CzScs8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392855; c=relaxed/simple;
	bh=4gxgrLr6//UJ5qO8AR3sR+nfwRTrKMlh+KIaggPDL8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aILoNUDxpxPfMbaJnwQwr0tUCmmTokzJheCh0NHUfgYn/1z8RFW4X3u2sxYYL+5/d/YPWEB10aPcyYdWIBI3f8jb0IYcWWBuOAuDaUrXIwqBIOWAOZ1ubPTV21DETTH0ENyHnykieQW31/R9EbmAz3zDXDxMUoZytJdW8lOwomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wx+vCUHJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wx+vCUHJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b9efc299so4840966a12.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777392851; x=1777997651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etYkbxcfufBVvSrAL5nRNVF//rHs1zKxtTsofHw0lVs=;
        b=wx+vCUHJPlIN88y7/7BA4dRARn3dAsw06upivnvQkLxFI8yMOFrQ70H1gmeQizYGM4
         sEQtlnrgQfJ78q1XjzK3wNUG8fm4F5RCaXN6mLb0vmQCD1RssmkUyd84cyq1R34ATuks
         D2cyoVS/VGPs//0UJmXSk+XRPcY6i7j6dyiYz93rrm7g8I/yJmJJaBCG6xZaqOUz6d1Q
         1tNMvWQHXZGZ1sskOToyo7xwNcLA7/O0MR0Z7S1TuTUv+0pFWUnfZZ7Zs4EoOn10AnOK
         9MKbh46KAptP1oF1oQbaoz2sJ90W09BxojHrttPkLnWyItmDBnjB5U1/gNl/0JzSm29c
         l54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392851; x=1777997651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etYkbxcfufBVvSrAL5nRNVF//rHs1zKxtTsofHw0lVs=;
        b=h8NOUjqbGoDB/PX9DDalUQfH4rUWrH3/YMfPvW0B6uIjokgx7k70BabNdBGMrD9tD3
         K7Zkm2d8Y65gS69g0cy2puYg1kNRfGdavBJu2dsMbLe/tBXQfWypJGvZe9r0l2pnClYy
         tyRVWzYEhZMaWRfnfsLeUncVSOgGQp1wH574c/1e9kLIqFJl/oGMyabBxChW6SrlT8Bq
         NAWojpGOLMB3BkTZsDYoA0cHj8ApTsZZcS/eo4Pzlu0+KVeXCVYiwuZT5yEmSk5+7M5w
         Nh8QEgh3Q3L1DIGWiYBGXT67XX7MAFuhr9i6e9Hiax5krWYJOjRjXxOXQy+KD/Yzx0Pp
         5lnw==
X-Gm-Message-State: AOJu0YxRnJfcVz5Wd6aRQ/8IeSVm086aQYMJIyM4aw+xs7iYidz7PJuE
	Uzmcyzii26msY5KKvf4xL+BAcc0+GUgJUNvE8lKDBNHqhXXUUcGClkEXb85SbTH+Dz8=
X-Gm-Gg: AeBDieugcbLaKTf6CLZ5D8hmSAO+U/36Rpb35yq+9lT3wS6MBV3kYIZZAJMSPhl8idI
	6PBM/UmpJ2IfjBf44F/x04wkEiEapiC9PpeblEcjinMRv7nbc7MRlQvQshEPavzqRXqfAcRezGx
	SNPEwBNznMVyuPARvZltCFcl7YkKdowNLyvdZ1pzNQVwajlCN+Mot60MWsjy2DxE7JRQuXcORfd
	jwtmONYgVLQ0yiVfcpjC0bVYCoHIngGw9l7fl9OKogQsRdAtiigxlS//cEkQYKXwLlBCdD0ktMj
	6zAQlFKjFcy2VnbFcuxCFPjJW5S3oBXgwc1RDLYkylqA/bGWJZ5+XHzxLf8d8Q1nVFfPBo3ipvI
	OGMl80abBX53IbPfNLJE9irK/d3p+XEhcvb8lAYtudRdycdQLZc3MPbRUzwpqZCExgqjBBdSMEh
	pIv9c4WqMkew3hIjHiBDq8PNXxVigRcXO4I3DUH+OO27Ke1rHkOltA1aiaIpNv5xI=
X-Received: by 2002:a05:6a20:6a03:b0:398:80a4:d6ba with SMTP id adf61e73a8af0-3a39c2b2da4mr4662245637.38.1777392850704;
        Tue, 28 Apr 2026 09:14:10 -0700 (PDT)
Received: from rafael-IdeaPad-3-15ALC6.. ([177.75.207.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc35d9313sm2887728a12.30.2026.04.28.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:14:10 -0700 (PDT)
From: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Subject: [PATCH v2 2/2] iio: light: stk3310: Update includes to match IWYU
Date: Tue, 28 Apr 2026 13:13:39 -0300
Message-ID: <20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the included headers in stk3310.c according to the
Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
header and add explicit dependencies to improve compilation accuracy.

Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
---
 drivers/iio/light/stk3310.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 1fad9367c2d4..37b7b9367269 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -7,16 +7,27 @@
  * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/irqreturn.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
 
 #define STK3310_REG_STATE			0x00
 #define STK3310_REG_PSCTRL			0x01
-- 
2.43.0

