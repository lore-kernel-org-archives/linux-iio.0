Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34B38837D;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=aTsHranJa6YlPZczlKOEgYbnB7wbvaZE3gAXC3iSmILqzpoYaYBRIOKYh2JCoCWP1vYjbEDLPnmd77Xngnxl/BC3FXl751LsKdyG93fTjF58S+LExK3pCEUPDDBZ4vCLRIusg5+Vr14rLKUMbIuioXeaJSYe+yiEj77TWEwkZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=XoUSz6+rVgZOj9EzZCIx9qvAwS9jQ+z9/pQSL9KW+tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sS9KeGsT/MJ8VdfUzq0Za+Kc1y3dQMuRBBUj15BRK1flua9T3d5dAZ6HFCEpmQBqIj8+ETbljUH7d8oG7FUKs3pyTnNUJASGxFURNmoZIHNiiZZ9OcQcDlm3IjO8ok+wXv8Ace/pRM+qLnHjCUTopR9n4UBkOGtKyUWRIo1uqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F98sn9F/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F98sn9F/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7998C2BCF4;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888114;
	bh=XoUSz6+rVgZOj9EzZCIx9qvAwS9jQ+z9/pQSL9KW+tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F98sn9F/e40jd7PLIQotzh1xCFA/URQtWldtrnwuJqlH5TH6s3mizZoocz9U9araK
	 S7kjOOMgLNQCAosyjgZQYSSLe//UF/qzY+iBD5FvSrKVXyNCRDF6YLKAlSlvVoc331
	 kP787VP1hZ1Xg9NZZZLMLmdegM7wQoorslBELPnUXZGZpPzzgb3g+KIOrUJbwbRNI6
	 +eFycd9CQoi7SOGd9k2MoC2ybr/PxMn9eu8dui/9qQxKST7rL6uEw331GZa1kJjYN4
	 4eFDZSrMudBGvyzPVSalm95qouKXgK5r7Votpbt6aEN9Z9Q9XPtoJB96sQUih2XPtu
	 Au8SidyBnxuVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94634CD3426;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:13 +0200
Subject: [PATCH v4 01/17] iio: magnetometer: ak8975: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-1-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=1542;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ifC04FwraxdTSdGAo9jIXh6jMIMFxT5mVabPgLPFhPM=;
 b=xhlO6XkIxZ/bzflz1hACjL7XpQ2K8fERgG8KpqGqiHDTpXsU0FiKbfOP1bklHbgiwRj5ZZDBx
 Ry3VMKRsy2uCogCY/lP1VCHaEtpHPze2IGyRd291m1gRQPhk4W4b10E
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Sort include headers alphabetically to improve coding style and
readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698bcac5ebfc62ce3740f361078fd0ce..569cd6fa839aec6ee8758a261d0e659fc20131c6 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,23 +7,23 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>

-- 
2.47.3


