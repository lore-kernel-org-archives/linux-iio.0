Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0035AC03
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459213; cv=none; b=TdL+SlHhL1g2723AM021fXauGtO3mD4W0ZwZjCeLOjd7PzLU2yNLYXX9eQJfABmNxaJkkW0TGn+T/PnJlz1YokAu3/dPsZ70ayU77YeNVdv3yEDP+5CAGJD5pkYsuYUSKgItX57ZLuQIeNydSPUMPvJBJqp7nvRS9surUr+q4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459213; c=relaxed/simple;
	bh=wFxXi8Z9WcIxFPd9fUaEH26jlrgztUaT4NJh8D572Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrrDC3uBIduLhzr98TwMVFy8Jw4z2hP/NyjHkV1n7qPNEWY0e2sqhXLziyrfbFNoH293tscV37zkaHb4QhoQt6ZErMn6eWkrKQk0P575YhBQUomBqZ4Rmvt8qpjwFjYm0Xf8CVTd/YwMn4eb2GW/E5NOWmC5p2U5qCvJYI7/vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcgwfU90; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcgwfU90"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so88005e9.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459210; x=1790064010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW1ixTgxWimSTTjdthxgReSlmPLPKmDhq2QrwAvzdaI=;
        b=KcgwfU90wWAGZpjTUr8z91VWhc2YRUIU65O0O21c3pzfStJ4f8VWFN9soQN0WrJhLd
         1nEeyLqBDoznAr9xI/Y0p+bfqGNjrthdpP7kwsX7ZfK6D1dPfqcchJSn72SRFuuys4qY
         hR2gRKhN/q/y+dB+IHKoqEc+XaMSW6fr5fqUndKSL0PCuTl2ZxZfRdFIE3++xuRgSbTM
         D/VKzt1i1tn0w7sZ0MPYsUHhQIqAsXs3rltt1cZITwWMB2CCtnyJpuOAK0lzPVah6frf
         Hn99UHHdTnfCqSkZWaFQOqqO7yd22qFFQOKJIDsjflOVcvBREk1tS0Q7F/vpcL6X1wmW
         X14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459210; x=1790064010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW1ixTgxWimSTTjdthxgReSlmPLPKmDhq2QrwAvzdaI=;
        b=Skf8bAwMlInd1zNtTsX3ZyTcE7B4XxZjttLPEfrq3H+ub4CYBvmSSh2X/AJbM1QeaP
         QvkGtTPnS80PmVuT/RRLvPo+voo42mDFLkyWF7pLLEyGridMCHO+kAiWctD24br/ezjJ
         NQD8LYOI6SUH/+/ykwKqkJOUfS6FNLnYFgi49ZLDESnaUanezZAw6qMsHLbB9iqxt3uN
         7ynOZwEZax6a2OlxfdSSfMaT5gUJQpfxwPCQiDjKMWU6+f2JXMRx4Q2UtMBGc6igW0uU
         XMqndhaHioRSQ94k8qI7H8ZO3mCCTKYLLPYxvcCEUJ9rxzbq4JAwaWkaefKdfn7KWbaD
         YoDg==
X-Forwarded-Encrypted: i=1; AKwUvBxhyjwO1usipS4h94erU1c/wbFPnpLqH771huC4eeqgpKXuohM1bgW9RzdM0gw84Tk9sXuH1zjlCCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mfrhANQKPIoU0GEkGR0W34sL7IAsIB8LTQtjXYOvfU2FxlVooQ
	PlAtdVLIT3N+NLrQZRE7BnW3OPZx3+bK057FY90fN6h2w0tOVepgd6Av
X-Gm-Gg: AYBFou2zGhNqkHi/E3mPe7c15zv1WI2AmDpea+E8jpHtPUQAeXkrjb6ct8i2ddjLdL6
	Eym3OdGg0c/NEgagu6F0uRNY1jBe1iuJ1Tze4+/LcSNWhbiUst0yl4d+3QDodlERc+pPhY+88Zq
	G3HxAi9K+uO8rdm23X9ykLa4f+1JhJqUpqRachIdA4YytbI2DF9Q2TvvQp2OrYula4kAsBvw8t3
	gnOdoXRt53bGJz+zIY7Mx9aKBgMskMTs14B0h0hY9DOX0ktPFdrSzdagYuAf52uW7PJIbtYnVAP
	Fe+3tpRGpVLy4h+vCVEzm3TeRv31+8wDSwuJcVAjbLEqs/n953ikYwLSi7qNi9PNQH8zysaxvtQ
	5WqlmI+/iL4NVAiaEGZ2yHxRzFd5QeGqcRXD7pKcJyOx9mwKTYOjB6pFeHE/z8/M/QJRrdLypGa
	SkR6v2mVztkURFwLkSyMU1/KObSCnY0H4h2knWZNj5DB4AnM86CcjGka7s7ACZ28M4iaPezo26T
	8GvsYRiytfBpW3ivlE=
X-Received: by 2002:a05:600c:3548:b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49e822a6d43mr585075e9.30.1789459210180;
        Tue, 15 Sep 2026 01:00:10 -0700 (PDT)
Received: from fedora ([154.182.99.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6bf4desm64112155e9.15.2026.09.15.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:00:09 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v7 1/3] staging: iio: adc: ad7816: Sort headers alphabetically
Date: Tue, 15 Sep 2026 10:59:37 +0300
Message-ID: <20260915075939.18180-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include directives alphabetically to improve readability and
maintainability. This is a precursor cleanup patch to prepare for the
addition of new headers in subsequent changes.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 30644d2d7c54..9e43ce83e071 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -5,19 +5,19 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
 
 /*
  * AD7816 config masks
-- 
2.54.0

