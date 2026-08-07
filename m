Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE22D0C7E
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112398; cv=none; b=nDCKohvf0xC9VO0ifk0Gvv+TPym9+v3YYnwpLjDLMw9v2DUUarVkT6xAwWAqlb2KhVqM4vbOYEYzRmWmzr7Y+0x3IvS4CBcg0DocIKhwBEu3ZaSH8d/DusgK0Bh/lx1himYRImHBUhxQPteStYqp9FrLhZMH4wudAYJyM796z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112398; c=relaxed/simple;
	bh=9xZaUz+b+BWl6IcZCMMqXWOA7QSl29Gyoda6a9Jb6qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qh7IfNqUHs/7vN4qBQrRbPXlCwEi/5ttX1WCQ2kixJP/qLLHdfsA6uNpY374hbCjI20zJWbiwjhJ0yXFi4zWrD6YT9wtFPGYb+MvEtN9QE+f2PnXTiKWq8UgciB5I4TihoSRWGrEdTftACtbZukzD1THnDhRC2c7qfLTvtdKXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsVOO7Zq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsVOO7Zq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d032846c95so42935925ad.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112396; x=1786717196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fg6k+823sa8zpOs3kR6BQUK6YT6riyT8/cMRVnCyQtE=;
        b=gsVOO7Zqj1JRa3Pi/b3S6A2PDb184FGx1OOuJn2nqUFm7ywJsBCA0Dt4i2O4HE761D
         RyCVfKhiJSc6x2udi7AH9RgeXnigiaY872oPZJtz0rk7iwC6lims2yrxs4y6sLIGShz2
         QBH5W4My+UGV/AwRmzDc99GfEKIXRwexLdpf8+wuwkAPrf2lfl2lU6vgaiS4iZzo8yg4
         0XEZE7Yq0wjRJE4Y+hYzvDACqHceqoQ8g95snYmTHuWwBq8meM5JmFkQgv5XsyzzNLW6
         K9tI/Z5ipTCBzpxwQdiiKH23cvRo0s4mXo9LYFbu1pdvhrHFp0gW1QJW1AeeKR4ZsAYI
         Or5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112396; x=1786717196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fg6k+823sa8zpOs3kR6BQUK6YT6riyT8/cMRVnCyQtE=;
        b=CiwpMgSPPzEjgTk1A++ELSUd33TP7AN57xFcl7l+baAOdZv18XSYU5BnU5/26vkJFR
         YZZZzyDo+XmDB2nFTcOWzk+xpOBbQRYzgwzqy5ADQBrv/acC0XgmIP7+ATQLoybwgmpf
         TeNh/OkNDng1IWuG7hXXHcOvcRM5AOF3wTDdau5tWW9us6zbcDI+IAcH4utWk0i7jBKX
         nuFQ4bkb2nG9Ygynzs6h8hhJEUlpipUsIp8rcJ/SglkdADS6l5GVlSzSkGwnWSwf0eQ2
         aWW1vDzVGnA6ildgeHltejTHe5PZ1aXEAUKF4XqIJC4mj5+TLCjj05QTdY8CcoURHKiq
         BBWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoamPoWP/cAADfgpTqE0hGLVXgq332v893il+85PtGINqbxUjad0Jdjp/fW8w5iNbqhyUZ4LFuymn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijzEjP4XUh87OJQq41sP+x26QGGtRYmPBirV91+Xm6hQ5X7nn
	f4tpxYvRILyIAEqA2mnsoBsvRet6UXWYJrl06J+zP9a8tjs20PSgHIK7
X-Gm-Gg: AR+sD133PrKVXVtsqhW9o9NTk17U9u26NDOu64K09g6c3++L1dTBh2ss9t6EOGTniOO
	ts4A1SCBGZDZ4VxaCffPnta+oUFj2daLzXQU+mgXJf8PNOdi6KGJOZr79sTeZR9s1vhbJMbknvM
	JUjYrLoxg7jUH3CqL2GdwEc4zYOSp4Dgfs8rIiTMO4F/IKnuzon1WfejdOrnzk3GdRF+MIwXgfk
	tH/yO5RfA4Rmjx4aD4JBV8L+6iNpp2XoCy5Yg4hyFE0byBnaGhwD8Sf5b+k4ErJLap5aCbCUvMS
	b8fAa9DwyioTu4ovS9XMhmZY3OreDnOQTCPNe5wq2bPUohE4jocgzuV6vwgE2YZsLsSbgwbwaY0
	wPKLawnVTYCXOLuvvZKwLNVba6JW7Cac8CSzZrFtoAD+66dOl/5y70KaPfA9QDrOYrJTP/hHuOa
	P98sOclW1y9TKsbX/WJyBsbvkvtpq/VnAv+jba5emoYkoWevVLuj5AuhyGDg==
X-Received: by 2002:a17:902:dac1:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2d0ca71b3d7mr260043035ad.8.1786112395789;
        Fri, 07 Aug 2026 07:19:55 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac104sm10196345ad.10.2026.08.07.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:19:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend cleanup
Date: Fri,  7 Aug 2026 22:19:37 +0800
Message-ID: <20260807141938.2491195-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

srf04_probe() calls pm_runtime_use_autosuspend() when the optional
power GPIO is present, but srf04_remove() does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

The runtime PM documentation requires pm_runtime_use_autosuspend() to
be balanced with pm_runtime_dont_use_autosuspend() when the driver is
removed. Failing to do so can leave the autosuspend usage state
unbalanced and may result in a usage_count leak when the autosuspend
delay is negative.

Add the missing pm_runtime_dont_use_autosuspend() call in the remove
path before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 2251157b335b4 ("iio: srf04: add power management feature")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/proximity/srf04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 7be50bdebfcb..5f270f506803 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -347,6 +347,7 @@ static void srf04_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 
 	if (data->gpiod_power) {
+		pm_runtime_dont_use_autosuspend(data->dev);
 		pm_runtime_disable(data->dev);
 		pm_runtime_set_suspended(data->dev);
 	}
-- 
2.43.0

