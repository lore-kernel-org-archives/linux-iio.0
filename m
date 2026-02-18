Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E342FD69B
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389472; cv=none; b=FQq1CWuzTva4XGyJpbjpzZpXZtvTDFzbsNC+5xyiTP+ytZkpmaQOuo3yPriYPpmQQr2SLVxIBrwJxlTj8yb6+g7o64zbofym5HqFNgOacUv5NT0hKPuGTrprWgvzEkUDX+MXQXmNNIuefqOsAircDq0Gg7wsLBTK+DgoFbeD5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389472; c=relaxed/simple;
	bh=XHQOu93rUWzl2Xuiv0/1QeO8Bne+xWmLq/eoABNV9Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGfqINgwE66+5ZazC4wGXCW/er/5A5ZhjSCuKqQ/pNqfeAFls2sflSg+rP0ngR63zp1KgwGP1vyV5g9jeLUU5KucHWMVJBIiC2uhEi6FV+Us89W1tfAJnimLOkTos9s9h+ObgnibsnkN/oWbeZwQeqCQBliEjNs7pr1fNlX6V08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah5gQDW/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah5gQDW/"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79628fb5c05so39585917b3.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389470; x=1771994270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86olDjHGDGW+KJK4OjX2Af3Opw6yf5oy5qhYxKNHWxw=;
        b=ah5gQDW/crG9v/t0ugfgN8KpJWcG0EF5+uOCBbPTKleCwi4h70+3wqY6K+7bJY6sg8
         mcyZHi+0a8RWkdTAStIhpGf3F9eELd1TkuvvrIU9cf4zZEilPWjEWAFTqlvSGOAoEzaJ
         UVjMlJY268v08D+0jdtImj9Jnrr+WWFqtb4k6a3VvpM9464rX3CilRxUOyOzp29mdNol
         4mU7TK2QeEGPFwrI3SutrlLCeRs6NlPeItdET/EsVhzujTXQuH+xWpMzMmFyWViU+DG6
         dHgKS9cB1IwxunWfAd1TsDIz8j9TuSfN9gerNzRNTDwFDSR1uCxSh8/6HsLE4qGXrvds
         AHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389470; x=1771994270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86olDjHGDGW+KJK4OjX2Af3Opw6yf5oy5qhYxKNHWxw=;
        b=S51PXQMJPADJmDx9cQus9jSO2klfsEArCiyi8zwxTwIPB3bwitrUwUUBCW3SEZ0qfP
         JVCpRTADnRoTksxVU7A5DxygioUiwg91p5z/qpZkZWHWFe3TaPwiMgVMKzcsZE2i/yun
         +wyhtJL0MKY8gD8TrWmZI4qkVXpN5eW7QRONZQ6TN243MM+FOarFHf2VByvIq41fAPts
         vagvbmWCEvNubVW2xOwRqq7FbZeHUHaFNU8rhcMh6Pbt7PkpptZ3Ao1U0S/FOYRIlO2O
         /AC0fuEirdYwIhMTXkSoXEIiYIjkBROxZ9Wi3oE5ucD8T2BkktPSTFtxb9sC5T5wcxxl
         rr9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbwxVsEKlTFZntptZqKfJ+TOdoPkd5oeVaFgRs67xDk04mZBQGBf8USseWu+90U3gvavP532YvgDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfmADvpGHb1d+7cLzXo47r/txgFY1HoocGi53hg4qSCerdEk/
	F29kAL2R2kFePd6Gpt1Kmnfm/nrMmKdC1S77d/juXmSAoGKO5IVy8Ez7
X-Gm-Gg: AZuq6aKTGpSEP31wnRwRc/NIA8jjfimqCgpQ1HWkGhYqYNSNCSHT39pVuHe2ZZwM1qI
	Fb4TbAH0j3XlXb5qRlYO5yqHhDv+qMXSRurbS8xs3hkpkDDvb8TDBR/glWJgzDqIVoGpiCy3sV2
	hpAto7yTIpq9yYt29iO3P3AolvCd/ttn7CVrI2WnIFshHDZVeG88CcSQchaRO1HMYywZxb2SgbC
	AJiz0UnCALyklrd+qt92CY2z5YwBAvUIJ/6uu3lqWWb19ieDfQXIXzvkkMSseMcx0+KVVtsCvCM
	a52p5ZdIpfFNmCTMUE3dOKkrTccgRE1RfFOXdeoOtkMoKw7/KP/GVrSkLmi2hZWbN6wQ9QXjYlI
	As4iAL9s0a1jv5dGSd5oQT78vKOT0pSIo+AcaLDkX/VtdToCQsNt9YNpSfH/UH58MSoH0DnK4LG
	+gFcLW4HZxWs2fcc+5HxqS3aN7nK8/75XHBx1FbB3TXoml4m8wmapqpw9QmXkUjAEVuqDDCHWa0
	p0DhhFCRgXan58LvUCSsEBlFLMu8Yegwc95pfip75wkKB6+3HYbhQ==
X-Received: by 2002:a05:690c:368e:b0:796:45d4:9e2d with SMTP id 00721157ae682-797a0cf98e5mr130383937b3.53.1771389470288;
        Tue, 17 Feb 2026 20:37:50 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:50 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 4/9] iio: light: gp2ap020a00f: Replace custom implementation of min()
Date: Tue, 17 Feb 2026 22:37:23 -0600
Message-ID: <20260218043728.609659-5-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Replace custom implementation of min() to save a few lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 82b078f6a43d..4afdd22499f3 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
@@ -45,6 +46,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -454,9 +456,7 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 		 */
 		thresh_reg_val = data->thresh_val[th_val_id] / 16;
 	else
-		thresh_reg_val = data->thresh_val[th_val_id] > 16000 ?
-					16000 :
-					data->thresh_val[th_val_id];
+		thresh_reg_val = min(data->thresh_val[th_val_id], 16000U);
 
 	thresh_buf = cpu_to_le16(thresh_reg_val);
 
-- 
2.53.0

