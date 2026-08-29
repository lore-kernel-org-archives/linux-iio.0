Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E83BB116
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020770; cv=none; b=hKee4qIR4hCq0byzsGBr594+JrC46c/7J3DIvfusTCU/LdtKK1HERN0XWgmKfxxgFOeQ5bejH4ORNM2b6abTwEz6Hp44mV/Slmqtq/CWgssvNeCj2Hs9DnZFecPJIQD8R44WymDcGzq8h1rxS9L+RXUgxIjmFfy2vd3NTSEpS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020770; c=relaxed/simple;
	bh=VvbFU0orbGq5GXqsfJRwdLZgjt+B5oLCdGxqVHcumTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GakunQArrJaklaaHHwGkHhGOb0logdolrJbX3Dh4lULF9GENWN1wk7b6m9yNXroHMaUfxIdVYorRxZjWWK15fakj0KDUnoTvTRFpHp3isx6vJRS8fYgTxJS/hB9CQ9z6vmFPui2b+lh4bhOq1wVTRS4NfMO8QQoTTOj8yNNurAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojlh9iKN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojlh9iKN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so19580965e9.2
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020766; x=1788625566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riHBGvJnWFIgnSmmlcRlU+TLt6jZpAQGsDXIjBsIX48=;
        b=Ojlh9iKNOZUgbzdOohBjAVXJgBPLREvcY8D4u9XqBk/6OqaEGAzMwszuKyQg74h/ht
         APAqa83MdYoKkx+NEs7uHVOHWVQaR+5gLWi2Qsd7O4rI7BPN3fThT5JIwlyi8GHsvJGD
         l8HPAMqFM4/MkfgOZGCtzrWBRMIS/XG+8RiYxxgX2549GIOiHCBvwSMXuTP0HgQjl5FN
         ssuPbOvtXqsQbWPLueu/IbXNQibFt9aV6ajzwyBxXjR9npdnZwCDVsc2Ev/MK4+5WEXE
         j3GbT5njsWvCjPxo8nSem1wpP5/yfUX3Ijd/dA583BDGnJ6Gr8bfPe0AfAaXs0vraESg
         RBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020766; x=1788625566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riHBGvJnWFIgnSmmlcRlU+TLt6jZpAQGsDXIjBsIX48=;
        b=bbXHaVqQ607miE2b3gBkRB9UhjpIk8WiiLgoHfHUJOEdYei0RPXfs3BMC1RMN8ws/Z
         Q7LR8uPTQsXn6jV7UUZRKLodXV32A9716C8x+yseJ4UsEZHxeQdij4w0/t0LUqHKgYj/
         VvAnPmrBw8B6j86K4heddzkecAj3pvU8Ji1ozJbottxZ0jIq27QYJpmhyDe90uZQd07R
         bdog3GR0tHkDnGp4Y3pNAB6F//B6izOD8D2q2BFwsh4WKsuVXIdf7aQAXxgXKq89FdqK
         Ibx++7MoVMOk0Z8IdZ6lI9NvKdfMBsDze58obO0Hs2YUQcliVN0ZTdC3/OacJQIbbCeg
         178A==
X-Gm-Message-State: AFuF++lRAz5DMHWDWlCk8SWw695UgrFwi6mylnLJ24MKKwyTHCYfC1SY
	KXQXP3PH65Qdq4SZZP3caNzKcPR/iyzzPZd3g15A+MB0dj+qWbrv4dnE
X-Gm-Gg: AR+sD13uU/4jfNNYmePGgS36iuwiTJUQ577QxdV9CFSu8gIzZJte0aLRNslHG5TpowT
	HoFdPrASfYzCK2dRJz4G6VW8K9njhxV9bYUwn3r7rzKHHYU+xNyqMDmUz+4IlbsXimSN9UvECpx
	8oxjncnKjBMw0QZy93QGHCx4rwKezMKSw+d5vPHWzfZcjTYEF+LjmFzonUix4BNpPuHm4AaQoOo
	yGrK79H4iDz3JsYoVP7WiJanW5wEIeFF/dIr46GSB5kmhN5YmIQ/sB12pFSCEjIEOVr+1vMuyyd
	O0Cf6cVGKWjTNigQm5PuR5WaEmS8J337Jug5AgC17opfAMa8+K+AKSdfMWW7QIk2i8Zgjz55W7O
	nVu++rXGxb8gMceSxkPlz6F98TqmmUzRiXjRXHZRzzY9GDvBqb0o0EDMWZK+obanEV5mKPqdRkd
	OtKvIhAm6RjPJcL1vIVw4bZ/dFpbCisbuwR4psW7gpQyPgdPxj2xupI17rZSGx/XXc3z0a7/rC7
	Ly3RxXvaC0LiJmDx7B12fi8w6xhw0/35eJFowSABtLIG4dKaZj3kVG1p9OgfBH/1TkVbDs7WpCy
	pHN4BW3KpP60zi1DNuJTP1WeLSFBGdotDhWOVE4YW6PYgqQAx1BMBX3orvjmoET7QIil53GfdBo
	Lacsg1bcuOD8JrmeUTLpYkVvYrg==
X-Received: by 2002:a05:600c:34d2:b0:49c:cbad:1c44 with SMTP id 5b1f17b1804b1-49ccbad1cf1mr101316995e9.6.1788020766117;
        Sat, 29 Aug 2026 09:26:06 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:05 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:25:58 +0200
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
Message-Id: <20260829-kernel-header-removal-v2-1-c67739d5dedf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1382;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=VvbFU0orbGq5GXqsfJRwdLZgjt+B5oLCdGxqVHcumTw=;
 b=AiTMY5GdSteZUcLB1xTHEg8sc7VLvWP1T3Xo7eB+Yghlh9Mk1Nd1+KHGocOaYVPuinSaBUO2j
 IS4SeczG5JiBC8UPDpBjo0e4vJ2xH26dDBWyhGipQSpjy5Cp6m1IJQJ
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

