Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612601;
	b=GfOAF5AENYs0obKiyM6tVhZXnZZ9O0+lNRJ4LvMqPT99KLdIek+/hOCoeu6ocKJ2FKV6
	 EcBF8euyKfZlM9ktjLK3XWOa6IImmezBl+MjT2USm+PMW5jAD6jirQx5SV+9Hb6baNJIC
	 nIRaiKsjoHw3pDyXwkhyWGsjfpwk8UFvy0U0igABxDw6pXtZjMMMfVnPzzXm+Z9FCg/J2
	 h0jyLZHZhk12tYTbzZOHfiIgLoNqiFM0kXzpKCS4Q8uW3Dlu0YU1ItlgjcqHLE/orHnaT
	 cTGccBRL6pWlyPGofeKapEqAoHoolMM6FTiY9huAOy16q8boKzfddRm1QB81NMa3POQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0zuRXRGdsCMZO3tCr5/uvz2iu/+zzw+UAMTABxMn/ko=;
	b=RddSeDinCQXwk4ICIYlsfQ+Ac2SRRvWAL/JUL1b12McllgNraYQ/cGXATCbu4rPPZV7o
	 GzFLEapVYjhCjnfff8PAMERYmL7yAzuWa9X3T+1VFDRZ6sae+w5irgNJqcveeoqfzMMu6
	 8gf6fEYuHtO9GUMhZbLNXRSsdcEGTeRh6woqm25CSzLrs+Iqs4BRILkT61gjEWMnDCXaw
	 vqfzltis+rkdTt/U+xHNXinlgd4EwFzoJ7BMskK8rKm0sJM3CGcBpKHDmRZqzwrZwJOYM
	 q4QLD4mRw0dIOK82UJYCOiXRU8RVZmRtVc83sz8T3dDRW4cvKNRaYn9jNLCamdEeWGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUxj6C4j;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BF606A32C
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 09:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7BF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUxj6C4j
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25525155e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612599; x=1794217399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zuRXRGdsCMZO3tCr5/uvz2iu/+zzw+UAMTABxMn/ko=;
        b=QUxj6C4jTM/fpGKIKda/EfSvaVA+WfxDvnfJ8ApU2q+sPhgkcjL3WCqJnb4Z5aeKkG
         u/pmR6IxF+7oUZum3xg5iQCWDok3opBaYeOM65wUBxk4Nb1cBMqKlteQZrL64PadhglF
         VFOzZTNzH3zmrsNOXhkZ13Xsmo+HafXbmIWMAGqGzNI31Zpig9AXlym/PSz9MoU8/LlH
         PCLBbwa1kQOmNySPS+O7NXp2pHNueGByp6fRFriLm/bsZ78eb1xKGFqu3hJnxGZzRItn
         66zHKFbteK3zlwFOvfsWUDE3E1V/Uk2HSSluTsz3m3NKkOLDxhyIUakH8d2lGPAd7gVg
         84fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612599; x=1794217399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zuRXRGdsCMZO3tCr5/uvz2iu/+zzw+UAMTABxMn/ko=;
        b=CskXk/a0GhRZxZSXKzpS58jHVO1GfY5ygcJfJdplx6gHO7612H1VJxqpG0gjw6qsge
         NhkCCu7d+1TUMzG9/Pen2yJ4lwyGVB6/v2GLwJvvCdIxs7ztazud8/bCTFEeHGFlScrk
         tWw5bGbkKlDaAZ6/ODv0BGTy+qHxlhVUTOCxDMWfr7Kf+Rb747fULmhke6h95gzmWq8g
         0s/8+xBjrrW38Q6z6nUUy+eK6iugVhtsWVaQ3q0qPrOphQAZpRF/S3BDbzUMtfnF+he1
         9e5g6fKaSDYFbjBAzPfKI0Zq/87IzF8P3V6abqN8BKXt/G+MPephc+tNoaOkN3XCXXCi
         58aA==
X-Forwarded-Encrypted: i=1; AKwUvBw5YEi2TzdNdzx4PV5BCwmoE4juxapqjpEW4kqJtVCODaX0Q5UKg4TsU6Ou2vQd5aTYutGeiBu1aFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEqMbNytj/bBKdB1DEuYOHxmKYur+cAb/r3FQyeTrsf3vbwM9T
	bR4XK+1jcOFpvYRusofZ/dBUDTf7quogmdE2Bb1Z8ctMr3Mf6OyPW9AJ
X-Gm-Gg: AYBFou11uO/zIWzOzL4gT2SaVBFfJdGxgC1iCS0xMIL+VzXjE2mSypuuhCyKLWu3LxM
	+s4Uugv6PhPwYwJlDQ1JbX4CxAw8xJ2N6g1KA6CL+G0U2smDQMaVy/fk251GsChXk2vDqXP4oIP
	laW2ujQaWcXN/TF50RxFHvAxWKA/VHTr22aTp4+W9yUBKLkipvD0rILxv3O60q5rchY5Yv9711T
	KQRD2a2MzOcwBAgDRoyU+6h9/8+pzk5kqpGvW61ZSIXdeSf40YAQmTREsdyz/nvfPHp5v23jdk3
	mjjejorpoHqc4C18e4pfIvq/wEOsO/S+JDV/kvv8qQLmVQbWtz5iA29fPU9SdFJysreOF/91+kZ
	xCWgQ0QOkX6jGdxhcDGo5OnRLUF/f0DrlY/hJcugea1qicnhYsyYa3bCtvH72eQaWOl8RBBnBok
	yUBnnb8dOBQ8oc7lsaG+Q9yP78KtNoyWvc0+C4OQ7XWlLCtlTnxxWnJEmxsodVKiNiO8Wb14SnQ
	DFF4UBikKgsyHqLOhTqn7DrQltddnJlhoIImdiDbWk4BdR3CEYABQRnECU2xBAoeD5M1yac2tXq
	Z3I/xNBEiHzszG5FeHDSrvU07MrsDoU1tsHMZ2A=
X-Received: by 2002:a05:600c:8b2c:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ac150b3dbfmr227970295e9.4.1793612599312;
        Mon, 02 Nov 2026 01:43:19 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm332507285e9.7.2026.11.02.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:43:18 -0800 (PST)
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
Subject: [PATCH v3 1/2] staging: iio: addac: adt7316: sort headers alphabetically
Date: Mon,  2 Nov 2026 11:42:35 +0200
Message-ID: <20261102094236.57757-2-abdelnasserhussein11@gmail.com>
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

Sort included headers alphabetically without altering the list of
inclusions. Keep the <linux/iio/*> subsystem headers separated from
the <linux/*> group, and add a blank line before the local "adt7316.h"
header.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
v3:
 - New patch in v3: sort existing headers alphabetically without
   additions or removals, as suggested by Joshua Crofts.

 drivers/staging/iio/addac/adt7316.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..515f1fdae46b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,22 +5,23 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/workqueue.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+
 #include "adt7316.h"
 
 /*
-- 
2.56.0

