Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393293254A2
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846079; cv=none; b=rYSvptgpiKktQazIvLdilQl57ulWgV2YGO1kecI2rgxt/PsstnJiWeO5kI83ZFFRN8zPgjjXhJVQWLTkMHjIcNQwcFB58mz0de8j9PwmUWMfGSVKpoqvXHIatlN6cw2+TO4ymYKfvOP+cQhUzfgk/1Z05IBpZSqzgrTFp2KwUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846079; c=relaxed/simple;
	bh=6CTNQnXIw7kksEaIR9OM04M+MlXeuEuffyRk9pjl+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/qMSa8z8USY/CUeZI+6GPTsYcP0iqMZJDoYc3Ec1vtYwP6AEUnIciTAiGGSmsDGaQPfUafPNTAVCa5X4CWGR2XOKmly1eW1udozP+QG4c5vUMz6waXE7FaorM53JxqjIv3Tbl1topDs/OTXz+HJV7kaXRzvojlhegsdzAE5T9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG7lKi3M; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG7lKi3M"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-961556c15ceso2304555241.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846077; x=1780450877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MPAh5QH40jCf+sMWnChY1UnCVNKQYwFuDgmckLLgiU=;
        b=gG7lKi3M0jqD32Y6nGOJw8NylRdj30Qe/j4l1/sYuy2pwKppE39FGtbd33cCySmOmh
         GSRC9OPqwE6Vw7ezW1v6lz8W3gEiaVVVCdbLVsYp1p35Kuuxas9btm4Xfu0llrWV/Wbf
         /wn+RSNu+Sn4NoeYoYyKowhiPL7kzDZYWG9ROIpZOziKY6ziOozqw6tbhNOnbE77bTg2
         49dLVDciZI/66MKRc1iJu/NayfwaTbOEWPB//W1UOukZAPiIUhAKKtAZhtPhdjPWKAaN
         KC1qxrJleZ6pFWjKLbIvNDE8wEo6Z6yZh91YnQIWufXk+cxoHYLA35OoQword5GeOOF3
         Xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846077; x=1780450877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6MPAh5QH40jCf+sMWnChY1UnCVNKQYwFuDgmckLLgiU=;
        b=E+DRT6GqJYEyFfVxH1vPIHU+4517iD4mzU24HDfqDebpVmtdFIn6yUfuVufdNB4hOV
         6dwYy3W+mB69Uge7zZb4m7HXaYjFa4ld/6oTkMGZCJ7vExxVOTIWg19rkvpnoI6meWHx
         pqBpwomHcCyhsFKNtOHyWV1mUOCiSK81VKI1L7ZV4/8mkxKNitsrhQGI6EIaSzq4VCSe
         1/Fq941wVP4ruX+YCDW/9khy9BFY5oOd94wMecsS9SaYbfT+wjEP0V5+Dy9sh60uSbV2
         SaeU8fqY+LhgKOXUgZwRbNt72LsQsPrIVACTcTc5dNzRY8qWxUupbE8HPouAVCxsDvZr
         S9qQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bPD25BaKFF/T7TTNqAAO3MySWlofgr+uRiQSrkPY4lc4T+bFTBU028rtrx+YvUDUwsI3y6kkBs24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSQbQwDgtNisaG9Agfl0/WuIXEMWUuonLG/7XywJjZRp6ySV0
	F7cMVi4qvYfb2F6kVQj9eLsZfu23M4BLOwx4THeOIsuQY7+YlHDz6WgC
X-Gm-Gg: Acq92OG7y93Fqqp3cqqqMi/gExXMMDX07wl+C3Xlw2wbWFD/g1oXU4XuAVV1VJmoXHN
	eqbdaZ7d1J5tdr5IYtHf6f1nwpTiy900DUVaA2VLLT/AwslkIe5CGmmGyiiRB2lkuyRq+HTOiTv
	sv8a42MRSWvfUzDo2hHd4kMTcOTSkRSnQTwVV0OPUpGMm2CQ4rE5BQb3mI6OlKMym7IqEWVsRfC
	0Qay8yUO/m4vi1vlzGTQd3BL22/geWXyIrA7h4QOsFrz/y02dSzAmeU/poc0BvU8igUngjjtVjS
	XgGZsraWxVS1jGY6NgX9ElJZ9hNlkUHacJpvict/ggX00iwyiEgh6Qmuqu4tLNxG/GR0xaf5/Zk
	hG8XCbd20e9OWpfPnzfY6nrPLQq2ZxBs3+DaKtThdjPpFHlM3ngAGnkqPWjXXZzbk2QAMCik/9m
	3OKQ1GRZ4M1JP/TYyl4Sa0WK4ZbZ9P22vufVLrZy2a2eAYcvtL/xScUH7ff30nTvOxz0OfmdjBV
	OX1aREDeSqAWg==
X-Received: by 2002:a05:6122:8d3:b0:575:24b5:88e7 with SMTP id 71dfb90a1353d-586628bc866mr10919647e0c.11.1779846077090;
        Tue, 26 May 2026 18:41:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:730:757b:d7ca:355])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm18491348e0c.5.2026.05.26.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:16 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: adc: spear_adc: align headers with IWYU principle
Date: Tue, 26 May 2026 22:36:40 -0300
Message-ID: <20260527014058.35265-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
References: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused includes and add what is being used:

#include <linux/array_size.h> // for ARRAY_SIZE
#include <linux/bits.h>  // for GENMASKxx
#include <linux/dev_printk.h> // for dev_err_probe, dev_info
#include <linux/math.h>  // for DIV_ROUND_UP
#include <linux/mutex.h> // for struct mutex
#include <linux/types.h> // for uXX definitions
#include <linux/iio/types.h> // for IIO_CHAN_INFO_*

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/iio/adc/spear_adc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index efde6afc54fd..4be722406bb5 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,22 +5,25 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-#include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/slab.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
 
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-- 
2.48.1

