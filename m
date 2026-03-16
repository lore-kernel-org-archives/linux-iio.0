Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23E382F3A
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651691; cv=none; b=OuIBzax29WSFfFZeO/AN0kUa0XB4YbicU1F48wSAgZQGvlRcq7C9+F+cGviK7Jk+WWSS9rwT+06lM3uLWhkQb4sA1U3UM4/nKysEBBECJvazEspie+yEiUmRUgcs9b+XngKIRnj9F+5yKF73PV1XzoCVhO+VfWF6R5vRzf/MFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651691; c=relaxed/simple;
	bh=Gs3zY5KGIX2nqhc8WqfOuJGK/XKU9gPfWtSK30NEYMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbEUK8l8Z+lME18WWfIPhyhfINiySwidYIIeGXdonl8uhWb/VdYvA1xkbAZvQuqo579Z0PHYLuPP5uSGjsNn1ihPpvfNd52s6RCPtCbZwP/VCdtnmHwlGPkxY3Q3XCyj/IRMDJGXJRmCf2FZkxioK6+kxHsTtyGZ2MDSG6BR/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXd1NnMj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXd1NnMj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1126938a12.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651690; x=1774256490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0s6VZrlSaFsXdqFp8sXze64L79nq0Bq0Ita9pFkYx0=;
        b=iXd1NnMj2hFH4Ss2JgGFOVZR0bijD6/APEsEvq3ZBjN2kiprEfL1wstVBFCLTHved8
         vpuyiGlTXBWt066MRcWMS88+Zao6jvc+DUdeOzwO9R/veIwbbulrmZ2DieUZ3KErmXdm
         dfQKpE/YeZx9nA2PDnO8AGYER5Y6XwRpbgcuwtofwEIKWsFslyJifyaTTk8jd+TMEfkl
         xK3K5bYaVPFWMkD7YcZhd1UsjNSs/UTNgeoo79NwALbWXGz+hHVw8ofHm8Glhuh+d8DW
         5VMF0nX/CWyAv4E7qrT3SSE6a4brS/LhB3GEncaUqpBWHPP0lFwqUmdMXX+9ZFsC+/iK
         TGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651690; x=1774256490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0s6VZrlSaFsXdqFp8sXze64L79nq0Bq0Ita9pFkYx0=;
        b=W/glA4UeSUHe9kPWX5jiHbLUatDP2E+5AejRyZoi6yhOrFAzEZqu61hGKXK1cbgNmz
         XKpjWy7gyOKLS4Z4stjhQReOmvzfp3UhwdWjeXPLCkmoBznienSCmisXIYQuYAMhxXtB
         bevSRicXasXlUQ2a4jnOgFH9o0Lvwaxu9Of/646wwubrz31Dy6DtlhXGx3sisAAozF8z
         T+XmmkVFFbPDrhT6a6ZRnyvWWJCqD23Y3fNvowYRSKO6XixlLdvkNHsAuW9rvEk3nBfA
         oDIq1ctXGPBUswKfH3U4chPD9qrH3Xn4MqzfD9zyAsMJi+54fx7xViR59ZL1XUMsND+r
         Sdzw==
X-Forwarded-Encrypted: i=1; AJvYcCUXO9hkIYbZm7+eBUXtTauTlOYPt4O6cNyWY3OvHccYGEVwe8OJBtmyATgS4c29FSvRCIh8KktDIsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVQFQmUX8WQYYXnuv78ehZrX3KXm6uCqlTBG2K+V49/grQONY
	scfZ+2dhKAyAOuwCnVkpiVcwGCkgWOT8QiJNtYD3reBfF1DxH9PnS3ys
X-Gm-Gg: ATEYQzyRSomVfjYKF61zFrp6YzqUTTjiayZ66FT8d4kN5VUrUbWF+GCtYxyHfLgC6tM
	X1ecdyMfO+6JvlzUqpskJTmoHb3jCnwxD2wILD+YJXJPulbBItSeg6howBtJ/wBc0u7dYQNnG4R
	I+CuIAdRz5qYt5Ut2LV+Lqdbtd8yEDgR6pBxKp1xiQrUOLB2gjmJ/k9KdrOaxrdJNJdp3jyI0xn
	Hdwwjw0I04+b9haO7nq7ZpZueDn+DqFLB/8NAmfqiZcq6rNrWV6nKq7+7OnKIWOyBo9jJVXm+Ij
	S1aWkTC8t4wnZC7D12lDFRdkbyuGpcgdivnH9/cFhyHsA3aKE1IbxuD+IsGiyb08vdtxmNZyFjw
	h7s+vCH/tJ67dMWlw/Rv0bfpVlb+CM1Kbrimz2jXBVKHBJGy/UxRI/aVyzSk6oVB3OTKG6BxE9t
	pF150RPztWWXe5DbKFCoqhpdwp
X-Received: by 2002:a17:903:189:b0:2b0:5520:f49c with SMTP id d9443c01a7336-2b055210a7dmr34736375ad.25.1773651689804;
        Mon, 16 Mar 2026 02:01:29 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:27 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 09/14] iio: temp: fix spelling mistakes in comments
Date: Mon, 16 Mar 2026 14:30:17 +0530
Message-ID: <20260316090023.14691-10-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes in comments.

- catched -> caught
- chanel -> channel

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/temperature/ltc2983.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 7dd40d69cce6..38e6f8dfd3b8 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -709,7 +709,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
		if (ret)
			/*
-			 * This would be catched later but we can just return
+			 * This would be caught later but we can just return
			 * the error right away.
			 */
			return dev_err_ptr_probe(&st->spi->dev, ret,
@@ -798,7 +798,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
	 * For 4wire RTD with rotation, the channel selection cannot be
	 * >=19 since the chann + 1 is used in this configuration.
	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
-	 * <=1 since chanel - 1 and channel - 2 are used.
+	 * <=1 since channel - 1 and channel - 2 are used.
	 */
	if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
		/* 4-wire */
--
2.53.0
