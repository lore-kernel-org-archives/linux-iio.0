Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4652C1589
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536996; cv=none; b=oqaiJRmtWSUnLjZNEi04th9i1sKa6rA4tk9n13AqN74qN7EcAH0cHBeCa8QiUUwM/++iZFvoFCDBjFoUPSt1T7HuVDo09m7VvOJswjSk0PDAQutWKPwQDXt61tLDdKYas+cgoWKx+1vJTKOEI7rmTZehlKtHCyd5WKdAyI5asuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536996; c=relaxed/simple;
	bh=FA4WOPgvDycyyHB2/mEGb4o0SEvbAYbqtnEqBnxYnHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQY4/1qG6nc3EsnKq68Z/GWRQiiFVp95tEi7ihj73mucrLM5ZbdRdK8cbkikn3cfQ2IwJnDQrM1mcQC2gs2I2F9yNPD2Hub9al6DXbiHfhTXoaKlJEJ/MjnyMaWWCenZgk3aCS2rsJx9YfzLG3BoGI1dABD9bExzyinxLBZSOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyB5sL30; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyB5sL30"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e2355739dso477584a12.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536994; x=1772141794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snfBJanBL4Z/KaYXmLO1nWQ2apjpeu56D3VSCWFakAo=;
        b=SyB5sL30vcLonMVB9mNLy0NWoeKac1OVFYfW+mlzeq3Kikh3qFuOkMUbHG29LIkm5D
         xveuy3dWAtY4JyVBnt/LwluX0sOWqEYBYlb+xwmnEuSbYmgl5tnP9VahNlgASMW81oJ0
         kZ+uRiHWJh73T7gqIjd2xdozQIsZZWAbpTM1JOGpVTqeB3VOkvj9AZJgfNHJTJLdrJcT
         1uBPtru3TZwDjCA5hGAKqY0eSbwTI1+x8Hhj5OcfQ5RNBDqMvu06NOA8ihGZNyhiGMKJ
         pm8damdJSNxTcC38qbeO38ryNK8QwQC3mpNd/NHLScglC8nqoDU1CBT4cgu1N9fyx7Hl
         t9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536994; x=1772141794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snfBJanBL4Z/KaYXmLO1nWQ2apjpeu56D3VSCWFakAo=;
        b=eUp3mqsEjBYmT6Va8c7JxyKLL84eRrVn4QK1C4sC86sQlradcMqvXw8msahBJczxk6
         dPgZAqnqwnR8AJMO3fZKA/stplPq9zMOxddTMTJk9DQ9ykx4jNveez0YF/E40qxu+zqH
         txrQqWuL4GSQiBXHYbr76ka6UPLGcwEq2OQkGZFp1GBBKmAsBnyBxsnv8gXXTuTID8QI
         TUFrGxrylTP8GzZ4E0MuuZWEs6h25dbRLhXxvxctSge8p8ybgJhssRmWKUV29mGY1c5d
         kpWS95Belo7yc/qwdzcZz4EgVn9R4IH0ZStz4P/a8+SxHzBxjABT59WQDQoRdWlGDP4z
         ORgg==
X-Forwarded-Encrypted: i=1; AJvYcCWg+RIGB5tCoy28mUGVWKTDHFSfyWXyesFjvMF8Y+MKvpaGi2gi27UCjVkj6e2UqMKiRBjqAoioSe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4y/dJNIuzZBmoBBkQhz4LtofJ6ix6Y4xrW1Rg53Qx9gzT0mo
	NieKyMx2akFSj5ZWemZCDYFCSvOXMjza05Lf3DO45Oynm4tXUJMOeqWL
X-Gm-Gg: AZuq6aL3rfLAUuHhW+HGJzwbFV2nFu6u4Fay2Qziq0utpsm/3jokdpGOzCloYznnp3Z
	HeFDLhfNLlGYZEbFa5WKbIB1Ro7/pxnm1eHIgoVFQCjlNnGOtGDUxEKgGkTI2Q4A2DCXI1cbVcO
	mU2Dyb2U+mqdoDXNbiC11tFACKUtwnYreGdV8jSZWmVqSyM51pJ83qH7eCDK0TSPymZC8utXm4I
	JLojHUqrS92mK1T1wvIMd4bksqvfT4mPDqlh11WMbwwKqEOo/ua5YCVo2g5usgCjRAWSDRHeTit
	bxGvTm8sA3qQj997BSuHJVJmdCHgp2kROcDf48qtVKzg/aoSRuuyT+p/ko/MJyFB6wkbTNfgjqK
	U9VJo7ViH3q3O5sLgmngyRsjHIGmCGHTrCSfao6DP3zsgPj/YSH5tZShjdP2mVehUn1TXZhvONG
	3IetUIjMZa81dPAAtAGCQJmyvN
X-Received: by 2002:a17:902:f651:b0:2a7:d5c0:c661 with SMTP id d9443c01a7336-2ad50e9dd43mr67541685ad.15.1771536994270;
        Thu, 19 Feb 2026 13:36:34 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a7145cbsm238938475ad.30.2026.02.19.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:36:33 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v3 1/3] iio: frequency: ad9523: fix implicit variable usage in macros
Date: Fri, 20 Feb 2026 03:05:47 +0530
Message-ID: <20260219213549.59645-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219213549.59645-1-rougueprince47@gmail.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
named 'ret' instead of using passed argument '(x)'.

Update the macros to explicitly
use the argument '(x)' for their operations.

This also resolves the following checkpatch.pl warning:
WARNING: Argument '(x)' is not used in function-like macro

Signed-off-by: bhargav <rougueprince47@gmail.com>
---
Changes in v3:
-replaced 'x' with '(x)' in AD9523_CLK_DIST_DIV_PHASE_REV(x) and
AD9523_CLK_DIST_DIV_REV(x)

 drivers/iio/frequency/ad9523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..5725ab62e0fd 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -167,9 +167,9 @@
 
 /* AD9523_CHANNEL_CLOCK_DIST */
 #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
-#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
+#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	(((x) >> 18) & 0x3F)
 #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
-#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
+#define AD9523_CLK_DIST_DIV_REV(x)		((((x) >> 8) & 0x3FF) + 1)
 #define AD9523_CLK_DIST_INV_DIV_OUTPUT_EN	(1 << 7)
 #define AD9523_CLK_DIST_IGNORE_SYNC_EN		(1 << 6)
 #define AD9523_CLK_DIST_PWR_DOWN_EN		(1 << 5)
-- 
2.53.0

