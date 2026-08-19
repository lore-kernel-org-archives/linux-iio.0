Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41285430305
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135874; cv=none; b=UyC0akuEoYo6HRvRM9LEX0YHBxVQRrJVitmAo6h3/rZf/ut/NBwn5cnt3Qot5YKepWSJrYpVPG5DZRC8veOZYXhkMHqat82wsB3inxA+sqJngdFn2EBlzdMDtxFCv2p5Mem8dM4ccA6vYiruArngHDmFXYKa1JiTfe0nl2nnOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135874; c=relaxed/simple;
	bh=c0R41hvx1GFcVYIKU+06pMPrMTmvcjlK9rOaHI3JxOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPiSPt+CKI3dB+q5IsqooeY3Euig50kbdh3A0IxSmymx9QcciXlB7Anga/iNGnwOYQfIWanu8E1TMaoEdMMdeQUgt2z48Zd4WtjidqXerlDzuQ8ogMNIIMJEWkQavTOxUqovYXKqHvjdYyQqmSSFKX4OahXVhWhoh/m+8i89fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXr/kNBe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXr/kNBe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso14388275e9.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135871; x=1787740671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMCrthaBVfWDJd5B2dS2stVmvpF4m+uEhT3/lYlUiTY=;
        b=MXr/kNBehPJlj4IyrjH3vwQ3mWOKeRUaFF+st3AnicQXlhxP29O5taS4FmTzisZSie
         hCcSv5tE6Or0+GcSg6cm513tHOtbQkRxi8FUNeWl6JMbp49lDSiZf9cbyHUqp+zxF8J7
         WoQBauI1hPAKsZk/wts8d5E1jnzefBg0gKPwtVQb7QZehCtQnZnJ579KM3nYRN2BjT0O
         7aq1LyxTBgWIrVvMA3PzpBU7QLsggS5x97ykiVJbCkkQ7p66DBs8R5uXQ/95EEonUcM1
         4vxmUgZlXgoV7TB6rVqT4sWVNOV0iGZF5DMGYfSCE8Ns/KpNoRFAMbmYpj7nd2zQMy38
         +Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135871; x=1787740671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMCrthaBVfWDJd5B2dS2stVmvpF4m+uEhT3/lYlUiTY=;
        b=sWDZllBCLjGM7WyBb4T+685rOCwuw+DWSAuC290pUI0UheMkLDXO95sQTW+oAvh+sc
         9Ope2R1ZTI0oapE8OvkUl1Bu21JzQdhE7s6T3WJgRJsKsZw1/dDEWJC1U++X8JxZWalA
         5OhSiM5m0Mn8ByZhRoEe9cDxSXiDBNEIH3dx+dIn9sRzeENUDeQplp53JM/kJiC4+HPT
         v4/J2uLosG8XyJWmkvuNexEbQ3NEUObyYFpvku03M/V1k2jVJ9WJjI8it7EYHcOIJ3oU
         IjWkKC4wbgMOPxjhljrYUT7cQMNiyL5jzUwZi8pCQKRho1BieFzczSU0R/KpsfnN5reG
         Ds7g==
X-Forwarded-Encrypted: i=1; AHgh+RqSjGf0FkhaEbXEhuj9R2Ud197FH9imjWNLmgF0EWvBUjOG2SQ4MaYkU8kUMF0teG5gqEMiswrI084=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvv8ec8u+RPhCOUOMUrSfS5Kd/xhkCBPL+w7xRoKeTbdV672I3
	t9oSrrQ8g6r+vfjE7m+djNIk7c0SGUXMwLv0Fvph+xvvT/9ljvWzYbaIicPm9dtggtI=
X-Gm-Gg: AR+sD13I5qewXMLl8dKyeaw7LspyT2rseZdwSstiMa2CPE5AeGgUAzwDobxDU5Y1HbU
	K6pfcRH0QOyaR0H7T/cnvaTmd15stuN/5NOpRp11TlSwK5ANu1tlR9lhtnA5RWYE6rw2nvfoT9D
	0Iduvy/zVwEf4ednCejmcs9Gci3R99WhT+zVxt8C4jq9vVrGkrBgLADNQQcI8O5AJxf9C3yxKEy
	hvr4agh187U6Lov9q8xpEuA9lotW3h6rAPFFKlOVd9SOgJEwE97FuRPXljZG+iAm5xXnY9C1UK1
	/kGd0kRDcX2h/LhTKc+RPH/sXhD8VyxSzL9bk86Wy1cl+amSq1zEQyPZz8FWDp3Qjaf+p6+iiTr
	YRasC1ajjNwdASh0WdwrlsFN2ZEfPtlQM9D1sGVyy7Dr6G8C/ep6JzY19m8Y5roVNB7udObw4Hh
	t+hyUX6LOy1jgfUxklykDtukT+BX1fu2bM0kRsX81FYs2wAylUj1e4b0Xqys4FIcVl4oI4u/zRc
	CHQKxmddCgz0u7adzdR+4FCyuXaQRgAsg==
X-Received: by 2002:a05:600c:19c7:b0:499:a5cb:b7c0 with SMTP id 5b1f17b1804b1-499aa0e7cfcmr46654315e9.3.1787135871251;
        Wed, 19 Aug 2026 03:37:51 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa11f832sm50175655e9.7.2026.08.19.03.37.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 03:37:50 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: accel: kionix-kx022a: use scan struct for one-shot and trigger reads
Date: Wed, 19 Aug 2026 11:37:45 +0100
Message-ID: <20260819103747.31722-2-grondon@gmail.com>
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

The driver kept two separate staging areas that hold the same thing:
buffer[8], a DMA-aligned area used by the one-shot read in
kx022a_get_axis() and by the triggered handler, and the scan struct,
used by the FIFO flush path. Both are three __le16 channels plus room
for the timestamp.

Drop buffer and route the one-shot read and the triggered handler
through scan.channels, so the driver has a single staging area. Move the
IIO_DMA_MINALIGN alignment onto scan, since it now backs the regmap bulk
reads that buffer used to.

No functional change. get_axis() only runs via read_raw() under
iio_device_claim_direct(), so it cannot run while the triggered buffer is
active, and the triggered handler only runs while it is; the two never
touch scan concurrently, exactly as they previously shared buffer.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/accel/kionix-kx022a.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 02dd1db7a646..93104fdc74b5 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -301,11 +301,10 @@ struct kx022a_data {
 	__le16 *fifo_buffer;
 
 	/* 3 x 16bit accel data + timestamp */
-	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
 	struct {
 		__le16 channels[3];
 		aligned_s64 ts;
-	} scan;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_mount_matrix *
@@ -611,14 +610,14 @@ static int kx022a_get_axis(struct kx022a_data *data,
 			   struct iio_chan_spec const *chan,
 			   int *val)
 {
+	__le16 *buf = &data->scan.channels[0];
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
-			       sizeof(__le16));
+	ret = regmap_bulk_read(data->regmap, chan->address, buf, sizeof(*buf));
 	if (ret)
 		return ret;
 
-	*val = (s16)le16_to_cpu(data->buffer[0]);
+	*val = (s16)le16_to_cpup(buf);
 
 	return IIO_VAL_INT;
 }
@@ -1029,12 +1028,12 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
-			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l,
+			       data->scan.channels, KX022A_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
+	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.50.1 (Apple Git-155)

