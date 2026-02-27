Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47129374174
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186975; cv=none; b=N+ZO8Wg9HDoqdzUs/3lVyqkEXRlYF9/+5bfSn0wyL1Z3+wF8DmA52/p2r5BB1CIC7y7JiFlda8eiYUs2SB9UUPvQXDoGJToKh5ulnfTY/nuZR+DKjQW8HhVUk0qOrM5WAzf2ISHAFllb/gQ8iD0pfszgFjczhHo2VH2FGdiKgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186975; c=relaxed/simple;
	bh=XxQhq24IP0RffrMJAKIWjVTnHOujl84RWJQmP7kSEME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzA5rJUEczGhn3myzyVB2Y7PA6vVpbWuKklCTgjTIEZwgJmDoqVDlkIyfDOBknmh4QJ/z6Ez5cPhnjRQh0UW33kZqCapruVnLOgSerQBUEyMJr6Fe05o1SUbKnPEsEmSl+Fjd1lwvFKUrnivAfh9yofNU0etqZJpko/r1SFfQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+Q/1j+z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+Q/1j+z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836d541968so2029545e9.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 02:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772186973; x=1772791773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVuS9D+l2Ox76ln7aUQ+JMThN/eVhutrb4aOCJcJ1OA=;
        b=N+Q/1j+zVpgNS4DRSxjXg+BB20vy8iRBX1bLJmCtHmcHTBdG5BcF7Ll6lN7vOBH2Gs
         HLiwiuze6q2ffTfFZ50FwbIn3bnN5jI3pcn9NwSLba8EQfoRdRqT4Q9Cv3voFXkZwA+z
         sQo2TsQ0NVrTnSngo0K2/283mAw6rlbCm0YkhKiMcOVoKcRnRih+KlrMtBBdkZ8DFae2
         qtLJKVyu8i8DnYBTGhwqRhabi9928CFOqYxqJ3DcfLHWx12pKx9ZX06Pf2hyCFH6Gktp
         NFsQQ7OxheqJgRR5i7/Li7fOgtLl/vLU5pAof1aEu7le9tMQWoCNUJgcnlamccv9QDwI
         LIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186973; x=1772791773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVuS9D+l2Ox76ln7aUQ+JMThN/eVhutrb4aOCJcJ1OA=;
        b=WrUMHoWuxojHCbUvXifO4mwa5jQT6/WKl4t3AwjH7SCuHfb6Xabnm/uKKSAxm8oUNe
         OEWCGBoGz3lcA3i+rS8i8460tglGAM9E6gtuIlaBai5VHg3u10GREpBvQrSwFwATXDH8
         581oamfddvN6kPrZEpk6TGCOPutoLM5cDfR0yX5Gwa+ZX0iiOlJCgDaWrqukzCTExDj+
         76sKncxlXiJHzZ9k0k2KdURuLp8whq5A6QFtUWtYs75pYKuukcqwqA5fjC4UujEjIt6X
         H/Z0RptwvYjTt/llQAnuLCW8yxDkEfC34/sVGcJGZzupq1ueyMrVYMk9LS90xBCcB/Ot
         GXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZCr6YUolB8YK63b1+xoha9Ogsya56IJImWBMvOrQBdFe0OGKNpZGMApU/A5j2FayuC3EpFYxTOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8FQ0ryRvXwmC9HkVlhNGGV0+QMesG59+opt1WmeQWgRQMJcJ
	27GgC5hDp8IvWiJAdEWC8UPxZLtCfAH0khSX9AJcrtTEgozR9mvNoWY4
X-Gm-Gg: ATEYQzygD2EYXf8SkQOM5vbI9sI5gTna0wwM8c4jlYjuc6K0yX5nrOb0zfUCt3nyn2m
	Aq9GJjU0GPQjgDlN+Fscr2BOyvTZv6qzJJmHGd9olD6+9T4NIxFeEBeUd8Xj2agFlQpQmduW1se
	lwEmZIK95RaUd78xCRlnrF0TlV1ha4+CzY0BLsQCRQD46Mbp2NK4ZLXPWX39FlagJEeUisSz9bw
	UHZtv2mfDeEQrNjsA/w+bBrGB/KKU28h2jA6IiDYOWXFlZ9uGDodAO4vvbdt5FeDuzWmcEF9g6t
	tEH4xIbjzTDmQU6c2lmgcZrZ7OVM/YmCBmerghnjOBsiPpDEQ9/3/KCO9V1pp2i28RL2TKrvY+6
	Q35KSyqP4hSX6dV/XQnK5ZSmLGLYYuvt5Ae1JtuNM87J4h2WQgLGcFOqmG0+9f+wp5wT1arQwLj
	uT0xewcofKXSmoEpOL5GoN6IpIwI7UVeXbJ3MEu8bsxt+wwtlGesNFH5rnYJtPvUukWVswZu4VA
	X7cLr8hrjhGM46h4lsuOK9n83mwYyqgnakASDPf6QnUR6TPmFsn
X-Received: by 2002:a05:600c:1d1d:b0:483:816b:67cf with SMTP id 5b1f17b1804b1-483c9bc1c79mr15268295e9.4.1772186972350;
        Fri, 27 Feb 2026 02:09:32 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm182836165e9.6.2026.02.27.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 02:09:31 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ade9000: fix wrong macro names in ADE9000_ST_ERROR
Date: Fri, 27 Feb 2026 14:09:01 +0400
Message-ID: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADE9000_ST_ERROR macro references ADE9000_ST1_ERROR0 through
ADE9000_ST1_ERROR3, but the actual defined symbols use the _BIT
suffix. Fix the references to use the correct macro names.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..0dbfc079e115 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -219,8 +219,8 @@
 #define ADE9000_ST1_ERROR2_BIT		BIT(30)
 #define ADE9000_ST1_ERROR3_BIT		BIT(31)
 #define ADE9000_ST_ERROR \
-	(ADE9000_ST1_ERROR0 | ADE9000_ST1_ERROR1 | \
-	 ADE9000_ST1_ERROR2 | ADE9000_ST1_ERROR3)
+	(ADE9000_ST1_ERROR0_BIT | ADE9000_ST1_ERROR1_BIT | \
+	 ADE9000_ST1_ERROR2_BIT | ADE9000_ST1_ERROR3_BIT)
 #define ADE9000_ST1_CROSSING_FIRST	6
 #define ADE9000_ST1_CROSSING_DEPTH	25
 
-- 
2.52.0

