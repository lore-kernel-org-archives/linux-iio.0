Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DE28504D;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=fdFqwCLD/MmOnI26p4kC7SnjF/UBSiOdeAwM8/Y9pTGAIhSXRt6y0fUZ41gann7dDcJAFHxLMffcGZCS3Y9b9Hlbe5115B0pnNEYEh2hqtRoLjaw3sFbJTwzxnCPO5jVlgPPo1v19d6/pc4T9lE/vOPu6OMYK8dNath2iIDNO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=tlItUifFWfsj0zDd20KYALisIhu+0W+XIM1LsxMLKfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFSYP7KCnumPDalHHPNzP3CDbEYwkieI2yKRRgo5fW6dxqINv+7Ew9q2SP5EWRu2SfxipO7erGfpMokC7/nLTXoqOxu6mwyuJB1N9d3gOcSownG06e8lz+z3sYqw6qf6waKXlUf0RjqRe/F2+G3Vn4JNo3XbwKNIKTtLOTWN6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEXNU4dG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEXNU4dG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62FBC2BCF5;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=tlItUifFWfsj0zDd20KYALisIhu+0W+XIM1LsxMLKfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LEXNU4dGU8orJWdBdghuGB++EvPUVuZulxNN+rVWv1wcEv1mdCh02zNWJ8vYE8+AZ
	 NOqcLhGcJHsm3/+ts7eekiKElTjKycgkkNu5Nkje7vdKxQXXId33dVMGJY5lIRTf3q
	 sxFxjME58xMfsagaih9yFLLpLFovNPC5Hbx1F86NwxGABAFWg3IKlxgE0WeGUHRmzJ
	 4m3/1ClyzC6t64NGDTn/lxgVMpmUdGZN0htEaezF1cFIjgHG6uCEXGvMD3aG3AmoI+
	 /Z/pL5at27r3bTLG3C+AVmxj6kxPZV+GW8r9QxRQtfw2o8yBZzhlSaq2DE8ChvXHJE
	 McsPLSNGcB86w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6194CD4851;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:22 +0200
Subject: [PATCH v2 02/10] iio: light: opt3001: make headers conform to iwyu
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-2-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=1404;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ijeiUs5HBQdNjkWh4WwS9ZTfUT28aBbKAdKEloUkhy8=;
 b=lakw/ozJZMdiTR1Qbov+ph0nozd1LImRurYgk4l4JQN0i5KH1A/gVh40gXV4RjTVX8FkLegEN
 I+rmj16iR5pDTuMdTK086ctOFE5KBYjY94rQd2UjRB5jWm7og3Uh/l2
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove kernel.h proxy header, device.h, irq.h, slab.h as they are
unnecessary and add missing headers (array_size.h, dev_printk.h,
errno.h, jiffies.h, wait.h) to enforce IWYU principle and reduce
transitive dependencies. Also, replace bitops.h with bits.h as only
the BIT() macro is used.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 3c79e0c4ca32fedf33e318d047d6ab3f62b6c03b..7efd92875c3f8c86b00a8aff8fab664457399983 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -8,18 +8,19 @@
  * Based on previous work from: Felipe Balbi <balbi@ti.com>
  */
 
-#include <linux/bitops.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
-#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>

-- 
2.47.3


