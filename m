Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032938A73D
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772083579; cv=none; b=TPBhK79Wng90KH7KoR7CyXg7VC9kbjg6sr1CLXyPjeD2LpxSa39ehKJhI4rqMPAspguEdkwgs3JhskaP8A/rbd0MIX6LyXiYb8/6UNobdP55GBfDfIOCoen6Ujk3uD3OvlfndScGr2EC9vuNZ2P6qnn2y+khareGg/MELC8LlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772083579; c=relaxed/simple;
	bh=w5wY9LO2Pk7znAAv+TBh8NdDYQlGt/PiTy8nFT23sMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mC22ItJFV4OLrqxK7ztekoF8cQ7/e+O0N5kJba7Ox+vxFl1UQcLWYODUFtMDk6btNlPaosnNIu681+3ST/LNZYK64TU5eizVW8d50QbIIzFA6Qxq/3IS1hj2lkCDVTzKK/zSek4nXQrSmOxkdVm5pxl3ni3By45+Fy4bdvcXPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2Ud/wm0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Ud/wm0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso6047135e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 21:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772083577; x=1772688377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOmVHNFGTb86WHQt7RSCacKlGSq4Tvh/jlgRo06YTiU=;
        b=a2Ud/wm0jZUtGI+HefROL54voyH2mdLMMe/ZyU/8rLUHUIuFvl2fNJf1rlCP5KQcfp
         WQWeS4tVMajvK2/LC/QWKEz6r84y968GdtgQtTomQs3R72lwEIkDVEqUVHLMWfsqztoO
         wKwLBhcBGe+eR8XDtobjITrd9wBp6JiQRKXVD3XOpf6kfDyLmAaolJvZb/FV3KE87++N
         jJ/w3Enn27VIg1roKGp2RjujBQMcojOjNb/3JI4U+xlmvxIu9yo0jPDkj8kiaeECEya6
         Z0u762KK2ceNSU/wlGCFOaJbUDD99njkaNocQ7RsH8X8QQlAsKt0uji9kXSLRExrbWAO
         8bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772083577; x=1772688377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOmVHNFGTb86WHQt7RSCacKlGSq4Tvh/jlgRo06YTiU=;
        b=k51/rbfBMWelFMvj2n9TB7eH9SHDTdtsKarLsreP19AF3OEGqWoOzUwvUZm702g43X
         Is2LotNVCrQ1W+yr5RAWFWP4Fa8m63AprYa1bg4BMqK/gzJbrQNACGYwtVR+KWqrwYSO
         8jvFt1lda7ZyNZw0JWZc+dh9Jvtuecgb09wQO6vrTwmySBw4qZwR83thAgidTLhluLdV
         y0mlfDWtcx81I78iJ+0PgzEPtjPbqJ3M+gl61PV4lolCH/YV5k15/gnix9G/A5P4dMfW
         75VCKF6j5nhQaRii7O80DXknEVS8xOdm8ywzcRDW1vGQA4ONf75yuDdW3yFaR+jOS0r4
         +vOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGApbFMkR925J/FES7maeKr2qVTl4VUrLbOFiGwr2AexKO/I2MttqjSKHTP7GzJmJJ65Vf4Zmc6zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vRK9hjStgXCD70BsdXMGgmM6US6NiweG9hzT8ssS/91TMo47
	EWBGzKYaaTGwP/zDkpwkyIAMUrjkdbhIvR6P+E1scj0CxTJrinQDnntQ
X-Gm-Gg: ATEYQzwvQ6Rt4d3sQ+YNx/bhH4JUFX4sD9Zj4+8Rn3X35455ICezMZohgR+9qx/AT5m
	8DLZ/62vljX1TKHrOJAKKddpw+xpNg4Llf2U5CGH4E4B9/I5lIy6EJUgpUdDQY4w1Ve6vqk95BI
	YfoePtu9sp7uEPUm0A/YVknoqgs4ZvU1U+IXTSAEPlj6NtEm2ZLlJ27vba/vIrnVeT38+9tO1tx
	J3B6p6RBB7PXeBUiNllidXWSLsghbTHzpztmgTmKgqCnQ+0i8WvIjYj1qRzO3qGGDwRb/WRdltu
	JP7KrQMT12Qhb784Inc71DHj6vW24V7zRBvtKaahp1zZVuyE1VSZ/oe4RLJeu38i0RY1k1ewprP
	XgTFHl50XcXTrQGVrutGaAZz0v+uNxeQqmhcsj5IRstB/ReIxxJxJD7yg+OkB3SMJAPK/aegqVn
	HthgJI1jHB
X-Received: by 2002:a05:600c:a47:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-483c21a9b06mr43033435e9.29.1772083576673;
        Wed, 25 Feb 2026 21:26:16 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm41800805e9.3.2026.02.25.21.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:26:16 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7816: add timeout to busy-wait loop
Date: Thu, 26 Feb 2026 05:26:15 +0000
Message-ID: <20260226052615.65734-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816_spi_read() function polls the busy GPIO pin in a tight
loop without any timeout. If the hardware fails to deassert the
busy signal, the kernel hangs indefinitely in an unbounded
busy-wait.

Replace the open-coded while/cpu_relax() loop with
read_poll_timeout() which polls every 5 us and returns -ETIMEDOUT
after 1 ms. Per the AD7816 datasheet the maximum conversion time
is 27 us (temperature channel), so 1 ms provides generous margin.

Also handle the case where gpiod_get_value() returns a negative
error code, which the original loop silently treated as not-busy.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..7b8a78e4d 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -85,8 +86,14 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	}
 
 	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		while (gpiod_get_value(chip->busy_pin))
-			cpu_relax();
+		int val;
+
+		ret = read_poll_timeout(gpiod_get_value, val, val <= 0,
+					5, 1000, false, chip->busy_pin);
+		if (val < 0)
+			return val;
+		if (ret)
+			return ret;
 	}
 
 	gpiod_set_value(chip->rdwr_pin, 0);
-- 
2.43.0

