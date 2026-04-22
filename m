Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C53C3C00
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856935; cv=none; b=bkftrDxD7tMVxZ6jdZe6ZcbbYnt/wim59SuuJmJaFloylrCFv2AkszR+pZp/s18uoGbYhgMPjUBDO8k47IpzRuy5/a4tiUWL6O1p/87FASunzD91xmcHq4/MpKEB/RnB8m4MEjgpFkYSesbLAOihSRj9XPWik/chiQkXETTpCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856935; c=relaxed/simple;
	bh=xcIHgNf7IZ1mpIYfG3PSV4cPJggdG9sf1zCtrefEOsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4lAa5PDjL0F6wMFjeGmJ2f/WssoWQiO6J/lKpRGV7osR+LP7v5EXL+JoAt9svtENxIQ0clmbNdVyYng1ELZHUGY2GNnUDxW+Mm4exbku30SaZOP/EdLBEmSv2mBp7D6kqyDjg7huDvbLTIlXPBMx4NiJ+TBGwUciuxAtLd0dZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoJXxSWy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoJXxSWy"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba6b39871a3so547742266b.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856932; x=1777461732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCVvekVxbkF8JFb/YEVQrX4pU3MJMS4vANn635ciIZU=;
        b=XoJXxSWyiqlxkIk4g4wPF8Xm4kphnyc6xDCcaMj6ZrjvE+Os+gMNfNax5Vvwd86Rb6
         PmaMR0F9rVzC8ORFu6Yn2tBjMmwLR/yk844rieIP1w42b6yG5NwiQWR2gwnScBUV+zHR
         l7HEIPi9+7K6M23lDgikQYTWi7wDraJJGHVXwyM3gIs3XkdbKk+2WrM0LeToZ7ddIqtH
         Q/wnOxAqnCpRM6lPXwXZbBZ/u3KsrIrn/S5kB2dHaSv570/1TCCxAA0VW5Cpq9Mrz2Bb
         PkJNBCKn8kpe3B/heD5NOcrNvMe9fKJe/aFaYvHx6x6I/TFoSdRgXe3yk/AaEzb3RVZv
         KyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856932; x=1777461732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nCVvekVxbkF8JFb/YEVQrX4pU3MJMS4vANn635ciIZU=;
        b=LZ3bD5NnzHVldxhFTQJI5lxprxTpwS1ibHX4zFHpHetuP3xy5v1iAKn22pBDhzvZ1u
         Cd7sTdm94TDaMXrJvUe80xQJ4PYvq/VKGRB+z7CH7/LIuzoyUY9sH90Piecb9z1q9jzB
         f0ous7F4Udq+XlAQ/bO5dmnhoOhrrdU5SMaHvBTaTAylQ4G+n9hUodJJ63o1sLECxsHi
         zoIwnDEau8Kiae6fZ35qW9gF96WXevhgmab4xtRCiS+WKwBFhr6Xrq1dEqslOfyzwRAV
         OZNgFp5nlQvD2CqzXlKArBGyesDz0h/ozu3Kf/L8VVmd0Z32xUX/X9ENN258Sau1+gFT
         NZbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xCWlCjMULMfnchMEPfi+XqMCxuy8qznNdXBxsNiMCkqc+xKRJ1eSyXWVou2QNfGV/ySpYGJG519c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3RkTO+3m4A15Y5kQUGMRsdSU/jne6LFaxqf42uMQAczx9gYw
	QPVjowGyGhpn+tA1NEXd5wTCjJmWcINam67jzXehbe2HExI+MxsTxP+r
X-Gm-Gg: AeBDieuykKOgx7TK6P/IE7g/1XNtS7QsqJkFGFVcml5csmxErH40p0NZbn1SsBP5Jn3
	hPiqmgaAKR8t4IhVoheSETBm2fEIpS0aCa7b7uIOFFKHbPhcv3XDMqLukz+JuzYwRQlqvynZKIP
	XhxQ5KB+pS1fAe6YblPaQVbXncKefFtRezRT6yo6BfzhhX/J+wedT3Ut2ufvLoL+WBFbskzjQal
	cuUs2jYT3LctBFYZcF5rr0m4qYCri8gKagbI57DfxTyztlXXpzz/kXnWX1foA844k6YY2ame8qC
	I9rc5KoZC3HjdncSKgQY36VzgQgnb52NrFAT0Gw3p3LVRRNhsuRck0fYXYrh3CoxW1hk/Zpl+um
	9hiW/h5Crj3Tx99Rrl3LeexHlC+uIBb9TarLeiqkkMvA/P0wOm5ZyW80Q9Lmwiv6yjb46qbY/ou
	Z/eFSQrEFwlyxjSbk3jVTZ3oCLFMnBjeDJLxK1EQg182CFMZv0QJETZJpcYAWtd1vq6J3baF1kz
	l0lO3B5Js5nzgpqW5efPQXPmM7AlLB0lr9tZkYp4vPutFKuPFrB3TT9U3Ljt4N3dqZTqiDxYx0d
	U6PkfLSmEkfU+e3XcLC3k8FSgW+EcwnfHV27WyJSJmmS+yBDp211GCHsJplgOz7/pvBGhdHpNYr
	tqZ5P1K6F2o7AuQ6i5EvDywsYoinH2ryhZZmczJghpRacm+lhaojg+b/zOaQopxP2kcf+6iEkXH
	nRS8yYra0=
X-Received: by 2002:a17:907:988:b0:b9c:5d3c:11e4 with SMTP id a640c23a62f3a-ba421dec0c4mr1017515266b.16.1776856931203;
        Wed, 22 Apr 2026 04:22:11 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:10 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] iio: magnetometer: ak8975: sort headers alphabetically
Date: Wed, 22 Apr 2026 11:22:02 +0000
Message-ID: <20260422112207.1313-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort include headers alphabetically to improve coding style and
readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698..569cd6fa839 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,23 +7,23 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-- 
2.47.3

