Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A440A958
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020772; cv=none; b=PlgMnwFRGS38uAXZSpK6oe9AObKFcnB4f8WBEiGTh9zMTB6RKzbM7ZrXaHOm0Y8aFz6vb4KG/dZYNMLGGTX7X5UCNW0hN5P9waz1Dvzt3sdQVX1FIM4IddL5ga9Po0nyuWJNIaJwEldP5gsjdI5mVq5O9wzDmTO/zQtMP+/lhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020772; c=relaxed/simple;
	bh=lZ538xn0MusE4k1KK9y0lCXK70e6dTvhVB099UUkj2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/ajPST4ARrUXz7+GxbAh8PxrJrqRVJ71HS1Tjhi6eQUYly9UA6ZO99k8agSkiQ5eINI+W5Ug7NxXw2xukGkp85W+xIh8lhekmgUAsp8VjnqWExr3HBgwGZSULsDQefsmeJ9v54NzeBZOKb8x3x8KSBw3sBbKjnasOtOORN+TQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvb64mpL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvb64mpL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so18923395e9.0
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020769; x=1788625569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IX/mr1AWyIWzkY9+da9P64x4UyMMvD+KxSqNh+tYjc=;
        b=Hvb64mpLmpjyPbijJ4POS3Ks0/861kEzju8WU6bRwhdAYee1kvZPq2fiNUdkX1htDt
         93b25dJQXcC6L2HZqBC2m8EMM048X6xPszEBwWLHGtzpzd0lFM6LEv8CWJOG24dWd+pO
         MlxVyZNy+kKd0ajHNOOV+r/2GmsZbV+8/GCzs9tjAGewAtQjQo7izMa5JkNycWJM00p4
         CMuDAnoJNneD2TOJShaNstrcVdO6bAE705EvL5mhmO+HIOmHfPaj3ZKgm7U9RJ1AKnsB
         khDiVvzZpz6XfEdqcylQv+JzsQaLO+XSQSDLbtzyJK4NF0nllpWFSLo1FTBwDs2tVC4l
         Gw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020769; x=1788625569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IX/mr1AWyIWzkY9+da9P64x4UyMMvD+KxSqNh+tYjc=;
        b=lyobiFR7+2fdxuZp2yYmaO5KBxGFnVsJAZHE9VreSj/vrTrpe2+bGNmNBMhMnZKMeR
         soZuqnSNVNSTD9Er29zrtrZ4c7EAyP9vYw2IY5TnSAFLYEfS5exXKIb/3bwxkuiQYXFr
         F4UlXodgxwLz43+1CfQCapWtCDCYUsYkTnscbCqVdoFEHV4aNOrojEXV6WPkQxskuQqJ
         H6s1kOXaw71jlALRhILFKoUobAF/FbOzP+xbr9wxiK1ESuwoBKJRmvhduA7mM97oHMvx
         UWhEFVqDcJXZP8a2QZxY6nrKHCqXr2to7t4XKtspB2GgyA8bcVnVukTFcCCfMI6NenUV
         I2AA==
X-Gm-Message-State: AFuF++lXxPO+KZGckHu2yjf8+meLjjqFTWlqGNuCLStGI3dX/F90RwDR
	OHAh3bnWMrh3Pq7gkIWGFo7TSJNhZ2ILG6TMOZP6CkKhmXNbtHXGyDT1
X-Gm-Gg: AR+sD10SMObjqF3vMZabOkI+qndn5PZjY33OC5zM9R5aMOfsMeSmHoXyacZiPLwpTM/
	+jHmzQM9uxXfVtaOwtTKTPjXSBFAUKUn8+TsK1qSYyLlrIRNXvWw36nUUlIzritKsyZooD4BS1B
	DGNM14q2YkrLGmcHtrc9o0SE42xo4C9ObnjhPfjnGReZx7gISWU6R4HON2CKquDedpESPqil0Xa
	ccwoMBOnvhYY1rW90guivODOUyb1FQOfPCHyNaroILPm9mwcnHm+mYRGuYMOex2qAQk1cFV5bgo
	4SvOW7KpmbJsXwl9sY1WSN7St2LLAsA1I19uXwI2PykqnljT9FL0NnDSwc7uTANHDJeHDsl+5MY
	tTUn+pIIsRB4c0UCcsi3HqjISz+NUq1H+Rbzc9cIclvx1PIffhSGivP9NZUF1bvpMbxtxSx0EFc
	s6PUIMZ370vtzdYngfgQme4Iz2e3ZHq29p/nkQiiFfe436Su5OP+3p1No3Vi1BWzQqxSmxGYM/B
	igGLXrAzs+OPeG2CGDmQ768jEiejdIRp3/yuWUozlYJQbr4vLp5hC4p1yMZhsUsJyPLG7VpaAjl
	XS11dlhDxhUX67DPHqcLMKoEaZ/tB/IA0b4pZZVAaAcR8DvWs0j8w3SIV71IHkpgGH56+jbtB8k
	rHQYZNOOepAZOF/5DFGpOiTyA
X-Received: by 2002:a05:600c:4715:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49b91c26a01mr216943995e9.5.1788020768754;
        Sat, 29 Aug 2026 09:26:08 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:08 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:02 +0200
Subject: [PATCH v2 05/11] iio: temperature: mlx90635: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-5-c67739d5dedf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1772;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=lZ538xn0MusE4k1KK9y0lCXK70e6dTvhVB099UUkj2Q=;
 b=eFx0TE8GgE6L2NdWf8apa0VbzmT1NVPo//tqIe/7pYiIUspmmT0mifu9c8FzKbqlzP6Ep09e6
 egK4ZvWF5HEDz2zmYsP+7fo5M+nm41c6AS/Q3VLnNh9Cd8lEXOnKl6e
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Additionally, sort the headers alphabetically.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/gpio/consumer.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
- <linux/limits.h>: not directly used in this driver
---
 drivers/iio/temperature/mlx90635.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 0f31879a4f64..48c760c980f3 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -6,21 +6,24 @@
  *
  * Driver for the Melexis MLX90635 I2C 16-bit IR thermopile sensor
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
-#include <linux/limits.h>
-#include <linux/module.h>
 #include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

