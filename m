Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612609;
	b=xWKbPgl2IXmON3hK0N9Sp+zLyCxB+H0F8ZNbZcZGG9zsr2jj3NjKtfhv7kta2TF1n3qy
	 YRxDKOFKT+kzV1kTiAEUB9PNs2dFXR5q44E3+Mvk06XJXjsaNLLChCOxvvse4dG9sxT/C
	 I8jxDrdxJfDVDRMrdat9bUhjOTPcaNjgHtYj8B3SaR0ML6Dv9SRLch9s9rXl3ow8Tn0Ez
	 yEPMWhOU1JKlsaeTC2+RlhitQjlnpyVwfg5X9rX3GSDLvPOAylYnq4TFQSVb/QJTm4P3k
	 OcthxBj62B/qN/ZAgzw+kt9jEDhzMB11nxYWeIPEfWTzSmkKunsz2JVsIhGBCmL83qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=teF6NADalu5/7cF6wyx/P+C8roXp4OA8wuuPR0caYC0=;
	b=iaw4tLyXPENkPiP0dj4jyOhDm7MNK+c++Gx+yHQgdpQ90wxpnE6Y7Mcn4abrezLv5UYR
	 Tz5H3tk6SsGn210ZtZme34JX4nmGdyIHawaC94c02gnEtQwnofbD4cT99PyOEr96ehN46
	 FytjtlI3VgrB5Znd60Yyfu9Y3VCws3Zo+uOw3srW9qS4dvP0CWYK/5gmSVoSB/G22Dj7f
	 JagVQjuYaiOLYqEUH4RZpBGDvo4uKGSkIDgC6JFzhppDtu8MNO2xvjjfovjeVxl4nUuCX
	 POohYpCzRG5Bgp9677NuDEdTmeecg8RiNBk/1d1TrCtCne1yCmQmMGpVb8TmU7FG9EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LMKrpVt5;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8625606A327
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 09:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8625606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LMKrpVt5
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so17080315e9.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612607; x=1794217407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=teF6NADalu5/7cF6wyx/P+C8roXp4OA8wuuPR0caYC0=;
        b=LMKrpVt59Xo+e0jBA1cABwDkmC6LHbX2LJa4iXrgTtt0zTh7vDPXoNmaMNjIKg2HrX
         pyPMORppsnJoJljs4Z/wIUml4niIwQIB4lofbenMLUNNaZ33xOOo1hGcF5sgPFzmPw0/
         tC+Cb+hPYWc4KwRSeQbmwm69XD1th6NbywcsQ2agLBgT5zEM4ealXcO5LV3WSVlg320g
         yy1XYzVBFNNDIHD7yGkk6QpUuOqA3oFnK+24fuQOPS6ml3ZRf0uZY2YV767aeGWvxyAA
         Fm0AQOjTr9YxLXcaln9VpN0D64ZFHtFWtX44N3jntoxiBL/t4Lvpf5UyBRT9X+Crcx++
         IiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612607; x=1794217407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=teF6NADalu5/7cF6wyx/P+C8roXp4OA8wuuPR0caYC0=;
        b=w5ryj/QTSGxXACFFbjDFUJ/dibe0wMwGC5WCAs3HdxzrHbzShe1HevVZ/GY3Ts7Uvu
         Rqi1Qu7YkiF3aGANzSDyYfaOLwO2D14NrykdCABtl00AhUP8GJ5TCZFFKVnFNV7til6G
         3D7WYnkVwx5zKfrZd3yMJS991RiwVADCxdHoBnS0r439PTVNxvqZ25CksT9k6vtyMHEG
         3P9nxVWiuvl2YvKcsHJF8xWreT7bezH2hkcbW2nqJ+/UHO3FoEIiuwhMLRMwJWt65L8F
         5dEtC0qQd5dZWmcpIHidBfL0VvnHYcctZr5/AxQyBiV4u5KamWTgXD/egGOAwe8rIuVK
         7CIw==
X-Forwarded-Encrypted: i=1; AKwUvBwz9QmgMh3dLbDYT+4Pq4wEw4zrO9k1VZBIal57sPOMMvqTcAP/zrxrjwXSkd64Gnqg2DsKuOEel0U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfIhoCW5sdNQvSJQ7e+ojab+dfjTblQsSHsPmSUG5F9vx5/Wrz
	AoiTYaz9I4YZq6PC1DWy+9FqEZIDIWaqlSzIls86L9plonVBbv4dDRTL
X-Gm-Gg: AYBFou2GoRlrVYVMZNXAamYiG1NRnUP1eklenVIpiyBVLHKipV3cR3te4xGfmH1wWNG
	OkxYRq/6I0hRKAK/XufvgMOVLXORYMdSNz1WOZXdD9XuxLvY/GauCW35XNKsfJf4vBWXNFXhVTs
	zuXC05PI/4JTTAJM1lUqYQZ8tNVp7BOdnvI9htUewM6kilXyxQvLKbbuEy0ySIH3Se8D+IaexFO
	jLwKoFMsAZjf1tJPE1PY9L1yIRyH+bWaWG0diZfWjXvX4vo6Goud0Sy13y66BpgH2GILqYhOJAc
	7NaikybSyTtdq1+L12hbZWXKk0pDY3M26MtaYefDz/0B5pFdvMjT3mfuWQIZK7+6R1uOrFtH2Ym
	j272jiGqnusHgS3jqMohPiSpPLlWwK46yGb60knVRcxgJHm2gkvMKt4xG/lzmFfdzrWajPltoNd
	oMTVLDAuVCHujABdgJIzZPdVC7ykmmneAWTy1ujhvFcjARzMY52xzFhMlFw+0VaDsGr1fMTYD+0
	tbcRxp77C7GYNLNCd7F19VpkAa4FExa/cUFnGS/om0g9SJff6Pe6Vkz6ESRK3cjvsUha0WJGxE7
	3AWHZ3nu4x238yVEU59+prJPaFgRHDuNZAVYyac=
X-Received: by 2002:a05:600c:46c8:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4ac16acfde1mr230539615e9.6.1793612607413;
        Mon, 02 Nov 2026 01:43:27 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm332507285e9.7.2026.11.02.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:43:27 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3 2/2] staging: iio: addac: adt7316: replace kernel.h with explicit headers
Date: Mon,  2 Nov 2026 11:42:36 +0200
Message-ID: <20261102094236.57757-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
References: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the proxy header <linux/kernel.h> and replace it with direct
inclusions per the Include What You Use (IWYU) principle. Also remove
unused headers and keep the list alphabetically sorted.

Explicitly add:
- <linux/bits.h> for BIT()
- <linux/err.h> for IS_ERR() and PTR_ERR()
- <linux/errno.h> for error codes (-EIO, -EPERM, -EINVAL, -ENOMEM,
  -ENODEV)
- <linux/kstrtox.h> for kstrtou8(), kstrtou16(), and kstrtoint()
- <linux/pm.h> for EXPORT_GPL_SIMPLE_DEV_PM_OPS()
- <linux/string.h> for memcmp()
- <linux/types.h> for fixed-width and standard types (u8, u16, bool, s64)

Drop unused headers:
- <linux/i2c.h> (no I2C symbols used in core driver)
- <linux/kernel.h> (proxy header)
- <linux/list.h> (no linked list symbols used)
- <linux/rtc.h> (no RTC symbols used)
- <linux/slab.h> (no kmalloc/kfree symbols used)
- <linux/workqueue.h> (no workqueue symbols used)

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
v3:
 - Replace <linux/kernel.h> and add/remove headers in this patch, as
   suggested by Joshua Crofts.
 - Explicitly add <linux/err.h>, <linux/errno.h>, and <linux/types.h>
   per IWYU after symbol verification.
v2:
 - Split from original monolithic patch.

 drivers/staging/iio/addac/adt7316.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 515f1fdae46b..54d942cae586 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,18 +5,19 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/gpio/consumer.h>
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/rtc.h>
-#include <linux/slab.h>
+#include <linux/pm.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
-#include <linux/workqueue.h>
+#include <linux/types.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-- 
2.56.0

