Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D894218EB1
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486906; cv=none; b=qtPT1ckA6ox3FDk0hY7g5pvSvQNMicx4jqWPF+JT0Eeo4T1oOsfkkaLlACrI5epx4BqoiyR0C9CVn5QTMko+BrpDtvSBYc/BXz2W5njr6diNt4vCETfWV45N4NeRkIp28STpwwjXDaf5HgiTVfA8zWvqJOGt00EjsJpaNPrpWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486906; c=relaxed/simple;
	bh=hZHHBtusbF9KaXEHVcHw5Tu2kyd0PdYE50KDL8HTD/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQfRjkl3hs0v7k9ksimictU+pTwo7hBvczFJApDEYc9HP+tSBwt9myd1EWJBzJJAVE9onUOYd+jWjYZzKbLTowvcHiwRx5ZFTQoX57zEVpIRgbkWYpctWutpq3CDIS21xVigwNx4q2sEm4L2IRlhRt5iFp580F5NC6U39AnfPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAGwzskA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAGwzskA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439bc832351so362689f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773486902; x=1774091702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sg6b15FtkG8N9Ana33zuoc6cX5M0C31WK5lJ4XFq1k=;
        b=GAGwzskA/dTn0j2vjV09J+VCobfSIetfy201lEZYGzK2QI7zHuAb5Chem9TdvU5h7h
         lWJja7vmnysxF4ZhbVF8UIKaNkp1M0HQ6y4eBs2/SZZfIuNWonjgIJDWORv6Hpn1fZng
         9/TrZ1jeNJ0ecr3wSEJpmO3Ys3uQKr/NiXGyASpxhhaM1DmX4ITBZFba8g9oorCdzGwa
         bFrhIhC2vN6+qGNiTYmjyC57VP/DW5mYkTStXDvLgT3+dze/C3PYUOKWJSRqOTIjZYGR
         z1Y5xsqs4mhiAgKcA5Wshnt1GmUDkEx34E0Hxw3pWDN1YgzVlkbxF14QDm52rsUXzNq/
         B79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773486902; x=1774091702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sg6b15FtkG8N9Ana33zuoc6cX5M0C31WK5lJ4XFq1k=;
        b=UGKvxUNMmhro/n6JvY04/vJ2CO0W5OovKEJHdp58S/w1iN14gqYlHk6tE6VQAQetNW
         TFOmTTrnxURC0U5UNB5EBBjbAkpr3xWPDmrsT4Hlb8U1SGR+4lR8qWWGiW70iifSqRl3
         puRCnalzTAddje1WWZAy/ZRVVS/JdxSE6yCnuFlPzi2LkecJPcGgbpKz3ZpPm9SN4ylI
         k707Q6xOPCr4oSN/xA24/hNj2V5aDiI4AH9tngGGgP3d1rc3+6HQTuGyFG5SsByyeABk
         l581h4J8oDGRBz/wg+1zzv/qdxYHX+8YgKvjhSuI59gF4V1FD6mIYJuAMeuYFiXWo4BT
         TLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuLRwXDcrisnGTEdKJmY1vIoq2bOmP0YO19waOczUlCnjNE1petRkG7O86vG2bezkIF+pWAOgaUk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw069FGvdJ6cAQd1S38MW5vPEkMhzYJjtiiBKOM6zFyCAypSoxa
	Ak1Ctp961XcKTWKmmJ3pmqgcNUTupGmnIJQEuON+gj03QgnhCz2uTvmJ
X-Gm-Gg: ATEYQzzoClYBwL67/tEp0Go9O7WpStU9Zzzl6W2pdlsdpqHSyCEruX/SXhRskcaNhNs
	imffj4ex21gGB1Ir3bCRjsskTb2QZ++ie/HX4+2Xg43fEi4iZ1XsO1OSFjpbDr51jKT9HfdYco9
	n9L2wptkjWE2Mqen4vC0lHyhWL5RdC/aRqfqUWZyj7N+UwkqgyuEbI8a5mHYF0TvsysRrJ5kFHb
	t8VzzoCJWruzTRHS3BDmvn8MKuJnXkcFPuPFED7d1ifFQD5fvME2Rozi7C/9sEhcs1iqNJQVPaR
	Mq9cbefOjaVejNooEVvP6Y62aBioyQ35P8JfjnXE3+moKIuapg0V2uvdnuxYz0Mhh31lkXbxbLJ
	HHopUI9dzPG1JVur8NhB5Wvobq7nU3ODL6UWCYVhNNTOUljrkd5gfd5D+hEljXbvplEnrUtk+wI
	yIo5S5xCZ+zI4RLFNvzZ361H05hzEsZ2IufMsAGft3TCcgR1lfNZb1rvpAVeHWIi463uj7cWto3
	KTNxtvt48UhdvdwgIv4ajZoMd3TZE7aBOaRFMClr1iYAZ3ODwJm
X-Received: by 2002:a05:600c:8b27:b0:485:2f1e:376e with SMTP id 5b1f17b1804b1-4855670e810mr52076045e9.5.1773486902181;
        Sat, 14 Mar 2026 04:15:02 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm25375158f8f.31.2026.03.14.04.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 04:15:01 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
Date: Sat, 14 Mar 2026 15:12:53 +0400
Message-ID: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Format the multi-line comment in ad_sd_set_comm() according to
the kernel multi-line comment style.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
Changes in v2:
- Use proper multi-line comment layout
- Address review comments from Andy Shevchenko

 drivers/iio/adc/ad_sigma_delta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7852884703b0..a955556f9ec8 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -51,8 +51,10 @@
  */
 void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm)
 {
-	/* Some variants use the lower two bits of the communications register
-	 * to select the channel */
+	/*
+	 * Some variants use the lower two bits of the communications register
+	 * to select the channel.
+	 */
 	sigma_delta->comm = comm & AD_SD_COMM_CHAN_MASK;
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
-- 
2.52.0

