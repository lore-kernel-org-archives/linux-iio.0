Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E26326945
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508062; cv=none; b=X6q5K0s4DgQD7JRKOi4fANEIUbYguYGg9HbTd+3ErLmMYpB96gEnD9SAIwxA1/6w1IEb5kMez5bYr3bYTycPiRA2kgbKlpplnSpB66M4h+hjiY/QdrHfEsZSgaiVZQ+SWkaksnU1XShKDxqw5GK+5h7Gvk3neGt1SnUndrDCisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508062; c=relaxed/simple;
	bh=Am4lh1Jkyp+tYV4F7zMTQJq7dkOHk6gWF/drmH2DpPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScCLwSRAYz9srReI5kN9BhhCaVqDbBiUJMDWVqIOzcRoxA4XFGAHapAGW4XYuykCkpVnPvmfiL5NglKdNkfbO0Q6CdtirsjYdLUN6uM/1h5Zb8GeyO0RcGyd0u+x+PMIj7kQuzNI1njCPrZkqu0q7poghy/uyIDAs/COYOca8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eljtXVn7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eljtXVn7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a18b65515so1953227a91.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508061; x=1774112861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ+pX53j5zcNZgACPR+XlfPgVgurc7IbtYHecyELLbQ=;
        b=eljtXVn7JtY8D6IjU8Cf/AYLi8huMpqqzyzgHs/mQJjaiVb8p7gw4wFOr8s+Iy2fDQ
         zTEnnpjEEllbFuRgbDb80sIwu+2eqBzQd1XDYgTAikb+h4tjTGH8wrnUeZD+HKspLUwM
         E9bnKjEand08vuPoCxIbF9cLAl0FCaNayEdXFijY/O0qJ7cbjnkN5kErxcH2woCyqNpH
         sk/IRl+NQJdGAG1DY39Pj+g1rysiTjDFPKJSUtIs8LHGnEWIdKpznIV9nKcblgbXd3MF
         obYRmVfRmFLsqcfwGWWH+Mtdnobd0pznb1b0qIbCG2YE3qQO8kPCSUNA7o1jvvIC/ps7
         D1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508061; x=1774112861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZ+pX53j5zcNZgACPR+XlfPgVgurc7IbtYHecyELLbQ=;
        b=doRsPqQFVdOFCrZvhu5xe+JIbJ8418Z4GsNaGgP5QGxFUticO9l7rXGzvTG4Yk2Zb5
         jloIJrEA1nE/sve7BaHTZUwzqpNsr1Lbeh2/geh2gUbkL07Bb4fqdvqO1dVehCrKpvUF
         hdLbnc1brluE8Sd/ue0+veRb2rle2z2+f8lGOck0SkYDbTB4u1iRgFMGa4VTcKT6sCk4
         Ce8Gd7eWK/3/Y4AyHu8L7YFFGDVClxNlMO6eHOa+Gm6bGxkVS/76B5V3FsyMY6ksO+CH
         hDthFeAX+6Ao/7deKmRVoTREFZuLkhArsVSMaZfqkrJBSnC4Az/4p6k5mkyxkPmZ1MeH
         /aUQ==
X-Gm-Message-State: AOJu0YyP3lkOsnKY+0xK49lQyP7YoFnJw3Nis7+y9/zuqPzFMPH5xuv3
	UGi6YmJYSa+orJ2Yxq38T2OgoUZPBITerD3XVokWvhQmvnvLve8R9euH
X-Gm-Gg: ATEYQzwE7mQTLypRJnH54OjDQz+h9zOQXAW5+ZeiP3K1nwKPtztJFaXzgJ/5WmonRiI
	FfodsQ4p8xaJLE4pVqkfU/YSj5EIY6yVDl1WZPi6EZUTwAtsM373efTr/PVJlyxWyg8MsY9jynm
	YfLoNXWjIlwN/PHuTmK11sHLQSdVDCVjbSp2ba8EzHX0Msd95e/3L2TbDpHwWqsPF4jeZoJeGVX
	yfRshXw033CbTl0hiYwBt0MXA+d2ShPayOCJ3cPfMacLz9v2ZKBzkiHqEIAWQlZmAF7dr+e0lXz
	WZfDYj7vfUDiU09UXFSdgSrj5x8VggcTQTov2zpfhCidYkZBEQcDm8gIIQw1pzGXBqL6M5cLzTL
	ZGR7vOPmBQ9Uc7D7fkpLZOKCH+gFXw4iaYgtPLzKnRGFfVUtkaQwSPoLSKtBGTt4Rvx0McCY2lh
	UkHzTBmtldT0Eys9Uqa92Eh66ufQR2/dNKrDVJqBo4rc8cnR3dhgg10H2Aa2uGDYDrD9MF0dFAR
	0jA4qOx37FM1OpT0LKZXmMUqls=
X-Received: by 2002:a17:90b:3d83:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-35b8d89818emr1893009a91.1.1773508060828;
        Sat, 14 Mar 2026 10:07:40 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:40 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 7/8] iio: accel: sca3000: sort headers alphabetically
Date: Sat, 14 Mar 2026 22:36:08 +0530
Message-ID: <20260314170609.26827-8-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: Patch added in v4
---
 drivers/iio/accel/sca3000.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4a827be439a2..d61ad12aef78 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,20 +7,23 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
-#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/uaccess.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#include <linux/spi/spi.h>
 
 #define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
 #define SCA3000_READ_REG(a) ((a) << 2)
-- 
2.53.0

