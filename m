Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447C374E76;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=r7Dqcat2yrpc1xLWfzSVUZnx4Q9ZDfg+dI86vbWsPEBUYKbQha6V15B9oTdTuA2r3Hy4+Tmu/njaZZ6AUQLyTGjhzyWekeN6EVQVUWyCAPwMGOJPY6MqonbXvL58biaizBSs4lZQGvTTN3uOpaMVfSd6NawiroUnI0JsWASiPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=sguCKgxNu8HtHe6LCiRY2bkftduteXjABj29u6GhgFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkUQTi7HGAtzf8YMnCO3H9Tg+4CZa2xjJJBJ9H6dTo69cV2PFtly+lRIa2jDhJcpa9F6HacEBuCi6Z2yMjivD714/xnj6ui2aREeoJbldBPJW3hT1VrqDUd/IVuN9iIWYVYi6wRft8WNS3ENPKloifBTFoyVws1nVM+FuYtRNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQd3Ozej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQd3Ozej"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FE9DC2BCC9;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=sguCKgxNu8HtHe6LCiRY2bkftduteXjABj29u6GhgFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IQd3Ozeje+yWTdyKzH7iowUn59u2s/e2pQNixWidueZVePNpwJ6a/rhiokhL7rzc7
	 rFYl+sxsSakDkrRii/czf3iKq/dZ97CgK5mXbSl7C9QjchLt51aio7fE3pgMy2hY9m
	 Ys/5cMSiTlrFhMRbuM9ixM4nuSZEGqednDBhxJJXQVyFl/pyXYutVgisE+ESyQwRsl
	 hBiXHLkz0Md7fXZDloLum79GG/r7nr5hM/NSnCMrkEvOwm4BOS/gLsgyCSWpwJK3g+
	 yKTXlmYqQ2rKhAPUbhWrYbTbHzBKQNpkpqPlNEuJe6XXfLNfldkj0tWL9nAQBXFbMq
	 gm9sfjM1B+u7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D84FF887E;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:51 +0200
Subject: [PATCH v3 3/8] iio: light: si1133: add missing include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-3-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=1193;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=OWle6DMZJq2w2RARzbyed/7OgweWtx5OkO036pgenT0=;
 b=1nk+G3fThs90hmUvMW0haSI5r1UjL8V18mpb30LWGYtqSMrSBuIQKRzJfKBP2vCidOmOYBnSu
 H+ZLOm564PGD3dIyMdrQI63Sv+ecomBQyKV5ul0qjg94HJP9M3xIhPf
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add missing include headers to prevent compilation relying on transient
dependencies (array_size.h, bitops.h, completion.h, dev_printk.h, err.h,
irqreturn.h, jiffies.h, math.h, mutex.h, types.h).

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 136436c0379aa732a2c93d40b08734ae4fc2a45f..dabb1aae05535313e77441b7d066bce931de79f9 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -6,11 +6,21 @@
  * Copyright 2018 Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
  */
 
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.47.3


