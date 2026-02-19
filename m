Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5A3254A9
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533220; cv=none; b=U2OirpB0D5h7i3K4UMWJKs7/kvWgXZWCAkUC9Uo3dcjSeHqrW7Q7u54qUz1RU9+3OhRMqJmlSwlawlCWd8F5wtg18cqAvNBlXU5jePW7C/nb3OR+xH5Hrb2G6K7xbShIVUDaRTFDsIqFEfPUBcGomEUAtIynXQMxgKT+Dsl7wOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533220; c=relaxed/simple;
	bh=0eZ6yzY4ylhIMJgYuPyp2CXQhgxqcrQbq+0L5NsPyaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1RbjOEucIARmXiBrxlBLJpWx+XjhI54XreKCLH3BZj+sni6LQcwv/oc87lilJMyH4LPRME5bT2fiw+7fyQ81P1afghyjFhN9EI/XaRpu6lPPVloHpU7lBS03PrHZ55/TRfwett2tUybk1jBDWCuQ8Bzkfa/gQNp8w/3ObRpTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRispM5o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRispM5o"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823075fed75so718841b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771533218; x=1772138018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUggxPaSmMAVQzWY8puyB/mctdVv7nxnhnv5JC+qPdc=;
        b=DRispM5o6UH6cvMHMPbHm84+KyHyoNhprcb1zmOnqkim4EKTv9srZDaDs0a+kWjT+G
         xIetif7Jhq9uj47Br8OCJkDmQHNwwtSq/c03lyis6c0CX0Wwim10nczeOWhdmTsLaiDr
         3n1+6AbpU6gK9k6Nu5mmzfwZqoL+fDtAXwRyZWR5hcfgh0kQMH0ZW5rXdskg6o8fLKUg
         Yitui6MrfCg8PdgLuioXU1ry1f8dWdeKDxrkx/tt27sSUNdY61CvZcdnjO+Bv2qfxPPV
         mlMtI+NmcqoMazsIM6Kh+q4k00nYFx3a+u1T1ibZeQQBRlx7joOriSw8NK1kwcsTD7VO
         7Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533218; x=1772138018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUggxPaSmMAVQzWY8puyB/mctdVv7nxnhnv5JC+qPdc=;
        b=bwVQ9Dcn15HpXfgyYTbqBPwauzcLIt5zca/zN8fJDsAl22x1SUr2j/j1UFDIpAH0lM
         pg3G+BgsiZmdxlSejS5/puz4CDVeE0EUY2i5TSR6pZlxDtSMKEBV6IBPcQUhp9AmUdsD
         lUL5k2tnm+dqdryUJue4PrHAq5zDYCJjjVjUYJyqXwz7Z1p+70a6yb9HTGJMEivXWaaA
         74Lf7pTItcVOIbKs7cyhMsSMBvo4IJWcqkaWngt33712+DGhWhxYCCD/ugWL3UyM5nLK
         58Vwz75TO6SnlNYJFenI+C+35U6p8nHZA3TKtzSdbCtfvp9siaErZh8E16L/wvE7j3ys
         Oc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3YR4lxC+YAKv6Dnn2mF8lAiHDgeyIxeEj+/fcYeUVSY769vIBTKjEEFTw1QHTnH0CEm5BkhBTKfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L1Jdlkqeoei/zAwbFsgfUFbd87xK2Gjv4WuRM0welABPrK+s
	DUhFq5inn2yqiCqV5EIaBrSvshZWvhvSbOmbDRv66mgIGOTaeumsBTPA
X-Gm-Gg: AZuq6aL8mzh619OKltnpmEkZhpuP9LNjgFGKWeFEp0tj45rF4nhBMqHdNFH7DFHs52a
	7jSAqFn0EDYXq+ky+wzTPPXqZZolALx5/3sXwiT55pDwSW+Cvqlek7gc/H2QM0WfTjPZpc3ertT
	AhDwGlkmkg8FlV1yvS45vHjeTtZF3lxAsRqmjK9T2EeWBxfnWgFeqL5biAltOFVV0ecDsP7KFJj
	IXSi2gY+bk2kwJv3oY+AgfUF5jmiQcREFTBnaaNr+SybqJYJpVslcZUQ0D+5aluBEA7lR1vCR9C
	ozKg285AGp9C4gimurn+tZkJNT0PXUDmcorIu/elepTqoxIUykUVz7P8AdKJbgIJjfjjkH3wI3n
	B/rSbfcslv3Z0uurIs+QT+iEtPfJ3Vkx1fwzrbqCdlBetRWmRG+b7QgLQIpZErOuIA/29dBt7zz
	WxXXx3ulEEy/p4TQJcVqtpW+EX
X-Received: by 2002:a05:6a00:1d0a:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-826badc17ffmr2708281b3a.19.1771533218052;
        Thu, 19 Feb 2026 12:33:38 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94b80sm20339278b3a.55.2026.02.19.12.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:33:37 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v2 1/3] iio: frequency: ad9523: fix implicit variable usage in macros
Date: Fri, 20 Feb 2026 02:02:13 +0530
Message-ID: <20260219203215.15566-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219203215.15566-1-rougueprince47@gmail.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
named 'ret' instead of using passed argument 'x'.

Update the macros to explicitly
use the argument 'x' for their operations.

This also resolves the following checkpatch.pl warning:
WARNING: Argument 'x' is not used in function-like macro

Signed-off-by: bhargav <rougueprince47@gmail.com>
---
 drivers/iio/frequency/ad9523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..d127f3aa6cb8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -167,9 +167,9 @@
 
 /* AD9523_CHANNEL_CLOCK_DIST */
 #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
-#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
+#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((x >> 18) & 0x3F)
 #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
-#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
+#define AD9523_CLK_DIST_DIV_REV(x)		(((x >> 8) & 0x3FF) + 1)
 #define AD9523_CLK_DIST_INV_DIV_OUTPUT_EN	(1 << 7)
 #define AD9523_CLK_DIST_IGNORE_SYNC_EN		(1 << 6)
 #define AD9523_CLK_DIST_PWR_DOWN_EN		(1 << 5)
-- 
2.53.0

