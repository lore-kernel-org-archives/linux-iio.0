Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5613CF687
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856935; cv=none; b=dhFuMfmfM87uEATpA7NfWqqVw4IyIlVR65U8ByUNaob+VgSkCG1/w3lyqIOkxPjOXK+yLYWpOei7sXBoojsjYvjI28pHrw9rlUUNogoP4gyZI2nNdeOc7eJuJBplyewQlIUdufUvHce6J+fhqlsajJDZraPCqmGEYMrNIr/bIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856935; c=relaxed/simple;
	bh=7/sVp9DzLdP7+Ca7u7DP2EC1ylQO/UxD0iuHzqDjZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPvSETeXiUNBalal1ZkhlFRStVWcwyQ/IzhTb4jpB+cV6DU8hKdUDrFcLwMiUk3loOW0Ycv4BR/dHhqIq1uPq6iBBjTS0L40Kt68ociYwDzNX8xAYXyrBtfBNRWdXdzLbdVUh3oh0Yey6ifpitJ7EMsps9Tn4bW1C361c7kb+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qylTuqOp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qylTuqOp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba9ad0fbc3aso244157366b.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856933; x=1777461733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrhnzHNSdNqB+1DACKWvGnlE3ootPvVmXB7Foz0r/x8=;
        b=qylTuqOpJ0xoyoutm4g5LyypDeaukVCzzCkAU71LrDX67mSCGwksvbqaaEcF4Jzakh
         GwtrhH1b7pt3B0ili+bdfSpXdCdq+m4236EABqvhwrjfjbxSRQt4JS49zIZZOfbyP2rA
         NtwNxdrZXfWkaYR7SFtsBCv0oqMo6Tf/0Cz0xJnCeLixLal5uQoBGu3bFmHmdlFziBAl
         Z5gh+JJLCK2Zhix1fLZhWJECQ8Afj2YcVmI649TlDA03v8xzuroioPzGdjDrIpN247RH
         vv/tJnHE4+wJL74HUYDChOlXvyLA3RyjTy913H8+ONDGn1iW0xf9nIx2KzKYFm+vOlv3
         H8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856933; x=1777461733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrhnzHNSdNqB+1DACKWvGnlE3ootPvVmXB7Foz0r/x8=;
        b=p2QEcOILqfN2v+QHMLOLQ104JqzsJPcbEOGUuH/XwGjSEVcQbkiCtapRad0eMv/pKJ
         AmS/Y82sxreIVVSzxZVY6oryrlmMtAig1h3G3TDU3HC3jM4/u1xGHRsqQ4l4C4JZQPdj
         +59phru1w7fy+eCFcyEFID5MkqPOUOuo+9RpVtVHu9rgEWYsp4RUlnKXR3RbNHfYWLh5
         0F7MmgBdX59xldWuMmcELUfxYEfN791G7e9ueE5KntswTPh+TvUGQPuAnm8PLEtcN+A4
         LOEpILckd0NopCnMQ3/Y4Ei3Tjw26bfS8BaSzAvUg4qAAv3YLRJC+KttU8bIBXG8L7if
         Zdmg==
X-Forwarded-Encrypted: i=1; AFNElJ/qM2v5TsStxwcLIUBxoW4tQra1c0fFS5kRmuVqEUCu7nIuxFgnXmmx4T2ec0VjwWQH7SFkl7XtaoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLooG8/b7L8JruUhqpPx2s82NW24EjZv+iHsMLIXpY+bAWZstB
	Jn1Iu04tMHyNznY5xEENaaQIpmc1TITzl/XZrd6sROiA/o02ODXSk84P
X-Gm-Gg: AeBDiesZDz//ZTrthEaPG6bKrg+FsGW5rM2jF4InuqvpwbbWQyaFuWFaGa3L6Yff68n
	LrK/07xrE8pC4NuLCQbU65qzo1wcSFA19v97l0NCQOiaOphvfiuIQks3ZNVT4JEtJlqzFdOL9g2
	oPEU6LqA4o9h5zvT8VU3OFn90OuM4G1blmepSiPrryO/pqxqB3c5HMz7xi2zjJTMicjF4I9yDsM
	jwWEcKgrW9WTFEw77h70Qvf5w7cZcUojR18wAqbKnVJLB/QORovHc13UAa+mTtWSxzTQ58Za9PA
	OLRi5nBvbblB2SWUqodJqQEKPEN25dOG2LCpitSONxpSF3qZkTkRQRAPb/CbkNh/6jd+PEWLEXc
	QEgPtHaF+y+aIjA0G/IwbRlrX4nYzHy4fCgGSgtAmp2yAmiD8qvrUzTHe2sUutgvLaG56iFFMUy
	y4Ki1LAz5oPoYWnjn2z3Tyis+1bNlRmRhmy4GL6uzfFX9D3fI0DBFBoDcF2URC0yZlafxeURwmD
	f+xiIYcblS7BnPNwa/+URlNlriNe+2oH8JOBSyigxT6j2+hQUBixgqE1vkm1EfHM8Cx2zSnwvXm
	49c6mE/+kxr//vmkdlvYs1RnIGrKTsS5hJaxvL4xNRB3ZdHKEyek+kppSQzME0foeWYi5ycdATj
	bJ1C4UDivXbXHYcMiuW2iSUHZrOZRPNH/KPZ3eJuOtz0MsuYHaySUrSwnzQs6LEKjoezbyqbTzJ
	TY1vlnpVU=
X-Received: by 2002:a17:907:1c27:b0:ba7:c8bf:dd94 with SMTP id a640c23a62f3a-ba7c8bfe835mr612077466b.33.1776856932382;
        Wed, 22 Apr 2026 04:22:12 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:11 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iio: magnetometer: ak8975: remove unused headers
Date: Wed, 22 Apr 2026 11:22:03 +0000
Message-ID: <20260422112207.1313-3-joshua.crofts1@gmail.com>
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

Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
types.h, wait.h).

Audited using the include-what-you-use tool.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 569cd6fa839..2c2ed2063f8 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,24 +7,29 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/irqreturn.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.47.3

