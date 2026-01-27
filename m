Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB67329E79
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494187; cv=none; b=RDFUqS46VlrjdrnP5C6ybBLWwShqD1Nlv5cTB10PE/zZHIK5r/hwlALVWA3GMsvXxmGEUdyxDgHtl2z666F1fbRyAu8zHBqSNKxORKftf6w8sCFc3BtvMhnaIBHmZQaJMMRUtt/qvnSRtMPUImOg40+xGW/hBXzoYMyOAqc1g7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494187; c=relaxed/simple;
	bh=9Cz8ny6H8Kxen28oclTzgb9tYmjwRZ2qNY5FU7uS0G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBlydil4A7MKRyjlBDg4hpBbnuYmhfG/84B1XOl6iraKwSJIUodyaxcPFeGxo3ADMvl8EUmYngzx6WjyGnDwiuTiZptivcFFag4r4eMz8FgMYKBVAHQtEXGfyBx5sp2Zr7+uF31xu74e8PU+Ee8yFsXOl/BM7fQgA/UVPc90McI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-0003pY-0E; Tue, 27 Jan 2026 07:09:42 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-002hiM-36;
	Tue, 27 Jan 2026 07:09:41 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-0000000GQFD-0maB;
	Tue, 27 Jan 2026 07:09:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v2 4/8] iio: dac: ds4424: sort headers alphabetically
Date: Tue, 27 Jan 2026 07:09:35 +0100
Message-ID: <20260127060939.3914006-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127060939.3914006-1-o.rempel@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Sort the header inclusions alphabetically. This improves readability and
simplifies adding new includes in the future.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- new patch
---
 drivers/iio/dac/ds4424.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 072b7e6672cf..a4f00045f17b 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -5,16 +5,16 @@
  * Copyright (C) 2017 Maxim Integrated
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/consumer.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
-#include <linux/iio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 
 #define DS4422_MAX_DAC_CHANNELS		2
 #define DS4424_MAX_DAC_CHANNELS		4
-- 
2.47.3

