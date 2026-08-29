Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA840099D
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020780; cv=none; b=DcXyaHh9mvSDKhuang1g3KTN1VcBoYCPFwXkQ0XXK1up5xQYnHtlkj6/sNNROoXPXqZRtDCvflb6ltoPlQSzH4BW3aPIxtpvg/JV8Zelyds6HmVb5qRS963gTkf8M9swNwAMyIfYf/bnXGAnVkjtOeOvufcV0zvhYI3cIuFLIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020780; c=relaxed/simple;
	bh=ZIw2rzdxIzgoQq1kfSNGayVIiaA2jegJtB6KBr+dslc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D92UuhZXWga3Cg7PwqUbo1u+HJGyfgCQDbO5dTMgzdE7eHOs/ubvXo6Ms9ri/4M6+0+K/nuQ830TYJDS9P/S0rssWo6b7rayC97VSTytzYrf8utwl5AJR/s92ITQ7B0fbrm+EeHI5KtYooIizaxrBSypamfwwL2IBSUSu8bAw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaVHsc33; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaVHsc33"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48433f36a21so211080f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020771; x=1788625571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRNnsMP4fdjNaKvqoLkeRuZUXITpXc/hMd/ONdj0oI=;
        b=oaVHsc33UUsWsLwrfmnDpxALQgWgCZ79za098Xhh4k1cLPpOavDVkieSe6oXSOSVJJ
         pKxzgpZYTNyZKTGwMu2F7Ejof8vXl7yZ7CegAkbdLsrOf7KTZVlg8+RrYFF8X90Sxth7
         CKK5itioFQ72pQVo6FDIBJSlTr+GHNRWX4BoSL/xev0DCgXgfD7JyJ0vVLGWFrA6z04j
         4d02OQ4C/T8+iFHcpz6P89wbkwgIzyKRG/j4aJijc74KloyV89oK+qGQQzU/zcYntzt9
         k9oaqANn8GHd0PD5nMGxR8lZau/sXhbGx8y6pc2yzFIr0GOy5MrQvncLuJL6JExTVdzc
         iTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020771; x=1788625571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVRNnsMP4fdjNaKvqoLkeRuZUXITpXc/hMd/ONdj0oI=;
        b=P7R0DUqfFa/Yy1+G6TKjHUyZQHNwpqLjKx/wJrzpCsNFODJIATYy+5jbkdLNqY+697
         eCtYKJdRSUrDNdOUKsGDOphaWXcaGr/gznoGQe7RWpXDDPv5hs8Iz0aTzz7KS5uBwj4k
         YAhx7vLCccLvdZg99Ye9sfEleLYGPsY4adqZkf7FIlIgh4OyGyZUZuFX3R5tw/zWYCBf
         OYo/ub+aA93MzrhUacQ5fM1ZuS/8sT9bM2MZKn0F+2MMPxP5YkDyg9creVPLJzBap7eN
         Oojc/nVHcyaJF4kH6wcJVAFesm4HXcvn9vEWO674STFGfk70pj7wuzXkloyIY4nERowu
         wpCA==
X-Gm-Message-State: AFuF++nuVOu3kW/1a0WvfZI8EgG12OD3u5Zs1DLgmMUtO+AdwBIk2wzh
	V4twbAsZGGuabjhklzuuJRshGNogE+yGNO9qNfgGSFh8DEmFLhEYH5BR
X-Gm-Gg: AR+sD13cqiOfZ8QeUE/Hd/voPjA/ryIDNLlrvUICrcnuisdyGUfk46MM1I+90uBQFpI
	zDGcRvD5fAoH7pT3vYwVVCXBQGHm139ye1EzuYeu31sHtztSJNLsWr7YMSmvcFbJ+jUYr4mPUiP
	XoGbNDeek+mmZ6u30n6+o1VT/hCk3kIhjqWz3OZW6Xolb+4x6vI6jv1X+sourMbcf/SoVg/vj2n
	h/LviHQo6EY+nk9KPrBdWXv61WMEVuYDYT7VRJSMy78IYAQPOOfZ4aIQbysJUrCGc+5ubFchxjz
	RWz7PpESes0SRBEcJw0aVIZ+VLcQX/AIgnxa6IGKrZ7jRVh37XD2XN8wMOfmEPC+5+MSCeawIb8
	PjIV+f+QLaFyI7la3xYs/rjN5npFMXig3Wpgr2/Gm+ZHiAJsjpP3uz9VEI2KMU6XjDfyBOJa8tB
	054C9qHLaLlguPehOjCH7oXTm/RcmZJaSjpB6d0Ut4xdKPeH07GHduXD1kqMBUertfCwKRz6xfr
	o3LdT7e992il292lirQU/tCxjmi5b4RhSy4iANL8rcIGb7tZifHXv2RfQbuiILYh0F3FKwz+D+q
	IWBAq/rr6ALKwNVi7e8AaTEMY+nwG7HoQLyOGqHjqc9Qt+VeaOBy7YGP5FAviBbFSiZpvP0qDDf
	i5zh/6cLH+Y8QBnH3/WR9+9vm
X-Received: by 2002:a05:600c:699b:b0:49b:e22:4ee4 with SMTP id 5b1f17b1804b1-49cca2fee49mr97536745e9.4.1788020771515;
        Sat, 29 Aug 2026 09:26:11 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:11 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:06 +0200
Subject: [PATCH v2 09/11] iio: temperature: tsys01: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-9-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=2137;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=ZIw2rzdxIzgoQq1kfSNGayVIiaA2jegJtB6KBr+dslc=;
 b=etx8yrDM8KRtKBRRMfOg6qZJ+DqgDqCZh3pItFttPj8p61kYxa6hO0NMmrjaYtno7Tm0bHxVz
 Pvt+ANBWgZtDU5uzl6K7YtUUBXrTggXt6xmO6DAkvBXv4K9ZwlTdPVP
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/i2c.h>: for i2c_client and i2c_device_id
- <linux/math64.h>: for div64 functions
- <linux/sprintf.h>: for sprintf functions
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/init.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
- <linux/property.h>: not directly used in this driver
- <linux/stat.h>: not directly used in this driver
---
 drivers/iio/temperature/tmp117.c |  3 +--
 drivers/iio/temperature/tsys01.c | 10 ++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 25bc98e64e48..96252627613f 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -12,13 +12,12 @@
 #include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/dev_printk.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/limits.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
-#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 14de67ee8be7..3c1f5b6ac156 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,12 +8,14 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/stat.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

