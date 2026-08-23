Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D613B5B3
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445245; cv=none; b=WTekxepIYWa0I846sgA3r6vYc4vi5R0fSKwVvx/9d8dCDTuNX9rG3aP72E9AzI8QiuWZ+CA+Khx7yDc1dEfE83976H3Y9Z3HPE6hJRyuTRfG94ncerJvLZdhS7f0qd18qkNVsEur9qs/1Wj9gLpbh9fVtVQB3iMNwjXoAdMmcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445245; c=relaxed/simple;
	bh=g0F3xnJRJxxCMYaaA6dOWoIlAD58qtUBsqbxx0qTfeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdW2/jAQqXXVw6fSdy/2Gh5zNMl5/ke93qBVR9K2/HNx3mL1fKAZ8yb5syesW5cFzz19SC9nKy25YXe5M0PbJfEjhct6bE4KTBBLKHC0gTkXhQcSfHTOwvJ9NTF11KGasjvo4ZNlIX8SzJ+HsYMFT9CGMQOdpS396MmHAiqWpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hSFQS61K0z8sWN;
	Sun, 23 Aug 2026 00:33:36 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v5 2/3] iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
Date: Sun, 23 Aug 2026 02:33:19 +0200
Message-ID: <20260823003320.62192-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
References: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

A WHOAMI value differing from the one the compatible implies aborts
probe with -ENODEV, which prevents a register-compatible part described
with a fallback compatible from probing at all.

The devicetree compatible is authoritative for which part is fitted:
log the mismatch at info level and continue. The message keeps a
breadcrumb for anyone seeing an unexpected part change on their device
versus the devicetree; tmp117 takes the same trade at the same level
for its fallback matches.

A whoami of 0x00 or 0xff still fails probe: SPI has no transfer-level
ack, so those values mean nothing answered. Otherwise the probe outcome
on mismatch changes for all parts the driver supports. The check sits
before the mismatch comparison; it does not depend on hw->whoami, since
no supported part uses either value (the WHOAMI values the driver
defines span 0x40-0x5C). inv_icm45600 carries the same guard nested in
its mismatch branch.

Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
and matched as icm42631, probes with the one informational line, and
accelerometer, gyroscope and temperature reads work.

Suggested-by: Conor Dooley <conor@kernel.org>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v5: the no-response guard moves before the whoami-mismatch comparison
as its own check (Andy); the four Link trailers are dropped (Andy,
Jonathan); retested on the device.
v4 kept the whoami read, logging the mismatch at info level
(Jonathan, Conor), and added inv_icm45600's no-response guard; both
prints use %#04x so the two ids render at equal width.
v3 dropped the check and the whoami definitions entirely.
New in v2, as a demotion of the error to a warning.

 .../iio/imu/inv_icm42600/inv_icm42600_core.c    | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dc97d8a274e3..be8cbecdd92e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -509,10 +510,20 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
 	if (ret)
 		return ret;
+
+	/*
+	 * SPI interface has no ack mechanism.
+	 * 0xFF or 0x00 whoami means no response from the device.
+	 */
+	if (val == U8_MAX || val == 0)
+		return dev_err_probe(dev, -ENODEV,
+				     "invalid whoami %#04x expected %#04x (%s)\n",
+				     val, hw->whoami, hw->name);
+
 	if (val != hw->whoami) {
-		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
-			val, hw->whoami, hw->name);
-		return -ENODEV;
+		dev_info(dev,
+			 "device id %#04x is not the %#04x associated with the FW-specified device (%s), probably using a valid fallback compatible\n",
+			 val, hw->whoami, hw->name);
 	}
 	st->name = hw->name;
 
-- 
2.55.0

