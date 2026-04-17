Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3C39C006
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430211; cv=none; b=lXOZOq8OtP+lIncZBk/jJUmgZYUQ+O6a0NQcWojn6X17HDX3+bOua5cFYFR7sssOd7RRI2js/apuuNF5/NnRsiDkZemlg2T7rMqyAdszjpFVcMZ8chQ+bDHLBkd3SwwgDQjmlvJDTFTF3oI3WPPuSqM3Rog8KBAIac6Dbq0sxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430211; c=relaxed/simple;
	bh=TarAZlGuEdwHhc5/39Ow2rqN+MI5stQ5673+V9XGau0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BR3q1LdvLY7pKq94IpoRhPea874WbkQdsth1695QpVXpkoH4J2wRKjeZ7XWDcJSD7j+dgd7nbohArmZsmsuqWlujFIEf56emy9Kvfl0LqU1XzCYw2GPPIxi6E4ilDwmWJqeX++r94/wfnmc7oCI7x9E398G3YUFdKslpHDFX7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRCnmZPm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRCnmZPm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso2911165ad.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430210; x=1777035010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imMh6hJBu2Zu1gcmhOVix7OG/ll3BvoGNjzRdYH94g0=;
        b=LRCnmZPm27LwUw/rR0UXr8Xt51QdURdC4iqAgGFbgu7GMy37FOxVIzstH2mRrn1AUI
         yGC0LrkEMz84g4ZrSaoLmz4bgodMe939aX3HKJU3z6uVQk9vMPzEHSDbThBRI8qOY/MT
         aObY0MirvpkZDVFHLJDvm/TRtOibSsm7/uciZXwdRwkZy0N9Ak2f1s5IzKKoIvPyBTK+
         JjDn8TEu/mb2V+OS49KzChCDzbHZvHyjBS8d2xUYHGbOH/k876F2CJsvJbzt2Z+MJw5Y
         WkDzomTZ8SFRq4bNUW3/J9g0qp3eH/ZENoIlLadFqmqcEZv2Kt/zLHhSRRJv2HyNxfNL
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430210; x=1777035010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imMh6hJBu2Zu1gcmhOVix7OG/ll3BvoGNjzRdYH94g0=;
        b=aJZfim/XaPhS2ygW9hz4L0YS8/nbev8ZgmuTa6vIlFARZ8ipb8RWL0pOl+dVDkjAxb
         NVRHLzrox4Iw1r6BkuYCi7HsI33NGXX+e58crhPqgbequBSpYUtL+MqnhnnB8uel1LJ7
         iXAG1ozvX6/Yetfs95KGwFPmWLQThpBmZhY0tabDuonf/vyYL+MP1IUkXJP0Im1pXR/W
         qFJAw/3jjuNxQPA5r/CxJXI/m+p+vSq+IHrAiNyhZCEL43a6B/V293z/bs3NpLJsMl6L
         edesvYtm+yJmpo+icgBXnVBlop7yeV0FZfxE/fHAsunsB2VXpm9LCl9RMo+tjWGnEfan
         7gbw==
X-Forwarded-Encrypted: i=1; AFNElJ/czmOKo2MoXGmA23yU3LV5DCF1vP1C/g/OqSZn0ml74hWAnnNL7+p4MRfCp2glRu+4IK+aW7tLl7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jCPskSLSTGj+Q6CEy7IYPTbFhFhQSKIwi07a9msMhA8NOX/m
	xsYSM/PkcowDMx7XOnDilb6aXl5BUAnZ1VGkEAsCtslMNzwXvKyD2h6k
X-Gm-Gg: AeBDievA+qFXpoimq2uxfb4E9mEzu/W7mV3BR4FEuSJZs6QGc4jYjqPTEQjkT38B6/n
	2UzrG/KZewpsTLx9xkE0b5Er+Lt4ZMFPkxoKewOegaSeUNox2+xkTVyPeFZnx41oJYRASHkrzQG
	E4MKlZz3tt0znPwx4iZhei6jHld+/qW264gkZ4U5l6xOk3IpSP3rl6je5+lP4UZOE8Uq9WvSLAf
	CdNiUn2RnpbZiRsTf3xWTpCf16dXPgvJF6nS/FBE6tvh6LHs9feTmrzC7aoNqYufqBlUP9UzEHT
	A55X9MqBjpnJMviGxT8mFEhKjqEwWEhasRs9rekAr5vxdQ2tFHRQz8cQjb3W4kEcLpN1TGgL+Te
	NIX6f9BcpDIB/vs4XrB/aNFrVjSdSqYbef1Yx6lRD8Hdr5GdccA8JoUggQMj6d9eyYTYvvIoqeV
	xdBR2ZsZ8aOuLUuCS5hTtB34FacJsg6qinE6wnxNAyWnAXkNYZX2rqEjKi0Iw=
X-Received: by 2002:a17:902:db0d:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2b5f9f52879mr26795615ad.38.1776430210102;
        Fri, 17 Apr 2026 05:50:10 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:50:09 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] iio: accel: adxl372: Use dev_err_probe
Date: Fri, 17 Apr 2026 18:19:24 +0530
Message-Id: <20260417124924.353189-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

dev_err_probe() makes error code handling simpler and handles
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl372.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 1a6ba94f54f4..e375d068a3f5 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1316,10 +1316,8 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = adxl372_setup(st);
-	if (ret < 0) {
-		dev_err(dev, "ADXL372 setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "ADXL372 setup failed\n");
 
 	if (chip_info->fifo_supported) {
 		ret = adxl372_buffer_setup(indio_dev);
-- 
2.34.1

