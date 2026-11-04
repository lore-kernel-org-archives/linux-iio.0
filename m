Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817308;
	b=NMKqh3BuS2qIwEFIR3BFVwD2Ol18cw4BaES41MEP3V3FQ9THCieldxCdcUnDgWSbyH+X
	 ep3kE+LVZX1cNN93AzNeLovwydnkcS/pSiFFy8v5w67OuRhWsULxIZboMpKP5k40A9XT/
	 panCYIWOtZjm7RgJOTTPjTgMVAM9FlI0uWyWzVQcL1FmJgaDLaFQmgRUb2Y/zmcLWuSMU
	 uX4jHBK57ehl8yvFRc6MED8gs9U78cqhmPc27uqGFaPtZmSuSmXwvr8Nltl0t3KBFkQUm
	 qH5eulXzsTuOaHgIn3PLHgfspTkVOM/WU3BGDVPLXbcfn/1TwaCA+VZNKmIFtqPvVVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=78AvqKs+xm6byH5E/GIRqHO2qPkCvfeiknurCnM2rCY=;
	b=LGU6OzvXdB2SYMcIQJLqF0xoXie2D/PL3637BORQnHuQnMsNXOfh8wDDJ0r5ifk5UmXg
	 mD1pNlr8npe62wWbM2ElYkd5XmV2N6O3Oc9+6q3BdA91rqreteSymnmH4KJ1CnifLnLjL
	 8105bxfaud8Ut5L+0PjONJqH51fiLpJMOkIKLoL2dRRg3ZrxfpskVffud9M3oEi62jWJf
	 JYM0Z7kmHe2F2KuBS0tC67cO/tLHmZLniO6zTi2Ca2nNwPPVNHUptneaZyT3taEFfMGMy
	 GsDLf5jJpH2SHkJCg1nhcAtT9sfcRtGNhkymTyuNwXVWdKVSGIdl+ZWS9xZXlrHYiCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqkI+Wlu;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7F606A32E
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 18:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF7F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqkI+Wlu
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so8857855e9.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817306; x=1794422106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78AvqKs+xm6byH5E/GIRqHO2qPkCvfeiknurCnM2rCY=;
        b=YqkI+WluIJocVh2f1mr6rKjFwFSild9YAR5zjTybNF0sQLhxBvfU63Ub8XXWfx/Ppy
         pDjNN6t8nR6bjhr9sgIGqKQHP/Kj3YNLX4W8Oo99wukrkgEonwiSYvD33FzkPAKw1Fwy
         gSVVgxp/XdDyAsouweUO9Ch7V4hUy/JUpVQd39HPHVNZ3vetItkzYs2+sOWnlbe72YGd
         IUjgod3hJU6Gd7FVkl4w1tF4mVXO+nLrW3W4UxKJYL2rey8dKPR+TJtP8PBUflYESuJD
         f4rE4OyPvKvtnJM0FFTEiuu6VprVSjZzYJ/scpsTXnEZ163tBlJoFkdDs0Pi0pdibmSS
         ZvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817306; x=1794422106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=78AvqKs+xm6byH5E/GIRqHO2qPkCvfeiknurCnM2rCY=;
        b=nbeH3M21Yn4pt1V0qI6B7z1Nqn61C+kTgSxZwQFCOzYhFnEjUyHzzGiVY0sEvucEVh
         6BRIVAQqiSDc153moswzf8PKL7oOHcr6tRnQNrr7hz6j9zQksaHtSJPz8jV++MV1p/JN
         LZLcgse6PGgUjQOoXzbdTHu7p/VNg3cEQnuyPPGi5WEU9gDfqK5EKSVGTXFPDnvCmwre
         lNMLMxCb16kvxHVXrtkX7BZxPCSdP4/qGSpuKoMZbSfjyURpKE5BTvMPNf5Kyoq8F160
         4WgEwo7uWNY9ZPK5N2os7on3K9xtrAi08Wjwlk2iDPVFjxcq/aLEBXYfuqO7cAz1KHWU
         cPPw==
X-Forwarded-Encrypted: i=1; AKwUvBwXDi/66k1qAv/icgFy7lcz4n744G46bHwCiyXZ15jkB63EHRVgjrdDc16XNXDQ/vJzOxVByzz8uNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+26FnWIXcOcO/eSkbg23CM5jOAAf0+zeR9JX/uS1gmPNcOJwl
	cCKQIMFP9GRo2y8sX/1gv/OmXDjGOM+xRvUvNZA5vl4S/DqhxJPx+7DF
X-Gm-Gg: AYBFou1zlHAxyKu9ZStPa8pb6AO1hzMzy0DXXVxtZg2r7fPMQU0U8wkrQvrO9c/NQLN
	9DWgcgQMt1xKDHjwSvBSq6uO67TCEADtIAPz5Ax2GEVvdBm66aoUDvYgnqnZ7rnh2po1K+WtYGC
	0n454gqSgUKZ4N/BlKhWftsbUdTGnzBwIcfngyIE5uzErglNaGOTfuZUiDm7LjshE9f4BI2OyCv
	2ZcIIt9rN+XxA2tampQXQxY6AlbArI6PZ+4RagjiMNhvsuthyDYpywA/21KWnLetD7V1mrbYvfA
	RSXj+h34q9RNQWRUW796/j8agW18HAO4L/FqGfPXm0sk5S1ACDSWLyXPMnEhegdNw2Ee43Fgs2M
	V4JYBSyCpIirSL8FOLC4ClG+8RphTa4GiiZtEZRWqfuC48n06iwUHwwJJHdXgvkVBfL7Fn9NHbB
	rAcp2HC8hxIMKo7hTyb+knRSTavlpFzAzUnZVhlxfRwyedHI09ivpus4C32r329cFQMTNwGIq28
	kEV5wS0yfN+Fmxz7QU5vp5Rh7IQ5LtXxRG88MMBDXgqI8XeG0DaUwyU5vvjsXNFnw7QxOZdF2z9
	P5h2imnzqkOruVqZ3Z0krq4EKxPSQazKACOKDw==
X-Received: by 2002:a05:600c:8b64:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4ac16fa21dcmr409797395e9.6.1793817306434;
        Wed, 04 Nov 2026 10:35:06 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b432a883ffsm31404915e9.3.2026.11.04.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:35:04 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 1/2] staging: iio: addac: adt7316: sort headers alphabetically
Date: Wed,  4 Nov 2026 20:34:28 +0200
Message-ID: <20261104183429.20125-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
References: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort included headers alphabetically without altering the list of
inclusions. Keep the <linux/iio/*> subsystem headers separated from
the <linux/*> group, and add a blank line before the local "adt7316.h"
header.

Reviewed-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..515f1fdae46b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,22 +5,23 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/workqueue.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+
 #include "adt7316.h"
 
 /*
-- 
2.56.0

