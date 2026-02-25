Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43131282C
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048542; cv=none; b=TF+e7yUcM2aJbIeOZ4oaQoAOOdWbHeejgnxfaAm/FCdSPJe+jhko0eqPjL4WE3YJghb0Mjq0b2QBPjqPDPgE5dXbLZaJInUs1mVIFI5IabSHX+FBrv+voxNb3KEnM6YlBIzlQyRklIwe9mOBk3CKAMUWrwWU6O2AR0ogwq/rQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048542; c=relaxed/simple;
	bh=KA3NRYLRo6cyPPrBHOQPFo8PrSHnZspIXBm9ThiE6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra4ezYWfT2D7qdDQ7I1fgWTPVG5Z1inyeNj26aI/sBUC6n4TmBzuiIcxezX6GnkA3bByq3B/X7hLY2RqFdO8OkTArKnacNVS6vPL9yIW9cQ6jl0kTmrRgBLrZny05On3B3MWFEYKSfTPIWm2phL+8Ii2NX2T25MSQxZohXuU9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB+UVtw+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB+UVtw+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so64476485ad.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048541; x=1772653341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OJBu/xe+cK1xEvQ4qTytpgqTUvr2mZHvyticnScKFo=;
        b=iB+UVtw+V5BLwDfYcw1K9AfsbsUXjKvP6eHgzsdsiBMQoJXSgaL6yTZwEVRQ68+lrU
         WciGr3tkT7JUb0uCAY0ElnBPokIuImTJTO4NDmFKsI1IwY/Z4Nd3udPoD/W29pwTyB4v
         US45HVBQWQY4J6agTaXQpFvJXFQrVq3ouleKA/GJcUjXJWCHVM6y+sNSdXA+KIg7qDul
         4unetX0wdtK4rzJe3OEobN4A9YrbGK4wqe8w2szoUBaj89z+lj8T9TWuTOPlucpkMWj9
         qIGyBw7C766D1nL8KVKXzsOMKqW7g+iUTaiT5HhrPugYqVIHUVgVKupijpzlCqVHEiQc
         u3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048541; x=1772653341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OJBu/xe+cK1xEvQ4qTytpgqTUvr2mZHvyticnScKFo=;
        b=o0KRpUsp/zQ4jWL6leiRsYgH/CbZymAS8R7sIEFWlms9DUnQ5RnZLlT8skNsdm0Il2
         8avVEn+X93/BGDl+QPqK2RWI7QGLU6wxJv+BaTss0ARfaSCIYXdGKeN4F6N664L+a+NR
         xptiIyMmVd3H+7ztMe/HQm3/vI4/ta9WSvaDZu2IrxMX/e47d9m7oy8+VYxDJcrxYUv/
         WlUCHISorMt9wmgfF+stjRqE0xsaZaYWfYYMqy0XPHobMqKUXfOXiSx7yLVCzEjxeanx
         /3ndMGbKg7gyaE8ZlhSvNQer2MrKFiaGtbe17wpy2p5PcqRXgMAj/ToudwyqjqzUWggQ
         hgDA==
X-Forwarded-Encrypted: i=1; AJvYcCWPA/AvnoCh7BL22S9+LDDDgwUeoWboQd+7bZLN824O/Fw4aCnM1v5DQ+H1qWwXsfQ936YXKhnjgFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgRy/f4ShP5HSz5HZrlhuLDlao3texUFbB+cdAu9T1flMxAn7
	ue1fauDI7IM1QV00YhapONsbvMNZdjelicHVEkjUMjdXlgyHrIzD/nF0
X-Gm-Gg: ATEYQzxe0lzDUunfgAtk7ICMLm0ZU3bfgG/bBLqS6dW/O2TsuEEHlF+35eX1IEgHrcv
	nhEC1m2o9u2SIXAylRpaVyiRVZv4ZAB9+aPDhbw7j6nZo5gIeWMNhuwyX46LdG3aHJmueV6i6H1
	SGJXvGD/6y8kFgMegrqXPHvXx3nHcTpm5Xue4B7DfwpdfMMxMGwxPU0iOemC7ZplEeTWkc7AHA5
	Oxh1FbkaFQPCqXPUdphtAtIkvt7a/3mZtsfDsPJ02UuXwsKGLbsX8ebW9ytDUGM7lkE71AsFQ3i
	LyUeMNQz8trIGZNJeh9zbf5Fy5JTkL1fV+mgSRgaz3CRTITXBpekU+MIq8r9fp0m6ff/Ii+p9k+
	FQattCv/6tXdqetk/9c2VlN6nDld8ZSijiMB9+pdhZWsJa7lmMFJn6xT3SjZ5WKpBGZ4IDHnJfu
	T55eLgQCcA0uTVGERUlSUvX04jCy/j4Mzlz30=
X-Received: by 2002:a17:903:f87:b0:2a0:8be7:e3d7 with SMTP id d9443c01a7336-2ad7456f999mr126909655ad.57.1772048540691;
        Wed, 25 Feb 2026 11:42:20 -0800 (PST)
Received: from arch ([2409:40c2:505a:f4f0:ebc3:455d:5e47:8a2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbaafsm302215ad.36.2026.02.25.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:42:20 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: 
Date: Thu, 26 Feb 2026 01:10:51 +0530
Message-ID: <20260225194051.8614-4-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225194051.8614-1-rougueprince47@gmail.com>
References: <20260225194051.8614-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v5 3/3] iio: frequency: ad9523: fix checkpatch warnings
for symbolic permissions

The driver currently defines device attributes using symbolic permission
flags (S_IRUGO and S_IWUSR). Update these to use octal permissions (0444
and 0200) to resolve checkpatch warnings.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested.
- Collected Reviewed-by tag.

Changes in v4:
- Used full name for SoB 

Changes in v3:
- Fixed vertical spacing and broken indentation.

 drivers/iio/frequency/ad9523.c | 78 +++++++++++++---------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 6daa2ea354a8..ad32eb66edca 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -558,55 +558,35 @@ static ssize_t ad9523_show(struct device *dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(pll1_locked, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL1_LD);
-
-static IIO_DEVICE_ATTR(pll2_locked, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_LD);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REFA);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REFB);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REF_TEST);
-
-static IIO_DEVICE_ATTR(vcxo_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_VCXO);
-
-static IIO_DEVICE_ATTR(pll2_feedback_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_FB_CLK);
-
-static IIO_DEVICE_ATTR(pll2_reference_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_REF_CLK);
-
-static IIO_DEVICE_ATTR(sync_dividers, S_IWUSR,
-			NULL,
-			ad9523_store,
-			AD9523_SYNC);
-
-static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR,
-			NULL,
-			ad9523_store,
-			AD9523_EEPROM);
+static IIO_DEVICE_ATTR(pll1_locked, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL1_LD);
+
+static IIO_DEVICE_ATTR(pll2_locked, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_LD);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REFA);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REFB);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REF_TEST);
+
+static IIO_DEVICE_ATTR(vcxo_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_VCXO);
+
+static IIO_DEVICE_ATTR(pll2_feedback_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_FB_CLK);
+
+static IIO_DEVICE_ATTR(pll2_reference_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_REF_CLK);
+
+static IIO_DEVICE_ATTR(sync_dividers, 0200, NULL, ad9523_store,
+		       AD9523_SYNC);
+
+static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, ad9523_store,
+		       AD9523_EEPROM);
 
 static struct attribute *ad9523_attributes[] = {
 	&iio_dev_attr_sync_dividers.dev_attr.attr,
-- 
2.53.0

