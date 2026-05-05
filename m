Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFF3DFC89;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=ByoqVpnzvqrst7NIyEIiJVhCEk11v6I7Zha0E/uSLk/W7ZsULAWRRXGHNdaUkyIxXoTbt0SvTmBiicTORkAl94NerdBfY90TCqrnCD36WHWIFtVf4512kvSwJJ0p9Bab00y1KxCUndehzBzMBt+4mGgJMPbNphdZNKvEid443J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=XWni74MDyFatFGyUOYnaQ09SDXms4jLkldIN5i8sZ+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1ZbyvS7opiHREo20eZgBOQUOq80Evb2bHSKZA3uWJ0BaKcYa7fjgr4UqSi6PC2pRQFiFN4iN//eMtRUOV/+EFtmdfMSHRfC9om34XMdWeXreCj3jK/z9oEbqkK6v0Qtuao7fZTaCC50EXfnfwQ5Jb6rucNTi+ab+j2hq5GE7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3z7njpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3z7njpV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 955A7C2BCF6;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=XWni74MDyFatFGyUOYnaQ09SDXms4jLkldIN5i8sZ+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q3z7njpV2s4ytYWAWAhaNKuviAsmofmBWUieLHSs+/EB91RPHYdGUrs7pr9rSL0ey
	 B6pkr4pYUaWh/eIGhtpLxI0kX+RT/cSALmSagPo3WhA2NODqIGgMk/OuMyF0S8errL
	 kw1at5+Sli94BALNB4N1w50uI/YA3550NuNXeTMlCo3Ou8l6YbGerI6Xjgh+uKFp1u
	 gmkFTeCd3cVZOj4LE0KwvQkG2J4TWoA1phzrN2FugpvYSl2Uw27snMM/12ptW1yQMy
	 z5aHqkvGOjLINBVuUn3nNUFfOVQNWG4KpWtlssLEi+cw0c8WkIu7F08RBBjo0D7hAr
	 lFfkcFQyEbz6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB8CD342F;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:30 +0200
Subject: [PATCH v5 5/8] iio: light: si1133: add missing include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-5-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=1271;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=CeOtWRyLAnt/yeaI6Z3dA80zv4Xs6KXVN4dHxPRCD+A=;
 b=N2nRz16e3NubkB15kCZ6CGC7VeBjMl4UvP/DPKrVN7D3tmRlHNMQlSQLgDeFaXNG4b5Wehg4t
 i+4VrZ0aCJuDM8j3n8wOJf8kqt2mRaQFqy6peg775yMvk2AIkx8nGDF
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add missing include headers to prevent compilation relying on transient
dependencies (array_size.h, bitops.h, completion.h, dev_printk.h, err.h,
jiffies.h, math.h, mod_devicetable.h, mutex.h, types.h).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


