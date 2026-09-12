Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1247DD57
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219565; cv=none; b=MSbPne3P4X6cGRch/XRj7lkuv2XOGSfM1Lk+OWgf7RazEEtC46IQlCuFs4OzaDHztzfrvvuHcndy0LcfdvwGe728k/K436ADS9B1yWV14jxP43pY5gbelt3BZh4jBY4SjtMb6imBWLWPwJPE/ZllSG/1Y7Qe7R3bGxNF9IbA6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219565; c=relaxed/simple;
	bh=B82+6jWVF+uGKYVaZQYTIbzC69mj2Z9dpEdSNIoCiio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwci3jq1uTKKKxuPlmXoh6LIeOcIfuYdCPOvFvDHhEvqw2URuj8I2kmMw5jK8FzIThZmNfSxZkYyoefo4hE9kwEzLMO4ZUzKI/4iTaF2c89ICZ2iMZopCfo22ugcDuPvVUSoKiGFJchxMGME1/qwpFdTgU9+B4n1aUM3S6cXdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiSnupCS; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiSnupCS"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so187424f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219560; x=1789824360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQ4thKSalDZM2rC8wC0NqTstNC8+R0mxz6pCgagXex4=;
        b=TiSnupCS68OFMTXkq/3G4FXjie3Gf7f5F6lBMBhOpCr9no/jKVqyx2FXvG6lOmTet2
         q5MMOinX7dukLo1uEnUaB4Nc8GAF+wURehZ9gj8IrGauBfUjBn5H8F26Yk2I0+iVT0jS
         yhNXNPl4ohWC4uYHbY50SBxQgURVf9nIeJJ2FGrUr44s1NnfYzOAO2eKYrC74y2a8H6a
         SwqtRCDFeLlOkjgdbwGQQWtpTNRvRnaT3ZEMUb3KgSziMEz2iOACNVnPrAGYHbsWEqAk
         899kaDQ7SXFNLNYQC0IcoYnCU4cK0nlO3xXdsUK8WoEesSXxYQffE2v3CJZwcB/DbNlr
         JO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219560; x=1789824360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQ4thKSalDZM2rC8wC0NqTstNC8+R0mxz6pCgagXex4=;
        b=hRfi/aUvPa928m4xzYaCj1E/Ft6yIB6SwS7CuM7iuu8lU26KhpCesrdLjRynqDWf99
         Mk1ULYmx2d4AJOTN9AU3PbcIS0q4TpElZohQNZaMEr8LbD16Z67z1captW7HjXt/F98c
         gNzH6SREM9nV+W3AUE5Sf+85SG1zgg7fadGCc6iPKER/dMiUC1o72F1yzEg0vSXHiiQj
         ZDwHrCszGerLJ59GSV9cUVrYBX8XViU/Fhg13mlQcXv/fWWHQdLJZplDgcZtIEg+Mvve
         9MOIXVbp+XSSJN26MEApwwYT3S3ODQy8HFMGR9msHzUjG0DteWjJqbHZDBgiE7gVEhjd
         n2gg==
X-Forwarded-Encrypted: i=1; AKwUvBwD+/gGsQrYXEr9s89ixTb0tr8BuqFb4lQJvkXZcvILSYRW4ZWTDEx7af0yS4TD9FVASaw6ql1SgvM=@vger.kernel.org
X-Gm-Message-State: AFuF++mNZlNiYrxzXxwjjppWyWYHXyzK92XulJeAUW804e38wPXZWj2x
	RLztAQ32jQxXcLezxZ72wThbWgCSMyOoFXsmyY4XGNnJTQE9O3kqSF8Y
X-Gm-Gg: AYBFou184c7duIliO8JJZuZVaRbuYhpmEJW41KV5fiERgE2j1FEmdarSjwFd2QmfXEK
	RSrtkqmDb2INTHT6MMHZwOB0bRc6G9mUJlvxNfPjbm+OTqzvrTXOvtuYQDZ5iyGE+ME7TVn3ugu
	UYgeFSXE/etPm2EYBVD74Yh4fV8mMVCdsw1NndneKJwuT7/oD3Pd///awFu8To1HvtGJItFOI7X
	vXgm0dGeY3JhcfiN9RyKF6c3W9GojhELbRXphp7tgPMeg+B+SZt0YOLn/rWXGuvBP+7PIyxbg9B
	PRCrA6n8UKarxeL4mmvZ6jfqlRT8rQFGvQ+0YyeXLKoQSWWEK0zY3GTpgH9wtuwe4cwotaMZLMN
	Z4Tf9CYg0Ej7t67JlzC3/Yv9OT1YqKg5+0itNzcqeHCMADqD+Co7c3O5Gbc6gWJZeOGzZNsBmHS
	hM8yNzuN7J4Lh3/6I+wexzFOYnPOTPZDlwf8MnWo9M9IKPFAhnC023DePyL7ELccBkwIWObb1Q/
	u2SlO56OTERasBiqw==
X-Received: by 2002:a05:6000:5c8:b0:486:f301:1144 with SMTP id ffacd0b85a97d-486f6beaa59mr2718066f8f.2.1789219560279;
        Sat, 12 Sep 2026 06:26:00 -0700 (PDT)
Received: from fedora ([154.182.88.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm12684503f8f.15.2026.09.12.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:25:59 -0700 (PDT)
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
Subject: [PATCH v6 2/3] staging: iio: adc: ad7816: Serialize SPI read operations
Date: Sat, 12 Sep 2026 16:25:16 +0300
Message-ID: <20260912132517.55686-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
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
condition where the sensor state is disrupted.

Introduce a mutex to serialize the read sequence, ensuring that the
GPIO toggling and the SPI transfer are treated as a single atomic
operation.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 9e43ce83e071..acf26c5a267a 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -5,12 +5,14 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
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

