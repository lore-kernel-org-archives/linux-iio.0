Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D03AA4ED
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210835; cv=none; b=TUtq3eo9fPZRYTLcdZvqs1sx1Lcwlv2qW4Q/BDt3YxkUg3j/FJkbPbn36YKJYssb7rI2wuLS7UXpcnRY9JP94sZ6WSSyxQb35t1q+t1vY+BeDLGJWWOJWrW5rBi6soLlOaezebIA06Q3gDGP2zUiCrrhc/f0kQT72dhrHaTGpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210835; c=relaxed/simple;
	bh=zlCbSMvrlfeCqiNJjQxZkS1vJbSrxoS9NwpBsjGk91A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7Zh45Fs1LG+O6dp2IFR7Tzy5X4ZwYOYrBYJvmskUW8zdMR08X2hPt4ekc6b08PW0697A3jF2R6EwLcfAsaCnudgqUzAKnIbdm/si0edSIzzxC+16y5azpoWc1pxhMoXL5zgxuKmiePCNBbimaT2ORlgFI+vnYqsBmH46mb7CIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YChxMGwu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YChxMGwu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso1361935e9.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210831; x=1788815631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZoIiBSeFcsiK0IdQaOjt017+Ix1aMSbciAf6wb0bRI=;
        b=YChxMGwu1GrTaT4pmemXyK1RMCf5IvJuWbjNmMVjKSVY0hTnto8eHOITfY0A9s+w8l
         uCSaLW1AeXyOnT+SmQO8IeKQyVBs4trYWJRAXHHY+2Uj6FaJevLoZlEgmNblJpWVH/dJ
         9XpYBTSVz6jWv2zCOx3wJFLuBmznlmB8ndweiHiePzayv/xRONlZpzyvL+pO0XvCJAIb
         +0D0rMZsWgfwu79sqvGpVjaB4SbMQo0i13Wswx4OMXvZyhpbHBhiwQfqfw473UudbL66
         oalg3nLihYIowRVQLgH/P/pUXzVdn+05fIQUV5kS/j7rT1Z8qXyR1W7xHTl7G7uLRdkX
         /juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210831; x=1788815631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZoIiBSeFcsiK0IdQaOjt017+Ix1aMSbciAf6wb0bRI=;
        b=NaLLGt3kBfV0bZ9lhp0bkAitjD9MnopX9R0hhMMQKq0zuv9zvrDiwV0Q/ndNroWQjb
         z5l2Zg2yVyTtrkrqrX7TWT/7h51HIt4kN8Dr1yRkPgv4H6IPlpy4jOcNkds1HKbyzyrQ
         LhbB/Cs0OBCklulLZLJYZo78ooHAsXaei9v1KsRttUZuXYaVNW7Mf5jGfHMwPCjnSm4j
         T2hD38HPUiDnP55S93F+tYONFDEMS3RNeCMUycdkgAYmCl68MPmbe/dxR8hRm7Os3XR/
         5m+B28o9yqUA5/8Zh4Y9hIIZneHLvatYk4ym56YmI3grUOoJxIlG/fzLTzFOQLkSN7ZK
         WmCw==
X-Gm-Message-State: AFuF++nGBdprSs24e8VDIDWduUZDBLkfeXYlX7S34gDLowzIlV8nmnPK
	qL94nX/TShE8s8WpaYXaHSzwCi8NNW2dQZt6k9Q6J30p5PYhSBw+3qmN
X-Gm-Gg: AR+sD123gT+GpaesKC0loequiipGx9gzFAIutrEvDdeJapE3UpA2pY2vck5IVTHEgSz
	bVuRW8Pnk+BDrm43jjHr4QH7ZyPJrNc5qixrDzDfp/7rCDNa8rLjjEQnFOyeXBLpgRqwVJtHDNC
	v6pHWaZo37MmyujLHNbG4K4hPw9nUp4nUDRD5hIAZVCDSFrNyVK2ZBLdAnIyyEoDbg5sipqKbXT
	7FwNBpmL2Fsxfg+BtkVrLCdS4oHFaCR+PjUKtZPEG1nzbKxoUJJj4kjqedc1UGaZljtG7fas2fQ
	BkneliRkgzTgJarYN4BlAv+GLDlG1Bb3pDraDn0A1ETkaP4Cfh79UB0oD8YwlK714n6669IvagC
	wuZXXCBBoeVbnaK9D/o4OpcnMuD1k0BLM2Gxl2Bjk8v2YB/EkYpriJcOz1uVBqwDp1+PVnWPFIE
	FIwqyNCO1Kz2t+jGaKdm5Jt42CrfRohZg2NC0vSMqC5H2y2aftgKkP+US5dHyCll27xypiTl5zH
	Sz2EY/GQPnBHkvFbokxmXOynI4Q0Pu53HagPBibyKuoNnKQsZrgesv0oRRl72E9DNfdZ6esMBjO
	fonsR0YirnbyNX/Exf5A9ZnxkGT2Xw8RlLNhaxOfjwwDQakKsIUQFGWgbCioTdt59DuqJVOBCm5
	rS3/gqBC6ynwaij7Jz0EG6FR5
X-Received: by 2002:a05:600c:8b42:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-49b91c57d64mr469951045e9.15.1788210831303;
        Mon, 31 Aug 2026 14:13:51 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:50 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:39 +0200
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
Message-Id: <20260831-kernel-header-removal-v2-9-b92b580ef5eb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=1547;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=zlCbSMvrlfeCqiNJjQxZkS1vJbSrxoS9NwpBsjGk91A=;
 b=oTABnNaL1RNH5TgvGZY7KHvLgvYQ0l5Qw182/IOVyeYvlMg1T3sj50D5/+XwHBXL9+op2YLK9
 1fqt9Lkj46OB2X25o2HezW37n2wCmgK4Owfz7u2UgpnbC6A7n/SPTKE
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for BIT()
- <linux/device.h>: for struct device
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
 drivers/iio/temperature/tsys01.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 14de67ee8be7..b19b4a3ef038 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,12 +8,15 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
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

