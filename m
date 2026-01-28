Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD032D8379
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614713; cv=none; b=g3g9UDK6OdN420h3aaylbGWOObujtyqkJ7Gm09yNC/p0Sqa5O/iCrQhw20xJrDPtS2JtkMbpnFFVhCyVjckypDM/uS7/P76KcpUPjTzx3XO7TjrhieTThngfs/tVkU5thMs0pWwWUP7RTUuyPPw9rSQbWEWGtxqYh1OPqJ8ky2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614713; c=relaxed/simple;
	bh=HuKdx9+NgWt+Gf9a6JvbKAE5xNrIcXfGej0M3axBDjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i29UManIiG9ib2UT6hUlSHKWtKgJakpk9J4Ik2VbcL+alY0bwRvVqzAMOm1PKVh/+j97zTgg/3Z08hsWfLM7JY2ARjPrOdzsVpG1HjMcL7+f5X34XmMtkcuJDHDHrBKp2nTGqx63QGe7zaUUT4K6m9cQBNZh8cW40np5rVmUZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0003or-Nh; Wed, 28 Jan 2026 16:38:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-002wSM-2b;
	Wed, 28 Jan 2026 16:38:26 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0000000FRA4-0EAo;
	Wed, 28 Jan 2026 16:38:26 +0100
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
Subject: [PATCH v3 3/8] iio: dac: ds4424: sort headers alphabetically
Date: Wed, 28 Jan 2026 16:38:19 +0100
Message-ID: <20260128153824.3679187-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128153824.3679187-1-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
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

Group subsystem-specific headers (linux/iio/*) separately at the end
to clarify subsystem context.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- Keep linux/iio/* headers in a separate group at the end of the includes.
changes v2:
- new patch
---
 drivers/iio/dac/ds4424.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 36286e4923af..c03051dc763e 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -6,16 +6,17 @@
  */
 
 #include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/iio/iio.h>
+
+#include <linux/iio/consumer.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
-#include <linux/iio/consumer.h>
 
 #define DS4422_MAX_DAC_CHANNELS		2
 #define DS4424_MAX_DAC_CHANNELS		4
-- 
2.47.3

