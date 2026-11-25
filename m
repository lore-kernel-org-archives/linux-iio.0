Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634659;
	b=hohWI3zXrdvecWn4nSFgISBKMjLwu3x6pDS91rTYvr6Dr80w7zq4F3eAz5G+VHV8z9U8
	 hinALPz/7SfU+ekAhVH5AmrPwbh8iClHqQ7ehybWJrQakrHYUj9VlqUwWbJjERlHkMXdc
	 nhzoduu4QWKuqaDXf/4t8jE/xxaxob1K4ayWFXSNmlfw/SPNETfjboNG51f2FTf0iWfU6
	 LsxVBGAplEKWWtzYBxDuPJ2m6dY/8/oI0kcXCox4sKcfaN8HeV0Y8Gr9MbONdY2YgbOIm
	 sJQix+hQ2bOAIJ7vT+3YF7s2jmp4haBD3pOY2VTQI9wpgqP420ZwhQ+UAZz61dpRLEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634659;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0aIOTQb3Onw/544ckbKdaHk/b/0QKKHLuIO5DLSUFu8=;
	b=ggHAsdKMFQrSAMMs5nPldwi77lOs2AC9gPLRRZSk/URW7sXc+ksJTA0C3VFYuCQnYDpJ
	 NkPEXVpWsAnORVsbm0MA/JE1iKkvvzc4bxCjFnM4iLuM1SeGYhRzHV8wQrzoNKu/+Iy2S
	 XgqUQmiOQJNInV3f2svlxUtYPi2hEkBxMf8+g6WRss9DNQ/Ot0Fvdq/1qFC3GwX1kYN/U
	 bqiVGDhebcg9BzjLiwcJG0AJJxKCL3FyvDMY8wKYM2H7Kbh7rZep363s0gtPGsl0jmwB9
	 iFOR6EEp01dvd5QxpvP9vD9id3EVd+QX+hjEv07Z5/asJfbQwbR3WSEeo9Rd9/IyuPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It7b6iQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08650606A6B9;
	Wed, 25 Nov 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It7b6iQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0CF1F000F4;
	Wed, 25 Nov 2026 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634658;
	bh=0aIOTQb3Onw/544ckbKdaHk/b/0QKKHLuIO5DLSUFu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=It7b6iQw+2d0ZfQdcX9dFFKGG+xO6I0qZgbfe9+yuLBVfaDJ1fj/i49aRndIMsrX+
	 uDuECMGkUxLmjsMZ+5kBcr9iRmGvmBBWRDHhGDNOeMYM2UFyBP4Zm0LQ/fpbpY9vmi
	 uIjdx0r+gLjYhQyLa2wx94pRv4auHz3PepH93GuW2IIrkuRRDJZZEfugmwo7g1eW3M
	 8aDOzlv+kJNwqC5krTX24QQMbok5LkolWKY/c4S5bsFVzaoJgZOk4E/1qQOGa1FIRw
	 kCQNxCXdaEBuUY6dT6FE/Vv+TXbSioKvJCByPBE5R6k2NKCE0vG27Ice5mlLGZ+2rP
	 Yt4AM2HHA8u9Q==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:02 +0100
Subject: [PATCH 1/9] iio: gyro: adis16080: reorder headers
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
Message-Id: <20261125-gyro-kernel-header-removal-v1-1-969b3e668d35@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=842;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=Nu5dbL4cUb2bY7ox/+xJzp2joGTi50w3TKdcq+ncV0A=;
 b=wquEn4yW9g0889FAfvFMOI6z2bDAel+fJOtIjmFHyTfSBn3l2XjDFryDC9k729R0gtYGTfeM0
 409vOd00kjbBXAXyRz5z/mJ6Nfv7LdQylmxi6RWaSSB9WwIVKIKbhW2
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically for better readability.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adis16080.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index 0c8bc1e569fe..27e6f28c69d5 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -5,13 +5,13 @@
  * Copyright 2010 Analog Devices Inc.
  */
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.56.0

