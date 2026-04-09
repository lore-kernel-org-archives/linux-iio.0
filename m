Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BDC3CC9FE
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740731; cv=none; b=rTOE4kCZ73vusmHwL4qQ8su7ijsgMkULjRYywxQ2V+4SxKfokjNqUJucKPRJ+xiZHgJZTIoFgV0zaugBxVu06kmbrfYrp4TGouIJSomaVjpTbPgWOkZbiDig+Ga6EprKuAYbNdIr/O872QhgBh40MXHkTQd1bKh/R1KDo7MjuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740731; c=relaxed/simple;
	bh=49U36clM8e2e3gJFrrWjkzxZ2BnblqIUI3dhDn43VBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdHFfl9HmsO3/TMhjUhjrlfWIbgrNX5oTbIl9VUM3Shx/EEhmKq352R4bDBZwGZbXRS7kpeob0PW2gSlGZun8uDRWWKdWi/XlRzUu5xXn1k99pnryF+Iu/N3Pjy7pbYFOskZ25t84FM+zMUasW0ne2o8p2e0GgThizpU0r1DF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIYSM/pY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIYSM/pY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6701c19e7b3so1457089a12.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775740728; x=1776345528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3bs7q6ZU0OTgcG9cFYmFS2g5VXGrBq6p5ZmpGmndRSk=;
        b=lIYSM/pYqOujLIs4i4pQEFtfIqwgeS2wZRLuSDciVbzEI3hO4QwYqQyEB7TETdFQOT
         2PbRNNrhV/LuoSVFKyijaq/X/SdaN2Xd3S0YF0DuCBiPKi2yqzGFpm68LDYlSTF0sE5v
         bIL/F7kIodvO9pVZg0CfwMpy2diFJdxDRCsSpjm9GgZ0U2GqQ0s4KfnMy4ZDGxBfv93U
         pqxt8PnzU+kyaKIgMmiIgFykengSdZqLry83G8TdioiXENzgIPqvg6ePvefq87DXyL94
         mr7v4/R6ALjVdBe2qfMFLheYZR9t81akecZC4JEHCnxg4zVYLmWPLg0p1lpeTLUgtdo9
         h0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740728; x=1776345528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bs7q6ZU0OTgcG9cFYmFS2g5VXGrBq6p5ZmpGmndRSk=;
        b=PamdZzdk6Ic6MLBnFTTuCGUZznQXPpS4uBypsX/LWdo0If8ukbJRdcp3dayrctd8wq
         fm560vyFBoUQI3MRSELgF6WqzTeMwMeuCLlkokLB4lTFQ8ZJEW6pKbhSg3KQgo0pESOO
         yTC9omRahxaBGPuiK/QdxzEaBiQNv1UxXUz12lX0J3XCC+7mWItiKwDBm8gj3Dw6eIRd
         kMMCikXwgbU1jGYLoelZng2/AEPSezGCs4lqUTm+jwDM4v9fxztL1zWy3okX7ekEpKIQ
         hr1td47glW2vIR/tmOExd1fpTuyJd0XO0x3HnSFknrzuA3YG+d3MxWaNMA5f1gY6lQIc
         ZX5g==
X-Forwarded-Encrypted: i=1; AJvYcCXXAMcuhUAtbrjS8Bis1yjOCsiOCpAVbk1nn50uKwqxCFWUjZnQkzK2qqatC90Mt6FYA5q1FgvchTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOf7BHgPDRh/IUNrDsq1mXNOE27Ekmf9b9O/vW73xOTfkdEhVY
	2AUsiAumj1H00Sa7SpUT5lRE3j8PLt5LwD55u98bmMaIAygu6pYLVoQ8
X-Gm-Gg: AeBDievkABrSiXW8Nxi9rDJbhNEDzWtanFxY0d5EldW6AU3ryy13BGS5xU3GZoaszF5
	HRVshqUctkojs0cipeXe8OLbbWfnJ9ffCO3oehL9sXqaOSNDwFKHZm2iNP2bd+0ReXikL6I23zb
	ERPDk79/zz5T6Fau/wSipynol3dsCaNQK9XDw/mkOIdvI+VtGnnocFdHBs/U9YtsQOSdLxK8ex9
	L0QkKSzrp2Glcqhaqm4+l6hPFYmHabshLFBWIyAn994kuLOP3s4ELTep4EsW6+t+quGI4GQPaoq
	w22Bza6B7br/b3FfGjSbSLCg6QaNosMkGEO17d/s1PSwyN714gPIxGA9yWeDT+FUh2uc+hFkPgu
	RdlSHQ6Zw2WAnNh18IDObu3qnDnbBCrhS+5fteQU0FPJRc99uwZVbHVLWI63J8YA3EjMZi8WfS6
	+x7KRJGNXZdufe1KKs+/5AJqkE145iMUvuzhoUhxfkOweLlGREvxBFsOKaGNP4C7iJooPZHm9ye
	ufCamrt+4sqYXjvhr1/78zbAbCBrrKheuKUReWbKI5h51j4hXKPH4tB1zFZb4LFv0gwXLNwpiNH
	rcVGrRQdSk60/kSN3UxYbCcbJHUVvj/uaLiE5pzxL27iNwzzBUrGSxnQC9LGEl3EL8dj2ZiGHLu
	oIRmqU7KaVclU+A==
X-Received: by 2002:a05:6402:910:b0:670:3c8d:1b6b with SMTP id 4fb4d7f45d1cf-6703c8d1cd4mr943734a12.7.1775740727985;
        Thu, 09 Apr 2026 06:18:47 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (137.44.90.34.bc.googleusercontent.com. [34.90.44.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02d37620sm5679424a12.2.2026.04.09.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:18:47 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	greghk@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nono.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
Date: Thu,  9 Apr 2026 13:18:23 +0000
Message-ID: <20260409131823.1289-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle reported the following in both ad983x drivers:
do_div() does a 64-by-32 division, please consider using
div64_ul instead.

Fix this by replacing do_div() with div64_ul(), which
safely handles 64-bit dividends and unsigned long
divisors across all architectures.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 ++-
 drivers/staging/iio/frequency/ad9834.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..61ee93263a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -115,7 +116,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e0..83d0e1360c 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -10,6 +10,7 @@
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
@@ -101,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
-- 
2.47.3

