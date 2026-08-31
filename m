Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2039CCE8
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210833; cv=none; b=MrygdtYvvvuGO6GLXx8FVQMjgvUY6/ID4f3KuPLUcdmItKqdgl5Et1ii9x6rKbEWAkxpPWN1ibr03k+TcOiis467ZOZjDTghTrDdutNTrH2yNX8KSVXXp72o0SWkc8+98jnS7AB4nyv+oB/KeJfRF2SfEJNnMVBIrKOokRPjcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210833; c=relaxed/simple;
	bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fw3wfnE0ldbW2FwboU+lqwPt5xKv2F20CwpLdYtpdCowr4c62iWdUCPgmor1O5Z5Oh4fgEopybRZdjIjX/JmRiGI8I2Gk3+mm7on8EW4ZsqkFUCP2Z1mcDB+yTZ5npjk8fgAq/LgblSLnXGU6h4ii7d3vI7nWc0Hp+sTpzW09IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtxwB1+N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtxwB1+N"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so27619455e9.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210830; x=1788815630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=qtxwB1+NeJBNP5+t9FaPgwDqXH1SvCIYoMXZd1zWRTB9l5FrbZ1Bj2ocoE+I6csavX
         fd+MmCKGO2q8BLSN1bTsIyealVCBkBRpFx5yaqdN0CShUKziIZR5vKEwbZHSY9ED2Twq
         P7sm0WUoSb6nJjB3VSP26CfiWOy856rnmV/ujNUxj2UcwXZnoQGMZ+L8DWtYabZpRVSU
         8RrB68YSLRRsf3eZ4Ymh+h2vbdhrp0+beGcQeaayCQnRXACkfCc71Hw8ctl/LbBklB4c
         +A8Jb7fXzwgjqmInLxxqo7jlJPjY7XjWvB+KbRLPZSwKztMuNziRBMNUItYOXvR6Bfwz
         cblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210830; x=1788815630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=CW0h/TSP5rtLumrlwm9563YbcLj9GMxs0mlx6SAJWJAlUAfWKoRVj3OzMtCw2bQt/U
         tTCmP/bz4TAz3mrHkmVGzlLKLOQgij/z69IRVudE3VTq9J1KN63Mj95t9q5iFOnRWChU
         Zk/iTbmrky40eEEjGThLOSU7kDc7Iumi2RXLIow0DicCf38wsmJYK3q41gA+Ntmq/gdZ
         BQHhWhaaMJBiXgFHFeAX+UZO5RTN/xIOPOK0zWGkvgNSRX5VO1/WM8su6VNu3UQhLIhp
         zbeMeUgghbroYOe0uKUAe4axI/kTpo++4D9vfudfsnEUpcW4cH0Cc14lR7/2GOSMOvpF
         5tFg==
X-Gm-Message-State: AFuF++lexxkm8dtC1cmWbbIK+EFcTzQ2MBq8y+PVL6YwHicPD5/TKyGM
	Ev+wzliM6IdgoiMXckdzoj5DTVKvSJfWA1vXnWdi+zeTjShkVwsA2ZWT
X-Gm-Gg: AR+sD13gl3BXS7wkh/4LJVldAoH6q4IyHxWtpS2/KxEgTXm4XlO2ACx6RXXC1Fv1ptH
	0HsHkaF/PoVnwrxeCP7gkAFOg/TBfIMWX2YwJFtOD5mClHD8bfGCtZvLlpBgZ1zNP13YTr8/a0b
	2HQy8FQaJ0i0n0CNKykAK9JB71jUJHM1TrkB/Mkaz4mRLgh4rlF+VdJnfrujjeNDYIUgJ4VKVhq
	hDPbOx+B2pq+kKSqxCv4fKHFT/K3G0dcFYri/XMDgOjb8CnJdtumN7Nka/0MY8im5OEyIKPAmzd
	R6Ucqo3aReAOEZ10D6PTOioj2/4iOZX52RiNZQMMFHxZEyTHzBWU2+BzK8i/3vm1i1clASWJC0J
	l0WFaW6Gw7EdWRCOFRWFGX7ZyO1pMEaxlcg/aBTIZQgZ0bczo35MC6Jcp0duZx32hUxJwK/5Tli
	+oMOHuvWWBy75nEoqUSBoP3m/9BFIgTB0IvMK2IuF0MSo2ldBdO0B9uI93Go1bpo2gvvPOGXHIp
	qfdUAv4xHWUWwE4O5ILd3zv3YSOOFAuKOObyJFMDvopLpjgubwwTm+m8xtGOCfYQCC0ZhSmdY/I
	vCL/COynqunfwjom+/VBiHhFQwhvtauLWnVZ1ILw8h/lldc2Mo2gHdBvbyXG2TmSnDP5PX1eSaQ
	UGUX+Qs5Gvrn/iTPrHUYfAH+J
X-Received: by 2002:a05:600c:c494:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49b91c486c3mr361162565e9.14.1788210829843;
        Mon, 31 Aug 2026 14:13:49 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:49 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:38 +0200
Subject: [PATCH v2 08/11] iio: temperature: tsys01: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-8-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=1038;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
 b=jW+8VHxUen/pme45o0CJauIjkEOZLcZ/pytVtjDREqo30I6sc8zb2/ZuQXdoD2Tak7ru0fGbI
 402OJX1QKRdAEee4RQGPryGtN3mniUeP2QHNECe7dmr2bHNH4lV3fTb
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO headers and vendor
specific header separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys01.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 28b3ce022ce7..14de67ee8be7 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,14 +8,16 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
 #include "../common/ms_sensors/ms_sensors_i2c.h"
 
 /* TSYS01 Commands */

-- 
2.55.0

