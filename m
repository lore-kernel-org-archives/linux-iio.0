Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768593C5DB2
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390402; cv=none; b=G2pBH7NLLS4klQgPU+MXq2YW7DuV5Zi4BAXl00ALceP0SQ7D5N4iNndh2C4yvYKgQ49lKKpYJeHJw/yoZlmHOJOdIFzCQME1F5PDeRM2ypn1WsWCxZzi0SzH6jBqdvnbBqLKoJmjNrWLLJgLGb1IWawRGoAJE60kSt1ystBTg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390402; c=relaxed/simple;
	bh=32ni6Tv+oy/kOK18mu9q4vLAUIJ8UdBbiOvv/GfppQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5aNvVU2LlTnDEK3shmsHWNlTf0dG25fbmX0ewE1RBhl5f+a75zi3qto6PV6qohjld7Sseg4DRljNxfouXIBOGXGXBLF9TcQGMTIbad9kuSfZbl9yhC0rcbD2E1dpPOZ87VR+0cD5dU9LG8VQ/3gpjMgZuhTwSrhdjqH6t7ZvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVJP/WJC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVJP/WJC"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so555692e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390400; x=1774995200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Iba95bLq5te8i3NRXZEb/Dl4RD0T54q3sNbhOaj2NA=;
        b=BVJP/WJCw0twk8iCUwcS8i3fmomxe1/3ox67sbiaW39JGnjfXujsqvsLs3gN5G0vMo
         H9D+fv3Do1l6+XcmSatZd3kZ/vbSY1reX6/Qz1XabgrOJ5HOz9zEjrMrzbaddME6IoZV
         hVxss+xVxRMm1ncbiFBIekSeW7p+b2um7RXtWCfegGggUN0+WtQMbBFMMZxFuNi5BaLo
         7kwpv2syPOuDOORMphy1M4eSLyLGOrgZaC8wU1sa9RmgieVZq948e4Mi6VLT6JweiWH4
         XdOCtf0sjrp/f1hIq702BqcRIcF8x92vDh9ftd6AC+cPxg9+kqgwU1/aCbFrdnwPQ1tI
         cVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390400; x=1774995200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Iba95bLq5te8i3NRXZEb/Dl4RD0T54q3sNbhOaj2NA=;
        b=bzTmBX9NZRrw33mrfQkWDitQZRKBZOOVR8QcP+CJ4WK6cnb6NcGTUSkRZeWXg7k2SU
         mQDHs5zzIbmyN/z8OqZmAJgQ2yuzla/mmBeFEq+N+B98WEctmSkksa0kmI8MuLeOovor
         ZXbnDfQBZvuJMUoKVL2OS1he0/29Q+WH1oBt1jbDuChJ4+Q/GW5D5ixoaExlMvL18A1i
         3BlPRthcASzjuTzJtcbOFhApkWgeu4IKqBeEp/WpCIymPrRnPxDIXiS7C0EaeUpsbK1U
         qj5gy9FufmmERWZkCu72bh+a0Yg24l/oHAAoEoYGrL37ADbG2Ie72GRMYwc/OKsx5C2Q
         Dj7w==
X-Forwarded-Encrypted: i=1; AJvYcCXRsOcVB4tOwn5Qt2PTGMiHbyhLuvoFmxsMQFe+YTb2U652JZWU7rmEJ74q8qibxSlyoQs9CfbTKcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+at4/ds73brBGU1plwpH3bzCVWuwL+y3lANrsDrzyY658I4JH
	0V+T5nEXWehuS0tdCjU+6SsKGhZr5lKs9rryIZmT9kZHQ2TUgeDy+Tyx
X-Gm-Gg: ATEYQzy3MWwicba2P9+FOzm5O1aSRUtTJwhlfBL93DcJKIbicEMecwxrNj3w6C3XVLA
	+ZvVhWp6duo0ePx0xjR2kWm0nmDuXzk/gBXEn8V0zxOYo3MaPtgpzgrqR8txD+kDKzd8dJyKOJ7
	Fo3qCMmRN2IrB5c8rzCttUix9WprHhbtUcSKxqCleu+s0E6ethUN4ZfQocyXkGqDy0XlDFsEC0a
	jp2VsAJuPBRe17sxPimQbF2eVYE+Az+IotgW0WEU4ePuOBBpAo210Qhnwcmij4qis6ervoitenQ
	bOHAINSlCEC8MXn30xXQuG1U6erhfFN2hKDfAzBgDCc42m098ry9gT+SORaI2elKs/NXIgsNHlx
	Ardmkj7OoJWlShrQLc/JGXp1jroXsYQ9mw2cvLS4Kz9SpVhT27P0siFykbLZRyHc2+dfOwd1xOZ
	xwY9q2GPyeLMARJw8GUUm8oqkKzpxphVRMyi9gB0DK5II8ZVxl7MXTKcxdpaH4XAfg8m7kgUyRO
	+qP
X-Received: by 2002:a05:6122:2510:b0:56a:f979:a9d1 with SMTP id 71dfb90a1353d-56d21f23a88mr834473e0c.1.1774390400346;
        Tue, 24 Mar 2026 15:13:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:a42:8550:3587:59fc])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddc7f971sm16808827e0c.12.2026.03.24.15.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:13:19 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: spear_adc: cleans up, update and sorts the existing includes
Date: Tue, 24 Mar 2026 19:09:24 -0300
Message-ID: <20260324221313.119473-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused includes and add what is being used (IWYU principle) and
sort the remaining ones.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Hi, all,
Revisiting this, sorry for the delay. 

> +#include <linux/of.h>
> Why include of.h?
Double-checked, we don't need that.

> For these, given we've been round a few times, it is useful to add a
> brief on what is being used from each header in this change log or
> indeed the patch description.
For the record, what was added:
#include <linux/array_size.h> // for ARRAY_SIZE
#include <linux/bits.h>  // for GENMASKxx
#include <linux/dev_printk.h> // for dev_err_probe, dev_info
#include <linux/math.h>  // for DIV_ROUND_UP
#include <linux/mutex.h> // for struct mutex
#include <linux/types.h> // for uXX defitinions

Changelog:
v3: removed of.h/compiler_types.h
    added types.h
v2: https://lore.kernel.org/all/20251206132120.11059-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20251009182636.187026-1-rodrigo.gobbi.7@gmail.com/

Tks and regards.
---
 drivers/iio/adc/spear_adc.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 50b0a607baeb..b658bf1a7f30 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,22 +5,25 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
 
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-- 
2.48.1

