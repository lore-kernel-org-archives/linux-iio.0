Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D15908C0
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888301; cv=none; b=joOr04LO2yuIFspOoQeX705UpZSBPZ5+u4nquj6/Qt9M5f6jDFgrIb61helbxxqESwsSNEEdoSdDdcfLTCVYXxQ4AZVBKaPB5P1auI44B8FyKc+dSXkLazlRmpkkBrQWRVZ2HGjLV1qDD1ckgIcgijytMwYGRytclllM4uNGSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888301; c=relaxed/simple;
	bh=HGcGydyDeZTeqtOr6+V26MAEuex+3SFEV+2bHwgn6gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prOkoepmMfShl9/8Lx/I6OM5tePxlR5iTa3y60S7+3q5elgXRJ1XyIyxlyo+A3l1rqEeR9iexM0BJxqJGMqpWNY1J1tFejqBF7NqOHljfzTZR2eayslcXmz36toWJXJ5x4P73fIm9J2q+jtmCfO/Mz+MJbgkShWS9CSP0GQMsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHKDcZTY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHKDcZTY"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso181431a91.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888300; x=1789493100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8FraEq/yUb0r8EupXB8EQKm5xu56D8kJQlL77fVqVg=;
        b=lHKDcZTY75XgjqwrBA7iYcT6wCkkjfOsiVvsrHGjG59qAKE8vuh7DGwhxh8/YcUhYU
         6C9xwfdFUpM1Evwgy164d5QWO06/srMEgN4pp8eI0bSam7+FYjh+wolP/iE2Dzk3Bsd3
         iVmh3vWK6FjNcYqAcjtL7iLxPtOwAQMB/19M5xe3ZhMcsou3/SEqKhmSAFZPBqtrsbgV
         OmpYzOykbi1Bu8ubjsIKNrVnTHDng6CJ7Bmj4yuHm2YPMTzhPvduk1gdVmFrn8E0uRCg
         FJQUMcCCxjK7q/BPer3Y2dmPAKmah9r+QnIz+2dSJaNTg7PhkKvL1yUIvP8bNYPYS9P8
         SrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888300; x=1789493100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8FraEq/yUb0r8EupXB8EQKm5xu56D8kJQlL77fVqVg=;
        b=Q8B3yPzfqTCKyD+wg4x7WGA+5wa5W9NsBEOyl1OYZU+BQUTH7h8Wdh2+ndI1G/+Brv
         BjKgWXh3vKc2Anl275+e2RrHRscvISikZmAfMcXrG8Pjz7WGD1oh4gCx+BQ67hGs8tt2
         GGG3RNttrjryIqUfBBgkvspQz+L5ToXu+HHxMII/ayn7Wz0zrMQv9+GrPIj4dIQF1W2U
         Js8prJd6L/ruhWmgAMHTaOWXZBMBFAM5dvqXup+BIBKouOHHRz2IrIQBn7LTaHilm00k
         LYv+I0cvo9oSm5yDRykEsmRR0Ues5ABrBPrtYdYbq175xFEzdUESYQ5bGZHngHKhliGX
         43uQ==
X-Forwarded-Encrypted: i=1; AKwUvBz37uLZrWG5Fq2SU6vzswaQQmm7inXfP+/PtkOPFeLshTbzb045qSY3qKZmSKs/5cZ9IuyO9iiVQlc=@vger.kernel.org
X-Gm-Message-State: AFuF++mVFrtRK28oxFnLXsxDVB1WcRZi7f5v1Wp3t6REoXd5tssZNehT
	iSW0Z2UJ14VPzoLwgv6SRrSZxGsnnEbnBvxmN3GFsEL3jMTUcK3HezMm
X-Gm-Gg: AYBFou0AWsFCwaNkMf5Gr22EsqPF1kIkyS9KWawqBjqgCs/QhuJplXzEfC2i3grz4ka
	ZaZaDVV14LXj6MsmdO+yXtJH+1Np4p+s3DVmIkUWkhv76vlvoymtpGVXdYZ+M7jK5lUUh3En7UR
	c6j3JSAzp0297rfrDK0t+LniS/Dmr5+8SZG9FQKgBhbMN8Xrwc0l2GQw1woXf5RIRGVTHQytyTN
	9sVdWVWY37hsZOoIEE87F3omcU8bjM85movbLEXofBDwbCpBhHp6hCVjrH4GpawbLpvFdz7Ylo1
	H+/9NBLNb/MBf9/cN06MDye3/YZ3HtOJjyKRaPuKZdhyQjUpCAxoDrKo+anibnvoXXuBPZEZr1K
	DHtMoL4pnsdyFIg2lfwycgh7X1JB+WL8rHmBUi5tqmUlBOlExTPCQTqpFEwUFmYSbVslmKt+qS9
	tzRR6tJpWyrKtZalNfG/Bt0svW9Cv0npj5LsWwv9o4YPrTmO2/MtDvpzhW54o=
X-Received: by 2002:a17:90b:270b:b0:398:c9be:cca8 with SMTP id 98e67ed59e1d1-39bac13b38dmr1363341a91.2.1788888299767;
        Tue, 08 Sep 2026 10:24:59 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:24:59 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 2/6] iio: adc: bcm_iproc_adc: fix include dependencies
Date: Tue,  8 Sep 2026 22:53:55 +0530
Message-ID: <20260908172359.30003-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
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
 drivers/iio/adc/bcm_iproc_adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index e46e3761993a..21bd51da9cd6 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -3,14 +3,18 @@
  * Copyright 2016 Broadcom
  */
 
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

