Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08730396590;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=s/oUDjEUGnhYIl1LP60f0ldVUALOJx9IQ5OzH9WGdpWHiqIJ25vXl8ouSKMVP2eCxMYkN6y8/JYYvXnrUgGVMzQ7w9rkKpx5qsu8gv7ar9Tl3aoedEgbMHC/zIyak+aNrsSGivQvvZcDyTTibG+7lbG8N9ZjEf0jcC/AVpwdxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=KTpXdGTT6B3eCbkI8WxFGVAXXF1bB/qEk4KzDV7o/5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWrOQvh0Gu2tqd0M+q3114pAd9g0O6GgERmtEO06+xXfdE0hfeoUl8IShe73GaWHFMXYbvctnV+CsKWNfOzOZQC9cO5JumbaKeoQRnzKr5YabPqz9XG1mG6uhZ29PBeNT5uNTFaE56dF+AF29LhwFrhfk9iiK1htnZ7TF9JZYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrKNz/dU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrKNz/dU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BABADC2BCC9;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981561;
	bh=KTpXdGTT6B3eCbkI8WxFGVAXXF1bB/qEk4KzDV7o/5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RrKNz/dUdKJNZedEaCkLBQfsemknoWd16QBD/Fywm4E7skpmAjbYpLs5K1izQGBbI
	 UdkAY1sK5Bs2tBcCeAm8O/ji49SNOqYp9F7WjhQaiJ0wNguWtaqQ2h7/bUZOb32Rbt
	 tHbndHoWuMMVsgsSbqtGY7qmB4eSPUjjyR411W1NbZ93w1l+7x/1yMRuPt6pDkJcXr
	 0oQvV40I8JhDZyKhknG4zVD3NomhbgMBw50wqB3GSGEyy6r3dAk0y+iYU7VGpp8Jgl
	 D6Cibok6OQdxZeRKXQTV4Rwi5ddGrW1Pn2mlMSyXNso+cZuuD0kDP29ojHetjSE2a0
	 f/BiwAfLzGhBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB176CD3436;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:45:58 +0200
Subject: [PATCH v5 02/18] iio: magnetometer: ak8975: update headers per
 IWYU principle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-2-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1704;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=0t8AkWNcobfyp296krmxpLOOL2U/ytoZq42+8WVejEI=;
 b=7iGbjPrCqbvNZrE9OPJp/OVmMtq+HP/+pouWpH5DELGeOnotFWy/DS01iiM+0okxDOX64xCw9
 IGZPpoa+ct2B6r6m9fJVaUpEb+y5Qb5Lph3PJ6YRpZqcseFaNWDUVLL
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
types.h, wait.h).

Audited using the include-what-you-use tool.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 569cd6fa839aec6ee8758a261d0e659fc20131c6..dac0a90c33eebd43f8aeed846c9cbf5fd1a6ab91 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,24 +7,29 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 

-- 
2.47.3


