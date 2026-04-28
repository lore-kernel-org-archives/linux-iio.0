Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF8441048;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=AK183YqgaTTNYuCyWfvNN7+thxf1bSRDGuRMVdQPgRa5rhLawQORLGBDEvQ4yMyFu1sdSGQ8UxunT449USLOvInHC6jqJlCEmGniVEq7VYoPMAAysi6nnFymrUTmHlUSNL9STpNzeuqsHlcRLRT344xWPoP/IqHzcnGIi2XYZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=Tf9Usd+TGMS4cV9YIAlaKhgJyO0gaGlhJv+u37S2NUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peBM7Nz2Qh6bOuxk/8xYU579XeTCBJZSsrDklq+mPCOAAI2r26kONyJnP3s11vCJXQh9Skigdu4ErZjNqIeV1slAG1giXYHCaBmtbqyt8zVIuvh/ar8hfnpy4u2WuIjzFL0mUlg4Rm1GQMb2SxkUfAtX/BJXY3jS84xGuGjaJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv3p3b26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv3p3b26"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC2BC2BCC6;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=Tf9Usd+TGMS4cV9YIAlaKhgJyO0gaGlhJv+u37S2NUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qv3p3b26huoDSaatCt2kZVFBUxVlA4zdMezYX8Q0jqXkY/Vpvf7nInOhEgXrElJNQ
	 /9grhgqdVKfvi//nTlj2zw2hEc3eIbuGK9YnvqtCSnjzlg4TGcSR5wboW553CRIHee
	 cBQp2O6yq5Rt9c031skAqReRN2KqRDFJC2FU4dzj4TTT174y9dqHxd+1kcAp217rTv
	 LlORpU7weFJrsWdVdlz7sJd3oYyuhJTyp0FfSHqnS/djrgpDcZfJGwu0GkExWELqxS
	 W5+p247DneHCP1XoJD3AQLz/TQOxuuuwCA/qkUNxc1tJNepyR/0xcgnklMlCIEk7zb
	 tuiCgZhDMpPKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF8FF886D;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 28 Apr 2026 15:18:35 +0200
Subject: [PATCH v2 3/5] iio: light: si1133: add missing include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-si1133-checkup-v2-3-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
In-Reply-To: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=1193;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=MpzT4gTigdm0pGKTWDLW4wW/fRg5QLjpB5QmAWAztOo=;
 b=UcUtVPhbosFV6g0gpCRCpa5IQsYlORL0hsqkOwRjauhr1Obz60kEiTFmKFH7l0v5uB4cG5a7O
 KXtJ+zbUH6xAxNRaO/3lJAvHBgUUT3RgFzevXu7xZfimOYi9uAjdGat
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
index ada8da122b76c9a0a55751baa6522a145f0fc7e8..5c5c5ae0535a9592522c0b21496f47068044c6ff 100644
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


