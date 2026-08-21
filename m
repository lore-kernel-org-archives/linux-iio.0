Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A83B47F3
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307918; cv=none; b=XoFtG+17w1dd9SVaIqnwm1B/1v/Ql0lNd63aLTUOb05RNlZbc3P3Zzm1K9XNrs7q304JGFH1obtx3SPYMr+gHkL43I/BBTS16SAnSX999tWexo/kdBHcaNsq3CokcX9zfvwchhSfrxAGzxERmMpmm0ba6YYFiAZLgV+jnJSHzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307918; c=relaxed/simple;
	bh=FQ4fyjXp2OqEnkYHwsfz+TTm/oRpClpjq1D/SX+fetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2hGYFcYdxVp/3WfLpTqpWsOn7+rcDTmp/8QGz3jDypWnyhSPGG2pJN1bnv06a9D3tkvSxNOErR3IZD9fi9OulCVFfr9x/1Bw9b75ZBHM2gyXft7doss/3vt/S2V+QMIWgEW0RBgr9IrJ3Pk+YD9m7oef1rkL0v1NyYlw/0DHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APlPsiNj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APlPsiNj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso5709355e9.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307909; x=1787912709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXCIKeHXfMN8TRcCWZhE+maVe8/ByjaTIx/Ywm2GTsw=;
        b=APlPsiNjTWO8PlFp79CkwZjpgFsRF4fCQEGz3+9PxrvmgtTj0nfUToDDz8m4geRAWE
         EjnA/9Y6XoM9R/Nyj5KMCzmoVSRM/NwyAJFz8HkH0WPGuIiclCs5v76QmxymJm6ueS8Y
         jwiKpxQcaxXHbc0JplcwEj0xtFOybYFJwwvj4YYjOpBns/O4P/h3pUmHzy/ZKbm0G5jP
         vJGnVqAT8VmKAP6NzDqyFKASg+ndzhWkyj4qhiqJ23cyYGdqyPBRJB4aN18RL/1SxOvc
         mWfOclH05CJNzhBycfqw2MzMwixoyStvMDuJMJXgOqg6ziz8QRz/xOm1u6Q3CReE1Mgy
         oQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307909; x=1787912709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXCIKeHXfMN8TRcCWZhE+maVe8/ByjaTIx/Ywm2GTsw=;
        b=qDsLuQqjawZ+FjIPOv1Z+phatESRbS/O3m9/HNWJ5q2oBvjyThN+YS4Q3Az6e6b3Z+
         4F3lBN4hmgJ8NoOllO8VyiTy2AW0GgRi/DxypZZ2BUx3e3iSCKm05SNVQC9malgaFGaE
         +8LJCY0k7bpLwp+5R6qMtSt7tlM948inQaziwVkJaupUiUPPrganL+qDOA3ADOqVRGj+
         gvEZoqiD4/Rt463BXSsuEwiVnexyRUHjsacg4saT0c3EypO3kC4yqLjj405BVWfhOCV7
         uftTDt8OehVZj63HWj6G40jTUv173LoGs1y/mQumqZEw2LbuJ24FD22oIe4oB/woR7US
         cjhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNB8Jlo7YhYPspw+3zJ8dXhhjR7Cx4fQRtAoaLFhnOVAsp3itdgATtDNokvgZkUseWPl24kKroY9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEphJ2LdlFJRk6ltw4Ym9osyYxl9qnLllsOL0MlHdN5bDT67qB
	LOHvE/F8cKDWyOOGaVezyYHW9a6hS7DMv1A86/GSAOLrxCcPHklBNFSG
X-Gm-Gg: AR+sD13sOOvi9PliCsCOVbaA7MqnU1xN+uqcAbZX1i/OvLpic4ZFVqJsyXhoQ5JAl3H
	bNiuHq8N33n26lp94FJPG73EtoP/fSBwCCc7mhrz0MqyLa7Vu4QrO50dtWI8owOnJe8UC5Edmos
	bvCev0Rg6RXgssVaZm/TLuqAZaPmZjsBl87tgWA+J4R5+IEdvvasbNv+VnHmr5BaQo7fICQPStW
	2nYtX2BYV2k82ei93lkytnT+TWO1a9/sbKjCwG0ugtn3NHudTznDWukn5ryKUgKEz1PgBc7gTL3
	OE8uJELDlG88lnm0KFvbad12zzuTCg80lWCvNRgCna8jp6+JLOwguGv2EOXhFJkoYbMOcgePwwy
	h9jzdRo1YxDjyZnILq2gMNUTCXxjNSzSMbI/OEjufinvaTx02kIZlCYQsJqm17GGm51V/AGB8lo
	qK1b+LV2qa9f5Y8VnO1Be8vpHUVRWzK6wWrdDdfoteAICbOMk5xPYMkDHaGlCG95qiKQZvEGaeG
	MiFoWohDx5veQ==
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id 5b1f17b1804b1-499b830d08emr83406875e9.2.1787307908744;
        Fri, 21 Aug 2026 03:25:08 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:08 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 2/6] iio: dac: ad5504: Align headers with IWYU principle
Date: Fri, 21 Aug 2026 06:24:44 -0400
Message-ID: <20260821102452.37407-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the header inclusions to follow the IWYU principle and ensure
they are sorted alphabetically:

- Remove <linux/fs.h>, <linux/slab.h>, and <linux/kernel.h> as they
  are unused. The driver relies on devm_ managed allocations, so slab
  is not required.
- Replace <linux/bitops.h> with <linux/bits.h> as only the BIT() and
  GENMASK() macros are used.
- Add <linux/errno.h> and <linux/types.h> for error codes and data types.
- Add <asm/byteorder.h> for cpu_to_be16().
- Add <linux/array_size.h> for ARRAY_SIZE().
- Add <linux/kstrtox.h> for string to integer conversions.
- Replaced <linux/device.h> with <linux/dev_printk.h>

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index ad1a74678cf2..5c9c66b04154 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,22 +5,25 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/fs.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <asm/byteorder.h>
+
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
 #define AD5504_CMD_WRITE		0
-- 
2.55.0

