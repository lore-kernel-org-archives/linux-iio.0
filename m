Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B843238D54
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383743; cv=none; b=ZwU7dPuJGWTkJdOyMrESxXyAyh7kP2pvsHUajIxyIjqSk5wrFCwl69555yYGDtWf5Wp4EJE4HfsK6NL9xAxuwfGyouk0o3msAZP2uo+bkCgjVcs7JCSm9ZUobmPgE6WW//zvwOiZ7gB/GUvNv/isT9Q4PLEZQ/yLyvTTDAMUj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383743; c=relaxed/simple;
	bh=r1259ryyq1Y5Medu15JbigI80IOJItrkD5YO2EJQ45s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRH9r5pP4VJ+HjWn3kUDx9gXup18cboMeu3VT0otdxc0QoJnoUZfPoxvE2hoZAGO4zAfLtO4sq9BnzXSBedMiUy/9pRSccV19A2WPGd/rbPX/vR0TSpD4iyBy5+ntYZefG4JH5yjxEJEGBfnVI00OVGUKd9z9sPD8mFmvNvjQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ihcDgSHM; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ihcDgSHM"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501418152cso10865139d50.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777383738; x=1777988538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+at6i6HiYTzumlfAVcy275U38oRjt50Rnp7p9mahR0=;
        b=ihcDgSHMB808S8i5NH2mI3vjyRZcsHLtq3NoZ52T9lYJMV3TP/MnzmI9tNmNrQkYEH
         Z7uoKZoY6uW4DnFbGImtrPT64zhAdMf4ySvRw7IUeSdXLYOli8lpGDYh7OYV94Q0NceW
         5NQqIbc1CZ/zq/6XTd6DoUkUKakUJMjiXiFdnEP/Pel98tc9h5jAELwTVbZUNAJu90Ri
         OGqI87WpThETviufjKFBPF35ovqk/zn5iLyABz3uAXc7V+mhQCmn/I1L+cYUjRH3pmUj
         1U+mxEtMsklNgZaZhDKJGDSmQhXnBprU48WOLhAvTFuO1C7lPRZfRBRvipRHJTpmvEJq
         AIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383738; x=1777988538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+at6i6HiYTzumlfAVcy275U38oRjt50Rnp7p9mahR0=;
        b=PwSIpWCzAkzv7YsSZulP4eSqquBord7ZHVyf2yU7UXWMqPKPoJwy5Sgs3Z/4Rr237Z
         rzC4Cr4aP68BUhsvLSQ2StcBOBy5Zhf6H/XPj3HBZH6VZLbkvCFi2tIWG5gR8jQrF7Bz
         6tXvKawnnxfyCM05d5xa+PXrKhy3Khx3l+dL5JPwdR+v5X5poEl+H1CbZoWKn3OTtEgL
         2/ZjqKZi/+7MY2588o7hAV6kGvEpQyu4QGRJWGtlCUJ/3qZTROnfoklysJfZdTzgmXRV
         45STqYtoP6y6OsUbwAFLqINFitcEWgPNFP3cAkh/fkc8hti75biHwEn7YcYuB9DARA2n
         LKyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+n7+m5VlCS8lby2ruSG2AgrQcdP9OiFE31XX29KZWmh5iWcmp0Z2uYYmsBeE8/LA8IKrBXbR8NrlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHmhtJhstencpKNsICUrANZxF41OtgK0GcEMiLdZd8lYDKcyE
	ZnlARAaGXk4dIP2QaOOyLdf/P+VvpKIQCvJAaX9+faiHijAZTX/SfviSr9bdbzDg/EY=
X-Gm-Gg: AeBDievwM494qun1S+9Tr1LeRojEfZX/H/+6JVFwRXSlojKq+YqQ8XMcJCfOQxHfRtI
	dq968E5rdmCIYjVv0L06xhpY/yiHxjLQVZX/GNAqaIws8JklSA4jX82ADS6YJiY+j87XfRu3s3j
	O9CmpIECegMmKPAkYoOX8GkDXjg5qshChf1owWzrNfvISzwQucXWLwt0Xcw2Q5YcpvypdThmYAQ
	+uPUFVUnv2e5hDLqJ+D6uO6oTIEygA+TMPTL08fX4UZ39UriJBFshZVO5epJ6UO10UpN6zPG0OW
	kvc6CHgBixKr0axSvAVZEJvXGzVxpsxXObiyFcPJ9sOuSvMmomfzJykf2wN25KAo+FWDnodd/Y/
	J57BaTKxO18xHBF/+V7qP367j1Q/qgqS5PJJmB5LGgB2qUfFKMKiIqeLPYUXR4n2zR/Yqv5GmlN
	qBf+W2yZpWZgHw10hBTIjVjUqTK86WdbzMDlHGunV/AZBuRZtBvDfFWT0k7zCwKBQsoVCnB5iNS
	A==
X-Received: by 2002:a05:690c:e3ef:b0:79a:b46c:e60a with SMTP id 00721157ae682-7bcf58b6cc4mr30026827b3.44.1777383738412;
        Tue, 28 Apr 2026 06:42:18 -0700 (PDT)
Received: from rafael-IdeaPad-3-15ALC6.. ([177.75.207.206])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf0d452a6sm18582347b3.46.2026.04.28.06.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:42:18 -0700 (PDT)
From: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: stk3310: update includes to match IWYU
Date: Tue, 28 Apr 2026 10:41:56 -0300
Message-ID: <20260428134205.1137419-1-rafael.guimaraes.dias@usp.br>
X-Mailer: git-send-email 2.43.0
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

The list of included headers was strictly alphabetized.

Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
---
 drivers/iio/light/stk3310.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594a7e..a4c182c83956 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -7,15 +7,30 @@
  * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/regmap.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/kconfig.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/sprintf.h>
+#include <linux/stddef.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #define STK3310_REG_STATE			0x00
 #define STK3310_REG_PSCTRL			0x01
-- 
2.43.0

