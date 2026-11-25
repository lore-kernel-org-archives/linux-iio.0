Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634675;
	b=Bi2QHxn3OXggzMkaa3SrbDwRpgZvCmJWtUtZ3zSmcgCyhwwl5+ScA1E5t0Ykv933fa1i
	 VUSZcq1pV7rBW69hd0SMFGXbZJH4fm228fNh6kTsUrdgKbFmP5XnhK7Bz8r3EFdMAKhwD
	 AuqC9kdK6zJ2dDA5hNEy9w37GzPbjlNOu7Y7BchOmW6VvT3L6fWxyAGH65ClDVWJQ9hLO
	 uMcVjTf1nlsI6GbNoMlRrVPaxP60bgtJ1mMpUO9n0NJBafvvctOBK0005/d8FUqNp3d8e
	 0XReej+zsSe4IVSOlT8gM0646RzO/6i66kF2kRwAVU5QngDK/VmiGPEsWWspKnQp+jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634675;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=a7QdtK42UYg77qJRm7vjKWsUVqN0sORpIJ9CtRWjQPc=;
	b=sFUCu0WUJ7/YomO6gTeM2fAijgkLb6VcXbCiXmxb7ayXq5kXMF6xQseU56ZwOKHQnLUD
	 Gd9c8QbmKjTesjiOcJCqLAKOwjaAiz7Rjzv1mAEWLTNtnyw34+BL5cddGru9YvlGNuERG
	 dq+l8cwzuRUGoHwbzITtLMpUdzMsU4Rj9bpGwGdFp/oUxauAydlY7SpOoCiiTo8s+t7s3
	 HuP2DxVb8kDKEWxn2UilhqhqoFfRTHPB8XkLyojdXhG88PqzZw/yQhdBjIdyzTpkKGR3A
	 PUPNT7I/zbqwiltsXXT95lN/BhuYR3UR3mqIAjavgyovVcNlHUUZtyQGRVsGJOlHCFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNJTCIZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36B606A6AD;
	Wed, 25 Nov 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNJTCIZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089EB1F000D8;
	Wed, 25 Nov 2026 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634675;
	bh=a7QdtK42UYg77qJRm7vjKWsUVqN0sORpIJ9CtRWjQPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RNJTCIZq43gsXLUJrZ4vboVY7fB4EMfAb+M3fsZwbfAS9e5gjtttsMPbcAE/EqjQM
	 RxmfzW3TfNqvS3js1A4LLBoIy1AggkEMRWdoMAGzX/sOs+eW5T8oxfjZqU4433vYP6
	 hLKwSKP1yLS+a1qmNpFgzVKbfx1NgdpzWFZgME/UlQz5ra2l3xXHa/+f1NNpFsg1yL
	 VTQEF1jKAqducz5SpS3xpVoV1GnYY808DW7dSsmdZylbeauE1iCuFjn6amglrUfxzo
	 ctHUhSH5gZXz4FYAp25GYrM7Duyyb0PEx7MPLHcTU7om2ebaiQLLvqKRaiQB7v1Wsd
	 3jPQpnwXJdCDQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:07 +0100
Subject: [PATCH 6/9] iio: gyro: adxrs290: apply iwyu principle
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
Message-Id: <20261125-gyro-kernel-header-removal-v1-6-969b3e668d35@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=938;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=WCvbrsjsDDs3NSUEUIi2Gy12kttTX8vAYizrcsE6hnU=;
 b=3G8n93DJ2xxfMhegvPx9eoupUgIncJKEZGTAD/ALfj9V/zRwqBa88UQhJ91FdorRF8dk5MQ7L
 RWe0iX2Zs97CiJOYb8G3OIJmh006uXG3nsyy4iTlnChEPQRureMgqOa
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adxrs290.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index b61cc81122a6..581de4c68396 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -6,14 +6,17 @@
  * Copyright (C) 2020 Analog Devices, Inc.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>

-- 
2.56.0

