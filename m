Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A02C11DE;
	Thu, 30 Apr 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=OLxQ3x2eFKTAbmLt+V8H1jfPdEnMKRA5LrR1FmSCFr+KYfFnR6QIJcs2E2uu/yKQ/Lbpw8nxTG1qvPekSaWM1QjpqleuOIKGhoKdOEqP3Ma3qhoaRY0k6yJWmUVuvGP6LCQDFm9U6ufUUySAi9qOVeKs7s9D/w9K7WhpXH1bWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=fQlarxgXxDJC/844KAcpEmpUlzcx0f6w63+RHa2rEZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cnuz83kGKjR+LqRzxe/lbrN8u62DDIAA4C0CeorFxL/ybVONHjoiNnLJeelYEl6Y7Yj5v2Z4FXV1sJSGa4kOsJG2nyL2StBKt1v557VYJ96NrfIhEiT+mt/rSLd0v4vNfkecHLOtYVvFQi8+RaWUKh9jm8abeKrsDqgTgw+uk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWVOcguY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWVOcguY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A10ECC2BCFB;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=fQlarxgXxDJC/844KAcpEmpUlzcx0f6w63+RHa2rEZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mWVOcguYEIIgnIp4P2GjA68oBxb48Th0CgN3zS2NLRlGvf0WcenXpl4cy2/3iE/qO
	 Z0x+/d/z6OKnNuVe/ilKoRdF3WguPCmxDNYJEzghHo1d51GOYFAQPDHeYrnMYQzjPx
	 XCbv7sV4PKLJE2IQl1gtcFalVw4AD6Wbh5V7OifyPcV9vz6zEswH4UGYuNSaxBo0sy
	 MntG/LDotnt0ISVXsoh/seexa/wxcMOhUfSp+zymlWzi39x1INAM/exJUcKbbecuiR
	 r7Ia6H5Os1SRKSgqgvfFj13mkGDKEXkgg12djLzon+K3Whj5jSz7MK9MUflO0U/2Tg
	 3evVNzyPrY6sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B8CD13D3;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:25 +0200
Subject: [PATCH v4 5/8] iio: light: si1133: add missing include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-5-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=1199;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=62tqivdanwU9bEEYOUM+cBHwVivEihI2W+qJmLI5wfU=;
 b=sfYT1TwUhCwjnHHGpn/6qT2nVJ+rQlJIsU2HqlAf0ijPObiKk3/DqssZiKpW+d/UNrXGsMIf9
 6MBKNaKCgDtCx2uJP2MMCAvc1LPHCtKh+Diui8q9udaIuQvOKkGCVDB
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
index 9abc0a7e2ecf0d2fb1bd3af88eb675e9f1be4665..ab66a5a9ffb4a89bbba7474b6e984ddb61cfeebe 100644
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
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.47.3


