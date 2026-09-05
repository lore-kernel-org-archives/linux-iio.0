Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F973D3D14
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601055; cv=none; b=UNHueU0w2JmSPmXiuLEiysAxQ5UlDQOmJv6rd/VhgVarAPvgCwo3iAwmQtqhrpTS3mgG2E+c8Fb2MweRHSJ+ZLxPs+sGnUPEuUJai100dvChUfidp/V4mNvHfi7XNnDxcwhn7TpKMZ3unyBTwk3bPsoTf0irnRC37iJHvwDuBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601055; c=relaxed/simple;
	bh=Xp9ENmv/lelwk4unttBWYQyxWUh9lt3BGxEuS6wNFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeq04YMjl5Bf9LTQVwxlRp/pjy03s/dJSIxqU2/avSBvi1J8RHiyKYHDrN5nNoknsELADj4EqYqkko8nFj4gXzChAIoh0Lqt5LxQ9dBLRJqHJt+llDGXPqfperPD+ZkosV8hLjMbuo5MC3kDSmV2ZKYMfGOgdoismUzvj9ZQVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/6pu3pz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/6pu3pz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9201076b3so22293135ad.0
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601053; x=1789205853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qSf28+gMU1cPc/sgLS/ZHLrlXSMGyx8oSsqQzyWeBs=;
        b=r/6pu3pzfhbiP6NDy5oXJU8bHG4PUYoqswdSgm1oCFDSY2AkCvxUDM8fjqvhmcyw/F
         Ln3AcTdW6VAZV5O55BJi4YnNbRVyafctoo9ghvpDgknXJWpv2MuprBMYqtfM5KOOYnoH
         vWP2PnhQ5Q0YuGwCQMbkWUt+QV5Ga4CHmzkLnGRvB0sP1JECMebyqIZea7MGR0ugoeYN
         hgfw7D2mSBMzcQOY8Nm6MuWpHXJcMl9XqykPuwxrquYJW0a/BtL16XiGrQt/L7hclLEz
         n/D1k0D33+PmMDss7qQ6T1usQ1l4Mrcz/b4zZjctw0bHOS3/ftJKFRYydI6xdnQHniRH
         QuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601053; x=1789205853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qSf28+gMU1cPc/sgLS/ZHLrlXSMGyx8oSsqQzyWeBs=;
        b=bNgJk1WYkaRBB3B7cj2mMJ0YvjIweMRnmKTcjfGnyqHq6VRP2DjqQnltxgNnEfvF6y
         uEvnFh7ioOCZHtybhwfbSnPseIDsSvBVqw66ZOze5hlG5o+WVmY7eyAJ7MjEPmdbLKc7
         1HjlUfGtmCDR3AO/PIhqnqjOvPJ5Zr/yewnKerYsM65LzWSbRZs69fYSoFoZyKINy1lL
         /srDLnJDviFNSX0msifokjLEKeQq00wNLeSS7ILmcBLhVj0IaqdzGqwZbrbiwx54Tt0n
         xOGSQGrWAOgZsdhmqZ9LGPiopti5MFA2VJAUaykznGDN9VuIFs6Nis0d1f+P02F7eXBY
         1rbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiML1vHgfvDAV5343eQXsZk14C020CpEripG5esxpa+TRakujRd8N0Q/v8gYzf3Oyk+aF7ZVkd/24=@vger.kernel.org
X-Gm-Message-State: AFuF++l90ysXo3ehZOik4aiL6QAH9uVni5aQKorc6TbXRuQdat0hc65p
	hKbA08QINb+WECSiAOB5FziSr5T6LBj1mdb0h5vNI0eF2JuVBRl5R3O8
X-Gm-Gg: AYBFou2Rlm0OeBlET48Us4gyG4lLh9y7wADTh9QLGruKN1AST4cqdzg9Y5bi2ooNKBs
	0fDIsJXxBh0K+B7cV7gP7fEo/A1DCjdkAhpdXYje9qryYhUjjw79Rra3QPUO5mWYzlu2Lc9Hkbr
	7GP2nn4noIILayXiU5w8jJNwBTu6YXDqcej7/PGhZ6Xmhnm5kaMDD9F5Cp6Q33KtHK2wXdBR49Q
	UOGAKEJtHCZCftbS5hrYC6jGgg0KeSd3DnchCiBw5oio9JgpjOMBL85xp/YzxPStPzze3YOqTj9
	Oy8Xd1SCJtjhc8bLWEU35aDMlmftYE5u5keRqF14jAEDVeVge1Aw1Lsb4gsDO3F7gzsoN3b57K2
	6AzTIGckH1BrUMGeBNPHtD6+WS5Y9Dm6iqa43YJc5Rhu4FrwBmULycaEqHkpioSB6lyAbjiV2Mt
	eIgxWAI9WA3pOR4YYH+5lSvQB0T5Zc3iWT1sdzzyIUqvYVE3yyt5mXFIKUgw==
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39b26101029mr16362724a91.1.1788601053217;
        Sat, 05 Sep 2026 02:37:33 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:32 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 2/6] iio: adc: bcm_iproc_adc: fix include dependencies
Date: Sat,  5 Sep 2026 15:06:27 +0530
Message-ID: <20260905093631.48667-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093631.48667-1-mdshahid03@gmail.com>
References: <20260905093631.48667-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Add the headers required directly by the driver for the APIs and
types it uses.

Remove the unused linux/io.h header now that register access is
handled through regmap APIs.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index e46e3761993a..e54f613d266a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -2,15 +2,18 @@
 /*
  * Copyright 2016 Broadcom
  */
-
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0

