Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08686395DBE;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=bF3r9ZXgZMhCql6FsBknvIDPVmdz4SotxPaEMpGpKQix5Mkpe/ZJ5H6cTTTcGC7kvp1bJImBCpgXmwXRhc9a+7jxnMSBpzlTPqh4+D6DwP5XrkZccgkGKXYZlbusSw0I1ahMhG0as+YHWwzl8BNCgUWI5Y+V0g8oMEHpgsXNyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=XoUSz6+rVgZOj9EzZCIx9qvAwS9jQ+z9/pQSL9KW+tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTMhxxuba6++VoUGd/5pAmntKKIq+vEPH54rOMcAxBpXu28PnT4yqn8AKTKrf4IzLWz7EZlydHjgBZqhTKQLoMeYB01/F8sa5Ofkkb2B3GnHHAjQ1/THxnm/8HqmgQu8ABwmJdMkxpxVNDtFpnfqzjsE1Hu7GY543MublHxB5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIlCwusT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIlCwusT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9A52C2BCC7;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981561;
	bh=XoUSz6+rVgZOj9EzZCIx9qvAwS9jQ+z9/pQSL9KW+tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JIlCwusTE4h6VubI6/AAYGN0tirR81X9POT/w6NMgYrYXjVAZwqcTNw9Pn4yH2MdH
	 pWiyBGCHQ9wvzk65+gvYeUFE2zuqd/RkJ9SwWv62biQbaXJ5g9kyGONFFNhxLpvLM+
	 pIUcLUhY66eMpAmtOHQz9/r/IdNJX6daFmVz+Cmb45EqSBRxqdCPfV2xBBKGHR3nsQ
	 OGSI0QVgH0O7gXQgza/9UgYt1UYNFtoJnuDqGkMyItqTFo6oQgJL1lpwXbj/Ka+nxl
	 DkDN7lBJ5NGv3cFqI6GcnMP3hf7f4zkVNoly20UInfEzhXFZvW0XgtTMrZMkU+2XJP
	 rcb+cEZekAX/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E7FF885A;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:45:57 +0200
Subject: [PATCH v5 01/18] iio: magnetometer: ak8975: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-1-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1542;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ifC04FwraxdTSdGAo9jIXh6jMIMFxT5mVabPgLPFhPM=;
 b=JP0N5GLtTNzsJeZEjiK8ZoTjo6aSOZnFtmfohwVm/Y3hKL+nPqM/yyC9PsbhlFDAWz6dcVtYW
 GTFwNtlUOKbBhNfwz7rdhJ+ytWoFkrcuylZsEQxBiZgGBwJkdgLbiWf
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


