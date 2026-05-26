Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95187165F16
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836133; cv=none; b=ZYKmcFQXVnF64/FWI/DUaY/LEnJrHx59rhCwUYaP9+SCK2Qn27aweyMNNKiPlaHnJzUK98NjIaokRYrzmEIH5mAtqCVt/VXjeyOxrRH37jcxiNSodvz1JuF6fHJEDDus5BVQLkiEnSkW7frNq7lx6jqDSwLU+dXa5Z9gj5ytmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836133; c=relaxed/simple;
	bh=+4BfOIrHwNp5Zh98vFYK7tpf8R9ocPQgn2KbiPpFooI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzHETAvvM1fjVAPAlD6+UcaQ6nLOnwiHhffstDj7iY0VgQoqPJBy4ZgLjvYbtSAvxUUYcwG3PB87+XgJojAZBpNSxEq8TlOyde39Uo31rdv94+YybfaZUDI1VBrLa2S0tZRlrEhe/O4sXhVRHioThVfUI3buM3txjEiBDr5MK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+Zl1V8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+Zl1V8"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8c92737a8d3so71856146d6.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779836130; x=1780440930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4yVkmTcVUUu9NqnU6zdwk2UhPPdPatpYNyM+RcDiCk=;
        b=E4+Zl1V8SYGDm++aFLJye6ZjL9xob+MjcspiZdteaRFfrv7Uxd+P/rNiUG2ytzGhGE
         7nVOQVT6z1MiJS7iI49b+9Lb402n4jZx2RYgHAGJX1jgMMvSU8dZoNUGgnSAgUxXwnqe
         L8MG1bdZ0vfS08k8ZXgNHb2elVl2BZLDYzamJHHHKzLMB/t5oKiDa3aFlNekhhtjnaWa
         gVsGyrICgLW9rR/nQ4t11vFn7aMRP/v6mm2+AaJ5r31nLMuq1OVe2bN4dm6etLbvdniv
         IE9BHDwsqehWvJrlyjk3nzRBMSt+Y4g1/r9GFfFtiO/ry2XI21tBuK1IjhoLByJHTJdo
         /QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779836130; x=1780440930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4yVkmTcVUUu9NqnU6zdwk2UhPPdPatpYNyM+RcDiCk=;
        b=hxAr05FjHQYoFJgqQKa5LbkwbRoHWN10Nfglw7YceX+9UDBzjmg2MOOeR2Fuoz0JAX
         t1d1brivCEgWnw3c63mejzCBksemcXEgraL75oPmT82M+EU8RD5WGZHzE6fUga+s0vYd
         nRK0f9Gdeaqkm5iCim99Y7UofPLFgaZnqHFBpGWTMLp5EoW5jXdblEaveszLhZJzvQFm
         aqkHqb/9aqdaoDVGFVEI7PIG8Rk7+epgm2jAy0Yvxs3cmy6QK1ItiuwW9ciI5MjnkS0H
         vTCjWnhiVmN8l8XkDh153CuTw8bALbwnAfew4S6lfldscJqO68R0WzDrqqGwze/N5ePB
         3CGw==
X-Forwarded-Encrypted: i=1; AFNElJ+i7j5d7FHzmpcuAH7lV91+H9i1qixnfcni0nEf3AnVXH1Se6FON1YmWbcqJ8sQimbL/I4nAHQ5AJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7cGVkvMv2pcZGCxeLWsuyquCaDMuCMJbYBhGdzzcl4pASrO4
	MtQ/ZLeCz/8YjvA0ch7JsoHmi1nafssUFBz8YuMuutY8QCJW+qteO28O
X-Gm-Gg: Acq92OHXXZ4xNlAow/bX2U+7GI4lCRcZkZfkkPoelSIw9Bhm1MreWGTcvF2wQ2+EEcv
	uOl2/PHRenG4RTKxpx/raixOU+b8CnhK9eHAE/kNPqCDUUCETsfVEPdLz/79feVMGczZ4vVhyGX
	oCjfUQzPEeyaMmvqL8c33aUlZhfj1v81nKe5Uykh0kef6Vgs5M7OrH0WDt/M7v6mQrll1A2Ltgc
	HCAtUEulakqfm+Rd5PSGqDm4ryr9cwPB/FzLz+3f0Cs9BrfUjpKzOm5ti7Xu1qy2jtx/xUcDmXZ
	zEY6/vT2vTJN+v4/CSzo6MsDTh5Qq+RXOPVWDzWmpbLn9IAF+BFi9VflmozI16honYMtVr8tmqs
	KD8PzNKIVIOMPQ7DNhTE5VIZdPDXnl/D2POB+xvLpZYo3NRzH8IoDb3huNDCxn5iLX2O7cHdhZ/
	3IH3/yReP56it4kKx0rlRhfof/ztbgBqFnNdzOHZnyqUHQpcRK7zlx4X3MKg==
X-Received: by 2002:a05:6214:5a03:b0:8a6:1216:fb78 with SMTP id 6a1803df08f44-8cc7b5eaecamr326150336d6.46.1779836130492;
        Tue, 26 May 2026 15:55:30 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306d70sm151715996d6.35.2026.05.26.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:55:29 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: sashiko <sashiko-bot@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iio: chemical: scd30: Cleanup initializations and fix sign-extension bug
Date: Tue, 26 May 2026 17:55:24 -0500
Message-ID: <20260526225524.119001-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/bitfield.h for FIELD_GET().

Create new macros for bit manipulation in combination with manual bit
manipulation being replaced with FIELD_GET().

The current variable declaration and initializations are barely readable
and use comma separations across multiple lines. Refactor the
initializations so that mantissa and exp have separate declarations and
sign gets initialized later.

In addition (and due to the nature of the cleanup), fix a sign-extension
bug where, float32 would get bitwise anded with ~BIT(31)
(which is 0xFFFFFFFF7FFFFFFF) which corrupted the exponent.

Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.com
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Added new floating point macro constants per Jonathan's suggestion.
 - Included linux/bitfield.h to use FIELD_GET() since Jonathan also
   recommended its use.
v3:
 - Added fixes, reported-by, and closes tags per Jonathan's suggestion.
 - Added explaination for fix per Jonathan's suggestion.
 - Removed unneeded comment.
 - Changed commit subject.

 drivers/iio/chemical/scd30_core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..79124f4d7b9b 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
+
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -43,6 +45,11 @@
 #define SCD30_TEMP_OFFSET_MAX 655360
 #define SCD30_EXTRA_TIMEOUT_PER_S 250
 
+/* Floating point arithmetic macros */
+#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
+#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
+#define SCD30_FLOAT_SIGN_MSK BIT(31)
+
 enum {
 	SCD30_CONC,
 	SCD30_TEMP,
@@ -89,10 +96,14 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
+	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
+
+	if (float32 & SCD30_FLOAT_SIGN_MSK)
+		sign = -1;
+	else
+		sign = 1;
 
 	/* special case 0 */
 	if (!exp && !mantissa)
-- 
2.54.0

