Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D9386552
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684932; cv=none; b=Pg3dkf9jLMTjv0gfzzq1SNu+Y1LSrqRxFUaSEwRmpDX6uIJC51izZ+duFdFN4HRDYkq4nXIfaJmvVWbUrHlBUUdmcjQchL+AGAmNJaMwNoP9JpEoEBZWqzpNDe9YSBY1la424tm4nf6MM4EhgJpZopV3RsAjzUXpoY4+ZSqhq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684932; c=relaxed/simple;
	bh=vmov1pEJBH+Rs3GpKL7hdtxpWbbPQv3pfJjcajOE0ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBzaqanW8mqDCayRXRGZR5otkj4gOMXmxLFsu0WqCNoWUKh9+KDcT2i/eUXZb0lB48bw4FOkmLIttkJRiNe5ZM+ulGc10DJqljDu8u4LYjgf2YvcxGbPnJV9MVSv53DutDTBmfVPAhq04QgAd6XJjt9kI8fpYVJAgLpiwhGHihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrNBZEYZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrNBZEYZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so192304f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776684929; x=1777289729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+pmA33HsYlT05KYLULHj0zn0MHmQJIrBIibT5vZ8w=;
        b=rrNBZEYZVhZr3x2pc3RDcmLA7LdPfpCURhdIKbZHM+LlomkgiSsQMClZ0sr7Ce3KGr
         8ufrLp09LejkCVJ8PEqoWt5Ops6+72ieRBZn4l4YTiEw1o97PEYBIzAIZyBU4qK7OPnb
         86jAtfdTWSOpo8TkyKpD63ptdwR/hLxNNmc2wLtfux84dnoNsvJ9Daf3UBsJDG+Mdxe+
         HqYZS16moBAzdee53JqptCOkruVZoDkEB+IODJqzyyEHZpu2oNfQyE64JaGFGMD1paQi
         uAvgPNvyKr+/3VOCHXzwUQUbMTDPEFywVP7EzCIrYi/b3koXshQWMKodVjudJIWqwAEB
         OrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776684929; x=1777289729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz+pmA33HsYlT05KYLULHj0zn0MHmQJIrBIibT5vZ8w=;
        b=T/3L+RIM7Mhr6UJij0k86i48DpaC1f/SOEVbIW9C41rKumyHMPd7CrNx9uMYlSZXkC
         4LEjNGtJuQKKkD82qI9MlE3R5u1wO41gIiCPM75RQ3oZ1oweYLugXvVOuhWFX+Idh0AK
         3h8BDsB6BGu3NfSrQQV09mrCo0LLd5ZV8MYghBkoE7Zg/oKRqyNPaBfj9f42ModSVXD6
         Jw+KWq9mcVzHyBoIBbQzbTIWA3SD6OqTQJKAQ+XjIcnXVFK7OjG3dFJl/kTolIqTcLuz
         tDn9lDE82dCvFgynD8Lw78S04X1MtIN7yRA+aBIxry5EHUXWtTz/3AUEPZ0M4g3Ha/IP
         nsww==
X-Forwarded-Encrypted: i=1; AFNElJ9adBzVUNAgWWK03ncs2Sbqt2OTvmTpAYTecR8JxEMHqfkehG0RF9Lhq9rGlX/EZLj8qftRXqDgx5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSr2zgIOAw2NsvOlWP8IuinXyJn9uTuphvuLVVmE/Bji3SlCy
	2UQb+mE+/uncuQ0j+ueKpGMa5+pJWsewes8+SRNWGBwYG/HvMnifurHB
X-Gm-Gg: AeBDietseEK7aJ35ApRFqgFHLzRS5ISXK+UBVIoY8BLYLjI0xrl1vNDK7W0Ljbxmi92
	EZ8q3LLbRBcNBji+itAp2kxheeyVRS+Wi14Zke1h8jlX8AC/KvCd4HGsB1XFyny+G3hFDIJjxbx
	FMOVbcMCUy0Qa/LV5bTAqgAvJR4zVHyIAAmIOsj4jUMjWbe0FgxIst3Zlv9+JH3Cm/oJrrM6Hx9
	UshrpOdOhs9oXOO3+HnZrdnt3edCGUGRS3dvG7Fx/aSSUzgmIYWA+OuDCGNScers5vh3DWsjBWV
	hM6IzsfPcMdq/T2ThMe8Oy3YDVIXZc5fLjFCdh/k/Gqzw7jxoNpDVACrnedv145y/KCkp9mns8D
	hykY0ETnTeRdkRdaCiECcXY7fxm27C5mQltTAanbFeqXYm1mcnpnB5LEPILv8/rC8jj9rJlYTmT
	gtIAOVd/bq5rulpKZLeN98JBg3dBqXJMYi5AlkejZMPc34E8XRA2ehQ/7cnLW7qpQ0RkAReW5bV
	OZtjRHVE8Tud2T6nAWgztfS0VCbQgaKzefNYUQxYu/+3SK5kYFZBnZi9cPlnMs=
X-Received: by 2002:a05:600c:4247:b0:489:1dc6:d6e with SMTP id 5b1f17b1804b1-4891dc60e71mr11320735e9.1.1776684929103;
        Mon, 20 Apr 2026 04:35:29 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c320084sm119227705e9.2.2026.04.20.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:35:28 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads7924: Use guard(mutex) in ADC read helper
Date: Mon, 20 Apr 2026 15:34:45 +0400
Message-ID: <20260420113445.126516-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() pair with guard(mutex)()
and move the lock into ads7924_get_adc_result(). Keeping the guard
in the helper makes the locking scope match the operation being protected.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
Changes in v2:
 - Move guard(mutex)() into ads7924_get_adc_result().
 - Drop the extra scope from ads7924_read_raw().
 
 drivers/iio/adc/ti-ads7924.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index bbcc4fc22b6e..5f294595a415 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
@@ -198,6 +199,8 @@ static int ads7924_get_adc_result(struct ads7924_data *data,
 	if (chan->channel < 0 || chan->channel >= ADS7924_CHANNELS)
 		return -EINVAL;
 
+	guard(mutex)(&data->lock);
+
 	if (data->conv_invalid) {
 		int conv_time;
 
@@ -227,9 +230,7 @@ static int ads7924_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->lock);
 		ret = ads7924_get_adc_result(data, chan, val);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 
-- 
2.52.0

