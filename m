Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD351EB9FA
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683910; cv=none; b=HZANio9PX4By1B+z0bJNng8qbcv8br6oyXmAe8gBHtze5N1A84pcF1M7X/7a9N4TY6J5DuYYW+C1yz8lXvoaiV62hLRlZ5ZjRtGewYHJFCRTAMpquCGPxQXCCe1D9sPM6LtAYOOGOD6HdKuERC1/UudjOf3pgJ7K7tLzCV5D78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683910; c=relaxed/simple;
	bh=f/sFuB9+bjMQ0kPp1EVSOWQEaFRObYhbFLYrJIilOsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Non12/KBzVyviBZ8r7wRcSZm2OnBmk1CCMOyLsMhMdXt2FomHlG/BOgCDNVQONDHszylRt9UxzgXn/aBo4WSPE0jK24FpGZ+b+7h6dkZa+M9YQmkmTEMf0ZGbsF5cJzWBMtXoebt9a779weCulfQQMnAjN4n9GKtgRBLyEj1llY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhQTYWxF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhQTYWxF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824b05d2786so2287878b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771683907; x=1772288707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akUfgl51sy7kfl5xLd3bMZHEwg5tDP3vP7i8XniCEog=;
        b=RhQTYWxFoSvfJQ6AyPxZcAsuKGe2A6Kinb371PFRvaVVrvRCXRdoSOoyjJT1J6iWSS
         d8uvm06BVNuxstaP20OiGeLS0hsZKfha/6QvcLHa76I9P3Jy1BgauCglcv6auWUXNIba
         qEYXpNeQPZWp8SO+Z/E13D9+1pAScErXJNdaLLDg0EH3t0OBP4HUiKqwAK1fvTXLPDt0
         BssSzvRSsZaH+W/Uo+zvnaZX52LmtjQSqtrAnobJzxCME6iEWv+DTpqlPkmj25kRx3GQ
         XCbg2JHgwMECdW0xnuz/oVoEu8UF4+L3fwtmqUX5BS0wYCNIZHo3QfblEtXTL9/BYJKv
         rvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771683907; x=1772288707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akUfgl51sy7kfl5xLd3bMZHEwg5tDP3vP7i8XniCEog=;
        b=iw/zxj9rNBiIAos4PjcnErZrfiFtVEymKmrAOkKSQUEYB+tiaBIiLdLconSJbL90m/
         WiQHbtsm/K4+jKl4v/ABnkdtKC+PZ4LyBIxIRxlP8Qt6QWZTJaZdLG23zBXrJCYhdueB
         Pbj5nAbgjeo8w8Apz3JO3BVLDZt3gWWuvOJo/BcgLODqfBEVtWH3QVanKABTboLagwrl
         tZRHWZTqpSuQJy5Qd37vOIu6+tOAGwxUhMa7DmFqWVry1DFXt//mD5Wu5rRiaS3BjMPT
         YDJtkZB6mASthl2qbfQp5NxdjBW9OgpjSw2YBxPdOHGUTuDH4NvdN9rnoTHLs9LGh8h9
         ecEw==
X-Forwarded-Encrypted: i=1; AJvYcCXVVai28mIYPfFk8ptye2GGoTGFt5jUpy0ntffmENrDlfmWZqpw+/+/xVsmHtURlXis7omBQCG+RZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUfMOdoqsdvQ+XpT7GiybaKuj5p9/NaalS/vdAbeUDlwRRKJp7
	EtY+nKsP6VazZjCbbh5k1mjfvwKGh7WPd0x7NKi99rKK15nCp0boa7i6
X-Gm-Gg: AZuq6aIRI5WO9OppUW8oRpxvZtkQeIJfLk2wYf5UePF1QZxhIW21f9EtNXnR/KtvZ2T
	ndEyAi5ng47Jj/hy0LK/p7nZL48BxBot7RkuyGuq20ixilgdQnNZVVjl9/7ehL+NGQCCRUVFF/e
	yGsL71H/vXr6uM6QAsMBEMhRtn9d+UUoPWG9Orz4HVOy3Ijl72L02OxFUI/8rIhE0K89lQrckH0
	SpylUrDE7Rm5JKy+jtrL9HK8z/LF3VJXSCt3zhBNchzBqRQebzhQ0yun8o2aaCh/5e5PmmG7q4A
	tlm9MqSzaxqGt/7viGoyshCnKUMeOPmwfEinmXK3d8LK6NDSpkz/FZ2CcIVLtBdpJ5dBPIPcTKr
	aoASztYkqpCdBckv2CixLv4YGraZQZDE4Po8Fx9xZim7l+3FE+7HjjU3IeOg9AirFfqbrHBdFzl
	bERgoXxhLUoPDIqK6UWqrWsDuUdlKiUYvWBhT0dlH+GMZ2zRzUnfrgBkyHGa55dZQwyw==
X-Received: by 2002:a05:6a00:3a1d:b0:81e:408e:47d2 with SMTP id d2e1a72fcca58-826daa2025fmr3270739b3a.53.1771683907494;
        Sat, 21 Feb 2026 06:25:07 -0800 (PST)
Received: from tabrez-VivoBook-ASUSLaptop-X513UA-KM513UA.. ([27.4.206.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8764c7sm2273172b3a.42.2026.02.21.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:25:07 -0800 (PST)
From: Tabrez Ahmed <tabreztalks@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tabrez Ahmed <tabreztalks@gmail.com>
Subject: [PATCH] iio: adc: ti-ads1015: Use scoped_guard() in trigger handler
Date: Sat, 21 Feb 2026 19:55:00 +0530
Message-ID: <20260221142500.87016-1-tabreztalks@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual mutex_lock() and mutex_unlock() calls with the
scoped_guard() macro in ads1015_trigger_handler(). This simplifies
the locking logic by ensuring the mutex is always properly released
out of scope, while maintaining the trigger notification on the
error path.

Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
---
Compile-tested only.
 drivers/iio/adc/ti-ads1015.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f2a93c63ca14..582d30c07874 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -451,18 +451,16 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	} scan = { };
 	int chan, ret, res;
 
-	mutex_lock(&data->lock);
-	chan = find_first_bit(indio_dev->active_scan_mask,
-			      iio_get_masklength(indio_dev));
-	ret = ads1015_get_adc_result(data, chan, &res);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		goto err;
+	scoped_guard(mutex, &data->lock) {
+		chan = find_first_bit(indio_dev->active_scan_mask,
+				      iio_get_masklength(indio_dev));
+		ret = ads1015_get_adc_result(data, chan, &res);
+		if (ret < 0)
+			goto err;
+
+		scan.chan = res;
 	}
 
-	scan.chan = res;
-	mutex_unlock(&data->lock);
-
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
-- 
2.43.0

