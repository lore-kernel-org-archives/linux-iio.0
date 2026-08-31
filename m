Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846239AD3B
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210823; cv=none; b=hZypobMFt5C4NVy/E4DDgi6XEBzKxqgTN9YzJcyZEo1V46XlD9gE15Hye9IYjNaLABpOwx2NhFLRcSwv/cOE6NMDIhvCBPbr5ISXui/1rN1yNMWh93QSi1hDJrFZW0GGCZUcRqGHE7Zpsgpp34DLJFTQlRIuReAzmS6YF9kqc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210823; c=relaxed/simple;
	bh=VvbFU0orbGq5GXqsfJRwdLZgjt+B5oLCdGxqVHcumTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsNumJSsRS0qvCNBFEopuRNoWHTJdLsC4mLef5D5ekaIfThr0ugeswwqlCbVaMoZIalVVGybAM2vcmcMlJA6wcycTY2EiASYfoaP3csBIaxjHAesj6n3ynF0ZiAVJoMZyXx7FJsMgohquZdf5RomfAmrWXzd3PcD8OoVe6Alwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJzV4knU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJzV4knU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso28837905e9.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210820; x=1788815620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riHBGvJnWFIgnSmmlcRlU+TLt6jZpAQGsDXIjBsIX48=;
        b=pJzV4knUwfAuEZhtt76oWbFQ7lIAwZ34o3n2Nrb5LejywTCehUTQw1x98iG2T49gAV
         rdD5tP85Q9sLZXGd2kuV08awnLnDHlsbWFD6uaes5pM2YL75zy1RbtD4iiHPCfX5prIl
         +QiuLeg8cmuNo05KMhW9/1u8tg582PIds7+rHlgEQd0ZKaLGSqBf9AwMTnn3vJK3u0kH
         bkRAPqKODjuM8jhMTF+Vm4xDwJzSquLrROd60Mv9y2VLo2Mahd1ZoyognPZRq2pLSLCm
         XVO8vmCXxzdEmvTU4EEEZrIWlp3k5hFgOZJfZzT4OJIPygVYdZdLVZZ5S548HnFMN+Dp
         Mvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210820; x=1788815620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riHBGvJnWFIgnSmmlcRlU+TLt6jZpAQGsDXIjBsIX48=;
        b=C8XKXaMFX0r6Q2LK70DLdFeTgxdGTbbyQ2FresDBHv7RLUJGZ5QEwgTtW6UUxU1eWK
         johCPMFY2uNQXbPgFWTmlzitvfyzR5GUX2cX2of/MWHhezintI9qClqP0ggFrQwPrKiI
         K2Iz/TVMUuIWtO7CeykNsH14STgys+Xl2IBrd6WsiMZqNOR3gXT06yOSFsxpIPM2NPJ4
         FfX0SOoEGYsMlZ7TndZiG8KC2m3WwKEOp4mixdlvnhGe95R8qfuiZHUal0dR6nl4//CQ
         LHAN7Jpvj8bXm6vlGW3NAuf2ZoUFEwJU3uPLxfnaHWdizlnWclREWux/f+hXa2mre81/
         J2Lg==
X-Gm-Message-State: AFuF++nRp5ByjomtMsJpBYmhcZJvt0S7bsmuERGHymhs/fwAjUrPQ0zA
	aw4DrAEsxmVJF23constP3vxeV3xsTTAJNuPnKZMKCxLa0pO5Rle3CpF
X-Gm-Gg: AR+sD13Eqv0KFj+DSF0dmewQkmasM4g+NSapnvBm25c9YRfMeRQcqtgjubKG6yZ+Sep
	7R0qS1euAP/ZB5t1f1xQLQflxUhPUybSUZig6oULIgqjtg0vChceu6ld/HZggXQB97odxPJrEA5
	p5IQuPUgpuqDIHY5Y1W/+3Zq2moQklzNqG7daZaP1ZLMoTRR2Gh1pe2En5v2Amk9/iY0WBy8Cvh
	L7yyjqOISO71VuTeYDpv1vP/m0sLa8C0tT9o1LzFPJaU048roZb4G8odtxu43HdJa0xyVvGt93V
	jCPPYDHRv3TdV8UoHV7Bywb+vkrA9W778A22bxwWOJpoZR7ajuE/f3GLzJ3C66a6NEbmhMOncld
	1ejeCaoDe3jLwLFNGNtI8FQujtQ9fm0Zaf4GJZ+tgQiATPhnOB4YB3dGVYECWTv88eTXEWVbrum
	7bHEitZehKbz9/GMMk2PyCzgkiaN8DXmKFMOZEAyNKOdcw5L/txkeiyyWlGK/L7iSgEK9trtmqA
	/L3fMNC3j8v92DkpIvl4vbrjJj3hnwESOSFGAPEl9i/ub6sn+O/5TsfOevyH0BkGjPoRKDMSRRv
	abk0RMmRz3v9x/KEAF8gwzZSC8iU9oisHIVIEbadOTkW+l1kbkm1NPxnogZns0PJ7SxjDlhXlTx
	Mak3W4KZnVg+FydzTx/GupwwH
X-Received: by 2002:a05:600c:1d99:b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49cdc560282mr73922345e9.16.1788210820205;
        Mon, 31 Aug 2026 14:13:40 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:40 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:31 +0200
Subject: [PATCH v2 01/11] iio: temperature: iqs620at-temp: make headers
 conform to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-1-b92b580ef5eb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210818; l=1382;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=VvbFU0orbGq5GXqsfJRwdLZgjt+B5oLCdGxqVHcumTw=;
 b=WiPTtq7oDQ3FSUPaMivMtWGdM+4RcQB455yli8n6KYYihW3s3KaBSecl3ttFOUTMNsFS8Riql
 QzKB6zcUL79A3bINAWKeZl9PvWzVEpKmgl6w2/cJipNrvyGjULWSzdj
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Additionally, separate the IIO specific header from the generic
<linux/*> headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <asm/byteorder.h>: for endianness helpers
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/iqs620at-temp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
index e2f878d57af7..3a3b1f256585 100644
--- a/drivers/iio/temperature/iqs620at-temp.c
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -5,13 +5,18 @@
  * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/iio/iio.h>
-#include <linux/kernel.h>
 #include <linux/mfd/iqs62x.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
 
 #define IQS620_TEMP_UI_OUT			0x1A
 

-- 
2.55.0

