Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980863CCFCA
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941948; cv=none; b=WTYsd30fGvQs5XGiOi9itU8QxAONXHDK00V/siDaIActVK4AjCCaHPtb4J2MXZ2m1M++teQB1j8MtAniliCLJeYICcRQovxmF3p3gHpy+rX2JTjkCXrVM0Abb+hAihpT0nsaYkCG5ODe6QVlLvYhpMUHGccSPN13s7WY/cKYOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941948; c=relaxed/simple;
	bh=AaeubZhtz8ojYJt5zsFPfxtOPOpZylhKBuq2cPd6gUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZcZGpuor7APL9Fpxyv20b9f/K7W2dUA80vqidq9vK722QDzZfo6VtYuyXk3qVof0glayvrzgMesWpb7zea7uuqOjfKJbM8D3lvHxuMugReBPSqWU0++IahFR0iuZ5Wz9UoS3VcvCuWvdKD2lDBKTrdZKH/husZA9dHvibdQOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISBDELZo; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISBDELZo"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3155020a91.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941945; x=1775546745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdIxdgSG7WGFBTZ3ix+HECNRQzg5xB6W1qz3YgiFcVw=;
        b=ISBDELZoVA79l2qKRTz+OelldXMNPFQ/tLQah08s5Dg6mQmbNSvKfCpWQCeLBJ92ko
         d6NGoccBECucC48npR3iJsjbQWO//P5h3XhMLf7OSBxmsuFvP+tw+B6HxSRfb3xIB8tn
         SjxMikPTC/bpCcLBn+W95+Popxmj7zJMpnEb6A5bzEqPCGvpbLpTmRpi73IaDDjXBA87
         mbWbHfw6b63JR5nghuD5tsQRI3RVFjFN9d4czdDqCtFY9LiqTjcn7RCz5ErMucQvF7cu
         LnIlEJL0cTwAr11mhrqABzq7/MV7KnThtAtfgFpffFyRfkt07rWFgBfX5uHuKIxC0DYP
         PqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941945; x=1775546745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdIxdgSG7WGFBTZ3ix+HECNRQzg5xB6W1qz3YgiFcVw=;
        b=fDJDAyAcGlNQ0GTsWJoll3nRSen1IQvvUeJak4j1HUojxy6ieOS8FrH5U4XoRhLvAp
         B6fPFLuOu9bDstqF26SAB7/cewiKdVLdzW4P/IUQ3OFeJ2xqf9KgFUcZFFO1655i07ay
         cstByu5ntxdDVvVjA21jzGusg4a+P9d42Cp6Iyc3REsnlBp0EzQ5VootVoHFOEKhMBJF
         9KCYP2li5gA5htWFCkKw43suMJuR+9//UhaBd9IvhP5SyV69Dl8ag2FYdcE9F85b89Pk
         5Ym+IxQnsdZ3efDwlmXRUtGupRz1hwEmPq4ohjIC0HHZn7u8alx1HzqFjY0RoqXWbnBS
         DR5w==
X-Forwarded-Encrypted: i=1; AJvYcCWdKmiGg61wqpjoFrhx9kUx79K9odviBLTuaS9rj4W3mQyk5XICV3dlQVqieZBJJG+wlPf6Q8m5z+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFsvrTIFKFZAJNSIyO39rJrVYsWzAZnL1+ngxwWR6jI/GwrYo
	h2QzvemjmMRDZKKcFxq3xQoUqLQworaYQgKS8WWtqroen+pvTZO45mdSH4yzq5PeXEU=
X-Gm-Gg: ATEYQzy+h5+YIwGv6EV+Sz7iRNQD27e5sOmgZq/mOc7vbV3SRPPfcnXOWsRg1lIlkWz
	4TpcjX64EMRx8LziH+H68Udu2oL/hLLHEjrhUtznpECgA26ac/1DwNaAOhAHZ5yHVVjsQ8/Re1x
	KIjF1iWGlzlRfEFTSsl9DA8I/3/CWzcwl5qOboSZpQMLq6lWJzZgNFXA33WLP4qin05dh/uOMzz
	2AMEOKN0p0hlB6vZVxB9ItAvKcgXMkjysraioFCXfvLyxY98eUiq/FVwuiMoHAqGPF1MhAIfgdO
	hJqv9XdIZuNOmy+gKU9cmzxz29yxyAS7hzH7RIHc6yu1xgXpTg3lMVmuvebT7iV5usz2g+J7lB3
	4dqQCYDPXg4srhgF/VeFrZBkxkrelNx61xpQf06HaROJSNQcYuQSRqsCr6nMnvYgBh7ZSPB2mfu
	e7Pb/pxOe4Ue7ajMa8y+KSM+MOUWGlfLNjouYUvac=
X-Received: by 2002:a17:903:22c2:b0:2b2:5515:661f with SMTP id d9443c01a7336-2b255157499mr60408695ad.9.1774941944981;
        Tue, 31 Mar 2026 00:25:44 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5412:6527:d590:8704:ff8:2ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm109272495ad.6.2026.03.31.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:25:44 -0700 (PDT)
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
Subject: [PATCH v4 4/4] staging: iio: adc: ad7816: use modern IIO attribute macros
Date: Tue, 31 Mar 2026 13:24:53 +0600
Message-Id: <20260331072453.6530-5-mdmahmudulhasan1511@gmail.com>
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

Modernize the driver by using IIO_DEVICE_ATTR_RW and
IIO_DEVICE_ATTR_RO macros. This involves renaming the callback
functions to standard <name>_show and <name>_store formats, making
the code cleaner and more maintainable.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 72 ++++++++++++++------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 790b04544..c83f7f70d 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -122,9 +122,9 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
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
@@ -132,10 +132,10 @@ static ssize_t ad7816_show_mode(struct device *dev,
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
@@ -151,24 +151,20 @@ static ssize_t ad7816_store_mode(struct device *dev,
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
@@ -176,10 +172,10 @@ static ssize_t ad7816_show_channel(struct device *dev,
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
@@ -209,14 +205,11 @@ static ssize_t ad7816_store_channel(struct device *dev,
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
@@ -240,7 +233,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 	return sysfs_emit(buf, "%u\n", data);
 }
 
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
+static IIO_DEVICE_ATTR_RO(value, 0);
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
@@ -270,9 +263,9 @@ static irqreturn_t ad7816_event_handler(int irq, void *private)
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
@@ -290,10 +283,10 @@ static ssize_t ad7816_show_oti(struct device *dev,
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
@@ -331,8 +324,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(oti, 0644,
-		       ad7816_show_oti, ad7816_set_oti, 0);
+static IIO_DEVICE_ATTR_RW(oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
 	&iio_dev_attr_oti.dev_attr.attr,
-- 
2.34.1

