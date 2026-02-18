Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F131BC9E
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419223; cv=none; b=ayH65ywWPboNImCk4oo7Bm8X/ccGopkPsHuxmqTnotbzGKGkf2c6r6bTQ4viNjSKVP74nULvQQp8hLGbZbDyKWd8mIJzn3qvl38Rsm/H5gEBSVJtECpYsBfrfCO9FZkGmeEtkK8xC4PYEYW81A4ulYHD9DcTfLIR/o8Ips3hdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419223; c=relaxed/simple;
	bh=veU5TcgEYyCy1wNNBap2rC6OOe0JEAczI/QDmzajykI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHJtDJIG/nsxfJIiKglBe/6OQEEP3JvQO+kaxZ+UgAAFN3tySfQXB8guwQIO/uvsMIhIuaoTWEz2W9ZSoN7tF8aFjdavqD8iO7Kk1gSxs++mLgLzO30aNVzxFxsZYijeFaKDuLRBxp7Sjv8B+K+kDyaU0IRHWIRs8y4W8m4Aesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW2H9+ui; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW2H9+ui"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6e77ace76aso1213065a12.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771419221; x=1772024021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFam5Du7VImRJOMy7ZXZVGOriiUs2AeEepbg/77PsKc=;
        b=DW2H9+uinHLgwz5AIftml5WRo4elum0spqUortKDtrv9Mrjr7j0OgJrvsMKDq5aYhH
         gAJvET0GC5UatJRfmsu59yXiVvM7+NCLbozpZw4von4Ig2gNIlC5wG9AT/0YbbzJDsH4
         xriPWyzb3w7Z4mwfcq0LEmHLABrUw4Nxck3kGULgBmak/DOAGkr583UQ1JAYjM5xlAwj
         o5pMd5aeZM17bNDB5HtlKzM1t2RgvzxxvWPYWYWEkXL6uaSD95QA1OYCmIs5T68sydBE
         pkrmMhAo2qpztEsmf9cwOCviXdpHoaB3e3J+OxxBuUrZcl7svwYnZAWQq926w12L2HWJ
         SSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771419221; x=1772024021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFam5Du7VImRJOMy7ZXZVGOriiUs2AeEepbg/77PsKc=;
        b=bC5OhcVfBAy5vOuGve1msnMoX5H1+NJhAs/1kU9IPhBodOh2Qqwg22sUO4DRNK0DnP
         YMFfYQheMrZ6GuDoxHGCQmltxig7JJF9nFKH406jiO1GZO0Cja87ANbIx2EqYYcazxtc
         eJ/IwoXkPqWxUtSnSYpq4WqNZvR+wXw3qL+Ks8fIGKn7FZihZAASrvSIbo29OYjYgmiI
         pAnPTaLdBfKUEWd6DSOUxuBjUp99GNVbfm101Fvlzca+6i64WVb0N2r5p0u7X+jfdpP4
         +4sUKK0iIl3+aP/jEiC9WVTT9/T89tJi6LsVna+VMX3hNHv9YvM+qItbh+tqlienN+3b
         Llcw==
X-Forwarded-Encrypted: i=1; AJvYcCUDlDhunv+4CPJFxoJkcdkzf97EJcOleXn1jQkJsLCC0SH23MjyaMdoFVo+XAmpIDm4x0jpK/xQS9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iALrxkJqO+8ttZwtot3tURXzlVn9w8KjhTU3snrWZkKNQDzS
	bgyJh33GtYmp0aHYw607Arm4r7ZWGq7Kgq7uVuug11WK9VkR29X2GhFL
X-Gm-Gg: AZuq6aJ8qQdiAcf/vnrYhpSzE3Gkln9pUc+QomR6MqI3vBJQsMSQ/pPsMBlRM0AxjzI
	vCH2yK1Tk135A5AnlkWHY3pmeTp+T5URbb7B454Lo8uy0kEgxI8RpWWyvQqi0NmcvXk1uWv3Rrz
	fbpiU5j4u5Hvwsft0/NQ7fFGTC5K7+Q1zh79Ylg41lyIL7NAnXVuIggni3L7qZ+UmSj/LixcOcP
	AbVyVoZyA1uZEsK9GPdT8Z3GpTNTsCLifWLcZPOOFlVH9lJ1/0lPpF6B6KzjJJ9Nq667aatt92p
	3GKwynN4cZExkC7FTNWXDelkHMhcWIBIC37BoZLxgduC/A0g8Rl9f5BZRK+tp55/plDTWC45XgH
	ysVTjUxC3HNcQBhNoFRQqPllqwCIJts8kQuOpOMsexnBV8XBN/KhIg5RZrkpxv2fp4U9NDFRs1f
	joCIHt5ln5e0Sm0MxotCnBxQdsvKI12ke9JgiTMkCa
X-Received: by 2002:a17:902:ce06:b0:2aa:d630:cd5d with SMTP id d9443c01a7336-2ad50f742d4mr17178385ad.44.1771419221059;
        Wed, 18 Feb 2026 04:53:41 -0800 (PST)
Received: from debian.ari ([152.58.183.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a73c6easm179460295ad.39.2026.02.18.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:53:40 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: gregkh@linuxfoundation.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use div64_ul() instead of do_div()
Date: Wed, 18 Feb 2026 18:23:27 +0530
Message-Id: <20260218125327.21467-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace do_div() with div64_ul() since the remainder is not used.
div64_ul() is the preferred API for 64-bit by 32-bit division when
only the quotient is needed.

Also replace explicit casting and shifting with the BIT_ULL(27) macro
for clarity.

Note: A mathematical simplification to `(freq * BIT_ULL(29)) / mclk` was
suggested during review to improve precision. However, as confirmed by
maintainers, the original driver's truncation via `(mclk / 4)` might
be intentional or relied upon by userspace. Since hardware is not
available for verification, this patch preserves the original logic
to avoid regression risk in the absence of testing.

Issue identified by coccicheck using do_div.cocci.

Changes in v2:
- Replaced explicit `(u64)(1 << 27)` with `BIT_ULL(27)` as suggested by Andy Shevchenko.
- Kept original arithmetic logic `(mclk / 4)` to preserve behavior.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a4223295cd..f6d3d98b6c6a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -194,8 +195,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = (u64)freq * (u64)(1 << 27);
-	do_div(freqreg, st->mclk_hz / 4);
+	freqreg = div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
 
 	switch (reg) {
 	case AD5933_REG_FREQ_START:
-- 
2.39.5

