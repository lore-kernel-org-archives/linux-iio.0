Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC03F6C3B
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020771; cv=none; b=nBbpLVnQPa7V+WYQE+aqoO2GSq/XPgXTnaP+UJAygJ/tvkYx824lczi79HIwcVdKlT4Oxisu3bCNRuhVMuPP35wgNR+1vivNl4XwxpaGysRIfGDr+mnGDa3XujFy7zEBhVdmKqa15jyBwefD+dkWNPqWI5HeGZRHM2WfGsm4ZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020771; c=relaxed/simple;
	bh=0QBxwUZ25oFa+ziWVO9rndjF13onxc8x1wc1KVIQ1Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMm/kFjtFlY+ODIrkt5TEGkeTVWKD9mNYJ/FcJ8jkkwlm3zlFXOL44lKu1G9W+FJiQ0EZDHk5TfUoJaoPuaka6Bx710DO3Uv3JDOKbphcjpcn9gCOb5L/vthLzlXSx+xAsiv4E+SMhYRX8izM1cKSXJPdhhz/XPgISOooy1V5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhDRd90G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhDRd90G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso13596865e9.2
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020767; x=1788625567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnrF/T+i862hV1ESmyIIgs0g7CPggo8JZI/qntxYxUE=;
        b=VhDRd90G2/vbg9+fJARfuIYblT0rfByVu/x9G6A7N1SY3pPY+tcdAOs+S8/kmfPdLW
         bqzYg9EDnU4giQpvBB2wZRMpSLxE0XGdYvP2SOeQz3NGT0FLx2XaAPyinyH47hZizsZr
         4jyOodC9zhXo+LqN3stwn+rRIgQjZk4JwKjVvsu87HG/qt4it++xYdkDPeLcicL65fhw
         o0ctfglC8tp8ftoyV4kOOPyHHsFTRhScB8GbgxD1MtijNQSUYCJKF4msSPuxdz3vBtcG
         8q7rqQ6Bb+0SbujA687C3Liaq59aUnQk8aFNta1pHEc/rx6FssqOHPTZVX+axbbkBQqU
         Fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020767; x=1788625567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnrF/T+i862hV1ESmyIIgs0g7CPggo8JZI/qntxYxUE=;
        b=QHA+sOH3BGunvjdI43vSubNyYW03Pd51LmtsZwKvOmOuukEg5+Es5Utqs49RO/Ajo2
         7j0wKXweN1OjGqkWr8pSqRoFldZDQjca+7dyG2Vt2S2qmyZmc2M9YqvJ/YfVCuO4wfUJ
         Zn/V/9inEBxamrgP3KDAu8q3OxD++QYMu4W0Uq0zKhwLX1Zc4ziuCjraVTjrFgI3QaMD
         XtU3xTnXNme70yUQgbWoLzzgmXU26y8+7DRmssD498L7TQXtYqmQQ0mJ58nPQp6nVOuS
         XjkkwuYa1EM/On4SzVs7fMLaZrxdq52KvimgtokjIOvPCkERXG4esEB/nrCRq0CqYtKY
         lkhA==
X-Gm-Message-State: AFuF++kfUfApywKJhPU1YNH8NIM1lQF67ZzjonXcnt7W/2TrwJ2dDTec
	1hqtj8o/+iY1ps343MuaXLb7YpwoyAH/BvVkKvs3phEcb+mz7PDr8mXb
X-Gm-Gg: AR+sD11uFjHz0MZjf3KT5B6j+r3NmYr3s2xQmqvETxf5lfKOLgKdFeK5OaT+hF7zowP
	Uz4aIXUuNqKnlMFAVjia0Y8v6+Re97IJ0AitSG3MObutqc6KpPoPtd964ud+5qA+nBrSlfeF8WN
	e21vaunjlGlQexjuyUry260G4WovWP5MaQ3HE+ONuTvEiTn1i5jZQysipZK5SfLbHRR8keck2mD
	GsLqJ5pe2HKtoBWfiryjUIFB0OO+TyeYpkDxi9CKUBXut7VeslcRyIhYY3MS71kR7CdDDWklPtA
	drhjZdTj3Xs9z4a0gG8iGWzUfHmojroZfRPuPLDKPtmROl5PFlrDraqNM5Tu7pbu9Ac2wn/l3IF
	xV+AH6Cms91Tx8w6vRsF/9P2f0WxAqITD+gkzSNbsWGUGEPZrKmOZphqk4XbGiaPehSxsLE4cjz
	fMu9tIgGmxZtdfTnhR1s00lELa7e584WCtSuo8m8zljKOFfDwrP6XK1OMJQGN9O8Tey+31PMk/P
	MncZvtbw1eYICq29mH0bUwcTKNuXqR3o6tsuMjhKinyaYVa5LENRX2nnanVgnqnuNiLUngB4ART
	FlNDYNtn04ElBt6ALqQtZQTg/DWtyyLyS3RkFKI35qlSplrJvo79ZjVtB+y72NG6PHDUX12tOBf
	f5Gj1++bAcVArliFILV/a4U6a
X-Received: by 2002:a05:600c:4513:b0:49a:252d:52f5 with SMTP id 5b1f17b1804b1-49b91c487a6mr240137365e9.11.1788020767446;
        Sat, 29 Aug 2026 09:26:07 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:07 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:00 +0200
Subject: [PATCH v2 03/11] iio: temperature: ltc2983: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-3-c67739d5dedf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1785;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=0QBxwUZ25oFa+ziWVO9rndjF13onxc8x1wc1KVIQ1Cw=;
 b=ncvJnG6Y1t/aSNYJjNSd9QhUFlUdQtKE8GuZl2/LUQtRJQEwiIoVZwpKGhxt2MvEoS7md5z7A
 GkaP02A1UJ5DqgrQrjaJRBojxM8UtKdoo96j/LiOob1EYnO96mGZkaX
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bitops.h>: for bitwise operations
- <linux/container_of.h>: for container_of macro
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/math64.h>: for div64 functions
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/slab.h>: for memory allocation
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/errno.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/ltc2983.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fe9eec3058d4..b8deb9aa9d48 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -5,19 +5,26 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <asm/byteorder.h>

-- 
2.55.0

