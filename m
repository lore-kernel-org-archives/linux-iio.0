Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03E40D56B;
	Wed, 24 Jun 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318088; cv=none; b=DfOkYWWWoZwoW/UXcQwoJYGDMVodOWbB2w2gGrS+uUIHyQ7j1g/IbVP3SNqjF9TyJ4d8vqLsYDa6ECkx70kOtZRnVN52/PywXue58jW1ZLsoPffpAi0DMGPalg+5vc8QLb18Yyw+Ku+TOv7bj0h+DDJOaRS5OKl/s/F/Qyvr2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318088; c=relaxed/simple;
	bh=4+aB0zt392xoae8OjYLBjO2crQ71y2MxyrXn2cyussU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RB+Yk/seS0u7EsCeOy2LEtmor0ptrhKWTlYHCsFasDR9h4iJ6QjjuK5poTblZ0leyj0KxP2vKaYII00+IfytQU3/7nfjlMObi5Mz99u7uHbS5vy24nMcCXPfQKsc0eJxcJEAvRq1d7Gt5evbkgJrBbfrjNUpAUqM9+kUbsHbPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9BjNI2w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9BjNI2w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0630C2BCB4;
	Wed, 24 Jun 2026 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782318088;
	bh=4+aB0zt392xoae8OjYLBjO2crQ71y2MxyrXn2cyussU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e9BjNI2wcaSekGBoUErOQcy86S+TlxhHq3GZ6DygCzMFoHHt/35zcgdKPsWo4zzA2
	 ZC1xTPo53WADQC08z2flYsH+wulzzzvPgPLFPrPWgAMVR7fW/FOSEcJfrEgUqDVbXv
	 g5h+M+44fHjgrNH1AXTPfr0yD4FQhJf71tWTIYrQrpwRZOW6VmAzfLQnQgPuh/y3Wi
	 2F7nB7gfU8lWwZKHRj+LS+aJgo9lBK22h0rfiFD5+8QXua9gtk8hUT9Q3pI0MZHiwD
	 Y5UcBQnp4gLTYJyDolxIe0mmCI3JVr8e1/XEkXUfuBqtbs/Ym7A6YA58xgU0xYCnz5
	 QYJqlEEmW+uOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9602CDB479;
	Wed, 24 Jun 2026 16:21:27 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Wed, 24 Jun 2026 18:21:18 +0200
Subject: [PATCH v3 1/2] iio: imu: inv_icm42600: reorder includes for buffer
 module
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-1-5d9a4c662f50@tdk.com>
References: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
In-Reply-To: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782318086; l=1087;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=/o86TiMkszwM4dpf3wC3v+DIzyJYtoJPgWoTuGRl3jI=;
 b=FcYk9ni7DTyb0ss0gRnbqPeVl6irSAV+InRO7BAdqYnxVpoBfMiv8qvLtFUxQtsPJ7mVxCR3C
 nfp2xUgrMsFBFo9coMfIdrenLMm2lR/jMIPljdcmpHIo60tifmOK3X6
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Reorder includes following rules and delete unneeded kernel.h.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 68a395758031..8ad6374409a9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -3,18 +3,18 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/delay.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
 

-- 
2.54.0


