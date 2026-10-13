Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA460415F1C
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902428; cv=none; b=QOe39SzklqspWYbfMoPwYWASm9k3PLsG56e4VcRkmZ4K/lrIMFV+3ghM/RxGmSkZ/m9C5W6z6Nocev6wIFm0B723So7GOXTPvf24z6xUUiNsph7UY6uv1AgvHhaOOoPehLsCZB628hxAN3N3fcb7j2v0jDsAEfixocdI39auBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902428; c=relaxed/simple;
	bh=MVMSdI+M6dk06WfdiVzlK7n2WbY8miUPIuSA1YW1sgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgN6nOySiA53NR0Da1r6rBSYTFkEpOWaHgga5G12OnJvkxWWdRIdWmgSv1LaDAlKBxsRp9rg7ovslD5fmYt0FuuLF6N3x3YOn8sWXPLRFMn5g66/HZ/mJnb1De9IGEsnY5tw/6aZ7DzLbf36sqmx543+kinXY1oPLNDwW6qRXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j14wXnIT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j14wXnIT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16c399641so30891855e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902425; x=1792507225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCWk7vUd5AaNbZ0fIrMDZxPpzdK6dUrXJVAN5ZA+fvI=;
        b=j14wXnITMxfOBrqf36YnqKYyzSqco8A8fU/rlrgr52kF21xZnHJxKM0azvG68K7qyu
         e2vnLJ2L9ec9lmcn8lI2uGEKeE/NAb3cS5iKokoIkg0kCDGJPoWzkS7jwBGx281LYC6O
         tQLqFugOz+hhN+ulSbun356FfrlK6MPDfrQ7ibzdjRVbcP1O1OuPm7Xi8ze8x0+taTvv
         K3Nb1+bCkgDl6KkPSEdohd8CIhL5r+KHiChjJSD1SXG3Yp2xpvvXcIAEdTqZ4Y1IzQMA
         dUDqSA1czUv8Pd0CmMKojLJIVgZr8bnvWv0TS0n5IiA2afQPE3XqkB+ehjCjUKt/zmoN
         XJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902425; x=1792507225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCWk7vUd5AaNbZ0fIrMDZxPpzdK6dUrXJVAN5ZA+fvI=;
        b=HEwkA4Zq/9RNqbnfr2TwyJSTq7lFrEznGnSgpDlDwYKiyLxfXZyEULR4bi1XLavgRx
         Q4ZiKlt9RY1I69kLNdmkteyOzyUU2AEkwqd6JYdE0iXnQxc7vZlRVlYGbbSaiXeTcKo1
         KiYf2lM/S6WTNutUmbl6wGdr5nlZCVTR4dzLtIsmp+9hC5oFPh/m22qy67++qFQ51XOd
         CesvIGnTT9evnPBcEU5X3KJ+6RCR/+JA+y+9XItHmSA9cLZ9SGtIRpX1PBuZdA1Sq/Id
         QbsoZAjbNGxHbJB+RmfXsXeHOj5lMx5jtm6qyDOfmpZUtSpL3u751mYLRxPsDKER1BNq
         6FJg==
X-Forwarded-Encrypted: i=1; AKwUvBwo6o+GGy3TIT9ysg99hfLVdhgafbysG4eoWWDV3XiD1zNodPHoCzkJJQBGemBSF/8YBaX60fi3xYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcHtg1zWzh9IAe+0w2q8qKlb2W3Y0bGJERFAQSTNK2JKe1A+J+
	iYXStt1o35HvNGKMd/kKtnhw46m3X53L5zPnFWMN3gtFbJbr+zi0RQ/F
X-Gm-Gg: AYBFou3xVUgVpOyKrYgBLpDBoGrI+3f5O26i7bYqXJlZTqDGFWZgcJCKKnQ3skzgh74
	J09nKnabETIMFPpSG9atPR/eOTQOAy4ZkSf+Df0aNUyCPzs9dk60DtYo0g5SdGCwoRRBTMi7K4l
	uQL4KpoLRW3LA82/0xdaRyplQUwor4ZTYAhPSdVfpX8s3xBHl6j61YY72x+dxDr0BCIYtc7EKJ6
	x2CV0Fod5w5T9zVGIdxZYFppqXA6LVIyF0uOPu4sYdWdjbmskYXjhxtE7DVbkaoAkheDvv3Ks3k
	Rmqn2xrdfTmagpvy5sQpwWBbpCFvXO3vpslAne5db756/CnVyBeeNmHXG8zC63XJcfN1tiL0MhP
	ZpebCitFJcUDfj4LoS156eMFqkva+laxomRE3w5QS83xv1RdxCOcm5f2MmdmzAsgkRRB9XXgh0L
	N7B7JzLYYhgijszvcQEXUSetc49Z4jv4Mn1j+eX3oT9ey6aoB1l8Jwf5yoHMKbWz+JOGtGOtGve
	y2HVpzmg8ZDuOMvV4BIplxyn7og0My4
X-Received: by 2002:a05:600c:580b:b0:4a1:688d:a43f with SMTP id 5b1f17b1804b1-4a18e4c9908mr180180885e9.35.1791902424717;
        Tue, 13 Oct 2026 07:40:24 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:24 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH 3/4] iio: light: tsl2591: report saturation
Date: Tue, 13 Oct 2026 16:39:42 +0200
Message-ID: <20261013143943.436816-4-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143943.436816-1-ciakval@gmail.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

When the TSL2591 sensors is saturated, it reports its maximum value
(specific one for 100ms integration time, UINT16_MAX otherwise).

When either raw channel becomes saturated, return -EOVERFLOW (like
as73211 and si1133 do) instead of calculating an invalid number when
reading 'in_illuminance_input'. Keep existing behavior on raw channels.

Note: Datasheet versions differ in the saturation number for 100ms. Old
2013 datasheet lists it as 37888, newer versions say 36863. Use the new
value although the hardware can report up to 37888.

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index d9c94ca5aa26..b780b236897c 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -139,7 +139,9 @@
 
 /* TSL2591 maximum values */
 #define TSL2591_MAX_ALS_INT_TIME_MS    600
+/* Maximal values per datasheet [v3-00] 2023-Feb-08 */
 #define TSL2591_ALS_MAX_VALUE	       (BIT(16) - 1)
+#define TSL2591_ALS_MAX_VALUE_100MS    36863
 
 /*
  * LUX calculations;
@@ -379,7 +381,7 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
 	int int_time_fval, gain_multi;
-	u16 als_ch0, als_ch1;
+	u16 als_ch0, als_ch1, als_max;
 	u64 lux;
 	u32 rem;
 	int ret;
@@ -417,6 +419,14 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
+		/* Check for overflow; special case for 100ms integration time */
+		als_max = TSL2591_ALS_MAX_VALUE;
+		if (settings->als_int_time == TSL2591_CTRL_ALS_INTEGRATION_100MS)
+			als_max = TSL2591_ALS_MAX_VALUE_100MS;
+
+		if (als_ch0 >= als_max || als_ch1 >= als_max)
+			return -EOVERFLOW;
+
 		/* No visible light, this also catches C0DATA == 0 */
 		if (als_ch0 <= als_ch1) {
 			*val = 0;
-- 
2.53.0

