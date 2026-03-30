Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBB3DDDC1
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892486; cv=none; b=KTL/uWIwfqFzAVqkbR1/S/eWdCWNa8hryZA4xso+pALuzrmb2onHuM3FxY59b4DXKj7UPwnRjqFShcs4dIEhkJIFQ9U2jadohPE5z78E4qgSuR+N4yovM5FkkA1t9m4QhijuiQhs4P/gOm1blPzUOqXOcdH/CJuOnLAAoFhY3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892486; c=relaxed/simple;
	bh=tSquc7sa2Cn6LfGxEXgHs/QIbImA+arPbrIn1dVGGHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iL2rIa4oxVS/qda69JBj4jCg7JjHQnXkGjw+ziLTSMobeUcXquh0T92183Kp6NhLfdWB7qvcXt6hTSYSZBhujUkig2mFzW5L98zM1P7OpRmwWqH7YlmE0O6UWw+zIGDCQOMYbaYQ3ovvjdl6qNPmTDnIBS0A0+yFZT5ZmSJJms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaiYEQmO; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaiYEQmO"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82a655cfab5so4462977b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892485; x=1775497285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fqwDF4ChSEr48olaKrcyFKqRQaBIIIXtDoKMJ7juOk=;
        b=iaiYEQmOzz72GdQQiXodXXq+s5o6xiJB6g3lWEX5lrNTu2zsxjVHHIkL/JBvnnZ/fl
         G76tSpztaGzXjixTlXJbAbKVwtNXUm+9KXkyv/2I+bSFZgAtJszvh1bQjQ4VUKJqICyA
         BlS6l2p6klgZPbVn0v9brt82N0tF7H+MmcjR8bKkm4wayFl3UJWnhoxlNAxtXUGfppoh
         4h0yaTaKL5bXJziReTHMRD0Zs2gbL7x4pIbiKvAa4LnnJpzd7OwIxECq6IoQSXEeUciU
         dlMgouMu8vw9VoeD6jjdJ0yPJYz9siu0FYrdogE/swWyYy1AIcW1c7HdIBRN3HaQ0jsj
         TGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892485; x=1775497285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fqwDF4ChSEr48olaKrcyFKqRQaBIIIXtDoKMJ7juOk=;
        b=EiGilyDm9FGLsk867A276T9XFbTMpvzyNjNo/BIikPPWfl315sibzaDDIyfSH0RzfG
         6BwkHJL+RdgvCZ44JgpJ69NGS/pB76gm+b8zPOHTUaupB/z8XsNOo0AdATVHAl1iFOhr
         OfztkwdygaRPlRfCxWO6aZvgT5UHdo3/rK3e+plq4LqnV8GSO5WVV3MNB+0yFtmse3XC
         S+NKRMhdHu0WLdlv7ITR3f0pDpnZGamGig5LiC+xm3w9pLlnhRAZfJxWMVCMUi7nsC1F
         n6AZmphEaZ4Tp11tJUr5vZv8B6KD/arYBGuf7vUQ2kWDPGydylpqHvIXvRSpWrpdcUb1
         xdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKPAAxby++465Pk9IQ28CDPviSZWi3NmUwjVmUF+Wicvd3Vnqn53Q7q1AJdCBfSsa2gbk4+wQsM4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywie7n1WXv4ScizwW4P6tNx5z+nJvBckzTXykSoxAhEXVmmSslX
	z1KZDOAMPPnBACDzWzpWqgEsi8L40Way6WgFmt4JHpFNWIeYIhhl/nm5
X-Gm-Gg: ATEYQzwds3xGKWNqSyWsSp2S7ThwOslZ9L4YfAmuD7wBsCoBFyJ4kR1KqrPdtKV10K4
	g66DIOfpozjp8d1NS5Rbnrucpzm0VKjCBRssbPiisX7RWZ3PQXPQifbNGletTM9RALX8LT4NmsJ
	FDbzcohtcQ3U8ejOXoJHtUUXqroGgcY2uOyrumhf1DZ9B+sPtDeirQm4rA67566SpljmtyR7M7R
	sz/07R9+OBHK5ifih4IkMoCVZOXKni1mrpPMpQK2z/Pe3Tcsqm45cxIRZQP72wx6bXFqLNSo5ut
	beF85PNiw+NmRe5zS1Qzphiwx4tlTYKQnYrjoBIpf5YrOB0PBDQeRRCkShUP5paGrT8dwvaFik7
	95fC0615Q9ukk6OpHxtBHBnnVw0UDDfWqvOvOOe1I9WNTbpK65F/Hy5nUv5VUBvJdOs77D0MlSw
	eFkj7jB1wA9EUfYOlHe2t9PlZylPIkJBQApZ+lvTqZ
X-Received: by 2002:a05:6a00:4299:b0:82a:7aa3:a2f3 with SMTP id d2e1a72fcca58-82c95ee4bedmr11931671b3a.33.1774892484669;
        Mon, 30 Mar 2026 10:41:24 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7844052b3a.50.2026.03.30.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:41:24 -0700 (PDT)
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
Subject: [PATCH v2 4/4] staging: iio: adc: ad7816: use modern IIO attribute macros
Date: Mon, 30 Mar 2026 23:40:24 +0600
Message-Id: <20260330174024.20712-5-mdmahmudulhasan1511@gmail.com>
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
 drivers/staging/iio/adc/ad7816.c | 72 ++++++++++++++------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index f2486cb29..80f84e2bb 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -121,9 +121,9 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	return ret;
 }
 
-static ssize_t ad7816_show_mode(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -131,10 +131,10 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	return sysfs_emit(buf, "%s\n", ad7816_modes[chip->mode]);
 }
 
-static ssize_t ad7816_store_mode(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t len)
+static ssize_t mode_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf,
+			  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -150,24 +150,20 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(mode, 0644,
-		ad7816_show_mode,
-		ad7816_store_mode,
-		0);
+static IIO_DEVICE_ATTR_RW(mode, 0);
 
-static ssize_t ad7816_show_available_modes(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t available_modes_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	return sysfs_emit(buf, "full\npower-save\n");
 }
 
-static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
-			NULL, 0);
+static IIO_DEVICE_ATTR_RO(available_modes, 0);
 
-static ssize_t ad7816_show_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static ssize_t channel_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -175,10 +171,10 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
-static ssize_t ad7816_store_channel(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
+static ssize_t channel_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf,
+			     size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -208,14 +204,11 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(channel, 0644,
-		ad7816_show_channel,
-		ad7816_store_channel,
-		0);
+static IIO_DEVICE_ATTR_RW(channel, 0);
 
-static ssize_t ad7816_show_value(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t value_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -239,7 +232,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 	return sysfs_emit(buf, "%u\n", data);
 }
 
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
+static IIO_DEVICE_ATTR_RO(value, 0);
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
@@ -269,9 +262,9 @@ static irqreturn_t ad7816_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static ssize_t ad7816_show_oti(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t oti_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -289,10 +282,10 @@ static ssize_t ad7816_show_oti(struct device *dev,
 	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
-static inline ssize_t ad7816_set_oti(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
+static inline ssize_t oti_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -330,8 +323,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(oti, 0644,
-		       ad7816_show_oti, ad7816_set_oti, 0);
+static IIO_DEVICE_ATTR_RW(oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
 	&iio_dev_attr_oti.dev_attr.attr,
-- 
2.34.1

