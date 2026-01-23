Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2826F2A6
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169438; cv=none; b=gZTqcrQCeTCOBiKTTTYoXJXQxaIjwCG6t1WfORzNP3U0aCFobWCm4yK36Ti4k4INPBwKKb5uETBoOLEAPIeMOsEauuAgPeFc+93xoiBSswFPPeRFzwC+Q7dck1H8bhe/XbFD6UruVR48xjVLbmUmU+WHhVZ8KNEWV69bh2pkIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169438; c=relaxed/simple;
	bh=k+8nBWm+Bslz1Nm0BBRcTRK4/N9lOFrxe/uVgNY4LUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpJMNEAa+3H4ouzmPpnE1wC4nicXZXPRO7KTIMWeuPEHBg8G9N5jynCQZVt3i5trBGTE4XqqKy9p+k3RCSnl04Ztki3dq+7pZLFAQqvW39o+ERaJJBb99GheKDKhr+j/3awgo1XVZkwdWH4YiPvj2Ywzyhl3G14YIpUtcB7Dk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO0k0NEO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO0k0NEO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so1003877a91.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169437; x=1769774237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRBAxZ2WFQ6LK1ZTTj+VOIJDz4VCitF/f3BXC4QqYz4=;
        b=gO0k0NEOIlJMUk8C6oYFKJa4kqd7S3gpUzmYZhmnu+q5cAAZ7UyiYD7O4wE0zLwnev
         UBkD2lwC2ApbecVVgEYZkobAXnP3QhWFFlVB78CQoAAfsgAGlRQJn2LsoZvwiU/H0Zh7
         J9/DlAWjq8IrHMPOgtDHqtY3VZZ54oG5ksxyllWeDeuvIU/Qwsm94fi948g3a4S5H38j
         0Caj2KNsqt7TlD3zsnvBiWIFqph4F+T70NY8t3g6RNNckXfaCNAFjfng5nsCMwJQhIiW
         ixathU1p6S/l5AW0fAX5bWMwME6HVlvOpQe1SdTJMbdyUFlkdElgoEkEpt1XClB0PlEO
         LPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169437; x=1769774237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRBAxZ2WFQ6LK1ZTTj+VOIJDz4VCitF/f3BXC4QqYz4=;
        b=wk5+oe/jhxxx9JDa7Lel6Ctq8QFQ0nE+EaipX2BOiNjKtejs+ogwde0g7JtCjFAXUr
         Dr/7Yo7rCuupIse1QDMOXpL7n5szzcwEcNkkFxtWKKqzmFJUAnHi+9jDnmU3XWS0A7jX
         cEXuRFCsSHqzQaGmS1cMxJ2YLuY+fJuiFz89+kVb44A7pDU7tOvQoWD1eqED+s1ieR/h
         Z5ziHK6fBdBxR3YV0Ud9CjUp6m/GnlwV8yPXqIOE8SKueV6mi8reNhnrWqkQg6nR/Ifs
         uIEMo7ulXyyyYGr/N2I4oP9+lko0eCO5LQhq7OUFPeDJyhMeswyA3/gU+U3jNDHcZufU
         GxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQDc+fIi1ObFzX9qbMzaQCAt1NzgcwDd586qI0Nc+FgC8NcLtC4RFg9GRekWjqnK+9LqrZ3a3e7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oIGkdn2/bUscDqZAKe5GwEQXk4QV7ghuGK9olYvc+9/eJ1cX
	W9ponbheqRJeVm0/vKjWwWlrQxX08+rpGJrhYIVfYywLPRmOjWMDuXHF
X-Gm-Gg: AZuq6aIiDbEubXG0sUWvhHIxmg9A7H1Ga8z/JvrpuHjqnmX41oEwLPb2rDxV3kFg7gD
	Z4TdOQyKypl8h/7oxlqwjpOU1c8R8xfU52FVVUnXDTFu9Dj14+/X+MN6qlm90staLmNnrFM65CQ
	tH8uj2h22r8LQRAXI95SvhYGCvpHxR/lWTWOjwq43S8FQS0VnpI61URSB8y4Jgewwgdahshf/eM
	n9HJXABhu1PPBLGS02iAaPY2CTxTssWmS2b/xACBx4ibPuMit15nXSpNRi9fzRtoEkLfXZqFW7/
	WPIv2mtQZ/HYlzUNyDeG5ij1QKdUQXqJFlmoZ605dcTTobdghSP4tTb1UkrxBOymb0mvTqTpuuK
	qf/pJanTX1qWrrhR1GytsIuaSwXTuHEapA0aZe/IDew8jgYrkoRIw8PzVNkf5qSvHSZ/OVLE2SU
	SXPWJ/VmKPXqaq1c8hPar6WDd/JNXTd3C72Kk=
X-Received: by 2002:a17:90b:580b:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-35368c42232mr2193510a91.20.1769169436567;
        Fri, 23 Jan 2026 03:57:16 -0800 (PST)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354cdee2sm4999635a91.14.2026.01.23.03.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:57:16 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Date: Fri, 23 Jan 2026 20:56:18 +0900
Message-ID: <20260123115618.403644-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
twice instead of checking both SOFT_RESET_MSK (bit 0) and
SOFT_RESET_R_MSK (bit 7). This causes an incomplete reset status check.

Fix by using both masks as done in regmap_update_bits() above.

Fixes: eda549e2e524 ("iio:frequency:adf4377: add support for ADF4377")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
v2:
 - Add Fixes tag

 drivers/iio/frequency/adf4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..48aa4b015a14 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -501,7 +501,7 @@ static int adf4377_soft_reset(struct adf4377_state *st)
 		return ret;
 
 	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
-					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
+					!(read_val & (ADF4377_0000_SOFT_RESET_MSK |
 					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
 }
 
-- 
2.52.0

