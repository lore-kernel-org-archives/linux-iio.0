Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E68407572
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200481; cv=none; b=RdYDLyvcstUB2U9vI7PcWBwa9TWJz8P6HJcTCDoch5knxzsZl8PCdZs2KIL2ajdbdVzkkb9Wp7/NOQNO65l8hVD/HupbqHcuGuzTdhFIc5N8CpLKVomvO1/kGTxFJP2hbCz0iicltzh4DhNj7VrXgL9BDwpgyhRCP9Zaq3IHnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200481; c=relaxed/simple;
	bh=3+A+SQoBt83gTfC1sDpy7RKcu5901biWiEykpqGIOkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pilPU9m6Ny+c9TJJ27CxPfgfz0RfgCzh1WDvjt//pwNahUWUwWxI157dQ1Z9Z312Wcf+lHFPNWTcyvO50PPkbNpK89ujn9G/j2cXUrE+V+lqZEVlOPjyM6h4zNIYZcwTPUQyDzOVT19oQlxLkWD9fkRjv7ceL3vMkHX5qkmtx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx+UiQ8J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx+UiQ8J"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748095892so745628b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772200478; x=1772805278; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcA8KC2efBRjVBsjImz9ttRUOmQCENzmLukTqiVhsew=;
        b=Fx+UiQ8JPqDh77TKkOUcHwCZjrN/jbcmH8VDKA/lircqssdz5lsCswG8zvsuf5fDE7
         XJeFQARuaWtIPARDLKMIXRBZlkzeeJaS4OIRFAVMhkJ8lDdccq97P1SMNL/DJx7+kCx7
         3CC4P26phQ0mp5f3vZzCtiOeyCJwuqsd+/AGOl+5qyBh7IxCPWt2dGlulT25ByyaK/Pl
         /+l5EmwgU2Qj+LVa11GE5K6WksbAfv1T7n84lEdmnskmfQNSxtRveysUwkdqaLz4+MMq
         q75ix8pjwwPumeUbhGSqsOcVkBm19vd4j/nH6c1Sw0j43HUswBXNnF4sfODylBXjRq7W
         Kbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772200478; x=1772805278;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcA8KC2efBRjVBsjImz9ttRUOmQCENzmLukTqiVhsew=;
        b=uJttCaUR701ts6qXrEDCcBR+HWfCB3nMVkolqgXQJRNxF9eU9GQmAB7Y0smy28OAKB
         nPDMEoN5SLGeEsBoy0uNtBcqmxmDY0HWLyzjT/tuIwvtsJXByQUCHYWA4ShYeumxze/k
         Th/3IFj9BCZ7xDGI/+7f1LF9JM7WO5MinhWib2UOnguaHxfqg+xQOKOp4ziOEYjcYOlg
         0uBjscFWbjAGXiLYtPXpoziLy750M7fKXgyM3sizodoNgBMoqwzc3LtLWpDjL9wBdQA7
         dweWbgcCsxtRPRzXU83h2icTgWkbJHQxWzy7v8KxBMstxmnz0nYdPRfA4+GisFBlMnS1
         6PXA==
X-Forwarded-Encrypted: i=1; AJvYcCVK39IlLNsZkd40JdEE7VLImV4/jJ6xzha2orcDm1J8KkSbWkDkSObKGCvpFfUhXFfmWUQ0v+bC0tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgD0t57sB4jRV2HMS/PEcWk/peJfM1K1iQCthi7i5sPOlNn84
	GSIa95Fx4KOSQUZc9QePgIXIfv0A8r1MSP77hWACaOH+pVf99Ghl71AF4XaUMsDMEMnymg==
X-Gm-Gg: ATEYQzwgT/UYhZBQQRkwOrjhYqsHIJdd23Gakauy+evmWU4uxDY3kGvzHKlwaFJntjK
	/p9U7bawoYKRqKXdr8xs0I9JHkAiVcKOWP52C6Bj8L+5FjgMEwtYLO2GiJbRDAPf5npTj74peTn
	VaGZ9YUEf1Ewp+7HeOw1deYuF0XbE5VPaVAfS4xsZEQoCfpFLut3XAIWbp+5jdsJp3az6yldeK2
	d9lQfdKrUVR9bddWJdf6CW45Nr3gGcICl8p5Pp8NRDKHKQMrRFIiDfD9eioBq05hCLOrNGtjCEK
	b3Gj601Mvcxu9bcM/TQDh+VEcxxKlQu70riNmvj764LSjIFQzkBKT4/zsRNJrKoQIoPj8uXHsAw
	fzfa/YVnNeFjCuQZisEO18OKNPF0EcFLVg7cGYMYGrxwBSN/0vkw+u9KFqwx1+v3uibsN3pqMFN
	CvgKKgsXxKbP4NXVFiP7V5wjO/N0PzuC41pkAN
X-Received: by 2002:a05:6a00:94ed:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-8274d94f80emr2937090b3a.23.1772200478434;
        Fri, 27 Feb 2026 05:54:38 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:acea:5ed1:6337:b523])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db4955sm5603549b3a.29.2026.02.27.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 05:54:38 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 27 Feb 2026 21:54:29 +0800
Subject: [PATCH v2] iio: pressure: abp2030pa: Remove IRQF_ONESHOT from
 devm_request_irq()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-abp-v2-1-a482c02a5876@gmail.com>
X-B4-Tracking: v=1; b=H4sIABSioWkC/1WMQQ6DIBBFr2JmXRqYFDBd9R7GBeiok1Qx0JA2h
 ruXuuvy/fz3DkgUmRLcmwMiZU4ctgp4aWBY3DaT4LEyoEQjEa1wfhdSGSeldb5VFupzjzTx+6x
 0feWF0yvEzxnN6rf++1kJJbyZaJT6pluNj3l1/LwOYYW+lPIF5NvsLpYAAAA=
X-Change-ID: 20260227-abp-016a007ab817
To: Petre Rodan <petre.rodan@subdimension.ro>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772200473; l=1403;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=3+A+SQoBt83gTfC1sDpy7RKcu5901biWiEykpqGIOkA=;
 b=ZgLNcDaFCsGmWq4bP0QO7YtuIFYs5XCN84D1LQSGqMOCdo+SHOoV81LvjrxOZP548fo203kmv
 S4lt77/dfnBBUw3kG8gy5ByUCFDseFS7yDa981Zzg5Sp18/Jvpxye2N
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

Remove IRQF_ONESHOT from devm_request_irq().

Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fixes Petre's comment.
- Link to v1: https://lore.kernel.org/r/20260227-abp-v1-1-b6fed0545852@gmail.com
---
 drivers/iio/pressure/abp2030pa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
index 4ca056a73cef..b44f1bf4c633 100644
--- a/drivers/iio/pressure/abp2030pa.c
+++ b/drivers/iio/pressure/abp2030pa.c
@@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
 	data->p_offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
 
 	if (data->irq > 0) {
-		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
+		ret = devm_request_irq(dev, irq, abp2_eoc_handler, 0,
 				       dev_name(dev), data);
 		if (ret)
 			return ret;

---
base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
change-id: 20260227-abp-016a007ab817

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

