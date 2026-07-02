Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA938BF67
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019876; cv=none; b=JZMD/cmwXeG3UoxlWL1KO9yI1sp0F/SWShBbfMuoQA2cqMMYCyD8y8eHPEBVJXcmO/Izx1tsYdSlRLU4uAyMffy+THnNsiCDJo5vfm1r/OqLhLsk6lQHdlzX8HASYakf5ISOthOtq2rEMiCX627ZuKYBNMEBAEJ4R6jMgYb37gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019876; c=relaxed/simple;
	bh=SoK/2sB5mD8oC6aHplibSXd6K3oQA0Rvr4iFTwI/2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/pAOtHM65SD9imwby93XacaZysqjZ67PF8rE2YDEvkOKaRWMeNSRsAd2E6otq1MytTrjl3/tjLvtKW5r46udM/NR8y41nQ4Kvr1JdSB74YnnX4n8j1IDuWlIyDZps/S51LvD1skEiDfKHGTyOoD5NzqKafJtpk++XOD/QWx6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvT2uPbh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvT2uPbh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b779003fso10819045e9.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019872; x=1783624672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyjDTrDw8lGMa7aGu5H95qRreDdDZe5SZPieOoHxX1g=;
        b=KvT2uPbhXXsz77Z/hUOim81tvs7dzzZWhsA6PhlsNUToK2YGQeRVAEubGDTmeJe6im
         8ZlCDDI73bp/kYCI84ESZ6LAUJ3vSvDRELZqCgWqxWoOStZZTAxUp0ONaJx9gBn+P2Og
         Hub8sv731uDs/qu68f63yC+EYk3OLBz/IYnG4XF+Tw+HzxMxvqUPF+p5vzkMpO1G7Z2F
         wIGY3DBQPOMPQUtWSxeG7UQeU083RDqsMwNGeptqcj0D8J3vsOOH2mZqvICzcOnOtRH1
         cWEtqDH8O8J2eNYgh4RhAsO58U1Sc+oqAk0boQLTXY2cMzH2rfofyyOkkHalg/jcQTs5
         rglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019872; x=1783624672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyjDTrDw8lGMa7aGu5H95qRreDdDZe5SZPieOoHxX1g=;
        b=U22doorMDfq0VvXcRy4MtEmm81lv7QUOdWsW+RwWRzbGSWHgt1CKBKWvmmdtseQ5G1
         xs4JzVzj20QTwI2nEDhesytlWyFsFRwLUNsPp0z3ueCfsjYt8yWBtN6V64dfUR28KNI7
         Y2WxUI0rItjBxomfCsqUhKQ3gXiUL8xEAOGvbxrEQLsMYGZBS7rCIxy79io/TW9YoljQ
         j8EH0yKUcTG8leH4TjJ5ylFBE2KtqjuXc4VSfFI+972Dg7jWEZRU4aUJkbIVUgwkbKRs
         ulzJAkCDz/00Q2ehkq1HVCgjW/leDP71GCdEtKa5hxDFf1U57QhBSiuvZ0bd9bkSBX+C
         Fwmg==
X-Gm-Message-State: AOJu0YyFOdy5MBkkP1hDTzR4gcseaIC3Sg/ttbXZo6rO438hiGSr75va
	vdyuS0BD86e10FSCHQ6mov4XM5mxV0SQfxNaK9L0kvhpYGQQ15rBtB5d
X-Gm-Gg: AfdE7cnlk2WcibNq7GbiBVcBHdhVcgkEV0711+nYkRgvuijcuWbYLMciqSrViMAnknr
	QPz+kPD5N0iyLIS6cJDvHC+USsPbVAR3C6wgQX88K6FeY0LQEluFAbg9S/Ht1UBdHTj2YkzbSSq
	1QsdQYo63DZdLi8NochMzJBJO6E+ML8YHHHW4AUwi4n7oVhyfuBBzV02kzhq+6YJ3lJW+2L43ik
	uCm2obd1PINp4GnJmHFDnocHD8jz+9JjUGJzHPrSSTL536f888PwCySLTXFeDjdyvj4eXpz6ZaX
	7cVc+eIe9gwHo1SIhs/wFjZSkINkJfwbuzXmAJI9Ac59l1o5+XMye418/DcDhJLPKgNH00rRuI4
	fi0Q81x/7VzAyx7fEq/0Zq33kO5aLwtiDqWOIAd9keR8L7sfieD+gaxb18JrNBmBMUAqAUr8PyM
	z9vaUBPKiXg/EqxYCsK7z89aAuFxodyCWEdV/RnR1Fr9nGiKZOImpWNg65elxwYMuibcQ=
X-Received: by 2002:a05:600c:3486:b0:493:c634:952 with SMTP id 5b1f17b1804b1-493c6340a19mr55379025e9.7.1783019871631;
        Thu, 02 Jul 2026 12:17:51 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6368f89sm64678805e9.8.2026.07.02.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:17:50 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] iio: chemical: sps30: update email
Date: Thu,  2 Jul 2026 21:17:42 +0200
Message-ID: <20260702191744.118898-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702191744.118898-1-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email has been inactive for a while. Replace all occurrences
with the current address.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/sps30_i2c.c    | 4 ++--
 drivers/iio/chemical/sps30_serial.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 61781aaabd85..bd4a2e6eff5f 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor i2c driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  *
  * I2C slave address: 0x69
  */
@@ -253,7 +253,7 @@ static struct i2c_driver sps30_i2c_driver = {
 };
 module_i2c_driver(sps30_i2c_driver);

-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor i2c driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index a5e6bc08d5fd..c8bad4de0c26 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor serial driver
  *
- * Copyright (c) 2021 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2021 Tomasz Duszynski <tduszyns@gmail.com>
  */
 #include <linux/completion.h>
 #include <linux/device.h>
@@ -426,7 +426,7 @@ static struct serdev_device_driver sps30_serial_driver = {
 };
 module_serdev_device_driver(sps30_serial_driver);

-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor serial driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
--
2.55.0

