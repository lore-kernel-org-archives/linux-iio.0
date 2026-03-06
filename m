Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81B36AB69
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778085; cv=none; b=Ig17xyOOEauPOA7moj6E1xNqsyo/m/tJglzpqaDR8HBW3rXb3ohVS3UrGG0lqh4UayTrx1/t3R46QQXo++typUOjaGD543Q3+j6ScKbuqdGwxr9LGQsW9bsDThKQQ33vQJjLEs/c8Zs2uKVR5tN2t9yacyKnRJCvjWBOXdz/WwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778085; c=relaxed/simple;
	bh=SotO0fYXQwis09BoQyPty1z4NsxH1j37MaYz09byilk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVao/TCFvuJxaIHOR5Ib7MnazZUnKZ0m7uKD7z+asHGhocSweH7+3LotzY9PYHQNt8u6LLB0u0+ym04W48aP0Mh+dOTTrOO+fHJicKdCW3wLBRqxwoX2950pCkKuGkA/iy4DTBvFqtQ0dwtmICwfdBWKFsUSBRWJxCViwJGrBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeXSLrN6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeXSLrN6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so5492598a91.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 22:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772778082; x=1773382882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4GInvwsf+roTirlN8Ozoace1npsOxHa2/rRC1Bvuqw=;
        b=SeXSLrN6f2No3GvkzZIMLu1nfuvdyx0HKrvbaEtb8L2ulJpMvrLcTVZiwaRgH98MND
         EecUMDPFuE0LPIUVzOHqMCjIBLekIeyGPXgUA8L8LTR1dV8aDDzDkC9rSOEputDDWgPc
         iBAllRulx+wDUuRt3HG/GUDfMnTkAB38c8K413UdLxGY+xjsjbqYb7KfxwxUYAGO7N4N
         DwRn5D/c6lhUri+xQWcR73qMDWMfI8DqGEZShCYTLKecJLcOIaRcI4MqIFjsTlLyx7uj
         4u47VF70cQJQx1VgMA9Ak8FrNzZ7LgIUn21mTUxbHAoRXIUaeGl3UPflnQ4tzLhhQLXg
         Ae5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778082; x=1773382882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4GInvwsf+roTirlN8Ozoace1npsOxHa2/rRC1Bvuqw=;
        b=I9L3b5dqY4ZGl1LjnXjrUQgommUT5D3JkHSSnZHOCJzuWL2lqzGH4KHWSwkoZxEkla
         PzAhiI29wXqp0fcli1ABhoSLe1G0kztjVmWkr58rEU/XWldf54dFxREeMnbNGR5nBrAX
         SxjxyKwT+VIukIQj9P3VFsgfH7pvaUGPhDsxM2enpK4qS7cEaisU1UpxiS1ii1pAHjqb
         IrV3Qsgjow+P8RXqimpt9fFSFOD2/mWNoLuVT8ZYlOsjx7Rd5FlIjMN19omU0BkaLjYK
         //X9a6ep3u9wWSKs97Uumhl7OqMR3QOtEJJlCjzVCf1H8KwXi72mPNEP0Tjm90xjwoRp
         61KQ==
X-Forwarded-Encrypted: i=1; AJvYcCULcj29u1MTEkNV5sVQ5qxFO14/c/pxhPpeINIsehzGDtXTxzzl86XsimNLMSps4yZHlwVtyf1ohQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7u29lV5v69UO0joz5TM5rLnxrEjYNSN/8Rv+ARiatwR2Xtztc
	7wFQ1N/ekW3TgoIM1N4hiTJof2meFJZBheYZxlQX8QrSBrQ9p6GccHh0
X-Gm-Gg: ATEYQzwE14kE8zXNCNkwYxbaYg+P7XHappqQVPs1uvOmnBPzh9/OPRXlECqItqXF2jE
	WZwkWdezksoIMrZUcZOcLdh6bZ9nse+xR/he0dvJX49SC3tWe367xguaoXpZ1+ZqaDnEgWDO2xw
	kr//9k4eeq7X0S79d7VLRQvOxBkad4TpRBzXRjN+tP6/sJ5fadbgfbQmHqBzbjyjFkmA+jZZ5sT
	vp6mBDxzKWfZZtJw+NrBpAwHVtafKeLAPU9AoBoZFrfTs76y9teRT6YooaViw959/LuvqQ6eV7o
	68vbTKIqz+oY36YMLFEogRSkF3SGqJ83ICHfNT6zw4EGo/JDNPhwegQrz0+1ieA6Pvq+DGcFk8S
	j9wHqV5pKavW6/XjnRiXWaRyPi4uT6x9GHP3ysnA0+CWequMjUWI5vJJr4CgiTp1rAxdmZhZtqz
	QpS2Tm7mLW+zwTTtm8FtaQRVw=
X-Received: by 2002:a17:90b:2685:b0:359:84e1:ba2e with SMTP id 98e67ed59e1d1-359be2eeddcmr1083917a91.18.1772778082234;
        Thu, 05 Mar 2026 22:21:22 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:a1a3:2df:56f1:1fc3:e6dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0154116sm586825a91.11.2026.03.05.22.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:21:21 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: marcelo.schmitt@analog.com
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mazziesaccount@gmail.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] iio: adc: fix spelling in comments
Date: Fri,  6 Mar 2026 11:51:07 +0530
Message-ID: <20260306062107.51886-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spellings in comments.

- informations -> information
- specifc -> specific
- avalable -> available
- Digial -> Digital
---
 drivers/iio/adc/at91_adc.c      | 2 +-
 drivers/iio/adc/max1363.c       | 2 +-
 drivers/iio/adc/men_z188_adc.c  | 2 +-
 drivers/iio/adc/twl6030-gpadc.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 920dd9ffd27a..219245106795 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -171,7 +171,7 @@ struct at91_adc_trigger {
 };

 /**
- * struct at91_adc_reg_desc - Various informations relative to registers
+ * struct at91_adc_reg_desc - Various information relative to registers
  * @channel_base:	Base offset for the channel data registers
  * @drdy_mask:		Mask of the DRDY field in the relevant registers
  *			(Interruptions registers mostly)
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9dd547e62b6c..d35f4487b2f9 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -121,7 +121,7 @@ enum max1363_modes {
 };

 /**
- * struct max1363_chip_info - chip specifc information
+ * struct max1363_chip_info - chip specific information
  * @info:		iio core function callbacks structure
  * @channels:		channel specification
  * @num_channels:       number of channels
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 90919d282e7b..5bd334ec5655 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MEN 16z188 Analog to Digial Converter
+ * MEN 16z188 Analog to Digital Converter
  *
  * Copyright (C) 2014 MEN Mikroelektronik GmbH (www.men.de)
  * Author: Johannes Thumshirn <johannes.thumshirn@men.de>
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 3ac774ebf678..7810d6b2b668 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -416,7 +416,7 @@ static u8 twl6032_channel_to_reg(int channel)
 {
	/*
	 * for any prior chosen channel, when the conversion is ready
-	 * the result is avalable in GPCH0_LSB, GPCH0_MSB.
+	 * the result is available in GPCH0_LSB, GPCH0_MSB.
	 */

	return TWL6032_GPADC_GPCH0_LSB;
--
2.51.0
