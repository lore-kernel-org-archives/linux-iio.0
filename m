Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F638654C
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961062; cv=none; b=ntfY8mxA7jfumeRS+40HqoEQzHoqMKMpWiwCPAydYSSoW/d2RqaubwSV4GQDDJ4FmNe2hJ14rq1n/FMOKzUqVc6LVXvvRX8sR2QLXUA41rv5Vd57vOckvP2nMgFs/AbIW+9gxfyQEyiQlAfbO+Hoh4nvlZcpelJY/PTrXuAUbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961062; c=relaxed/simple;
	bh=A5fdWSepkSgmkvMJpmG5ZlnAONFldDTK+KtfLvuP/z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQ9IzaF/7c6A5eIqYGKh9hllrZ2q3cSWXBBxNQtgjg4vJ9p9xSUfwuJN5dgjKkD5xPrLX8PNemA07aFqwuj+YBHZZQwXyuZKmXHSScluk9KMM1tBH7CeDbjZOD0kAxGvNACuaNp/Zx6gTzCUMmxLe5uxMbzyAga4Q57U/0/XU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYB2LzjI; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYB2LzjI"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so650959241.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773961060; x=1774565860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLzLy2hDM9Kbvx/sb4ZAms8XilnjagJUDNjtCCjNGlk=;
        b=KYB2LzjI7l4fLmqKMSLpREBYa3IsApX/3fJ4tNkjphyXi7+vmBOYdnZ9ex9js52GxI
         NskSJgDWg2rCJ0pb1b70+c9qP7KzscU+6dXXas2E5vgFmyJbLc7+/Uc4rQj3aVn/Yf1E
         N3DJfbNr9ov1V78hyo4Qwc3IFmSpwdDq5VNjDDuFsYoH12gYheP7Bg1DqyowvfXdzZ6p
         /NYVf7XOz29m3TOjreCv2Hr4MGWNF1I7H2/cmCTSinPmU6DuqR/76ePltzC/IjCQVCAI
         YGqVietCHzKymwvAYpNSsLhi00R6vla4GEB+2vwnHw9eWgTYxWg7qUfEG49HRwZZGb/q
         iklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773961060; x=1774565860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLzLy2hDM9Kbvx/sb4ZAms8XilnjagJUDNjtCCjNGlk=;
        b=AFmvM4Oc9qao0gmInoSj2rNf+h72wwmcgnQlrxCZxKyXPNJlQgxN5fpThD8QeASByL
         4zXevPtP34KICRqQmUbsZNehshDnFNFG3Yiffxjezm9nsP5aKUh71xcWGyaqRqV/H1Zd
         d+QNd+CGpI6PT43KuBjO8T/aimMQc7EkqLyqL5moTPPeKVEdF6JZqgZd2Tew2CTpHo66
         xVAuKvnrq1K6Do7qph0BY26/I1kF+6qwgcPAmZlimuLA26u5Vpb0i1Tq7iu2jSHF8XJs
         6U9fpLrTNSfDat8sOUTBRdb9NyiPwpHOULoSS04ixUzvPJfYIQkDAUYHiM6XtEAGlhGn
         a5jA==
X-Forwarded-Encrypted: i=1; AJvYcCVjY75IiyHSJUyVlh7I4EP/y9GjAASBQWg8lN/rfuhXERR+tZwSIVdsTtANJDNfxIhvEUtsBLgQWE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nn/DP513QNpOWwmS6DWV723U84IeWveooc/JPDbzTnBe/FpN
	kVXttSz+yHI10o1i4PI77i7SMU0piZK1UXFuBmeX3UUECZOfj6VDnMeG
X-Gm-Gg: ATEYQzxntR+fry5pr5tcqieU31cnVLLNao8nVRgCL1SFeng8Xldcbomy0Vz9KWoTncQ
	6f04fLz7n5e8Myz7/OsY2/qc37PAf0OZ2JxeUo9hRbmenw3Kg1BuM/CJYrIyMSp2Ppzs/f5Jp6n
	/CzFNJoP21Jy4qYrbk3HCfApevWMyjC6WZUpgokSdE9MahtNyxOCc3ULTpQwc792Habt8C1lIUX
	Sv7DCL8XnnObbPhR2Zp/vfoAr9hquACBj6xjOOQBKewgbH9vfwK+t4DVtQRqcc8dTGdsNXpYv0f
	rO7JoigCDYxpAkwOhBqTwPYw7W0K7ZXVxv/W/rUbmXb0N+euRLrRYjIkd94bJyvvj2TEUoJYaU9
	T7TCxHOirKU1upN9jDnT7+r8DsddAg/vXjUWb5epWCIpL2g/pG4s13fUOWX7N2KJjYjbzSo6VAy
	1B+CnWIE/hUevnSPb002MzsrGnW/nQRljwDQ==
X-Received: by 2002:a05:6102:5494:b0:602:7627:6c4f with SMTP id ada2fe7eead31-602aecb757fmr653428137.17.1773961060208;
        Thu, 19 Mar 2026 15:57:40 -0700 (PDT)
Received: from localhost.localdomain ([149.102.251.107])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136bd79c0sm204828241.6.2026.03.19.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:57:39 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: iio: ad7816: use sysfs_emit() in show functions
Date: Thu, 19 Mar 2026 22:57:17 +0000
Message-Id: <20260319225719.73587-2-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260319225719.73587-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all sysfs attribute show
functions. sysfs_emit() is the preferred API for sysfs callbacks as
it is aware of the PAGE_SIZE buffer limit. No functional change.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..0e32a2295 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -124,8 +124,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+		return sysfs_emit(buf, "power-save\n");
+	return sysfs_emit(buf, "full\n");
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -156,7 +156,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "full\npower-save\n");
+	return sysfs_emit(buf, "full\npower-save\n");
 }
 
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -169,7 +169,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -231,9 +231,9 @@ static ssize_t ad7816_show_value(struct device *dev,
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
 			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sprintf(buf, "%d.%.2d\n", value, data * 25);
+		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
 	}
-	return sprintf(buf, "%u\n", data);
+	return sysfs_emit(buf, "%u\n", data);
 }
 
 static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
@@ -281,9 +281,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		value = AD7816_BOUND_VALUE_MIN +
 			(chip->oti_data[chip->channel_id] -
 			AD7816_BOUND_VALUE_BASE);
-		return sprintf(buf, "%d\n", value);
+		return sysfs_emit(buf, "%d\n", value);
 	}
-	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
 static inline ssize_t ad7816_set_oti(struct device *dev,
-- 
2.33.0

