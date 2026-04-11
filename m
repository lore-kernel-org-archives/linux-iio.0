Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39B1A681D
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910955; cv=none; b=hOlBc6feoFmn9Fk4lJEnqQORUItgiGL8Du/IA2Ks6Od3K4LvJxojNGB4oePZyNhMnjKzpc45X28PzFZUq3fH+PR+YPurR1/R45mIp3h6rn7+zOYTetxMxgg+Hfn64D6uWMuxFXjUkJRZh0GDLL10USXocFDukS+hCBDa8Z/jhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910955; c=relaxed/simple;
	bh=efT4gFsu/j92HZWkfQpIUd+RFDi8g5WcBoyNbiB7f6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSC3FwdmcFHW8f76lmddQ8SAssj+4a/DuVGdH3AU29xVdRRfuS4H05jnqalMcxMlhE0Ak/XciyMRclV/ybGrNewUgW/ivSL84dY2WepBflbIwoyuh4YljoLSVHKJUMGn7ZcizFAyu0hzB2aEzwHaSbywlOE0h99bwZkjv32FP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3qdKu2Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3qdKu2Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso27806335e9.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910953; x=1776515753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X85TaJiSk03ThcLTorKFKgIn8WKe/qweX0BaBKvuylU=;
        b=E3qdKu2YcX54wkQcq2ULBOe3g+WDaBZ5K1+RRD4/8e6eFY/C/BX/rKPxlGnqmqyyg3
         aUSbOv0irJKqWYdQ+KQxDatSocw/9yX39MSrO6Ntkv5FesTyOwVgcIlt9dWJ0ytrQ4V6
         Vveoh1em9Q1G3mFms7YXEqjlYss2qsiiYCE8rQg4jb0e0cpzbnTI6AVNqvH1j8IAHmgs
         cCl3OXBThObIKk6P+ki89lhNC5Vq23EHVe/avlafzI/UOKAs42wELqsjXsLWyyhkXmGV
         OZ1pLIsXubUx9b6xhSs18Natp94zfuEJegHxR9zRgpJrJKUWp2bvBh7geCM2PEZO8E0U
         0L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910953; x=1776515753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X85TaJiSk03ThcLTorKFKgIn8WKe/qweX0BaBKvuylU=;
        b=nxAP2F4P5uhxRzueYBHu3Kr261XHDkZj2x62NgnklazygksFvUDTnXWWl0D1rgvpYF
         8iiuzNLCdw28/ejz9MbzDUhKXQeu4o2rU3HNrb7lNnKm68BffV3oYLsaKpDdQ9Ng5hsN
         kIofYAX2Do6wQByVDsz0VPTmAkkOpEeR45FOaJe3sqmkbh1A17cP4Ocug1r9b7qeKYTY
         2YUTtj3IiEdZKdsDB7pHRoxRGVidJoibaTgBC0X7wcHo9ykzvIrymrmPNsECbFgIt66M
         3EmvMRkHpKj1aWbE16PHwrKu5LJCA/pcnQdGmTEVLdFWdEPj1quBuCpk0/aMwdjVJmq4
         BX8A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1HzGn+ka4bP+PCVByB3zYba7fYYzdeYzYqwH4Ip+AFNFAcvBMm936hRxVSOay+N75ucm2P9NoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMM/H3BRaShg279AhMGUazoGKbWWU0PkKyehtAqzfYkQi3qbP
	PrKWGjw0z0XoxHDajjuAi9/TC0POocq5dgV1FQHSuWMyW5hOJdDDQ+wd
X-Gm-Gg: AeBDievKECMo7BX5UTjI9KuplcYwhR0HyLWAr5ilycM2pCcA5RBuDvJwuJGoVqihh6x
	dWA0nBtEThtbjEM8Euj8mdESo7ivrcictXO3KPQdMOQuJPxAf7tPf1RwNcuqs/bVk85cTIrQtvW
	chPMT2Jlyn3WILuWrHmsxhvP2AJec9ftlXy6PyNdVesZQFPttFruvjpjkGaeSoxo4UAJhY5nR/y
	qqkgw/BljNdBsAx99jj7Jq1ylRjfxCd8Q9J0IPwBxaGpqEvC/PAFQZa48+yZvxiJqmD/UXhGYGQ
	MXi9H/6qBRml1JCjVAJht9Sq+uQ9Hxj8JnVB4+CBkMBMS1cttEeMNcHB6pl1XVQGLVQx8peIw5/
	ubFVHzmawIjgz2uurMGWRQ9Bf57EQQ4mKfXn4txLTQ45aRAANM3/4dVUWKmvOJVkD4tIv6hMC/J
	CS6aOVuJR+9BH7Mju4zVBeqeeyR+UOFH6KfCDRbf/AxZQzjZTAzCBgSJNo6SLfLClzGmATDP1kq
	T1D1qrSoMYwUcVQBUh2/IsxJdwjaZu70y9sOIWgVs66KM6TsabvleHCwlbWhIqW0R2aA2PGm8v2
	wfogTbPZgrKXIx7tGv+MHK7O9hzZfp+GQk2y0HdyowCAoHjc9/NUaGBKHZ+i5cRIAwA9AbyHkwk
	=
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-488d68a4765mr95095325e9.23.1775910952548;
        Sat, 11 Apr 2026 05:35:52 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm103104385e9.5.2026.04.11.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:35:52 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Sat, 11 Apr 2026 14:35:12 +0200
Message-Id: <20260411123512.84739-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411123512.84739-1-joshua.crofts1@gmail.com>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
macro instead of manual bit shifting for better
readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed ull to u64 type
v3:
 - removed rogue vim typo

 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 8873a6d11e..778aaa8747 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -112,8 +112,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.34.1

