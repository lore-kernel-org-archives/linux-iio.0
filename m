Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44A332918
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252064; cv=none; b=B2FZGTJ/LoG3Wz9iJob2acrzxp0rVMmfgrzJOHMcRj75Di5zhwzJ9/Q7MAws1VaeoRWirSlCBzmTu+UbkelnCyh8GqAIyXH0c0cLSL09dq/DXLBYnm7jU6krF8L6y06fBSXe3hZ3W0sqqXZJddArgNYr28bZM9N5KOOWmMHr3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252064; c=relaxed/simple;
	bh=4q8s68gE50AUTBX5ByZ5704etDStoIxQttjAftpTluo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/Lr5LQMs8M0unIrgsV4iNgpjGuifqffY46O54mEzwQ3wK3DIDZRF6Je9TUV6erqzAKA/Fa7xAX1KZMGigEOf+7SeyvVObPQMfIQBG7OV0Ckx3TLA0D+97WlK6D1VDlmkEpN0evux3y+OP8MJEy4b+nzwmGyGir/Uy8bNb3zVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGFwD6wo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGFwD6wo"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671a2f4fd28so4211979a12.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252062; x=1776856862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lgH8IHB2BEbMC4PzGbxkkl5jh/6dQ/P8CyFJN1sen8=;
        b=PGFwD6wojQRAyyCzzQsTxBSLIfxt0ti8snXgSf4NQ3KPlJwhfBnHYWfb8cQhnHslo5
         P9Mgm4+RUSrJzrBQcGd60OQAjaZJAFyhQFKpgsyofAuyXupPawg4cFtKPiZA3zxbjT/0
         blritS1PFYRqLPamtw/oEai/iyEGxxavNa3sLOtX+Frz/YHbU/8FdEtBUeCdKMGy9U1G
         lUdCHTVGrvDrLEYqQmddTamZWHZfs98vdj/VdWW7j3KnUtMck2hQKqWwfiqRF9EVh3xA
         lw35tLJylhCX7Y/nD2IzwIUtG27Ka+xQ/KSmcVDuZL+sjYY/e2gipmhNtPvEj1XcXArv
         3zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252062; x=1776856862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lgH8IHB2BEbMC4PzGbxkkl5jh/6dQ/P8CyFJN1sen8=;
        b=ZgbDenEGo2IV3be+xTh+HttguXcrzTdlUsAIR3hRbTTSwrRE7aDw20zaSeff7WRyc2
         DRkSI5yQ/tbZFIhuRSDgunEY5zYpVktLzRG6v6B6zEU9hUDZAQkn5ZIdnYUZhMskvanr
         7QQG0llvwayraekv4uAUMy070yijBMi1jt9/m8j/xEzkXpM43jB6sLBX6yN6AifBUN3b
         70Boga2m+K/ZZCeoB2T0iFbbSJTm+od9hcETGLVkQMGfyZ+pWS/ygtpFl9KM3LvfjaTH
         xfqBxlObSD6hynyUl5qt+OEV5zRrYtL+thIxPALzq7eo7wbiL6ZnGIEeh2FFe7CEmTx/
         85eQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OxFG7VERd67Pp3qtEjJY+AO0Y6DW+ADId3aN1etEyAl6sUwO+dBLUPIde14CYq4QmGBOm46eTL1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4Wk/Rc20NecOhqM90cBnJpeOYT0I7SFWnP0s3gUDxfRfOClq
	aFc+FbEcnyySy9osDq/mS2FGiAcw3KAT0XowUH2WnsTQgD3Yl2xsTR/Bre+Sy3oNubE=
X-Gm-Gg: AeBDietH0fY2bOBCF71yt4XjjpD357zcS6l4BoaKD+vrIEfaa1148jegoYuHXQDz4jJ
	tDiQvtM7YqqWweNjz0ijVgp9tOStdlE706Bl+MQHFBvy0ClG0EeitL3g588CCgGvsrJ+QbHjdVX
	mdw8HQUaUVH9G61d9e/efYuxa5m+AqGqPwGZwtComd/zBT1mvbQyp4jPgRx/yen0eoDJZlhVSkr
	Ps9XxJGQAiVOvSmJ0DCDjuLEJFRGjE1v9FCFZtrHGo3pXdqg7Nng7P69au5ZRkvJsBLyDeluqq+
	Zj3URB5OEQyH65Xvz73+Y0N6Upk2bfwO1FDXqxgnWjA1XngEgIJ4+Lc9b7u+yp4rgG7y0z7BGKO
	j2YYKmP4eFmlE1vaDHnoHLyIEK1oHCeHpP4BKnQYSN3sME0jX12SRHDVBWUrFuXKIccxIBdDFgz
	GyMtkSG0+x8sFFcbhHR1s42K1gz6aIY3E7Tz0IcrrNSaTvKCJdiZc6YGqXMTJuWFftS2PL+9HG4
	56aOVKVzqqWp4cDYu579FNC7RGQOlNGL/IjPxU4ZPO4D+I1AbwaneNd3B8yIwbO6tqC3XCgH2y9
	Jrq/xNsQWPrFqLIwR0luPV3g/Rmrd1M2u6NWd8ZbnK1RFZhIKis2hr9KoRO53kbfeYvUrLySU1g
	H82K3niUtFZjiQwzamep7OOIjjHy6LI48Jt1BwaXZr+RMFiT3FihAu9BdQdCfRtSRvoT+Ex4yRT
	JC4A==
X-Received: by 2002:a05:6402:1d4e:b0:66e:5662:2112 with SMTP id 4fb4d7f45d1cf-6707950b1b9mr10446575a12.12.1776252061547;
        Wed, 15 Apr 2026 04:21:01 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (8.159.12.34.bc.googleusercontent.com. [34.12.159.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d78933sm325485a12.6.2026.04.15.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:21:01 -0700 (PDT)
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
Subject: [PATCH v2] iio: frequency: ad9834: clean up includes
Date: Wed, 15 Apr 2026 11:20:30 +0000
Message-ID: <20260415112030.1324-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup include headers by removing proxy kernel.h
header and unnecessary list.h, interrupt.h, workqueue.h
and slab.h headers. Reordered remaining drivers
alphabetically.

Verified using IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - dropped patches from from previous iteration of
   patch series
 - removed additional unused headers
 - returned bits.h as driver only uses BIT() macro

 drivers/staging/iio/frequency/ad9834.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e0..465b2fa7a4 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -5,18 +5,15 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+
 #include <asm/div64.h>
 
 #include <linux/iio/iio.h>
-- 
2.47.3

