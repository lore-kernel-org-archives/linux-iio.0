Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9A3BED69;
	Mon, 11 May 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493849; cv=none; b=ulPJu2Heu5iCQUFAehJxQUkH3ky0K++/X+W5BwH2vnVKc4nP+SZT3RgV+siHS+wmMYXB1ad9l2fJMODgxmobtLnFGrYLyCR347Y9R1qdOki9oAWiqqikJDQawP1WPax46bUj5I9FHQCtEVg6hgA+SXHYkXMlAK0cDuOpI+vwA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493849; c=relaxed/simple;
	bh=MFHojmFQf9VayktGRWT7VpOQGCXGKQOTcmOc4TyTDOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrqN+d1yVgsVoYn1vG9LY+zkLwO1gBg4831UUD2nS8GBk7LFxKxFL7ib3jMcVJP8+X7EgInFLTq36Y+zSh2b+UWij/eupLSHIRJUNeHqJFz6Urcvykt1NHZTBohmCC82QnC8UVo8iF2iUBERVPVJ1gq9Rbfd7CnFN3ps20IgmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKhz+bar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKhz+bar"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06779C2BCF7;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493848;
	bh=MFHojmFQf9VayktGRWT7VpOQGCXGKQOTcmOc4TyTDOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MKhz+barPjqlcWohCpvxPbkbldkEzhSjseQkpBapv7zssT7nB6gww0yDKGRPEoZhc
	 0uBPsqYq/v1fsiT+hL2MxlbnW+rHswYhJzTq79Fwif3Sdp0UhvttbUvlIrKeFhEayV
	 Pac7MqY8oV8oTppR4oNIwqpK56mbH+cM7hau3IvnTcpfWysU5OVIH9JzTFNm6GgNJX
	 Ww1bMqdHYemQKZ1uyl511APmvx2XtKUmXjInIiRBYPONBriYRhVRNOXVWnb+Pktx+4
	 ImuQpm+mG+CDmAyRXzFU+Jf3bEglpj21wND7DeuIJTG/B/Wh/sGPeTK3foewCLFKG+
	 3g5KugOQLiYSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E860ACD37AC;
	Mon, 11 May 2026 10:04:07 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 12:04:06 +0200
Subject: [PATCH 1/7] iio: light: opt3001: make headers conform to iwyu
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-opt3001-cleanup-v1-1-f7879dc3455c@gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
In-Reply-To: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493846; l=1404;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=sYBEFSgXpCTsp4tslKj24XkY3mo8Z+wM+iHH5uIcud8=;
 b=RaQLZ5q+3Ed1Kjee8RbUjs4MNQk8sssWqDyvUiES5i/iPY67EdehWu4ZVccI0qzWGPkHXUZ/N
 Vskl+Qs5GLjA+OiR00F4GR7hetb1EExOOAxrqSZ8Gb1vYqcCYRHVHzT
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
index 53bc455b7bad142695d9fecc6cabb934fb3ace0c..e6c3665f46be47129097c3997c7551ba9a8f6440 100644
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


