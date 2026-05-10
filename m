Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A525369992
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401567; cv=none; b=NtsTJLCcG9djWmyilQepkWBztHZgjGVc6+8i+CFtD1mx3L7xPuGjZsJiIzsgLGWvCfXTN3UBsh0Xb4ythbNpmgLrFBBqGD8BQn/NKypc9eUS74e6Ds1CSUTTpsOt3LnIE9rKKDd6MJhkJBPCFtoERfWRRyHOBnuX5K+Kmlwogmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401567; c=relaxed/simple;
	bh=nYZrEY7KG9ZK10b9Ud7KtTNU46e+jny4vSpyn9eAOTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0nxm6CkisVg8ccuskp6i+9UZNeLfCZx91KqhZ6DqMinTmcXUSGdyuwlyDiGMUMOwpUKuO+IJ+YNUdbzYZkS2LyAyyYNQQCEWwrIfpjxIL/OoVyjXF5s9cBYUhfVh5aoXqee5eon4sfdJGcXbvNhQQ4fV6B3ZIaYgGwbBvrcgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjcZapl5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjcZapl5"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so29526431fa.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401563; x=1779006363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INMcp3DTrZ6y8PF6UoKwEHyyPGgN1wy5BQ5jP3W/yjU=;
        b=YjcZapl5JdCEoM5X7A8o+14P0zAeYu75jVXLSzJI0lp+foyDMYJKFKt+jAU1BRrzb8
         5MJlQxDYzZulUl3AwwVnKC0ISn8/9wGt1h7zZhQS1yjPvQBD4X2T/ddBxasocR0upQAl
         eWKx8BvYIAKa8L/no2w5PURu1k8fSi85Awaev4tGmZ3Uz6fxouguZ7A+IL3oWuHw86h6
         gc/Q5tRuve4ElNUmGj2LZJz61m6lwRfIq+fXLOBVzvUcwQ4oIWwbbcTXpV5xDea8Wh8T
         rpr4RkofW7XVhikq7Hxus9Stjwih9s8yG0+Lhv8iW8oLBEM9zBeZUGNRGVLgIVRTeLX8
         aQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401563; x=1779006363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INMcp3DTrZ6y8PF6UoKwEHyyPGgN1wy5BQ5jP3W/yjU=;
        b=SQ5IzmywbLJWVQG9/QORd1SE6RoIm/2uAeTTtsDaScGudVS/iyNd2NXH/SZbQrmSZR
         1tSEIHvpI2eVtuo1ooXstwbdWxuhfu3K1THZ9PuZgytfnEfi+qbmMwpB9J1uFJgNMN4t
         yfH6AL3vozv8w+L4i6xLUokhrw+E44OPbVDOxqFtAEUT/kp69LJGJf/4xY/kQcpxiPz9
         bWt+mug9YMHlechaLNZBY/ASzpZJNVHbwI8cLpzgqzu1YTWn4evDlJgonp3Ln7v/xEFi
         zx5vWwlldTQ5xETMeJKZiHwGBZOcEZX/itaPrFTjQaWadXUpebbnb0CD59AtQEJ28M4w
         9K1A==
X-Forwarded-Encrypted: i=1; AFNElJ/6ADsGAbYGd/JEXsUYnvIQlEoPwxaqEKMEFTfyq3VhaEHPYpfesIyPjOttbBsWbJj2TG15/AXR0K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkL1R/UK41VULHcudHnGc0PsWNEtay0goljyKDglixYqOqPR9
	FHejJr5834HRREPtclyjdMwLWwWbyHYNxuo6IYeAM671VYYwk65YHbw3
X-Gm-Gg: Acq92OGs8XpOYGXekrzM+8u6qt+RaAw8YzyTsNbB/da219ubR/HO5At9Rlk5aWXPWk6
	iovOxRO7GcOiGCe/yw19jqSbquIB8naDQ5V/QJKulZcXNElGJtW3FJyNO7nwpeWNs0BenXekrAm
	QDvKmHf2KwFtkI2XfRcGYpyDJa+ygRXeWqCBnFFhgnWnejT4/JXue53rNtoSVJSVJ3ULLXpWrzU
	H2IvjrRiF9Zkcc/kY1Sy4s8QGsALVtEFx+SJ/R1+uyv2BLIz763HMAwSzZ+YD3w6WNRd1j9Ce07
	PhUwQ5OKMgmPRvTNH8pfwkYEIT5D1aSfSb20/IqTn5CVcs/BZxBfluUj7l95H7s3XWWlu9/mEAn
	UMVBial5eaMYN0YQfF5i+d22bf8RYbbnudgWLD8tfV/rJdcpThcVG9vDaCQ5d2gX6yyk2nEg9x1
	RN5KBKGB0P2Pcl6J+tNL2vZnAo/agsrZiEXAthCarTnrar5FVheBlLImcEm8R2i5sp
X-Received: by 2002:a05:651c:4017:b0:38e:cab9:3637 with SMTP id 38308e7fff4ca-393c41c2df3mr43981161fa.18.1778401563259;
        Sun, 10 May 2026 01:26:03 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:02 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/5] iio: accel: adxl372: Add timestamp to FIFO data
Date: Sun, 10 May 2026 11:25:52 +0300
Message-ID: <20260510082556.3867-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260510082556.3867-1-shofiqtest@gmail.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver pushes FIFO samples using iio_push_to_buffers() which does
not attach a hardware timestamp to the data.  Add a scan buffer struct
with an aligned_s64 timestamp field to the driver state, capture a
single timestamp per IRQ with iio_get_time_ns(), and switch the FIFO
push loop to iio_push_to_buffers_with_timestamp().  The same timestamp
is reused for the event push call in the same handler, replacing the
duplicate iio_get_time_ns() invocation there.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/accel/adxl372.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 545a21e5a3..521e8313b1 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -367,6 +367,10 @@ struct adxl372_state {
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
 	bool				peak_fifo_mode_en;
+	struct {
+		__be16 channels[3];
+		aligned_s64 ts;
+	} scan;
 	struct mutex			threshold_m; /* lock for threshold */
 };
 
@@ -703,13 +707,15 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 	struct adxl372_state *st = iio_priv(indio_dev);
 	u8 status1, status2;
 	u16 fifo_entries;
+	s64 ts;
 	int i, ret;
 
 	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
 	if (ret < 0)
 		goto err;
 
-	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
+	ts = iio_get_time_ns(indio_dev);
+	adxl372_push_event(indio_dev, ts, status2);
 
 	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
 	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
@@ -733,7 +739,10 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			/* filter peak detection data */
 			if (st->peak_fifo_mode_en)
 				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
-			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+			memcpy(st->scan.channels, &st->fifo_buf[i],
+			       st->fifo_set_size * sizeof(__be16));
+			iio_push_to_buffers_with_timestamp(indio_dev,
+							   &st->scan, ts);
 		}
 	}
 err:
-- 
2.54.0.windows.1

