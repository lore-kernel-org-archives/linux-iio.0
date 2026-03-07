Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6035838A
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884182; cv=none; b=u/qSnes9cqoq3eSFfvZWHjXW7d0OXZ/WyQfrG3BK0pHPVBx6n3rKJ7V4Wgqc2VUw9fFPYFOf2z81eAvJxevFdhkTE92HaPaV4ubgT9Rs/VcT2EzXtYrsIgpnoDSJVqKxoVCTaGI2pihoxtUz6T+QJ2jSePokEwh8bbWEo4HqkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884182; c=relaxed/simple;
	bh=6egIfbb91MwMvx9Dl6WFYBZFdRtaQ2U7JT3bwOxKCwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el0DrnFuJkWUUyVLiJGP/9FPlC841dF5JoAf9SrkvrYqte4094mSLeO18qnoTYuN6Rv/nAStVt38Mdvqe2/w4wg6eMbPEYVAb4WxQ6kbnpHNgHtUWFi8bO5Sf2dXXGcJSX4FdJ9S5q3iICPBjkk7+suOxssJqBwXtRiSMiS49X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4j58H27; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4j58H27"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82984c077b2so1368184b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772884181; x=1773488981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtfaivtV8h8Ixik8/FgW2zl+MoXFXqxu6ojz9mj7aT4=;
        b=L4j58H27IySRM89V1SE+ztqI18CxCcsie+Ft82PnWyJlXZtB0KlTmtwCWUJh4JNQAH
         bgH4tm9f6Ld7JUA2hZeVpgx92kGmw7tIRzUEe393AITNZ0FyylqK1OUx3t/yPU5Dlwoz
         kBCdsSOG43TO9e/JeL0H5bRnUjr0yWGTbdteKCQFEo4bZ2yXhP1XUFdbyq1NVuGaeUU3
         I63lC0b//tdgjW+5/kKim09KQprK1N9iwMc6MSzFBGFfQDL3TTGNYd8uG58VLhGSzobs
         GOir8UEjraGUDwb/KF9UI+qQia4ky6i5TuALG7hpAp3vGaYTD8UELZ6T4gXOyZPebp3U
         m+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772884181; x=1773488981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtfaivtV8h8Ixik8/FgW2zl+MoXFXqxu6ojz9mj7aT4=;
        b=A0QMU7svxwfn3lGzsWeK+AReg9zkwj0C0c/XlKb/yQhNLZnk8y+t/eGJoCYJifOBGs
         POQ3iqhigWySrAFoDPbUtdwMsq4cyRPEj8fYdijYdwOAOL+jA8fGQNBf/AaY/qw9XFQd
         tdx2RaZCBeml4bd2Ot3Q9RQx9o+dlU58kTuP86513DEl1QYpvRsWjJ5+PdEUPd+G3f9D
         OLfg+bf/EVrkI54vYur6B2g06ul67ZykpdyamAeJdQlYMw9dekqPdaXkjMOcP9hONM12
         Whp8jUlb5LWAte7Gq73+306Ovp6ZTe7TIlkv4qeTmBY90LfDVxr0IhVFOcSUPoVLicrW
         tAcw==
X-Gm-Message-State: AOJu0Yybb9jwco7OyPG13dss/Gq0aZjSE2DN9L0H8sdMtN+Hpoqv5d/+
	mfBLYqE6sEKCPq8xJLFI6RfLXN2OAKYpms0dD0wBR53JOtRYEpfyu/Tn
X-Gm-Gg: ATEYQzywK4QAGo0bOywHMmvjZJwtKEyN57m/uqz8iw1ydTy71V2j4lSntpnQ4sLdz3L
	DxhOvc5DLdV6z7wRt3lkCyVD6K2hBnGn1xb+XLkmeOH09UurByRhHMkWA3eHAPnBAabbq4eqe0H
	joI+V+JL2URiRmCPzLXfOU2oLDE3eltLyuUmxq34DD5rWDyAtBfHCqCJ8ilExLwLqHHfjsvgHVV
	MGXcqdi5XOVp1X+A0XEOTp2TjZ+1ZP9kMcVqyGWd5OJ7fN7sff5V6JXut4lUcddQsVzob+vCcmM
	do/ENr2IjpVI0BVW7c2DAmkUXp3MJW9enbiDZUnOjFkT3wYDS7wQq0ELXPC2lVPwMfT8wuMXbpz
	06QPjQ0MQAltmM4A7FvQGGmaTwi9yJW65xtYaZBeBRaX0QMpuWTylXRULPBdH+K2Ws+IovSRNvM
	iUekwvCZkaeGaN+NJhbCCr1AMwj4E5Lbn2ta8r0kYyLPxJRIpiZhi5s2Vmya52xd0e9lvR8j2+a
	nzBYmCIGfs+rX/xpL/ZjYki
X-Received: by 2002:a05:6a21:7a8c:b0:395:1511:7221 with SMTP id adf61e73a8af0-398590b3e55mr5239473637.59.1772884180704;
        Sat, 07 Mar 2026 03:49:40 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739dfbf4fesm4264696a12.0.2026.03.07.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:49:40 -0800 (PST)
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
Subject: [PATCH v4 1/2] iio: accel: adxl313: convert to guard(mutex)
Date: Sat,  7 Mar 2026 17:19:11 +0530
Message-ID: <20260307114912.58062-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
References: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
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

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: Keep ret declaration at top of function.
v3: Return directly from regmap_bulk_read error path.
v2: Split into separate patch per driver.
---
 drivers/iio/accel/adxl313_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9f5d4d2cb325..084037c89ad3 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -356,19 +357,15 @@ static int adxl313_read_axis(struct adxl313_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = regmap_bulk_read(data->regmap,
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

