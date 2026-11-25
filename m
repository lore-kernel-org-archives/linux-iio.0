Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634664;
	b=tvI++S5x2ZZyQEkXt6LQ9U7lwWC05+TZSTTIDlVFpmEuS+WIfo0yfCvoZMrhE5VGkk9P
	 Hb8ANibdYf2U8z5d6PSdSyFTgCowIspAAeGrSC9jg3yRR302g1rv/SKsUMx20S9jlG/aj
	 Kui203Gz/JzuvhpRpw2oxrQln6eTr7+79oaQQcD+Wq0+4ea5W7/g5Op81QLP92tIHkJ8Q
	 GhnnlHnWaSNVXi48y+Fcfhe+6V5bzqZoYT4yW/e/YkXcNIkRzEmqXg5eqoFreKpKEq/UL
	 Ncjx/1c9aWzhN+HWDp3MMHzRujqxxUlozG+oxrhWtp+lGvmMwA3ua2GBR5vlIbsTxlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634664;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MODycNRnPQeXoolJNsq5rlwR3n93k/TMqPuz01JJ6+E=;
	b=eL1MjRSqDHyj179gubCt55HavIJ9qeBbrVCLBuK0zIgyebkChjQa5Htf/gTjW7CcPCXq
	 PUg9C4GQYjy6+tjVxuFL0JumU9sLm1qds2vNG/PD7D4Vbg/5NzebNJS60GewaIVN4HlKK
	 hWf8i8LNmBOITophDQl4Z2zu2jAtGNzbos5Wsq2rvB9e6tUcw79skmPTzLDRDEnp2ojSa
	 MNJTsU7xQhZ0y+GIxZnu6mBdKjddwVTlRMO2fLryrxWIqz22LGxjilDovaZkBPmw6Lney
	 vYCyinBCmFRvHE9Mg7qkLokmFIG6SfZeyxDLQ7YRgmyK4SqNPGWX5KAmAwUIrMtE6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoMJ9W6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5A606A6B4;
	Wed, 25 Nov 2026 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoMJ9W6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3701F01564;
	Wed, 25 Nov 2026 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634664;
	bh=MODycNRnPQeXoolJNsq5rlwR3n93k/TMqPuz01JJ6+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZoMJ9W6s7tw4IZz1VO+/7WxDdI9puRAzdg0QEcUdn8MneNkKpwokp/g3rVLZ8LJNt
	 M7DmOKsikW4RxFFeXq8sGS2Gs4tjTkIGE3BU3c5IhSFDT2lJK8+JHjy4wGJfID/Jql
	 p+QfNmGLefECMFAVUpa1KzydCqsNi2SqAUZfR0mxfQctLnvjZDRXR/frR1hpzeq9He
	 KSZKzxptwWB4h2rChrhwMccWvAtAjWp5dIpZMI31yMwBhAH1WmTV3r/jilNUg5NTsi
	 uXHYrBJq/SxIdQj5LcoX2eafoKqa3qZZFLxtpL7+nXQPv9vW/XPX4Xf401+gHn+8MP
	 aP90nKntEoY0Q==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:04 +0100
Subject: [PATCH 3/9] iio: gyro: adis16136: apply iwyu principle
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
Message-Id: <20261125-gyro-kernel-header-removal-v1-3-969b3e668d35@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=1104;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=vu387nxZY8KFOYCptWUxtaNNGv7UDpGV+XyNBS+g5Ms=;
 b=WYDHmjz5pbKMq6EeHl6tbqPbXLGkxcUOXYoBVYdnp6XVSJPodQQhH6ZRnNvi0erLzoc7/CWYd
 NT1+Tjp3aUDCnWWxeVGNOp610r7VIGgyufdo/GwGcMqmJWU9BNx1+Jb
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adis16136.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index b687588ada03..7981ad694c1a 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -6,17 +6,21 @@
  *   Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
 #include <linux/spi/spi.h>
+#include <linux/sprintf.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/imu/adis.h>
 
-#include <linux/debugfs.h>
 
 #define ADIS16136_REG_FLASH_CNT		0x00
 #define ADIS16136_REG_TEMP_OUT		0x02

-- 
2.56.0

