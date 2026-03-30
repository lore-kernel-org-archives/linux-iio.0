Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DF3DDDBF
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892471; cv=none; b=fT6XrVT6P595cRL0luZT9Uw6O4T1tmjjUViSbcdhKu24JANQon3bSksn1so12jRmIWfecnIni61rV3hIbwM6Ws+9nd8BZrqLg3SBPsXmrwqymV8u0Zy7OVN6YT9LoZDgcbr4p+3SrJSYLSYu1AGvNVe8G2kBTwL8uyVUoPyUMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892471; c=relaxed/simple;
	bh=od+CttlPpI9/Mh/jJSm8FrUoGXVeBS2nvt98p6hrArk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwdWMgbiu9XXgCRXzSd1FZ4iekKBxgfmS6BvqJezCdIUAbrDnm3zGVR6G0TcU7KSh56gMqkpsifjesSS0+RaoRMYNpRHW1tj/A2bBO12wOuSc7IUSDb5n9pOQZq4ow0FJ/q49G3++lk2jWxkz7JrbSBZ3XLSwFlGdeqkzzDBfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5NEYeuE; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5NEYeuE"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c76864f4e58so1385767a12.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892470; x=1775497270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br6i/M290AXSW7sbMlbOqqhuMEb0TR9+xezMJ45NLio=;
        b=N5NEYeuETItsUMPQHIOgz6mwJmngXg8Z9OwYU8TWlWm1MsFsAO3Oxn+tBavG+JFzNn
         f4+VnpI/TRjFghZfruvPYkqkY4w44TKy8WFrP5fE2aBbNtHXw+X1XTpLKXg7Ee07J843
         H71gnaxniBMjXk+C15lohp7DPmXAh928062bAYywq6LYahPCo1IfidfSBKNKzofTrdbx
         Ixi0jp1eHOKFxQTgBFeL6v8qGIhUT/PW0KYxLd/JPJgb2aLHr+LL2ixYGXUVPDtyYXHn
         hnVXlRv2E20L8a7+6UfqA03LYJdo8PdkNevl0zNgJqL4rFAjQHlDna3x/Hd5OUl22EoI
         xldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892470; x=1775497270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br6i/M290AXSW7sbMlbOqqhuMEb0TR9+xezMJ45NLio=;
        b=Sm/A2nSzu3DfRTSthrNHncJ063Kku0HSeus+ca7YVZ4f+AEYy17/mYyuMUOoTKgVha
         vk2w4tCYWjdrUPF9T98cj3xNpBF23uEZ0c5aDRsDOjun2N/lcHQK1rCP3rZ67Y4RV15w
         wtgb29iLRSzcxBmHO6dWV//J9n1yRRq6aQ4iCvuBC3sOx3tqiclJZbRgx47o2yP5n5tz
         8SFcea1Nq5EnL6CTc28GdCHR6TsIGTKCQRFGFvpqClCgcXXGTw7sF1MDDCTcan42I6pR
         9EdUpyaD3MgQ1iD7DqE5EFgfpqbMJ6FAvQyLgB90k/8lnAFzP+Isc4udn/LAuE2Mn3Lh
         oNLw==
X-Forwarded-Encrypted: i=1; AJvYcCWoy6oW/YwbBsxXOaYBrmT69SnTeOQfM6PIhqV2ErsYglAFeFpcnVK2gEKzV3ZN4nlfp3Z+ZpQH5Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIAD+SsSNQPDAfD09w63RpMbycROEYFMeWjXLN3ADZaXTLywQ
	2Ce/awgfPgLUErMfNOcA6Xdo7UqmnCFu1C6VDAkgMBZWGx9uci68DH9L
X-Gm-Gg: ATEYQzxmRtZOYJCBz89lkFra0YofbDDM7jEVZd0usZBwH78zLjb0OulpBaJqh8N/Ql+
	e5r87kRpKQ+9Ari1O/JU77bJmiE4xHu/n6j7hoBbyq9dmedbLFZJQuORWI1ZDxKfC8Cw2mPyx/Y
	JicKMebgAXwEMXDutjnxJWNNNx1rvwcUveOV+Q3rgpQF/JiEoNHzJtIG4whqIVExogmwTiCB4KS
	kzZEzgAI7gyXmHTu3S6fkbv8YCrKMbQmoJo4C0Na7/60nRTkXiRSTELXppX8oSPZzPg2nARL5DF
	/cywnzRx9z/SnX8tuzSJ7VfpE+stWJK6edquF+w9nNZHOv4aK4cID/QJaGQlDE9y26sexoC+WRR
	l3rPhM5nnK4FiDSsOip1Duv49SfPDI7AWBKjd6tr5LFHO+Qlm/x2/QcVqyw6VJxh3iNmWE9qyNE
	IzhoLIAOVoR0G249uUrAZTRR6bM4c581O45tQ8Qv91HCDiN/5Hryo=
X-Received: by 2002:a05:6a21:9987:b0:39c:113:14a4 with SMTP id adf61e73a8af0-39c87ae49e2mr13191508637.50.1774892469601;
        Mon, 30 Mar 2026 10:41:09 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7844052b3a.50.2026.03.30.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:41:09 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v2 2/4] staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
Date: Mon, 30 Mar 2026 23:40:22 +0600
Message-Id: <20260330174024.20712-3-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
References: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/staging/iio/adc/ad7816.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 5acfceb90..f9a0a5a69 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -58,6 +58,11 @@ enum ad7816_type {
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
@@ -135,14 +140,14 @@ static ssize_t ad7816_store_mode(struct device *dev,
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

