Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA413FBEA5;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=W0W+S14bTRW8vHZOAxWbruk1uCJ/IWZon8izEWaUIHhCjtNWxUAjbfI6njlJj6nE8qeVqQzRogrRcktaL4Y69LwG2Lr+jRpvMt6dKg1eS0nqq3lf4NUAF92b8vmDX461d2EZnnMOPQ0IU+fu0hROwioMoNpwrpOpTJx8tkmSR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=lcv6z1ZAdYCF6mpSpS498JRZrHuLPx8kHVH8W6ltjks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZSvmm3cAnZmxCY3S286KRsrortVy83DZoK/AImCEnTovTrWJX6LwT7RfSNsTxXCRh+38/JSTVj+xAHQIn8F9KAphICyBqZip/vdBh3cEcHVfuT2bGu4ZhRI5E6T1ouxOJZSaVY/Rhzgh3vspU/ZAmYGlNcYqnhHSOod7FQW2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejSvqJz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejSvqJz8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3A44C2BCC9;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468057;
	bh=lcv6z1ZAdYCF6mpSpS498JRZrHuLPx8kHVH8W6ltjks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ejSvqJz8HCc6/w8K/2g1AX5r1YAhcup39HMvKln4Sgl9GRO9GtB9jDKg8lH6OcyVQ
	 6PSoBpBdKj8wtlnNoDNwCknOtLZYvfrdo/DyvQDSm/u6pivvnTb41YOOApQwSV/qry
	 w486OuprIdscsso3aCJk9i8YxQyg4A6oIc62gNzpQ75vyo0rClm42IKV9XoGWV456L
	 OUmxUL3oTRWgrswncZpl5ir/vAGmfGAVU5sbuGkaAXX9PCswM1Aew8U8kcdf9EeeRj
	 EgVkhLbsjfkhlTpsKbNMsgYabr4qZWPfwqfvk3gr+fa+fzZMQ+0CfPxM1JVMa+96Db
	 qDznVOP/mJrdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FFFF8867;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:36 +0100
Subject: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=2812;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=RoEVXdmkieaZi4J+cKaVs7klr+L+vuT7yR/Soth67CQ=;
 b=6u19Rb2FA8K8uhyW0pE98CrBrrMekTF6xQnsgtpv453n7vxdXU9glXr9dwE3BBxBZc5gVv3iB
 /Xo8aDZ8SWpD6NNHBZWvgBYMsMXFtqfDLEsuMp0lppOnTItWvko/EX9
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Apply IWYU principle, replacing unused/generic headers for
specific/missing headers. The resulting include directive lists are sorted
accordingly.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  9 +++++++--
 drivers/iio/dac/ad5686.c     | 13 ++++++-------
 drivers/iio/dac/ad5686.h     |  5 ++---
 drivers/iio/dac/ad5696-i2c.c | 10 +++++++---
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index df8619e0c092..cec784b617e6 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -8,11 +8,16 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
+#include <linux/array_size.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include <asm/byteorder.h>
+
+#include "ad5686.h"
+
 static int ad5686_spi_write(struct ad5686_state *st,
 			    u8 cmd, u8 addr, u16 val)
 {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index c607251b82a0..572dcc918ef2 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -5,17 +5,16 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/device.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #include "ad5686.h"
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 36e16c5c4581..d08160e7fad9 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -8,10 +8,9 @@
 #ifndef __DRIVERS_IIO_DAC_AD5686_H__
 #define __DRIVERS_IIO_DAC_AD5686_H__
 
-#include <linux/types.h>
-#include <linux/cache.h>
+#include <linux/bits.h>
 #include <linux/mutex.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d3b46496d67d..5b5b30f586c1 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -7,10 +7,14 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
-#include <linux/module.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <asm/byteorder.h>
+
+#include "ad5686.h"
 
 static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 {

-- 
2.43.0


