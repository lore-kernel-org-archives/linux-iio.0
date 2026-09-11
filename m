Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44643CE56
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125048; cv=none; b=W+Ea7levo2W3r9xRtJP64EZgXe4jRf5gL/4OCVwcnxsrObMwVmIs/jO4loujxYs8jpV5VjSqR4uS8baRODt9aY6prFgpJvbpXHiri0SukHXSJDNDuI3GprZvyNbogiC8NBOhASjTpc+uREUkopksakw6lkvbz9g7wrROVePQcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125048; c=relaxed/simple;
	bh=nkt9eX0UhBpFnXXxyb40A2jA3fGy9p1WHRIW/5hqH4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpYlag5GCbHJ3Ej3QFw6rSMgSj6P8ftYst7NoD34I9zPYwZzZcpQ0z2phoBTNaXsKVAjCGwqbmSxK1/iC5P3+YvwKU5HRV67aRhuhVCnpVJ6NIoUlY0SXigUgjBt8eNEJ7NQpbh0PzgMgHhv1VkdJkimlqIj7ClN7Y3X/qrqP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm6M1h0Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm6M1h0Z"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so7818635e9.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125034; x=1789729834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buEE5TDzC5FsioP8qx8e+5Y4xF8w0Ds3BqUa5qHn1HE=;
        b=dm6M1h0ZIXunFxt01MMVbCItktIlWZ1Djun8hj2gMyjEFq9C0gI1e8bZoeo6p34DGe
         XS1tqguS5wLIpOrl+vgmJ+UCboR6oIRzQq+re4k+tGsSonvh/A+C36ZZozV3wPlHfAVb
         6UdhJ8/vopy7Dd+f/su51rCnGnDRMhKxtu/Ec1Vs3EiZSGFp3kJWS8Uy/lYJ8iRKG23e
         3feHMZg2atTDsrNaUFmVDySEGXItfKbClY0A+vxFPLh5nDS5VaZQp72cea3D27KpoQne
         18Y5NQhUdRpHiZ+7wZHcmJffv1PTxewkJ4M0Lf4Zt8iy+/bw9uOW+UjDlhvkmkorVZmt
         OE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125034; x=1789729834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buEE5TDzC5FsioP8qx8e+5Y4xF8w0Ds3BqUa5qHn1HE=;
        b=lrUphvnGGUXxQhdtdbLEd7XdlRCsgTzxXplSjmAnRQrC82tjFDvlgERSGsgLwOLsd8
         fpFjJNr/lgmMQ8tuZFu+01EsW605UnFRYUIdzkVoZFn8e39Ii3vsV9NJGvdoNSQUFqMF
         qgJT+85ws034CCoQd1rnTQXvvsYVKX+n3Vp9OBg7dw//5mwLoOuWKOmSZ6XQRxeH/eeT
         Xkfl+jQJa1M5cc7jghtvQ1Z6nAvnEd8pqnSoQHZ9Fw2SItGUntP5I2Dl4j79n1nGGvjo
         aw463cGmzt6bcQ/rJ5XrtOEeZxP9YivstIz1CEhpyE+yWKGqpro5ECDuqAjdXwPOJY92
         RXJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzKqt6sP6QcK7cy3shmElvy1keUPOhafdce3finQScPMX4AwQGLfZQzffte0EUYKgQWJ9UUQ81Hg4=@vger.kernel.org
X-Gm-Message-State: AFuF++k/h4AEcMsjHQVBZt6y30rXc+5wyYM0TUTd3B95T5x+72Zch79x
	QosjW5qELQOwUkYoMdxQqsrHOGDWwFPDOi1l39BWISpikC4oiwR3+B+K
X-Gm-Gg: AYBFou1NoMKUlvv08i40L7TJ5jGszTZczKelLyHToLE43y5FHOYerXZ/ExzpPtEbaxZ
	YnktGHLcCgImDMSwWDtzXGEjo3wW4ChJzFDoZcwuQzruJY5mCpu26Hw7FqVqx3wZuJBDqbRv0nX
	tbpdOZG0oHwgeTAc5QjUi7bmuPcng5UlNvDtEiMnJJz0KSJYP6BjQZ/wVg5b0AHxdHqGW+CBj2H
	x1lzskK68H6NHAeGWxg5EWTfQTQAlM5E8ne0bh8fvR5jCmc5TcDdhlkCXEjgPbqxgsG5/oI95/s
	HfgQKdgBGXnsMcQ8N+I9DQTsbtA8B+E5hFYI4H4r2j7f/F+HH7PUCb4HcNFpf2SNK2bmpgBe6CT
	OHMsWJ5yup+63D4ReORmmkHV8PoqGtnsprP2DfTAxcEg98n/RQnBoBivcPlWC8NnKMWcknJUBkL
	8bIz6/NOH60UgIV9+1ITD8zMMu8DZFf49YGG2pwWeSVlW6cdf9cTEUB/oTjKlpcnC2XuajacUBp
	UzjeleMbGsnkw19gRY=
X-Received: by 2002:a05:600c:354a:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49e61a005b6mr41951185e9.30.1789125034386;
        Fri, 11 Sep 2026 04:10:34 -0700 (PDT)
Received: from fedora ([154.182.82.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ac411asm66109065e9.8.2026.09.11.04.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:10:33 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 1/2] staging: iio: adc: ad7816: Serialize SPI read operations
Date: Fri, 11 Sep 2026 14:04:55 +0300
Message-ID: <20260911110456.24873-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
References: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816_spi_read() function performs a sequence of GPIO state
changes followed by an SPI transfer. If multiple read operations
occur simultaneously, the GPIO state could be changed by one thread
while another is in the middle of a read. This leads to a race
condition where the sensor state is disrupted, resulting in corrupted
data being read.

Introduce a mutex to serialize the read sequence, ensuring that the
GPIO toggling and the SPI transfer are treated as a single atomic
operation.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..d0355763aa8f 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -5,15 +5,17 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -50,6 +52,7 @@ struct ad7816_chip_info {
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
+	struct mutex lock; /* protect device state during SPI transfers */
 };
 
 enum ad7816_type {
@@ -67,6 +70,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret;
 	__be16 buf;
 
+	guard(mutex)(&chip->lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
@@ -91,7 +96,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(*data));
+	ret = spi_read(spi_dev, &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		return ret;
@@ -360,6 +365,10 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
+	if (ret)
+		return ret;
+
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-- 
2.54.0

