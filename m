Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA32ABCA
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746234; cv=none; b=Nt1Sl7UEf/3Nqz4PdJJafcGncg1paVG6Lzenxop6feGgIfk0SRimMVG4WwfQeJDKltYndz4u155kJGCOaR1Z6vgjl5TWtr81DpkSNxKrWLhnhIIRCD3+1zhUzg7uQIgtOGin9J4DYsQ5ah2X2hzDx7dWX5JCx1JiMhbgWR0NFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746234; c=relaxed/simple;
	bh=wnlNOPnY0hP37pyG/YOSqunFl1dMBiFL5sS10fnr0To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rjS1r2JnkaZBzQYTNh7vqx8Rf9vmxGCtv4AmMdMXx8r2CTCB3qhMf3WoOaNpsO9gk7IhqeToPtRB552F/cfOLzsy72WPoNq8l/YvCzP72WIRoGwgvJIIx8JTxz2tGgasbAyaz6IHgjyIDhye4pVuazdWYCs4yzKGE2w/oA9B4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbc8iRFy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbc8iRFy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso18487105e9.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746231; x=1787351031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dG3ky9ZlsV4zjJMppn5nLBEspHl5/MNFNDYpcigizeY=;
        b=gbc8iRFykpdO0WZ+7aXt2sLWuYW8G6G3FnGbyylpFnOAlfic/vQd9ACD3YeyQYtezF
         sbwhgyePHt+mgL1KmLCUOGQldxEhHJV7+jsHLQvhKRyJPtZ5FS3R5Kk7MbLkx32sAcit
         c1mXjqOhGVjkIND0NQ/9+PRkOOBhm8XG9lEhk8pxWiuIaMvtDpEK2zA0FvEXmHWtYdDl
         DbMBUVV65fWnLN5ezmfPok2zZ5LLVgn0Fs8U/+ganH7CD7jokN5LP2m3hEif5uzbxNOG
         ccAYH6J9or2oap90sFyxKNQq9WGHJGnWwzAxqQ+W/Hu3c1XhPVrPq5xTH4kVn1aiZAAY
         Pjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746231; x=1787351031;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dG3ky9ZlsV4zjJMppn5nLBEspHl5/MNFNDYpcigizeY=;
        b=KmIb7ovLEeyZGif4WVW1HI5l2rFPzO7p4KBt17At61QPE643ZfVeBt7PgCz+yYRoUX
         KGa0kAxU21ZiNPFjBgGp13CQ8hdIWG6aD7F7NcLZuT2pDiq69xksqVmUzprvkvJwd4wl
         qzaVrg9AG3gSU4W9azx+ZoxZaVq7zrGak2E6MRXP7dIeQNQZOhKeVFbBoP+jhG0y2TG2
         xxLr7p+6hcRHO1hVySo9SPH6xJxpDvte2eMaWTWnSCRfFc42oI1WTwWoxHL3KZBrENDj
         UeM5lIbgBcKLSYRKXWF5ZBeWIEbBxuUKT61wFyNc0ogCMA3NYFnrQZV1xwuRGI80hlt1
         INdA==
X-Gm-Message-State: AOJu0YxAz1AteyS8Xb2RZbqFfsougPRe/wOSQwPpgJuZKP1GhyMaE7D6
	TTEi39SQ9a1ugAN6v9ryJZcXBbSBbYuqIX4rIsIDQ1UEPzFNiz8S2ryY
X-Gm-Gg: AR+sD1305MfU7Wl6pMCU1U1SKA09SESY1+cyRuhUY0Ojg/nMj2JSwxnYY95Sezf9xBO
	3zPnvquqC3dVM+b4ERf0PNFsE7c66uwpo51jpu6gx6UFD5jjkGyDyoRQ9g+tS/3ldqF4xrsOre3
	twgW+IOiF/uaiq4zWEdZRvrKlprXKo8R/OZUFRqEj0qJulcm/+zl/+1bbu3T6nLktG+LDm7tNLg
	goBXujLQAx02rmMc2uRTmnlA0t86ADEow96CruL/e/kjuVfwecfGzaXQsS4ga4Nug4MihYgS0c4
	u8xXK+dzwhkEoU/x3DZ7IWmgTLWKa2tV+Y+YRNsX88tcotJG2puOV4tNFPWAPry5iVOlSl8SAdp
	SXMLDQmRdG5PK+jx062arbTvI2+5VsXVbHcGe6VijKa/CNR20AqPgivYq0MwrSKXQ6kBjYoWufH
	/KfpbOGjliT94yL+bJSg/ojkPu+o7NpIxIqybpc8Q3OQrt35TUCQzqOkyKkXdKTrQuC1XJ666QE
	Nx1jev17vpU8LsP
X-Received: by 2002:a05:600c:3145:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49987ab45famr107072235e9.6.1786746231309;
        Fri, 14 Aug 2026 15:23:51 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16f:15e0:4de3:7ab4:f4f1:da62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499877d7974sm63203885e9.1.2026.08.14.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:23:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 15 Aug 2026 00:23:47 +0200
Subject: [PATCH] iio: gts-helper: fix error headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHKVf2oC/x3MSwqAMAxF0a1Ixgaq+MOtiANrnzUTlUREEPduc
 XgG9z5kUIFRnz2kuMRk3xKKPKN5nbYIlpBMpSsb1xUVi+wcT2Oo8oopQI1Di9k3vob3LaXyUCx
 y/9dhfN8PG+y/C2UAAAA=
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786746229; l=2391;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=wnlNOPnY0hP37pyG/YOSqunFl1dMBiFL5sS10fnr0To=;
 b=f06yo0G8ZHRe0YmLrMGzOvCYfklwUTbgvmAYwnNigLVSqcSvgoOXHiQsYO2iGVswPW1iqh52Z
 URPwwHB4fnSD5dMC14g2M8DyKPbmGMK65uLSYj15sWaXtrXbkYunHJM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Both industrialio-gts-helper.c and iio-gts-helper.h use error codes
defined in <asm-generic/errno-base.h> (usually included via
<linux/errno.h>), but only industrialio-gts-helper.c includes it. On the
other hand, that file also uses error macros like IS_ERR() and
PTR_ERR(), which are included in <linux/err.h>.

Add the right includes to provide the used elements from the error
headers:

- <linux/errno.h> in iio-gts-helper.h

- <linux/err.h> in industrialio-gts-helper.c, which in turn includes
  <asm/errno.h>, which only includes <asm-generic/errno-base.h>

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
I stumbled upon this while refactoring veml6031x00.c
(which uses IIO GTS) just because clangd threw a couple of errors where
-EINVAL is returned in iio-gts-helper.h

In the end everything compiles anyway, and therefore I have not
added a "Fixes:" tag, but please let me know if that is really required
for something like this. It is also true that if the gts header is
included first, the compiler will throw the same error clangd showed me
and the kernel won't compile... Unlikely to ever happen, though.

I have compiled and tested this implementation with the driver I am
attempting to upstream without any issues.
---
 drivers/iio/industrialio-gts-helper.c | 2 +-
 include/linux/iio/iio-gts-helper.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 4f52dc373abf..af6ed37fb34a 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/export.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index 66f830ab9b49..f63a482b82b8 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -7,6 +7,7 @@
 #ifndef __IIO_GTS_HELPER__
 #define __IIO_GTS_HELPER__
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 struct device;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260814-iio-gts-err-headers-d7ecb6b5ebb7

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

