Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF2441049;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=F4ZmwK66krkJSV2W2EFxvc71MLSNA3dfLsli97vltWmoy2sfVLqE0pQM+RH1ZZvaRIxc6koGxspYNanKDsPhxdTsnw0KdK00FzEC8UQNJGOE3qgrNc6WYi5Ekm8pO00MqjdJ4lL6M1psLwiYPzvj45zEmguIqREKAQhSRnntLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=3INDDAAeuGZJjvJpNIHDcypkpPRwot8PZrzZ40usoqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwXPnF0xq+251ymRAIoccJUAXqPE5K0HKn74P69wzWtvPv22FLhZyL2yJhlT3WLUMmHAo8xAyzb0OSWj3IQnNryO63x3JW1ThqZk1C5MYS7vAlkTAEL/LJNyxXLWSL3kv8BtQCshIV6TSNyM68TsMixWA49tPDcMcvnVblgPNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ9KDjkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ9KDjkW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A2ABC2BCF5;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=3INDDAAeuGZJjvJpNIHDcypkpPRwot8PZrzZ40usoqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UJ9KDjkW/ZqyzuFBUHaHkqMECpXIuYwbzt/ZzTmgb/E+UBzFTbQO4oHCbN3iqVDEX
	 sGI7Xp1ecX2oRaK/gViHHawpIZXrMv3iVyzVnkllPQ12YTAXXWibcnjTLk7I2dM2fK
	 qaMM96p0VbO7N8xZQmeWeHLX+i3GaZqU8lHJKB0pvTaFbzmV31IHulj5oZ9L0Y4e6A
	 KWX4a/lbyJIT+TCVvR9LHX4bLADEwi9175ZctHAh25jxSIYA5yJ0YYgfHNP4cIlQ9B
	 wRDyt6y7DkI64Bi219mWzewZxs9w1dL8b4SlptLAUJ+kG/oQtmfWMx4Svf0ws2ZY2S
	 wE3MBCxJStt8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFEFF8868;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 28 Apr 2026 15:18:36 +0200
Subject: [PATCH v2 4/5] iio: light: si1133: group generic <linux/*> headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-si1133-checkup-v2-4-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
In-Reply-To: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=901;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Hvej5eqSWeD7xV4MQtx/PHfw5MbA/CGHl9BhtamspOQ=;
 b=Jq6Mm6BMuxPeRSM/zgyQQlhBls3VQKeMNzAmuCPCkeqSIrBztw1/V0FZ5zaPc4Un2nzcNBwSP
 S5pD6WHm1qSAwPpXC38Plocga5bLjyIq36kw6o7eBLVti2OJCrAQw1m
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Group generic <linux/*> include headers to improve code style.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 5c5c5ae0535a9592522c0b21496f47068044c6ff..f2a79675c026c86bb56d85a65cd035d7540d0ef8 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -21,14 +21,12 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/util_macros.h>
-
-#include <linux/unaligned.h>
-
 #define SI1133_REG_PART_ID		0x00
 #define SI1133_REG_REV_ID		0x01
 #define SI1133_REG_MFR_ID		0x02

-- 
2.47.3


