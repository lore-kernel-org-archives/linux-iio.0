Received: from cvsmtppost02.nm.naver.com (cvsmtppost02.nm.naver.com [114.111.35.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB136332614
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685055; cv=none; b=kOclWG4wguuTCbVGRZIe6D4Rsa5HRtrathJX3ayXbjEscwKwJiVsKvu7h+9UAdY/FgDnrPTESeVyr1uYl8mEKwiJl1YbWLjlD+5qYp91WAT7EpSHWMbwxWaTxlJUAFo08iK0IuzQTbsqaagJXiINMSnSP9Whl5evHtczyayc1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685055; c=relaxed/simple;
	bh=8XifmBjRXAmCF05BRVFiftLmsRfF3B+6jLWYzxxr2rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7oiTTbg5SF3+gohCPHSwfxRhqA+OcRjmpQ4yCheC0uGKWnD3vzmiXjKN7oSZEizz26L3i2i2+OKZNcuWnlPLxWxa5guIR4URe0kmobPsCX+46rLWHHv/G//ASXrWHDUanR5QDSmq1K0oiohD1dNjghrlaEq/zbzHe300KOGn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=Z4P3jw6f; arc=none smtp.client-ip=114.111.35.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="Z4P3jw6f"
Received: from cvsendbo031.nm ([10.112.22.37])
  by cvsmtppost02.nm.naver.com with ESMTP id NvqzIGC6QUuJmM4xH0piTQ
  for <linux-iio@vger.kernel.org>;
  Mon, 20 Apr 2026 11:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1776684444; bh=8XifmBjRXAmCF05BRVFiftLmsRfF3B+6jLWYzxxr2rU=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Z4P3jw6f2BrkPmJHfgXRQ4YYFp8YRuJ01nnrmFNzdZju7Viob1FnGPtU1jROeJdaF
	 G0vqlwL9snjdrVI8v6d8wf5MlJ5Ip8lMshUiLKiLkbrAhFHST4t0Gq271Gb1d0UKcW
	 ZOUHeTVQvd30gf/Q/Ad5MkRL7ST3zDp2sN1/9ovVzR3qKpD6yXHOjCohslsSyUDdNP
	 /tSavAQ6er4GWC1nJ/tOlXD/OYzaz6Ufi1YjeO/5uYekzi7DKkt5d+dx4jCskSY0tS
	 aDafbDGb+SyC4LpLd3ZTjWfcdQiIhxwRhsH+A9D2iNrPsBlEwy5DXYJ7u2nBX0UtV2
	 ZqPFPjIikYaiA==
X-Session-ID: KRQO1LvrS-yNLCVyk89Zpg
X-Works-Send-Opt: p/Y/jAJYjHmwKo2qKqJYFquqFNwkx0eFjAJYKg==
X-Works-Smtp-Source: gwn9FoMXFqJZ+HmdFAgZ+6E=
Received: from JMW-Ubuntu.. ([14.38.141.199])
  by cvnsmtp006.nm.naver.com with ESMTP id KRQO1LvrS-yNLCVyk89Zpg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Mon, 20 Apr 2026 11:27:24 -0000
From: Minu Jin <s9430939@naver.com>
To: lars@metafoo.de,
	jic23@kernel.org,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Minu Jin <s9430939@naver.com>
Subject: [PATCH] iio: adc: ad7816: use sysfs_emit() instead of sprintf()
Date: Mon, 20 Apr 2026 20:27:20 +0900
Message-ID: <20260420112720.1662703-1-s9430939@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit().
sysfs_emit() is preferred than sprintf() in show() functions.
It has aware of the PAGE_SIZE buffer limit and ensures safe buffer handling.

Signed-off-by: Minu Jin <s9430939@naver.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135f3b..0e32a2295990 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -124,8 +124,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+		return sysfs_emit(buf, "power-save\n");
+	return sysfs_emit(buf, "full\n");
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -156,7 +156,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "full\npower-save\n");
+	return sysfs_emit(buf, "full\npower-save\n");
 }
 
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -169,7 +169,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -231,9 +231,9 @@ static ssize_t ad7816_show_value(struct device *dev,
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
 			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sprintf(buf, "%d.%.2d\n", value, data * 25);
+		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
 	}
-	return sprintf(buf, "%u\n", data);
+	return sysfs_emit(buf, "%u\n", data);
 }
 
 static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
@@ -281,9 +281,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		value = AD7816_BOUND_VALUE_MIN +
 			(chip->oti_data[chip->channel_id] -
 			AD7816_BOUND_VALUE_BASE);
-		return sprintf(buf, "%d\n", value);
+		return sysfs_emit(buf, "%d\n", value);
 	}
-	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
 static inline ssize_t ad7816_set_oti(struct device *dev,
-- 
2.43.0

