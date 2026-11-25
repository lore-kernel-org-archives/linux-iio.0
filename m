Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634681;
	b=H2HN2H2lU9iCBcAtKVrzTM/mlm9LHEpNnW0Qd+/hlgNl/YvwiGtVdIGJ59LiXbnmG689
	 ypGJtdGUv+RgCrGVDhtFk0xQYko0uL0UtxD3hlbqRhozxHGFMB/Az/pxKQ/eB5jQYG20l
	 hj4zETv51cCehlRXncSot+kNYooHd4ItJFXHvcg2f34Pdt9ZdHyRTvKcNtlw1KRh/e9Jt
	 byWB5yK0usBqdA3ShoIkU70OOFpmOx1Yq3e6Y4Gk7GsjGT0m2PCvPo4YkZ7aO+hPXCt2F
	 QrO+EB6NnsMxGz/nFleT55Nb8PWLVutgqK2qvSOmiH6s8BSJG4seh8fz5oFC+5HKV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634681;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RzI9Ph5V6odgLaL7x3dEHHnJdQ2l9ORyQljCjrUhPaA=;
	b=ukF1RtdCW+Y5WnbSOaVDbDmi1pS4nS9gaBvzDbe5ck2lvUb8Sw2QQHdlbU3AhcQbwZS+
	 xfGOML4kYwLyLD6oeBlyBS5gC4WIPU6C0Tr4hSCH+8Bye6bXhSugPoQ6LMChwDUnn7FOj
	 ijwryTO9eY5CLfP9D0ireub3mDkFCvQziXHgeZ4mTqQKumRsjlKlAVDFF8HflqqkwBOi0
	 cFCCoqTO7814TO/Mc0t8AsdPKGBNVjvbUvI59ihhHivcl1DxQAPu0NiIgQQDN+cJ/XZfY
	 SIKkEoqnsMYmj0RoRviBzmjd1SpPE03hm6l2i1ZZ1XdIpgOEV6hUKZsPA9mDsFESpKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYdruuq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781360A2629;
	Wed, 25 Nov 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYdruuq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF461F000CF;
	Wed, 25 Nov 2026 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634681;
	bh=RzI9Ph5V6odgLaL7x3dEHHnJdQ2l9ORyQljCjrUhPaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SYdruuq8+jBk4F7DCaoY9Rcq44Z4XbBU6YSMMvOm3TrAV8/ZHQ85M5j0dkXDOnnX4
	 OMspTU4bUCNfJXiXv3/6b7qehZs8vrP+gZjgjfftHi3YXeMcVnOVqmyeI8F2boBqb6
	 IaoiFRd9jIQmDL94cLhr6X+7mTCVvReWm0z9xn2TqT10Wtgzzw341kJdoXcHu4XGx2
	 gsYURixXqeMYO3mY/dg/CckMsZNNSMiR7TdJ8yLaZegzi7ZCXj2OdpKaOYGVYSqz6Y
	 1O/Pe4XyodbntZtJcniRX3Llt6ardy0GkwziMorOzToaximkO8zYWv7QpSw6vgmprN
	 dfEadWt9ADOSw==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:09 +0100
Subject: [PATCH 8/9] iio: gyro: adxrs450: apply iwyu principle
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
Message-Id: <20261125-gyro-kernel-header-removal-v1-8-969b3e668d35@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=1042;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=C/X6YZNSeRoNCDYidvLnshDd/2XYWwHSjOLUCNy4KBY=;
 b=rcjsxAV8hizWYys0BEIaASAybDqscA8BkyJyh1UkCrDzJFJZCaHJ7rUX5Vq/tiEStQT3kg66V
 E32blsoxkxSCqs4tqaQiOUntcV1362v53pxmtgfirXX807zfLla6opG
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adxrs450.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index be904d615f59..b46722ff39fe 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -5,17 +5,22 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
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

