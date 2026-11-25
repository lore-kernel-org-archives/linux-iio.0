Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634679;
	b=jxFQcXD9YxU+8LbhRhF6KUjbGyWTNM8DE3AGBPXHzMNVe/FF6+8NvcMFVrMLCjGN3fzz
	 3RVetoRYsczkndpq/9E++p2ScOlm/KAcURCC+LC+pOQ6Lsh1EVn8UgkUNustQ/0Kajef+
	 PY8mVooWs01Gz7hkd9aN28/EEs+Bxol7wy7b0i0Yt3iWoOZZdg5MFJkNYasRQR6xJvXX4
	 mU6Kf66U1Tx16QbsIgTPWvEOBDz4j7DbH1BiSGeOESEhE5f294SRlUE5GXtAQk7NGVjAJ
	 jo2U5CpQ1aTSwoTO1K9IX+A/FbnJ5XFkxOHspV51nWF30vRQbrkCBruoyOkQfm4DwIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634679;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dgNjjYvDqYvY8ExzrL90MvY/X8NfHEOjTobRjASoM4s=;
	b=kmqhl63/Qx0jTLoR2ggGdW7mwRYWEsAmWnXlZ72MXWXhe/kgkWIYBrwkVid2g6CqAjBY
	 x7yF35P+aOZtzO2I3RvAIH4DFgy4HVd1F6QdPcwv5ng576KpwMnlZ2M43mo2SoS7Z6NI2
	 yorOdUoS3+Ky1tWhY/CYNB1p+R7UtiXT4566PI+ADf9VHFNzXXwW4w0wMQze7KtJICdfq
	 93SMSqorOG/jFXEKdNNB+NmwfLXp2V/rzwtmSD0BUAVuGx9PyYl+csuRzsOAFIG9oTXT0
	 xwDS6YY0VCFmlRm4CTxKT1ehnDXwab6FaNKes2f1Ro5NOCvBGIE8JneL4A+16D4AT/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4AQPUYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B679606A680;
	Wed, 25 Nov 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4AQPUYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5081F000E6;
	Wed, 25 Nov 2026 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634678;
	bh=dgNjjYvDqYvY8ExzrL90MvY/X8NfHEOjTobRjASoM4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V4AQPUYrtvpd2f5JJshGZHgXLfQ1lASReHcIQACJq+1nahY00afPUhmkZCN+vPLUu
	 A08ShkoRzHKY5zNWPXXO4YMnkmt6m0mvytnzLnV8X1bhGw23hJ90uDQHC37E593KTG
	 WdFTAgRoL6TjikJMweJXQ5xcoI0D2NCD2AtahrgcbNRnrnxn8KbP6/PCXaVeyNUb88
	 ZrG8tr/MxooYBSgwnrvAYbZObQLKKvxOGSHOnO/2U8cL21d5wKCH/Hzm3VHV3VhIB5
	 Ynw/1eqvqLJ5RkJnZBqA+YgnGCDmE1RSJF9vLsl8wIQIgYK6dE0yBLLP8P2vSWdMiz
	 inWyPqp5N99GQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:08 +0100
Subject: [PATCH 7/9] iio: gyro: adxrs450: sort headers
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
Message-Id: <20261125-gyro-kernel-header-removal-v1-7-969b3e668d35@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=1005;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=4/vm8dvjwXEGqzn4q3s6iYu9UnmbsFKXyyZnVWKPW/k=;
 b=8VvrC1faMCjrONtJPgHFYRIZQ8jQ/YBvLI+oRNl1m43tDRQ+Opwr14aE3QzdXSBcWqZWb9I77
 iquEXS4V6/rAV4UlU3zXHLlOzzE+4iFvcjAqjKWRQbAgwCjWWcrY3xB
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort headers alphabetically to improve code style.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adxrs450.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 030d042cab8b..be904d615f59 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -5,17 +5,17 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.56.0

