Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634661;
	b=nKxW5f229k1vS4mwezXEX4vNImit/9igAY/TQjcsy9fZ7a+8F9FlpbMFWNwWs07/jO+e
	 OgzBbR1BPxxVJPs3iCmWjtq3SWAT5hyiD4jjKvJQvUadT+yijtSWOSLZOV1q++iUsiCFO
	 qpmVyUOTZNXAZ8nGK27HvctmbpbYy081nEADqetOIqhR/+Mg0kpgnmUqwZAUL5q82Ib2R
	 Y1buE0tTJ5vJa0Uz+p4JEtL1SneFfkdKZtTv7Pl2IXFIMpkuy3COpZFSQ37o4sBk7vmAa
	 UFk/X9jDUCgFY3F4hkGT2rvyL+U0tcg2GKdqiAIeClu3jR8h8tu9F71EzOTdbFK6wNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634661;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rqM3UpYwhoXAYYZtwm88re0ZbCwIcE/3m37YDfuaNjE=;
	b=Egr3YUOvTBB4So4i6js+r2947qKW4p9u0Z7QbVIOjj5UnzkRST5RUPC8DEUMUiBqXg1e
	 4m1Mv//HVh6QAe3ch7egu3flyNSaLRz9i0wWnkmcHzUBu7h+XgcXYn76kmaIZfol0654Y
	 WaLcuNonqujv8AIGNSXlF6zKXpRvsdj2c0KZiDykxkG1svO11cPtOrJzgTcAPh2+3ASUT
	 d2tovRgdWYMISHNL3J5A0av6+LhlZFtfJrmfdLopxh2fzy13bEfXks7zSLjkbGlrgtpFD
	 J5MX1KqZU0tEzXj431MZ/c870A55ccGzIZC5iSrv1Ee14G9nd1s6sx1emUjvj8TmAQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBob6JWx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AE606A6A6;
	Wed, 25 Nov 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBob6JWx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B721F00ACF;
	Wed, 25 Nov 2026 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634661;
	bh=rqM3UpYwhoXAYYZtwm88re0ZbCwIcE/3m37YDfuaNjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZBob6JWx/yB0cEyo0fKukWgiL+BVmKy87asv8m33L9vazom7X7gusO5JEDOVS9FIf
	 hsnwPMCrdaD+A17JktRJPHLiFwte7cLoM6fStaYwoQ2vwSsd4NXMmdNQCDJo9yT96d
	 xYcMHi5lESl13wlG+szDvHA6DJT3x6JOq4xG2jHeRDLVjnMe+w1WmfuKW+yTnDdcJ8
	 0qBIbgLilDg4TY45kmVjXxZiDzZL17+FDgZ2amjLMY78/qx+XzgGvkmfHM554EWZe1
	 Ap/6wPWrIfPJtmQB8S8XDwoJ8nOcdFObt9ubnvlZhg6vZzfm22ju7W0jqDudomx5TB
	 tMYJNjxseactA==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:03 +0100
Subject: [PATCH 2/9] iio: gyro: adis16080: apply iwyu principle
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-gyro-kernel-header-removal-v1-2-969b3e668d35@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=998;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=bntR3udZtoPd61deipt2QE2GYRC5sfGPEIPTI5Fglek=;
 b=t2Pown9sPWjjpenacXqfWw1aeGC4TcmTHM3xuy0BVVRTmoQqjPANYbFfUcskZMYkyJeV1/WfV
 WcjPzmRaGvhAUqBfhsSXC8ygC+wocO43rx7t7T+HNXsgfXlWSjJwtGM
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adis16080.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index 27e6f28c69d5..39437244031a 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -4,14 +4,21 @@
  *
  * Copyright 2010 Analog Devices Inc.
  */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.56.0

