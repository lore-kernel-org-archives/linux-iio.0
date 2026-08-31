Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDE39C63D
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210826; cv=none; b=eyNAXPqtKu1Ui/+YaB7HG8EG8x//x5+2CUXTTdHMdB7LufQd0qBh0BtElKSTc/KNE+aV9wS9L5W3vFSM7DOeFp76QjgukhocUIMg2g6x7CpBWvD5a/h0dBPhlR7hSmfP6maPh2/c45MW2yQxSXYrKRDgMNnx37GJkaA6EkgNmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210826; c=relaxed/simple;
	bh=7S3GqdGF0KlusnvtYvgxViEubrKHdp3YCun8jH+9hL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpOy5aPBCkc7cnMHDe5MWwyxDDC6rY5BTi/Z92jEz6LfVPEpkv9q2ASugr8SPnRTgsiTgJUX1LTybX+7PcVg1grwsvNu397yKgC1KJqztQ0laSf0r2tPfu4g6r4yNYkVUPtuVafvKtwTHaGS2IXej+9l7MuzqPhzYkTiuQIaUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epWe26SL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epWe26SL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so38206475e9.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210823; x=1788815623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+t41cBcC7m4gJOioG8shHYMVAqAc5cSMhVD3K6KstMQ=;
        b=epWe26SLn94WvOEHxMmmANZ++KOsoZX3BUAe9jwL3N/nqEkXmq7s48giZ+p95dlb6w
         q6F96jygrAQ0D4Ax9V5Oz0xs2yl3aJWvF/PektCXLZpsky9rBWEhwFm0tMIygpO30jps
         wMjAcBv/iHJAWNFZcmxiWgkXcZ/gWu1h7z4r9Rz6S30gt7b617N+jhcpHvIB0vqg+MA0
         URV+dzCbb4AWmRGlt3tdFHKNaFJ/+lTbAf2GOjzjzEzAdqa9DCA9IZph6CMUFrvc33ZO
         tDmozIXqYT4xhc/VtHx++7Pg5j8S/IgMz0hmRc0AWm4V5M5xQa1AEDyQyjDK9oKZSW+c
         Rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210823; x=1788815623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+t41cBcC7m4gJOioG8shHYMVAqAc5cSMhVD3K6KstMQ=;
        b=RvwSBJFKssJUKBK4KmpJrr0HrjTerolIgJdmH/eX6dRqYElufVmaCsgHb/ecykWCYd
         ZZA31bcz3TB3ss9kQ97cDd29VnytJEaJmPoMKGYLF+E3151Vo8xjxbpj/LG/uU/fAxeq
         mYBuEfL2unLFnoCcIf1+Ph3shd5HNh6s2+GIx4+S8U/0MpCUXtmQ2PvoZLw3r+4aoubT
         wJsFpis7VGaQVzzdWD21kUmMjAtq0hkVsaa4oUd41v4QixaCQC4qwTzUQMKcza0aPnfi
         az6XmD5hyoHtmkTHhMrtU+XgRNiIFWQMRLSn77wTOpbtSiES/ICOgPWDhjLueSsbZzRu
         sqmQ==
X-Gm-Message-State: AFuF++neyyNanZFNWpSfP/ZjMaBVr9QkZ5PBC7aUE6LqTO5y34xkvbxM
	eQVNN/DjqqtWGPXp/DslJR/PqveToaUfY53jQckYUQPDzlQqi1p+GFv5
X-Gm-Gg: AR+sD12dC5+V3nFGW2Js19Ua+UI9kkkMDha4cw4oluiYCJgZuGHoSYCnAVS50HFSdC/
	Dw0pZJEFTIoPvBCnEEZ/7mVAzVUS6tNhQ6LaG26CXWoVXb0GdACqAqSvSIRzPrn58cwyNK20wJL
	vjacctjEvqq9PZLTFPY142U6s1HbJM2u0xcaBr/RpWGP6E9PiXXu7hAIoGvzwBagFZ00tPq+HzE
	dj/GUEMJ+rSy3spODMZ/jcbUKzFoFZMPistg1mzeieoes0/0w+7wIDPZ1etKJxeR1gIEhWlm97x
	bL4fY3fbgVTpVt7h3XpCoofUtmPhdS6szq3lIw7msZOEfC9T89+RUiWpllNrcjxeaC++1e7Gyz3
	b2xrWzy/banWd3g/k6WgB0fmrLyuYk7ClyKGerfkP/tTBzL2NI/K+4mhPRnBPgeinqMNYlRSc51
	jV1bA1NeT6UPN0aSJSvRvOkd4/BOUj3ONzeIvFKbgvIWRrQBMTlMJjAMipFc/AU33wtfiZCuozD
	YwPTNb+a4fGB1PkfR1DREZkJFu5jSJB+596dNTIHo91ToV3aZBypYeUZr4z+/V0QmUfXLfp3SZK
	cIj8UoahPRAZMgfEVu7AlPeJ0599lP8ofLISvE8BhQUa+ihSFXVMNSeNOE5WWX2TPx+Fo9Rghf1
	qqsYYCTHot27hAGdgNGZMGq66
X-Received: by 2002:a05:600c:870e:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cdc43f461mr74399055e9.12.1788210822685;
        Mon, 31 Aug 2026 14:13:42 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:42 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:34 +0200
Subject: [PATCH v2 04/11] iio: temperature: mlx90632: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-4-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210818; l=1745;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=7S3GqdGF0KlusnvtYvgxViEubrKHdp3YCun8jH+9hL0=;
 b=kbASjicAqc7v5dkMxgLjn5XPiAx/VzNB27l99Q4B81dXw0B5iTU+YCxRuJnG0WmDp/wwQ/zKZ
 BbtQhwjUPuhAsrY4Rf9uZUz1zV/wdYE1gb+SCWcgwYQXmc4veev+847
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Additionally, sort the entries alphabetically.

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
---
 drivers/iio/temperature/mlx90632.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 2fde48f337e2..74ae36f74e8b 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -6,21 +6,25 @@
  *
  * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
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
 #include <linux/limits.h>
-#include <linux/module.h>
 #include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

