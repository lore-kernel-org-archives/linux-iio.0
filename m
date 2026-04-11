Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A2334C05
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897086; cv=none; b=ODN+VyuYXWt7s+W34UJYe7iz4MUfX8OVpCKrQwg/XRlmMFFFjOZRUXoUUpM4bmgd0Bf6BCJbR4XgPj30DFc7xUx+WQlEuQe6hzs0eCqX7P6NHNLXB9yQ3KJIUSIyDK+OLbzu99R/BZPgkpHmd/ww2dhQcZsYeXkpVK92eLbGlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897086; c=relaxed/simple;
	bh=7Q5mva72tlCTFYBzwEvO2ZFGsF1JnnlsFqj/wvcMAdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoXQMVvi4eP1sAWg/Oobu/gU2vwAlzWFo72KidaRPDESJw9DBN7OsGmOSXosbXAkadl1NQarZaOWhMg6jRDH/N9aBP5cOfpztEIOgj47WVbqa7Broj1d3LrPcB6OBHIJbvE5PX8TZ6aBI2hVuknR72OFUQ5cQHAR+Uxc/1uGuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCLUnWYO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCLUnWYO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so26606495e9.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897083; x=1776501883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z9NrwlpQUG/cW4s7HQM8LOZblhF59Jnsa4w00A3aEw=;
        b=cCLUnWYOaWvscflo1cpsUYUSKEz7WS4USid8mJo9Jv2MA6xfiDVJfKQoz6XAzmSeVK
         StP8rA6vw22CXKequhIVZUspZqeynQbUbPOZ2p+RtGIGmcbZl6Zl8sO6ZngO7qPaf4ZZ
         /ThkAyHrgIaMvZsmTUx/Mru9xtNkv/UhlHyX+yU+x400L0GB9iWt9tHoGjKea+DRYDDl
         597XMZAhV0qq06n4Uh7nOqcDsYVSWbvwVW+HT+5kbAUC95yeCF3BYdfp5zLEI3ruqjac
         qmvT54XIOaN45zO9CrEWHylB+gT1jDFEDkaMWQ9KSYF7bli1LI4+0L0gTtSB2jhnwbpW
         EJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897083; x=1776501883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/z9NrwlpQUG/cW4s7HQM8LOZblhF59Jnsa4w00A3aEw=;
        b=szzKo7Drb4Lasa9DFID/qGo6Y2TsYEG3XMbA2taFkv1yBYjGXK9/1MiLPehdujoaTS
         t4MN5qlsvD7nfeBRY/lNhBQIxEBtSzsbpiCU+EvHDbCox9CXKqKCP7Csf0i33WgkllMZ
         PF9osLnDZnosZULnURJy7WHguRqJOyfe0tG0F1Lr2ZP2mgERF3zqZK8ia7RsSHb4oxjA
         3sTMkGvyNJg3HhLN5G7A9vrSxsBkcfeSp7QXdu/ZU01lsx90I+STyu1r3S2UOMpVCdBs
         pUML58NSC+g9khAa7qeRkcmrwVTL/DzMDyq8UKHdCFWVzEsa1cRUcq4wqhUUpcaFApJZ
         M1vA==
X-Forwarded-Encrypted: i=1; AJvYcCXfuUv3p76h53WhsgU7fRnYAgbmcLyrPweju+pOXOrOoqTzPcRPd3B1+nanURZdX7bjcRDhnvjQ5xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IItWp5hr18fTMmTumv6fAgz2XHFp91EKWVwG/Bt0pLMNtBgm
	j7iDq8vnv0bNQCz6bcWEMkPrC3lJLGOMgY+PObjs6YnspxwXfPJaHEKh
X-Gm-Gg: AeBDietMJweRSbO2VMuEaDE99XRv7wYvjIhibbAgh/Jk7Wy4USyv6fhLcvw50t+tZNm
	DmzMPpRXOYKHiLRwBdz0SBU0xpn2icwbZ5Qi0Af69r5Zt3A6ApModc/yNjI21vnz7raRq6A40bG
	APr512uAAIMIxnbJLBmcxMuT6INvEsns6/TvF4jTRhhbOgJpJek0DHSwQncxq8djjmaBtg7gI22
	+B4jhKjQvpkRwRLGY7dJ+9f8Y03mg3Qtnen0+m7Je21bhSbqn7IwJaPIrlxOLYocShJgs3EWiBf
	gc1JRi2R8LrNyGBQJJaVNxIciUqzt4YptvZvnwgK+fJj051jDm1qsgaZc+jJo4wJHSc45QOWeY+
	j5KDQ0KzworWd0zMIWAKz1EHuxYrIJ7Ti1efb4gKQ3z8wQGduuY4amOddYDs093tV2AbQ57KPZZ
	9P712CfUFPp4xAW50EVN7b+LOfZ7FBdaAZNyDQ8Xkd6UuWoAHmr16lEEh8we4c3Z9Hmc/j8bwOK
	StYsFjSydbpcqCMEnv8z+odP2oakgbX0Gk6KDjAFVkCyY04PJIc+y7haCLfm0wptwWCBAuGVXVy
	MsusCke5F+QDIS89b+U=
X-Received: by 2002:a05:600d:4:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488d68ab2bfmr66116265e9.24.1775897083054;
        Sat, 11 Apr 2026 01:44:43 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm41117715e9.35.2026.04.11.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:44:42 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Sat, 11 Apr 2026 10:44:02 +0200
Message-Id: <20260411084402.71837-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411084402.71837-1-joshua.crofts1@gmail.com>
References: <20260411084402.71837-1-joshua.crofts1@gmail.com>
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

 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 8873a6d11e..4221e51dc4 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -112,8 +112,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.34.1

