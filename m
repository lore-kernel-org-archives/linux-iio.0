Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F4396D22
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961070; cv=none; b=PcaoI9k7FMF9wPAJCo5UaYCENB+0qdTc/DtZ2HeRvTAL+iqzHrZ2CYkFKGkAzaOYAeJNEbgiOkLbPgdsdNoD907reFnOENYHJUr/pmjeNe244E2oL4fGu4730BrFSzZeww729jD1uoYtwJKLp1g8peg3ZZGJ9+YMqKnIVASKhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961070; c=relaxed/simple;
	bh=3DxMmMkkTJYuthcc1FWR63wttOEOetgZxkwVVvliXGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHvcbPFEIP3QcXXRyvQgeEP5S5dUBb/JzRBiYCv4v15NrDJHl2uHmt/h8huLBNUC2O47yNKwP4/lPlo6SAfa6kLXhycRkWCzgGiyoyNFv5nMyoehF2/dyeu0QDp8yRZoP3wA3kXdnh7cDg4TGnaCDb+EY9Z86q0Nh71eTfWG+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1HJ71tD; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1HJ71tD"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffe6887e29so909316137.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773961067; x=1774565867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L3neA2+kvCOVzQBVY/s3bzaGGTddNGHKUrFDsFPQIc=;
        b=e1HJ71tDyoaNxGyvKdVu82KHIDsPnzLM0hGzNAOnfVFLzqmeZIN0MH/rkd8qqfufr2
         Z34/FaZaPiJmMbKuqjsQnszXaXEPomS//mmnERoiNYlQieUX/R1Z5oxqqG2WOth3hP9q
         GEpE0AwKnpI1PBVQM3F4KazzgjQLLrnLxFHJ5fx9OGQ4xrLWCeOl6E9uDf0a1cmYOFqd
         qWYuWGgDMkNGadO8dfRb0+pM2UtA8vNdUDU6jUUQcCiBAQ6oZh7RwqPajcM+LLMxh6r/
         itX0vUIjW2IrAus+Gxb2oQKsX4GslzzL6PprZZxX+2nFwmW4oe3PYPfEKFknmQVy2mA9
         v2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773961067; x=1774565867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L3neA2+kvCOVzQBVY/s3bzaGGTddNGHKUrFDsFPQIc=;
        b=kTRY24OCWXSFZ/klsOnKN+obT1VJBrilgMt0PPuyip7xH1j4jZstRt8MkJbECmUT47
         h1nGW82UE1/1bht39iMpZjUQpk5fIl4hiPctTa5ed4P9YgFeL3b5UJUzNG+AdKe/v9+w
         Nj7m22OvUWRiOYFKJ3nA4ZvdpYK4bUNqXggDbC7hl/7rrVzd/KsCboPlfd2mQ4mLAQBo
         zgm+zpNOPaT0V7j0frijE8XN3WaMR/Fja218o0a5d1ncx079vPWICoeRNswJvvizYtxH
         DxRl1EiKfwOG8wcrjCs0i+kr+T0x2n3qU/+03CPsfg+Gf6oKS5z7n5aw3JdinAQI0+YN
         XYfA==
X-Forwarded-Encrypted: i=1; AJvYcCULVTl7Noyd2GEcmKlUtgWWgjFKcD1Z2qCECmzRU3FRvwX6ZqjpgGrkDB5uugH7/6Z18WWHgcPsPWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOGaE8/6a2U7ugbs3Wn/3+EBSK9zyESIx7gdDKfe/NJuD5zK2
	SDOnFhNeSE3yInXqTzldKbq1UfHTN3FDQ+vaiGlFbjNIvYx/L7qdcqyH
X-Gm-Gg: ATEYQzzav/Bjr8TkD+m5BKf73G/TLlRksz5R3wD7/eiHIOr3IATpiuOS8Rzr3EPJYtR
	tUPhqrjz/jmsLvDjIphKquYZVnqeNEr1GIU7VQdIUPQ0sTUB0+svzt9Uu6CpYiE+WA3OGS4QOui
	od8Cg51B5Xp9uN03R0RIFarw4LtUdORKnDJaTRaeB0h2zbX095XO9AG6bNKnh8M455f6Cwj3Svd
	QqzcNodt54gYO+Ey/1nKmEPBn7L08bo6PkVMCHCLqjUY/f9rIrCrwqXKi/DMKzZ9ofZo8R2CP7c
	ofjM6+M461fGcxpuScQLCckPp0mq0AreIqKKVshK7vkp72CMuOk8ssZyV8xPJn8pfFXukNbUPdD
	A9Ak/TEuLRzwvRVImuOKsU0qUH/yVsLrFeyWxljOt6K1WnFmrLR8dIiOcTI3PKrxGtEhDJCZ+fz
	pYRrzdaeD0GkCTcIkVHdokAHHF06u00rMd7Q==
X-Received: by 2002:a05:6102:3910:b0:602:8cee:8246 with SMTP id ada2fe7eead31-602aeb3db5fmr754587137.16.1773961067458;
        Thu, 19 Mar 2026 15:57:47 -0700 (PDT)
Received: from localhost.localdomain ([149.102.251.107])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136bd79c0sm204828241.6.2026.03.19.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:57:47 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: iio: ad5933: use sysfs_emit() in show functions
Date: Thu, 19 Mar 2026 22:57:18 +0000
Message-Id: <20260319225719.73587-3-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260319225719.73587-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all sysfs attribute show
functions. sysfs_emit() is the preferred API for sysfs callbacks as
it is aware of the PAGE_SIZE buffer limit. No functional change.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a422329..f470d3966 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -285,7 +285,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 	freqreg = (u64)freqreg * (u64)(st->mclk_hz / 4);
 	do_div(freqreg, BIT(27));
 
-	return sprintf(buf, "%d\n", (int)freqreg);
+	return sysfs_emit(buf, "%d\n", (int)freqreg);
 }
 
 static ssize_t ad5933_store_frequency(struct device *dev,
@@ -338,27 +338,27 @@ static ssize_t ad5933_show(struct device *dev,
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
-		len = sprintf(buf, "%u\n",
-			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
+		len = sysfs_emit(buf, "%u\n",
+				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
 		break;
 	case AD5933_OUT_RANGE_AVAIL:
-		len = sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
-			      st->range_avail[3], st->range_avail[2],
-			      st->range_avail[1]);
+		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
+				 st->range_avail[3], st->range_avail[2],
+				 st->range_avail[1]);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		len = sprintf(buf, "%d\n", st->settling_cycles);
+		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
 		break;
 	case AD5933_IN_PGA_GAIN:
-		len = sprintf(buf, "%s\n",
-			      (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
-			      "1" : "0.2");
+		len = sysfs_emit(buf, "%s\n",
+				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
+				 "1" : "0.2");
 		break;
 	case AD5933_IN_PGA_GAIN_AVAIL:
-		len = sprintf(buf, "1 0.2\n");
+		len = sysfs_emit(buf, "1 0.2\n");
 		break;
 	case AD5933_FREQ_POINTS:
-		len = sprintf(buf, "%d\n", st->freq_points);
+		len = sysfs_emit(buf, "%d\n", st->freq_points);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.33.0

