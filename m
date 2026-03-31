Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C83BE16E
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941932; cv=none; b=cN2p25KJK4By57BM/HkEje/cJy2SaNI4LZ1IrqSt+jiTqNxBkCgrmVeqm+ddzd79j99GptrGZP2Fqlyp70AYTTCPVemIxFVPKpCOhPRwj3lIdp40pXoJhdoHpJO8ekuNEaMPFqKschK/RSxwnjK39GZRnTlosenK8df8DRmkN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941932; c=relaxed/simple;
	bh=GnqjuQY2SpYNpEiu023jp+jx3wPKs2w4MJgRFZGBcBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEVTY7zT8p7IueOtbJqqDYNT9EZ4sSTxiZbOC3eVxwvhVLuse/a4iM/Cl8Ts0ZY59fGd71NKenm0AEZ+pGjMKzWbUYGAcVf4p0Ilgx65wm3Rn5rMhbXak/PBmqeMbhZbg+UmIQXHCyfTIR4hBoTax+7Ni4MJZeTD82lnVg5GsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS+acAMf; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS+acAMf"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b258d93ffeso9108515ad.3
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941931; x=1775546731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUTK122ypo+0e+etGwYyhErGcBcCbI2DEOZyVvoyYr8=;
        b=kS+acAMfaUeDnndOCHFAvJoauEGmKeKj4d9UWvwJsFXKc3NjFg0GoVeQ6XPLtIx7SY
         P3SyW8CMIjT/oDEvbq5cSNlxOP/fm5ujz74bbyjhAq3BfNquYSeck4J3T4/TxVqodSa/
         oC4kDbs9CVMpE2jcwKsLWGzQQfrnJzB/NABIZTIu+GmLgK+EayaVCgNfK/4rYeXlw1zk
         D4IZ90PvT5SOb0DJz2mRiR1JUoqeMGE1aUHC+vC73KJyYWyaKvmMQ8OskwOV945BzPZU
         tGDEp4TiKJ60pIUcxX+r6VZCNqzav2dkJyVHqdngGyYsISycIgmqlj6tqsDSonO3JRpm
         c3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941931; x=1775546731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUTK122ypo+0e+etGwYyhErGcBcCbI2DEOZyVvoyYr8=;
        b=DKjRkYPnUwi7TFowfYNnDZKsucuSu+cMI3CztqaQsUjf9+2nkSGk8gerFORuG5O6c8
         Xw2joDWyRYv/UVOBAA6h1U9zHDuV5EhtP5wBFYtDkBAtQdDR/u1enRbh2XCXedo9+TL8
         kyBDLHRYkeOkV1CA+p0ZwU2l0dh9BpCp5+ruLrH7zXopsEQdcj3R3vaqDBQSEmBLOWzA
         Q4SuAo3JP3CPiHuTlNJVOgvOlGzFocJIBydEdi+07GeXhHx3SNzwlSu/+3TJ2c83tk/4
         6u0R1saBJW3zul6E3Kl64EsX0R5m6ip2/EQuUXbqdSgs024YBx+JKAb2GekaOernO3Ly
         DZGw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fNhEGDsppMfs77tkPsfHwRlbBrtYkXhvdKNjFqUfB2p0ogrIq4HqsF+pxI+KcCR2wR7dmRr2Jlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpUPpUhP20a7dxvTTf+mgr8z40/8+EIY+9GEvpHKpYgYs6sjY
	qcbBUgkyV3rFsQqYSROaEPM0iY5d/4qIdDHwnbIVUSQTNxCflUnUXM4v
X-Gm-Gg: ATEYQzxHl1wbkeHPWTfFb9RSOEZD6WfOCGR2GMcLlCAlqEBBwIjog+pZYblnHLwrng9
	55mlw1+Hbj+QFo9UueUTkHqaabG5tJCIURQ8m8qZC74J8Tram7pM31LZl1Fqj/cxr6x0snWZDoG
	wIAHykmc+MhbT7FPTrt52iQvGJB+AOaNrJ6dbO1HmuTtlsxiFjSPNcb6w4MJJcq4gFGrQeGluUO
	hQpAdn8A8tQQzd5gghWf73WpenhND6jWqj2orTPc2+rKYll4/jH2KZjeaKI9B9/sReAup/NLIJh
	drJSanM5Flo8x7PrEX2aWfyb8powdhW8cmar933ESH0tm2NYbpdEL3wIDXo5PDWQIyMvh/zKpdg
	FW2WW8FKOdy8S9/w2hhcV6YOHrmmH6AQ/NmvlnUnyh4naosD8a8cOsc/vYJ34ApnhS79qD5Xo8X
	tspJkOOWvNLtMOSE+MnZ5ROgt07rBQtT90dwnYOi0=
X-Received: by 2002:a17:902:cf0b:b0:2b0:c90f:449c with SMTP id d9443c01a7336-2b0cdc22e03mr152495895ad.9.1774941930836;
        Tue, 31 Mar 2026 00:25:30 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5412:6527:d590:8704:ff8:2ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm109272495ad.6.2026.03.31.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:25:30 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v4 2/4] staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
Date: Tue, 31 Mar 2026 13:24:51 +0600
Message-Id: <20260331072453.6530-3-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual strcmp() logic with sysfs_match_string() to simplify
the mode selection process. This reduces boilerplate code and
leverages standard kernel helper functions for string matching.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 9a2f60b97..253ef2262 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -59,6 +59,11 @@ enum ad7816_type {
 	ID_AD7818,
 };
 
+static const char * const ad7816_modes[] = {
+	[AD7816_FULL] = "full",
+	[AD7816_PD] = "power-save",
+};
+
 /*
  * ad7816 data access by SPI
  */
@@ -136,14 +141,14 @@ static ssize_t ad7816_store_mode(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
-	if (strcmp(buf, "full") == 0) {
-		gpiod_set_value(chip->rdwr_pin, 1);
-		chip->mode = AD7816_FULL;
-	} else {
-		gpiod_set_value(chip->rdwr_pin, 0);
-		chip->mode = AD7816_PD;
-	}
+	ret = sysfs_match_string(ad7816_modes, buf);
+	if (ret < 0)
+		return ret;
+
+	chip->mode = ret;
+	gpiod_set_value(chip->rdwr_pin, ret == AD7816_FULL);
 
 	return len;
 }
-- 
2.34.1

