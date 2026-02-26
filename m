Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5033EDAC5
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147480; cv=none; b=FPwNxyCl6zYxon9ICIcZuyVEuyxozE1F5Kdq55ZnbPlwJKWW2RIg4627cnt93Y3t2rPHBqVoWGX1MpWJxOcQ7KJ89Z0JMwFJ+kY1EtRQQvHLxBQafX/CBe8KaQedAN6BSJbmZbvmuB1OtP+PwF9+fBqnI3MZfbewcFsIe1qBRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147480; c=relaxed/simple;
	bh=TfhL+f7VtjbiWYOT85/9EUVD1Gke8/6vEBgL8gRLVTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhp3f7QHdSElmOxpjgRQhME+UKqoMYv4fUTAyKNJANwvnUc5eN3ec9VQoSAGYWjcmGJ/7IJRNzypDFGrYaG/RMxaDZ4vYQYpd1O9reKakdFJtROcCpJUtd7vHAON5mKucffh5EdIqsCE1BuWJsnAF9b7G4cfi3nxUk80QpPIowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6RF4snM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6RF4snM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824b32875e7so791284b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147478; x=1772752278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQUc2l2etFAMFSbUDTLR0OFMDbwiSBMKpEjkoUkXXeA=;
        b=d6RF4snMO8py8nAVgGzvDsFQp+fd9C8Efumvp9lWvf39udpXQKCLu2vDFFVNHNSAUD
         lqCOjeXuTMEMCrNkv9ObJjI/uCTxnOecaS2Hs3EfbgzgWe+UT5IiI0m5ShpQXnBz/KTM
         gljM0mynXPu2rZJwx5nhCrEewGJmAwIBPE1qxpqILf2wGB2I6SQdaMhREYD8cGSPDAmu
         K+6DUlyb+KFEfuLMG3+IPf+dpfmdkfZ2dP4IEeKwSY5L524/Jw1pb9MaqQffJjKS+GNq
         Q2yQHc7UIxPOJrJOPt5D1qUqgO3BJhqABzFIz3P+OCgUAXfRBnWs0N5zkHMjWVaZXHVc
         tesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147478; x=1772752278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQUc2l2etFAMFSbUDTLR0OFMDbwiSBMKpEjkoUkXXeA=;
        b=jfLT2d5qfpHcjTzC5djd3SCrI80E3rkAHrowzd//VZ9tqmNGNu32Fh9aMtjZWOrJNF
         Xsai4BYH2Rb9oCEozvFUnydLfHF96242F3U89BSnY75wj184u1L++RdpQrnrr+STYGaD
         7wfgu/9hjvavWK/i9E68WxtZ7MoGiODVW9Qd0crkEk9ylw2bGcefoViqx4IYdWArXscC
         ga/Hxuyv/lx/p7de/CTVeSxa5efes/HTLFwZuxKZgEs/dBljR1S9wKd3xjam2JZQunHc
         wzpnI+wxlsm8vXctL3JxucqbWAsu5u61kMk3uwO1Dcc9W1vKFxwHSf6ai85Mcy+3tsdg
         DCyA==
X-Forwarded-Encrypted: i=1; AJvYcCXR1ckXniINcmUSAdI4c+T0tsMIEX4lZEf+E2XQ+2sZNCNSJoKF4vCgqobYTeX/OOQ3osc+g20mBpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySn7vN+11D2AJvJOo0LqwohquZ2wwwAhm+tyNCg8G/w89xtZ6T
	i5zAupPOgnPs8hDwNuq46lMeLJV5tzUudaJYyf28YB0yePNKFlqC/NcH
X-Gm-Gg: ATEYQzzFQQIICFQDXcYasPBIX1F6R4jXC3n6Gfz0LuvRIVVZx0nyLd8iJ2Xev1dDXof
	gpPuTL0oF+7c7MJtYuDUgmPoM7PkRpJZfCUby4ZF61Q/Tg90BbcyQwm/NKQSrOUa5E2I1zgz1TK
	9R76CVYsVwUR6JyHAoimhgwqksU/FVz5EQAXizq27W5Bj8pANMfXLLre3mSgrBBkzNFMHswFb5E
	XLM77jpbq4pYGntOeZZA/yY5mztR8Bt7BOMSlrBEGqB9S6uCtv2G1RI1kQdTN2HVVktMKcqad46
	j52WJwsz14EvxnmEE66lwXE2qAnCXWw8MSjexSwjrymtRVsKYp2ypF8U8OfpT7JBnR66Bj0J3WV
	nXpP+Db/4qoGA4BzzfFGzQs32/xHKB5VcPGMNh3oMhp1iqHQxqyTG7C1wFnKkAMLamsnpM6JOdt
	GaocLFZ0ECxMpkTKwy3pomUY2kVcvuhEughW4=
X-Received: by 2002:a05:6a00:1992:b0:7ff:ecbb:1c28 with SMTP id d2e1a72fcca58-8274d94be70mr564246b3a.16.1772147477764;
        Thu, 26 Feb 2026 15:11:17 -0800 (PST)
Received: from arch ([2409:40c2:5006:5b06:f9ff:5cdf:1c23:a906])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm4238752b3a.43.2026.02.26.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:11:17 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 1/3] iio: frequency: ad9523: fix implicit variable macros
Date: Fri, 27 Feb 2026 04:40:55 +0530
Message-ID: <20260226231057.20669-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226231057.20669-1-rougueprince47@gmail.com>
References: <20260226231057.20669-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
AD9523_CLK_DIST_DIV_REV(x) implicitly relied on the variable named 'ret'
instead of using passed argument '(x)'. Update the macros to explicitly
use the argument '(x)' for their operations.

This also resolves the following checkpatch.pl warning: Argument '(x)'
is not used in function-like macro.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v6:
- Fixed grammar and shortened the long first line.

Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested.
- Collected Reviewed-by tag.

Changes in v4:
- Used full name for SoB.

Changes in v3:
- Updated macros to use '(x)' instead of 'x'.

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

