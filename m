Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52544C4E5
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135876; cv=none; b=ZcYPiT+9HmajPPHUdybquBLG9Emd+9Vm9AMj+Mmpr7L5emhAUqsxVnMGsmZHJ2dPUg1f5h5AiE3XN8HEhyRUGb61KZGIObZ2vM+5JmTS9WCF8Erdyb3xFcyZrSzO0afJC2tg13CvRPS+/CcP0H77wgAG9lAn6zgb1U73M1YNyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135876; c=relaxed/simple;
	bh=++TIoj3A+M0JZYDAhLxTeZGLyZXNpK4xhfOd+Cc89Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm/P3/PXAWRiDe6ryc/mPIytOIAeZX8MOz/gK7p8c7htXUws8vji4wUdY7778uljKiOA+NIpsWDSNDnEgldO0z6XLyxm6Hnog7CrxUOR3yslWIgrrfHF2U8zDlPv5cchOjOY1mgmKmfpxBrzi/XZldrYeBgY4w5RmenbaNbHSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDKwgUB/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDKwgUB/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso6963625e9.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135873; x=1787740673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRygmPAwDhxGh7gR4IpZ9izP9D1E2/GXlaAymzaHHWE=;
        b=dDKwgUB/pckPOZdI5/tF3T3LI6X/kF0xZOoIhzRC1tUU6UeR38kpyGhWnVKQ+UfEN5
         tT+JzzYJWRXxTj7FyqT04zI6fw/8kOYSt2tDILKxO195VDus8hZYTQ1Uz9IVpWS6RTX3
         uvMwt2Zyp1w1Gw5U4yuta5FlcFeFUJTlhcv92VElqYOMstbcLF0AOqDW1pOuPVnYCmEG
         bEu3jKaySNn7LywEvrYMtpx/c3jgkQDw0Z7adKS+KzTrQ+30jHR8q4Z00pgwXp6lpy64
         S3nog8kqi+bbfTYsRFuyoQ/9dkxCXblwtCmCyyICY28EofCBekUe3Peisx1S89bhO7f6
         qV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135873; x=1787740673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRygmPAwDhxGh7gR4IpZ9izP9D1E2/GXlaAymzaHHWE=;
        b=H7ZhDaHQD2edWyrY0rho3kTTbMtzlo2DI+wOhmZ2XR8wFQYtiJjGqObVpbu7ylAQwt
         jqCyKO6UvZ6IqMr5pgK9jII5oDUSEggfpy8pSp0hcCojWuvuCaCCL6wLXTB+LBiy6rQv
         UnSngmxnnh6AqxSY4hAUjVnLWfursYn3ehZx5LE+xhezBc7wWI35usz5KcO8LoQF9W5k
         8uN4O9+lwSvG6DlPvl7aqrQ3yVRkPgulq1EEJfG9T3KKXF8ozRt5eTMSV1qL+9EQ3Jdv
         i06Oo3fGO5Ko5yF0ZEIfXHHov5NLMsXvmEJng2LtIDrpRkgJbMZRDcfVleIUFvewdwYN
         GoxA==
X-Forwarded-Encrypted: i=1; AHgh+Rrso1eJLp4QUYOwJiVFn4+YFheMul+DkSZVJPwxccY/YY6S50dnVsfHA6rx3oI3uopL/t9yVy3zeFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80NI5JUgAsb7rHJkjthTwBuqlgNvCdvL9EplpR5NJB6d3GDNQ
	yRNH/k5gq9BP2ZmYT5dOEg5OmZpUeuueXs4wC3cH0AnyPcoU4SzRrqzA
X-Gm-Gg: AR+sD11p2HUeV19z/4e9OwyDNxySn9nUSxOH82Bb6/DQJbuTvV4aSL3nm0l8rRptXfY
	fwTShhQ0pgI1OmbqPYyTbq6o5ShdF5fjIizY9WWxzfc3Wkkmp04e2KkTwPsc0XXh8FqofWO8pob
	cR9eKqoJz9joyT5HJBQypbgBKybrj5RceoiG33EWY1/w+ieWGFevh6mnYC5x2WCqamygpZoA3AD
	JS5dSCItO8Y8C96ICoaBQ8MP34QBvNfhr4huKWBJAfhTQ0FQ9rSj4zTn5KP29liKdVaInUbiudS
	LSb3AzPqqIcn0mwPQoUbj+ZcNvOF/pFcykdCUctkNsaCV3dXQdVKKt9LVRSB/Kqb6a15EcdQTCC
	kdGDmfwWTALxUB7PEoEWbt1J/pGu9KbrawlOERH5uSuGyCA5QvOvv7UVecDoD7HzDUvgvkSjIyg
	DQvxKctYlcFbgD3ktmJJmbdw01hCQZyEeKXrDQDqTqQrrtO9aD2Opd3U38YEK1KA5FOVQJKvVMS
	u5CuNAvTyg3C1WxopW6IeWlvvBvL2V/UGIeNOWxWxbd
X-Received: by 2002:a05:600c:6990:b0:499:8c68:a3aa with SMTP id 5b1f17b1804b1-499aa1c53bfmr63160515e9.13.1787135872768;
        Wed, 19 Aug 2026 03:37:52 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa11f832sm50175655e9.7.2026.08.19.03.37.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 03:37:51 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
Date: Wed, 19 Aug 2026 11:37:46 +0100
Message-ID: <20260819103747.31722-3-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260819103747.31722-1-grondon@gmail.com>
References: <20260819103747.31722-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), which takes and checks the buffer size.
Both sites push data->scan, so pass its size.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/accel/kionix-kx022a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 93104fdc74b5..06ae7e540ee6 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -863,7 +863,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
 			chs[bit] = sam[bit];
 
-		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+		iio_push_to_buffers_with_ts(idev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1033,7 +1034,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
+	iio_push_to_buffers_with_ts(idev, &data->scan, sizeof(data->scan),
+				    data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.50.1 (Apple Git-155)

