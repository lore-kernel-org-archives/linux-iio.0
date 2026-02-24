Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9934D392
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973329; cv=none; b=DZhA1Jw7du2YIQu0uugOLrIdEnUTUdZhYemp/1XkAK9+3J7oXgviYpvK9/iUfl/PEaFNr2zoETjEbJG6ZqZwo0A4QKX9EVklXiRdC8fB6R90IoA43q8FRKKoG6XlmhfBuQ7mroLR+lwt2+sBMswbqHzIHMMHJS1QVrzBDGclMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973329; c=relaxed/simple;
	bh=nmugurTC3LquwwQ3c1ikZQil6rC8xY1wLp3DAB/gqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0qlzXVtiaEjstDakJpvqZnntXLTtIP0NQVhiaCyxE/ZvDg/aUcilpJEyuZ44BJemg/+JMSc0q4hh5b5KYT5wBqUC6VKHEngfLblf8kh72bKwPLQdqvW2tWAAfmAvQyIHUCMv+F7SGVJ18fUQUAoD62a17bMQLUPVgBWq32wPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC1JKzm+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC1JKzm+"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79827d28fc4so35395287b3.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973327; x=1772578127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRmBa3MakDv6vabRp84EIeQ9FVfS2U/MlXhf84RaaaU=;
        b=gC1JKzm+1up+NQ/0qjJQc0FUsas4V5RVB1iOafT+trxakAs5GWRYEG09jzWtDRHLtE
         sxXdfR17+1p77bnMA5EUJRkdE+xDa3yfiN684yVi/bsVXg/hf4XLUUrMGVRvDSRZ6pES
         wxgDsfn1MaeilaiwVyvJJakXFaC7KB0M4vNqIan0Jv8vw9o/kSZNF8lnDo1btZWPWO97
         vYFAJWZyMK8X26LYQop9teEndToNKGZnkDTHp15RMqBDrPPBGmF8h5LZQcZ7W9zVpCTK
         UOBZRcrDc91kBqlqm8UeFysDQplC/2peTqpJrnUUlgGNmIjNCdFhzBwM0naq2oDYQzS/
         jNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973327; x=1772578127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iRmBa3MakDv6vabRp84EIeQ9FVfS2U/MlXhf84RaaaU=;
        b=eFAGm3jbw1jEKE0RHwSx4VJokxrgMYieoVwwfaw+lBeSnFuky1zCIYLV5Xj4qMoUMS
         A2LpoOw7y88Oc/3u/raR3J4JO8y5dMhdkL+PmnBqQLTa3N/D/yY//qTYvUC5DCZwCIM+
         dgN/8argiwOnbnpm+OMSP6PLbDr+s8y281vQr5f25V/yTiW3HCSITWN4+4K0obQUFcNi
         l64rewxFMtB7fkbKDvcb4Vm0V7JJOnh7Dy+JlS682fkfC6tFVC5QHxKBXYmIpb0OV5rC
         lNPU3Nlt87GEkGEmmHYIZUsgzJthloq3noYSlTiiOrB1SAJQWPv5FBAuW51Hj5rFWn5R
         1pUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YCMM6TB/0e3tkNr9tbXDu7MRblGdEhszgu1iNkjLxc5zxqHp6LparVHB9O0hzUw+E+B7QeQQ0x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1b47cY9MK7gtEcry9cSPukBH5wuadKUUa3lf69U4R7nJ3y5vp
	CWCeOUUAosd90JhM/R6xBY8AGqzlX+Nsyq7PrbwlsoN1MnrcCtu1ykiK
X-Gm-Gg: ATEYQzxj1Xs4fcXKCwXPOeJGGpPKPBQo5Y9Si89yCxypP1jN/5XVhy7AKnfM+LniFKU
	xeHXjjl8tml4zEP1gx2Ii76DXPLK+exaMC6rf33IIxq8LSSVJGe30qrVs5NOk+2BHf9dPUp/H3c
	HMfzbjnS+dSExIqP/we8NYQeDgj1X5TpjEDNbBP101Et/BXVzMesgwGOGTqlTkgW6DjMu/zdjwI
	ohvjsWH5C8G0pqOTTVlKPWr1Dt0le1FJ4ohU4Bq54tKxnr8DbcImA7Bezh6MBqfuotQDZWK6P9I
	5e4AW/EeZhhDawFJGdEofLdDs3bXb71lodxRq2HZ/9LJPgv4g0akc5GjW8n5SnT2Dfh6yGVsRHO
	6+m/i7HjMQJsKY6/TNra2OD2XBeA3or9cTe4c8y9vfodo5r7YW1eB4He1EdSp8TFj4kqRvQC1b8
	2MeDp7NeX3dUqR3LXXAC5Ol7PEgkAa/OavTByjT8KG4iGgTWkdP0PmT0hjSGIv4a8pMJGfekwPE
	StA0ewcxeC6passj/9PNo1nxTBw+ODXl1Y=
X-Received: by 2002:a05:690c:101:b0:798:5951:f42b with SMTP id 00721157ae682-7985951fb32mr45275177b3.42.1771973327471;
        Tue, 24 Feb 2026 14:48:47 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm48838757b3.24.2026.02.24.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:48:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 2/4] iio: gyro: mpu3050: Fix irq resource leak
Date: Tue, 24 Feb 2026 16:48:16 -0600
Message-ID: <20260224224818.2452675-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224224818.2452675-1-ethantidmore06@gmail.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt handler is setup but only a few lines down if
iio_trigger_register() fails the function returns without properly
releasing the handler.

Add cleanup goto to resolve resource leak.

Detected by Smatch:
drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
'irq' from request_threaded_irq() not released on lines: 1124.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3: 
- Remove unneeded code snippet.
v2:
- Use manual cleanup instead of devm_.

 drivers/iio/gyro/mpu3050-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 06162d886b59..b6e05afbe512 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1121,11 +1121,16 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 
 	ret = iio_trigger_register(mpu3050->trig);
 	if (ret)
-		return ret;
+		goto err_iio_trigger;
 
 	indio_dev->trig = iio_trigger_get(mpu3050->trig);
 
 	return 0;
+
+err_iio_trigger:
+	free_irq(mpu3050->irq, mpu3050->trig);
+
+	return ret;
 }
 
 int mpu3050_common_probe(struct device *dev,
-- 
2.53.0

