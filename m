Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF036309B
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477421; cv=none; b=m7l2MNK90yw3iDatZ5sgzFVWoBVaT18ZUlHJsaJvWw0j2g+fy85dbeNQ10WdRm2DD0iXyw2iWDs6xSYQccZ2D/hiv+sSg2yVYiYqgkO6tmTLLEdrxKATJgXntecm/UMz3y46Ead4yg4t3+6FXKV0XB2teI3W72GXWOFfL43Qv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477421; c=relaxed/simple;
	bh=vtlyrLm0TvkUPo2wg/R/JazT+XqsbQ1jNn4MsZdjIzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyLsZq1cQEBjAxBR4XtBWpocikoDuAiQvYMXORx/vYp7zX71o2IMBUEnt55BAdc2jrAabYKcvjaQBatTXi0mjZamU3gJ442j2ca6dyb/JRGsHSMkHOos5xHDukFO7FiOWCGkSAvTaNE5ejIscq97znLzIBraLILASFMgV+VydWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJf6Nvo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJf6Nvo"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa64cbb08fso370444e87.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477419; x=1781082219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uh1b+mJpQbr3+CkGJCunycJWNSs6fDOpmRP1WL4Ja5Y=;
        b=AxJf6NvojgvXOWh88CUPWSopJrxJ8Yd16nHn4mivRGtFNYWlHknCGLawKQlvJUyv9z
         Ttzr/QmQNIssw9WA3EVV0KRqqTQTWOQ8qNWMYPqq+o/eYxOaYauup7S44uo0i0hW62Rx
         n5vhiBYlW5QdUJDKfRE2IMunPudaDZT5I3o7kfmFZx/nHGYrW6QhewlHTkkYFNpVou6x
         osecQ664QOJYPi7uSxYXEL2/qSoo+RVXEAfjzyaeiYDdHI0bOpvUhjRuen3P4xRcCRbN
         e0daOHxPwJ2LymGsvp0/wZZSJYXvx/3My2pZmeBEylHpWHi48RHZ3OtcqjF1hHRQxx1Y
         9QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477419; x=1781082219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh1b+mJpQbr3+CkGJCunycJWNSs6fDOpmRP1WL4Ja5Y=;
        b=jxKHmtwZJwqGAkzrT9LXQovUPBTzHodA1O7WTna5i0jAn7ZDb+rohP17U0mk1Syh1W
         sMJZf4j0er+UfCYEy+vJCe+GmuGfmW6R9Ycjy5VHQu84tryaiaj7RIpFQAtnI0+R3gkZ
         FJpPZxZb1XXONrCsITulLLMGXAG81YOnNf91XoR+lZLDOEUFPlOeS1BrzDzp5usH1TA6
         AgjbW8C9GaZDJv10JOKL6ZaeLA14YokJKq20V6RidVp2O2QVFlGT2oepE2n0fe4/DHot
         SkbQfN8CEEPoWTYkhMXZ3Gda/NCD8iwC5l/bmnxq20UF3g/0AQhl4dbSVLbaU06O7G5R
         htrg==
X-Forwarded-Encrypted: i=1; AFNElJ9YigK1tP99DdfDz9T66uaBQzM4fCLlciKOCWOi+sMKGzqk5O+bKLJqP3vdpROSMQsip6KIWSk1HDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznb29n0SAM/CyhgTRoCQuWt0CQWpyW+Sq/GTfa+6o4IKMymMxt
	HnzMsFG1tVS2O+hydmz7sxxNQFjln6cDOAtIp9kCevh/7lKh2xHaAYEu
X-Gm-Gg: Acq92OHri+/oQ0cDRfU43CuwHG4H62Oy4EsEY0uy2YgKrv1fKttz+kwfO6KOyv3xZRK
	EBvys/pHZPvpPHuUeFvDYoAdzNvZcFmzzXgoBM+NvSD2JHc/089TJuErlsA5LXMNeXtBVsr1lqe
	8s4b+m5VfhyskTnQATd4aSy5/SxDCHvqPhHzXQWTTxZioG9ie14wAD6wD3KWx26wPWcgyBo6rtV
	ipzbFt/VBX35E4ouLM8cQoLPx6rrK1qnbqad5pZ6eoJVZbkv8l5uqhZ1uh4SKnJgowa/LdYvH88
	HjCNLkYgnk/qvMFTIFpcWDhuTcng4jc9k/6HoY4H6W2hJtSoV5g0kioYMzuKTqjx/Txb697iyhz
	cql6Pbpgdixck0RrlJj99244tXLRqLpavqpNsS7KTFrcy81ZH0O0xJGsIRbF1ImICK4kEf5JdFr
	9fSUjPIDbFiUZewGMQoo07pFmW+8MS06z+oSqiq+5xCKkWzg==
X-Received: by 2002:a05:6512:3d19:b0:5aa:6232:576c with SMTP id 2adb3069b0e04-5aa7bf48994mr353921e87.6.1780477417014;
        Wed, 03 Jun 2026 02:03:37 -0700 (PDT)
Received: from localhost ([5.124.46.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9862fesm517686e87.57.2026.06.03.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:03:36 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Taha Narimani <tahanarimani3443@gmail.com>
Subject: [PATCH v2] staging: iio: adc: ad7816: Use devm_gpiod_get_optional() for busy GPIO
Date: Wed,  3 Jun 2026 12:33:33 +0000
Message-ID: <20260603123333.5608-1-tahanarimani3443@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently utilizes devm_gpiod_get() for the 'busy' line,
which makes the GPIO mandatory. However, the busy pin is hardware-optional
depending on the specific board configuration.

Switch to devm_gpiod_get_optional() to allow boards that do not have
this pin wired up to still probe the driver successfully, and remove
the redundant conditional chip-ID check since the optional API handles
missing descriptors gracefully.

Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
---
Changes in v2:
  - Fixed trailing whitespace and missing newline at the end of the file.
  - Converted the file format to Unix (LF) to remove carriage returns.
  - Removed the explicit chip-ID check around the busy pin logic.
  - Improved the commit message to provide clear architectural justification.

 drivers/staging/iio/adc/ad7816.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0eac484..039b34d 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -84,7 +84,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	if (chip->id == ID_AD7817) {
+	if (chip->busy_pin) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
@@ -380,15 +380,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			ret);
 		return ret;
 	}
-	if (chip->id == ID_AD7817) {
-		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
-						GPIOD_IN);
-		if (IS_ERR(chip->busy_pin)) {
-			ret = PTR_ERR(chip->busy_pin);
-			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
-				ret);
-			return ret;
-		}
+
+	chip->busy_pin = devm_gpiod_get_optional(&spi_dev->dev, "busy",
+						 GPIOD_IN);
+	if (IS_ERR(chip->busy_pin)) {
+		ret = PTR_ERR(chip->busy_pin);
+		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
+			ret);
+		return ret;
 	}
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
-- 
2.53.0

