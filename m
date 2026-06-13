Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD82255E43
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312300; cv=none; b=R/sph56y843oyhCXnMlUKc5887PBZR2XLD90JRUtXB6FZKD7xQdQfl4CTDjZjhksBIyG2FGa7CTym4zVN4GHI3pU877diY2Fr3qkA5IsLB+yn6gmk1oBu8zJL4jBWUaRiA2qSLN0XBJHxVCoAA1dROEyYKxpEatiQuMweHv3Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312300; c=relaxed/simple;
	bh=QqBN0kqahzZzpesKTgX1O4zMEfif6LQxVxhpISDD3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYIc2WmaoQAwz6jETBsqR2DtAFhcQkzwcQs6dDwDUNmnLaKZ15A+zfcOcgWZtBrk1TkBAadwxArxGDFUmrXa4Z+9+V42IUfVsgBydFZgwvhRxD6EKIr9zPYeYxl38ZDlW6DK7csRWLCM3nAoJXAGxEanlV2u0QIM/4HD7a43vbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km/KcCzO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km/KcCzO"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6f8f26d66so1565377a34.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781312298; x=1781917098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL0Ledz5ddI5Gkr4vZQhSArwkkWm/15rROLq8VW4R/k=;
        b=km/KcCzOvIqnFUonfWm2+k08zxHuNtXlZhmwZgCf0jspOziVLVyKzL7e1lGqrV+1Cp
         4/Azm7Ecfrv6DPPhLNDdYzU7LATANls0toa21feB9fdUdF9H+OtD8tXV64+zgiQmH7W2
         g4ZixAVtjLATRa0wWW4vZk9IRr6sxL/SL/p+jvvNnWNBPeNe1RHpOWcmYgDZCU5O3QHI
         wpm9Eq14jrrDHhUqu02WYF6Lj8s7FmGdUjn7JuOsJ4OapxpcGuGF42qnL5eozNdjLu4m
         Bi2OnEbWYTnqRx/dRFHy3BqROj/80TvRaqCQT8Gt8quZl1K6XMaV40MXzCczYJDMy9qG
         kraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312298; x=1781917098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AL0Ledz5ddI5Gkr4vZQhSArwkkWm/15rROLq8VW4R/k=;
        b=hayoangkGLJwbLfGPuszwQHUcG1+CEnXXY4IRhQ3QInsQcgaA+l3jwCfo6ac+UVv5A
         P1iXio0wrrdZImMgNrYMsOTW4EeB2jRu15fOz49dPT4Hj2YMdH7sNliyjuaKYLycK9EE
         PVAm+P0pzqOQGIRcVqK9bd8okHcF0o8fEySltW/imGGeezbsG+JlaqWwFTDyu9YWoRCg
         ZuwFtA2sdrRDfejC5C5coxHkTZQE4pbUbrzZHjLJMVXfxT+5qAngHMY3NLTLcxrkKHoz
         ClBA086GLz7nbSm4hRZIHVEgb1Dd6Q2UN5I5wxxq3JlwlyOUj/+TmuttodLXE96sukj3
         PQfw==
X-Forwarded-Encrypted: i=1; AFNElJ/ybuXRyzRFOxhaFbmEOUz3mFpBCtlaAXs+hyGp9RSvX1yhTQXLhXW0yEFDSmU5q4rbzodCTUxk5CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBFSZZThZmByj40/p9rAJgnCSLS4OuZU7RnD3FuGW18KvYww/
	heeastp7KHmKu6kXyl8mSoX//Du0/8iPpvDFFtH/IqgXlLVJhrgrRQLzbyUmJBaUvRk=
X-Gm-Gg: Acq92OE1yhPWAgnO5nCjw2NFrI1Tfy4HiyqXwFR5mfPcYSzjxIucXaxTDw+sq0PylLk
	hruf4fs76YQFwkW9GZLGzpl43x3GdLrukUuRXorqL/UTcIVUauDfHZdTvUL5ifwIn5moeBifx2q
	0b8bjeFNezt0g4wt+YtKxRNtGnkNbUIuFAfVPpOfK1spsBBayN2CzQRGYjuyiJZNLejc6aMUfGL
	PhYmF6yKs/08JupGZljambToParQdp6M6+35sWMGbZxBnM7UM0ZdsYG6KLHhNUJ354rSDLh1lgX
	AprOOK7NPDZxtiJ22aT3M0iRL7TrK+TKiId+FDwJEPfL0rFTCb47Dss/QnSTI3aj7NPiHxp/Jtd
	E4QMhygGmhrAWBr8NetGPo28Mi4scQY+9BWv2Lq4s0/hn36QLZfGY7nSaMNTdmi5nRxHRMTOyUg
	hRbw3LvHZz6u/bevpql5jBwgnCsKqYz0ZDX6d6T0rgzG8u67Ei3Z7fJVhVfGobZdNS/pLr
X-Received: by 2002:a05:6808:c1fa:b0:486:caa4:ea44 with SMTP id 5614622812f47-4872dd9f5c2mr3185022b6e.6.1781312297861;
        Fri, 12 Jun 2026 17:58:17 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abf260dsm3150731fac.6.2026.06.12.17.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:58:17 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 2/2] iio: adc: spear: Initialize completion before requesting IRQ
Date: Fri, 12 Jun 2026 19:58:11 -0500
Message-ID: <20260613005812.160572-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613005812.160572-1-m32285159@gmail.com>
References: <20260613005812.160572-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the report from Jaeyoung Chung:

"spear_adc_probe() in drivers/iio/adc/spear_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in spear_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, spear_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: b586e5d9eee0 ("staging:iio:adc:spear rename device specific state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/adc/spear_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 4be722406bb5..ab02a14682ed 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -283,6 +283,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->dev = dev;
 
+	init_completion(&st->completion);
 	mutex_init(&st->lock);
 
 	/*
@@ -329,8 +330,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	init_completion(&st->completion);
-
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.54.0

