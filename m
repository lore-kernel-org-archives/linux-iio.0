Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458253BED76
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003216; cv=none; b=ZVKobDMf2hMDoWyaop2ibzqr0tG0wxeLjMYFtT39T+EXZ6tc3/PqilVZt+7HMfOjwR2g8TqExHqYK2aEMSmmhfQKLCGRICE9AYDL2FdtIX+MbellneH4R0EN9fsBMimZ9PvZ0FyWIvO6Uwj/XbYnQ84QqyW+9BZnXfI+7fCJHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003216; c=relaxed/simple;
	bh=uvMuNKhl2md9ckDK0UL67dgKZyZldjsAwfjJ3rNNMZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mK6uNVXmvw22OJ4wAP8TUf+HSRFnNVzQukRvcWo1tevajqbQdaYD+ssSTlhxzBUHISIQ9JUVeqXrUH4hQPJK9oN0wKEtsHsfbD3IoJMlP3ZmEiCyJSv7hIke3JnhOJfupuvo1NnrFSzjQxbSevPj6ib0s1P4vZGGunMVU1YnC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBm1PqCZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBm1PqCZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3652546e41aso1991097a91.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003214; x=1778608014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thuhrm8tCmZJtgI5sGLEXt+cjZuKnZXihxMoA86J9mU=;
        b=BBm1PqCZIgT5CYuDLLtZnZ8JIbpOuwxz1/xyiBXIT4GCNBIc1Bv+HjJcAhxJa/LdNZ
         4+vSPtVWgosk6iAq4WWM/eAKVhLJgTIywRq5tfIJVQmWP1qh0LqYZWRJVcWy7aGZ+ZQq
         VMAZ3DWYq6vtnddD3dMe92PNv3QgxAjpf2GBBBd9CJ9T4rFK1LealL2297Q8oe2PZadu
         nzFRwoanX5g+wEMRtrucxrigB82kwZovDbbjbmx5tKHm1BtSjAhV35eL7FMt2vaHTgHA
         7LuEzh/uCjpN5ofcVVsOcnqR1dFDusP/uxL4eLiEa1gEpgvTbJ2ehqkmvC8dh6WRcNte
         QMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003214; x=1778608014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thuhrm8tCmZJtgI5sGLEXt+cjZuKnZXihxMoA86J9mU=;
        b=U30e+gFIgTKpARJI1Vv0ZKZUhLx6z9Ru33MdunQTXQHdr751bAYA7DQIWs31aHXn9h
         kut2jvsb7zIhrQ1IooCjXpd72ImB9raMQkD2K1gMBgRQeSiRFMvKSTiq+GIJ0RCufOoT
         uVgCznHDN51XqOGeU9cFlkeKWjUkUbbBKfuSfc0WnQ91S0tDHjPlsRWvUGC+aQeZRjq4
         RTrjRK1f4k2GYfP1AMXXx1UMEget5IpXnyriyw1g2wOVuxk449bnHP5uiKfXOOoO7Woq
         2SOXQoiibmHyBDlhJejPGbIjHiR1I/uzYPiPmBVhdYs3bdFhNHolpLltFb3b6NNk2KDY
         x8Sg==
X-Forwarded-Encrypted: i=1; AFNElJ861T2IVHdVM0LiLCVbXU7B/GvsN2YD6o7yNLPPBp9uCNWzS5FnuD1H3h91uk/tN6A7vI3MwmD4gBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQ5MwHQuZdRNbarRavJBV8hyplHK27EGWgfyXjB84dbCp3w1C
	g2IlKoK5ONOJ8t86ZmdD59bBT0O01LYmqyDcInys1st5+IX4rwE0U4KT
X-Gm-Gg: AeBDiev7BbNzmJdBmdoh5YJWeFIDx6tPMkig876sWbRINArpK/pg3Qc/R2JN+2u+GLx
	c3cOHzZTf12XilbXB9xPFgKnttAir+2ZC0Dj552eWz/YcbSyScPQXrFvzAh35UMEn2aXbPY/1/K
	h8yL9Vk3bMNFUvaZ0kN+pE45s6WJWVaMZV7Ts6BXygLMQtz33fnlMNQwxtqgYfeVVBK4Jb8pInk
	F2qTIVmBg6jnYP3aP1ghraFM1dxng9REXN2PfYBTgv5NaiHJf2f8JiCDjStIwlY6XG6BBF3AfDb
	p7a+BrFuzlVs5m2f4Ep1gznRFAQoi//uqOUdYU00J/QPq78JjS0w7UqrjFi8NKlGMw9fMgnMKcR
	8VWoBnk5/UN8htXOSKsuKcQXlrWaAA2W4DbVwhwUw/OqAgrQHAYjhwD7LIObtybowFQhkAH1Lu+
	uF7e48Ga2VwDPE60ILz53gMOe3Dbedm37zR4gbhK1JFNGiyUTIwq431XRWMfs2ANjW/cCJdQ==
X-Received: by 2002:a17:90b:53c6:b0:365:3154:7b1 with SMTP id 98e67ed59e1d1-36577613d3emr4259663a91.26.1778003214535;
        Tue, 05 May 2026 10:46:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:46:54 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] iio: accel: mma8452: switch to non-devm request_threaded_irq()
Date: Tue,  5 May 2026 23:16:32 +0530
Message-Id: <20260505174640.3998281-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid using devm_request_threaded_irq() as the driver requires explicit
error-handling path(s). Using devm_* API together with goto-based
unwinding breaks the expected LIFO resource release model.

Add explicit IRQ cleanup in the driver teardown paths to follow kernel
resource management conventions.

Fixes: 28e3427824cc ("iio: mma8452: Basic support for transient events.")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index cefc7cf4bd83..279a9b364886 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1682,18 +1682,16 @@ static int mma8452_probe(struct i2c_client *client)
 		goto trigger_cleanup;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev,
-						client->irq,
-						NULL, mma8452_interrupt,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						client->name, indio_dev);
+		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto free_irq;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
@@ -1702,7 +1700,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto free_irq;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1713,6 +1711,10 @@ static int mma8452_probe(struct i2c_client *client)
 unregister_device:
 	iio_device_unregister(indio_dev);
 
+free_irq:
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
@@ -1738,6 +1740,9 @@ static void mma8452_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+
 	iio_triggered_buffer_cleanup(indio_dev);
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
-- 
2.34.1

