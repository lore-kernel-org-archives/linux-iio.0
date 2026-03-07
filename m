Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A3369984
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878709; cv=none; b=HueWqOFa8Pb/vGMFB4mxGUyzdRAoh4cy/CxHpIEFQA3OtHYyuoZdKcwfMZmCv3d/tso9+Zd0oc0Sh3Cofh0aomtsqx7UGiXfwNZaukWfInC0xDhy/uWT/fsBaPZnq47kwaYhEbCTipV1ipJQXINqU6GzwCpBEcsZbEMawDCxu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878709; c=relaxed/simple;
	bh=HOXEPuFDHq4cAEsHy1JJD6E7KdWxcKY/1o1AGOXotRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1z2q6Cu4oNFeE4HipAszOT/dCdazYTApkEeVKIdJXEY6rSClpxi9eENVBT0FOkFIwnyYSUAqCPPaNzJbbkD+2QZlhFyDYHCpHIfbL4UiB2oFQSHWfzA9lACeiioYzIPHScty92BG+Y00v/KjNbGfw34mpeJKLx+1mGzRojXODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0PqeOpo; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0PqeOpo"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c739d32b72cso951169a12.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772878706; x=1773483506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqeU11PM/n3egwzjA5sFzLDovMDrITrNKIRs91FkAow=;
        b=L0PqeOpobkjJnVb1wU8pxXglrnKfZsUgABrT803n4OCP+QErLuT7qbMWRlYId9w6JW
         F3Wc/x39DoA80aRDLera0NJMQD0jmd+K3l2PUDW2MalRD0k+I9hjl1CbcDzyC3aK5y6R
         Qx803v1GjQkbGnJvQwpROB06zoKCwZlm6+IkLLQ83qUe5XmoiaST1YHOVxy4OX5wIcxO
         4ycWPm02VX2LTlyxW6DQpeJrfr7xCcMLxqVL00Oo/mhdPdUOQDl7MlscQRfsvhHqpgQq
         xJJz2O/BO20xiL7vxN7zeKAMHsUt2bbibwtlVpXqKht14LX04PeH3UfmlWarxxGOPIGk
         wMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878706; x=1773483506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqeU11PM/n3egwzjA5sFzLDovMDrITrNKIRs91FkAow=;
        b=F7x+S4fWAyGWrPKhxxVYX1wB/bDSIkcXIMIJOVfGiiYYyuQuK/eAGiBHEWXAWZcUJI
         wMCbS+5VKH5DAU115O5gIMgRezWHOgd1Nt1fxz0JD4pj9vUKT1Yhe0FmPf0GRe15ORjs
         L6O8TnG148Ow3glw0S3VRivAPA5WsEFga2gN2+tnsh3wUttZOAECbIcCRj7JFfjR2opv
         lDOA4CXXw0rN/TL9sZwHR9FU6M//hiM2DAskY0pjQ82+cLBmV/ex52K+gyprAm7Rfmrf
         WjwzEIof4j75FcogJOcR0r5Becw3DMRUB7b894Og0ruf0zYBN5IbuOVaczVsF9NerEjc
         nJCQ==
X-Gm-Message-State: AOJu0YwyMgV9Jgj7Cuo5QqlctWxK6GWdIn+JzlzNOAg0RPr1v2NB/Ym/
	USGKRSaJBjWn3/3Bv5Qy1Sd4BbL3492eHe84xxP6gOUUh48fvDUQvx9z
X-Gm-Gg: ATEYQzwfquZ6ZlhAAOK3MGlvkRJ95yHb3Ud4Cw+RqlAohmQwWzlMAJfesoSOtoXqXss
	HVj49HZrm6+6XFvT13r9FaHX6s5I6xng4HqeerYfZBIvGyIUbcL8IDXkytoy/itncXhRZx8YJxX
	b1MGPFWI/QDtv15yxmbTcfPEkwE/bicDGNuO8tA+pnisaRKb0DIRdI0UDtsgYNWpIxFLeuypxaV
	PGHO8hShJMdEX63hiInw2ka2uyqXMFIVrQXyAM9I86Pq/TJj0lpZffPt9U27cfq30pQK2Vpram7
	I0iSXSSL+Pe5eYwqQ8PLnjmMUhl3OLL6zZ9mWjOwD7QXBe8jpklwM+x7GapOwrBOPToBIfaEEzV
	pHwqmiz7aG3xpbOMz6t2vAaLdERugwX8YDMlG0ASulh0dZhvS/1y/OSVy2MqG8jEHpYK3nwnivu
	JT+fQGIxP86I94t88JRXVgOG+S25x2ejT9MiUsj4/0Fu7nittSQxasCyaBG5mvUFoixzJpezDc6
	FsdZCH7dMLJHVnwAcdIMDNh
X-Received: by 2002:a17:902:ecc5:b0:2ae:6ced:e1a8 with SMTP id d9443c01a7336-2ae82366e5fmr51558275ad.6.1772878706045;
        Sat, 07 Mar 2026 02:18:26 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7864dsm48381265ad.49.2026.03.07.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:18:25 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v3 1/3] iio: accel: adxl313: convert to guard(mutex)
Date: Sat,  7 Mar 2026 15:47:56 +0530
Message-ID: <20260307101758.50091-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
adxl313_read_axis(). This ensures the mutex is released on all
return paths and allows returning directly without a goto label.

v3: Return directly from regmap_bulk_read error path.
v2: Split into separate patch per driver.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9f5d4d2cb325..40f62c6f89b4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -354,21 +355,15 @@ static int adxl313_set_odr(struct adxl313_data *data,
 static int adxl313_read_axis(struct adxl313_data *data,
 			     struct iio_chan_spec const *chan)
 {
-	int ret;
-
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
-	ret = regmap_bulk_read(data->regmap,
+	int ret = regmap_bulk_read(data->regmap,
 			       ADXL313_REG_DATA_AXIS(chan->address),
 			       &data->transf_buf, sizeof(data->transf_buf));
 	if (ret)
-		goto unlock_ret;
-
-	ret = le16_to_cpu(data->transf_buf);
+		return ret;
 
-unlock_ret:
-	mutex_unlock(&data->lock);
-	return ret;
+	return le16_to_cpu(data->transf_buf);
 }
 
 static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
-- 
2.53.0

