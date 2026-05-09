Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A138CFF8
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336560; cv=none; b=jfjPMErxJUcH//a8GXXPUBut1p2qClveW1NAGNDYcmXeL2vyIjW9hVGvH2yXmxvaiXoZqpr1btqnBdIx33OzZEzyfMPEG78PAGsgvfWUW2oOVjWXbBrG/VTI4wgXCalXFaTXljSciWkJGw7/bdaH15fFDh46GAk1FIz5VyUlLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336560; c=relaxed/simple;
	bh=E2/2xrDLF01RqPtbbjfr1THrdhR5njO+Hn8BI2MmETM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RspvdJYAReBajZ5/qebzfR/H5IxMUkfhxztBUIFdXf8ftfvoCToLlAxPYAFxChvZ2DkCl+q7/UtMp6qiGOCFGBu+IfCDBy/nLSQi9fMVjidBMrV1PySdikrxfczPDn30nrX03/SAUnd+40QaOFLX+ffQsq1lh6dwz3U99BoqeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BftjpNvt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BftjpNvt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso32141195e9.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336557; x=1778941357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIWO8QWny+6F2s+uW0e9ZWzfRgApaENsGndfZ/2xHlI=;
        b=BftjpNvtV+xYxdx0znm9Q/Omfk66ETiEmge/rNURZi83pOnQjEPjmoYp5amHk8JpDi
         ZdyLfkY5UKie1qxLCDaJ+qfF8qMGO6K7zP7uC+gJm32hccO11922AyzBiwcUgMyYA4Wq
         H+ucHXuPlwr0Wwob6vOIas9MmrQb0lQlc4FBILnwOlivN2BwG/IC4plFjcJkXvCgi89F
         07OHXXH5eMuqfLUzFcharQWrIJ8ar31DiU3jaBZ/kYFZWck7lb48oTCqpnglToWVhxyC
         oNB1SKDz9ynn3MOtp2zBvUYp75XtKHji1Z1SiI/F3QhTZLTRem6fc4Tsy5ghVNELuoXX
         NkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336557; x=1778941357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIWO8QWny+6F2s+uW0e9ZWzfRgApaENsGndfZ/2xHlI=;
        b=E3OZEX+XRovG9IjxX9CXx+jwCZPsm9ak9fgGB4VBq3L5Ir7hCFrZWRY6KLK1Qzsm+T
         JPxck9irt4R/WNKDyV9/sQ7gI5hOBcU5LY6q4e2AGLA1QBNAlbFPRc15GL+aSXrgb9mv
         AIDEuFEwTjZC7Dtz2gnOGdKuLF/ocVQWv1VIK9rSjOxahvQ7mWQlYcUzs7CzIFd7KZiB
         uyBsRj8ZABDeacYcONH7FMkHbqv8TPI5YniC+e2OH9oNWcTY4HnJ9JSm7e6eUijjFMY0
         a76O1KfnmfmC3bKchT5NKwHEGY3erEda9GsqcD6fEGEs0QEbfZTnNNIRC5RG8y4mniWi
         AQCg==
X-Forwarded-Encrypted: i=1; AFNElJ+h2qzIiDnDa9tMmvJp4+U48kGofrENpdoBGcWCWZr8rOZsbznuCeI0FpgpQJinv2GRdg34Co4jLDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiimRpKdvGpxB+TjR4qt6zWAS8he+yFQHFx0Xg/Hg82iJAkmqu
	wuPn7blzT4uoUbwuJ9roezFbbO8P3sZq+2CQaLMwVr21gvEdmxKmTWHoc7W6e/JQtUM=
X-Gm-Gg: Acq92OHAa9DOF9V2su4SJ7pvJQbj/vDpPMC3bVRDN+3Jf7zhtmMtgbiSj8wpwP0X7RH
	RzzTEnnZNTjSMT4gkUmmxviEj+PiwGKaGErTOUxKYMnL3BhxWCtXkHTdB6YW/I5FtdLWIhwIIMd
	xTT3t6Lly3Sxlbo3/wPbplrtONuBxId6kma7U4u/dJrWtaJgW+rq/KBD63xOSq4EQWLUkR/SJai
	mY03MepuTrfUQsWMq58sIrl2fNWI6fI27nETnHd8ykWTeI4CfwldSDYG8No8gY/P+jDeIIPk8gt
	DjIi0juT216apAnapx+/+8Nd1JIoTNejgp/vY6UL540sZoOn69+oB1vWCNFMLReTSRjRRlw3Pm4
	EoHh92t7jjXIn1yva1s6zvMf8QhBxJfxbUYd8KexagFEEOyt8sp8YWv010fI+vqwJ8ig2W3Xh30
	2rIVAI7K2kfac4NS3nG+J916z8moQ4ByqToFkaLMEX726UYacDsfFYYCJ+hQ==
X-Received: by 2002:a05:600c:c094:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48e51dd89ffmr199033075e9.0.1778336557435;
        Sat, 09 May 2026 07:22:37 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:37 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 2/5] iio: dac: ad5504: sort headers alphabetically
Date: Sat,  9 May 2026 15:20:40 +0100
Message-ID: <20260509142047.30302-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange the include headers in alphabetical order to follow the
standard kernel coding style. This is a preparatory cleanup with
no functional changes.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 355bcb6a8ba0..03ce37e2c616 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,21 +5,21 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
 
+#include <linux/iio/dac/ad5504.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/dac/ad5504.h>
 
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
-- 
2.47.3

