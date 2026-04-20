Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FF334374
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683353; cv=none; b=DFqipwLwM5JkI8TKSgCyVmgT7onLyTqaVyMHOUft3wW7MiD7ta6vK7Jt+wddupEHmLnEbak69aEx0x9E0wpdQJEJxJKsWdyaw3EbaXjLXc/qKzW+sL9+tXXUxZamUEsOCwydvtS/WYHKXx2n3Iz++CFX8tFTW9IlL5fmlqEQkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683353; c=relaxed/simple;
	bh=X9dWI/VxwTVt0b1JPTBKFWXeQZrwFIw7mwBm9QmmgQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR8QFvo2Dm/wCuq7J3oQg025X0gisDGcNc41SJJxDxorSDKpZ/jczI/A6hvm+vZTN5q28Es9ahlm+P1XKbR7H8TYBSE2KG+eF1CIpwJarL813ubVTj1J1KG/8IMSRGta2dizR7O4dNJu9IUox2zY47x2xlINu/IKGA4AADUMzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4fNhyJ5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4fNhyJ5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-675ab6221c4so1615730a12.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683345; x=1777288145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQO90AiegwudsrGxT2ZVvYfLhx/rXT7hOvORupcDKtk=;
        b=L4fNhyJ5mM6508/3l16qFhMV+EC4jTrhyAyoMjqMD/YG0r1atJuk43foR6pQMtcsCa
         GZnjLQOryp3cl8pX0Rxfv4IDkL+kQn42aT7WzEeB0OvpgCf7RU96uc99wmjf4cg3yKLo
         a/tBGq5Dia0KY7XxYehl+PO9gfJM5z2bPcFyJgYAfOs+e7Q3G3rzJbYm3SR2JE7wgaW9
         osTxPbmoSEUZAL/NB7wv2h2Yzwu6vQHc1Wk67Q56cQ5AfSIISv0BmjtgtmuWjN8d5xNN
         NyzEGu81tzDWfx6E2Uwbx66uE4VVD9oK14hOizUgUsPCIw5w70HRrxz88R6B2nl+gA87
         jabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683345; x=1777288145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQO90AiegwudsrGxT2ZVvYfLhx/rXT7hOvORupcDKtk=;
        b=giYgoVVmBn2umwycRtUbINfIQWS8nQ0Q+MxPKR7RMSBKnS1LAJNPhjsJKXBC0Ev/cJ
         JrLx9BgeT9Dj/dqXmgXNIHKKOMbqvxFpy5VtOXbQqn1WCAfxC6meC3UeFnHOMfR00XUs
         bIpH/5rjEB5ExMND3utepD+jiH8LBIKuy4CGal1H4aTVU4QiZiQR0QUnB+Wpr4jr/yz3
         0GCNRswkG7QeAlrrUo4f9FJTEvkMTd1F3cayMqnOCGmDUTvh33LJ0uHwTzH8FJT7zBvZ
         yuhJAhYgSnbKILw7B6RLIpaV804Ve/4dVYRa0NvGhj/r5pTG0g4D6lFXjfPYTSZe/xKs
         8omQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qM27zd0eowivWPt+gspO9SyakyN2NzmwG/v+Ymaa8FTLbbm2D/VxHn5ztqT04b769m+ijc78alcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUbYqIar/sWdgIfYtu/9+WRHYIXmjMLuqAPj5X2PueO1mIffU
	7ELgO9nYgBn58+ph0X7JWIm8l5DhVfNtpizBgr8zujQcwL16Jr45M9rt
X-Gm-Gg: AeBDievlkqaE58Haqojw17bj7lcRmw787/fuzJjh67NhxmCcHWVRMAeuLEIpDtmkA26
	9b84wjTIXyMRP6tZiypQDOXadNDwBN/cjDYwDx2PZWZlq59Nm6f+wgwmzxwerFl1JGSA+3QH+sU
	sptNGxPPImvDQSe8HhcxLsxoi5SRvQHEI74oaXx4gpSrMvru0d07CMLe6lbxYZoTqATnz1sZVXq
	rQEjTA40KE1f25evZFQHTVnHSuy1NVw9Y7xHHIaienzfjlWP8vRbTb8CdN1bPsMK4WXegnJGjaF
	OG3aEdIfTVR7y/sABgyI+DL06sd9EXRSy0DzGDLUbS3FRKFbfHgqTXIQGx4u5qBDASLxTEN7u4z
	Fy74Mel0ALb4jdiP6sEITth1SPzsgEFQ8hGzG+ILz93EbcMPXGSXPRF094DAmXLwL4kGngCAHX8
	4QOiZbCDibf7yTMjLUlXzqKuLYuZqmj7bCKzfpUiWWL0VLNevgTKPLIhvh+R81dZQogBB7HfzYT
	KFZCw6j+dND76+BwYDwlr95TApfH9Mch+gb796CZEmbAeymCvVy+uMUIHIizJYmLWiimg+r2pKQ
	fL8yevK0PYf3x9aqlMIt8Wy7c1FIj7vYjj/XS8R2krwbUjLjbXRNYZoIYxfKhHa6e2o+hI0yi9x
	snGbdIgDbgayMjHBmBGLNhzjrXW0R15h1UDlPVcwJvgL1eSpSTaAT695qAqFiFbGGrYumvSAxgL
	8vFABWdxI=
X-Received: by 2002:a05:6402:13cd:b0:674:5b2c:d42c with SMTP id 4fb4d7f45d1cf-6745b2cd8c4mr3585547a12.3.1776683345460;
        Mon, 20 Apr 2026 04:09:05 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (254.196.90.34.bc.googleusercontent.com. [34.90.196.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe8a0sm1947664a12.5.2026.04.20.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:05 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 1/4] iio: magnetometer: ak8975: header cleanup
Date: Mon, 20 Apr 2026 11:08:01 +0000
Message-ID: <20260420110804.1353-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420110804.1353-1-joshua.crofts1@gmail.com>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up headers by removing proxy kernel.h header and adding new
headers to ensure atomicity (array_size.h, dev_printk.h, types.h,
asm/byteorder.h). Removed unused headers (slab.h, iio/sysfs.h,
iio/trigger.h) and added minmax.h, property.h, wait.h, irqreturn.h to
mitigate transient dependencies during compilation.

Audited using the include-what-you-use tool.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698..f45dca0a6f0 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,24 +7,29 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/err.h>
+#include <linux/irqreturn.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.47.3

