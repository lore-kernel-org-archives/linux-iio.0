Received: from out-93wp-a16.jellyfish.systems (out-93wp-a16.jellyfish.systems [104.207.68.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0563F86FB
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389919; cv=none; b=pu+mVCzvVzQXcmDpgYgZB6Vvz5Olys/RbOud2Gvir2g+cniDO2yiuo8wb8ETSvvjFp+fI0+FTxufNIjg2h1dNWqug8jrkGcf24jOK7ZlmeinWyJgWT/JSyDigeog0riJ4A+XSc8GQy3xDiU9wKkEauSHfp69nXe+MGZFTt5OXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389919; c=relaxed/simple;
	bh=aqYf1sM77HVeW0pess7TRxJwHjdxa/ksSEzUXUewxIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY9WBRTXV4cqc0rl2Ut00Y12FLvDYKOSv3RNoT/XhbSjuvWQJT23sfmYkwEwlejzHGwvly0QxY9xMl0zpWvn1kT99jItuhbnHH77/n4Lf1ZfpHX/03IfhZ9TXwlQzHymmL4t07fL1WnI1TvWyZnxDE5w1NrMFTEz6ZrpO0Z/3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJks56X8xz2x9C;
	Mon, 10 Aug 2026 19:12:09 +0000 (UTC)
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
Subject: [PATCH v4 2/3] iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
Date: Mon, 10 Aug 2026 21:11:56 +0200
Message-ID: <20260810191157.125550-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
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
ack, so those values mean nothing answered; this is the same
no-response guard inv_icm45600 carries. Otherwise the probe outcome on
mismatch changes for all parts the driver supports.

Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
and matched as icm42631, probes with the one informational line, and
accelerometer, gyroscope and temperature reads work.

Suggested-by: Conor Dooley <conor@kernel.org>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
Link: https://lore.kernel.org/all/20260728222015.6a62b287@jic23-huawei/
Link: https://lore.kernel.org/all/20260801032310.18f5f16d@jic23-huawei/
Link: https://lore.kernel.org/all/20260804-scarily-hacker-651df3eafea9@spud/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v4: keep the whoami read and log the mismatch at info level,
following the wording Jonathan proposed (Jonathan, Conor), instead
of deleting the check and the whoami definitions; add
inv_icm45600's no-response guard - whoami 0x00/0xff still fails
probe; both prints use %#04x so the two ids render at equal width;
retested on the device.
v3 dropped the check and the whoami definitions entirely.
New in v2, as a demotion of the error to a warning.

 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dc97d8a274e3..8ceaf825f124 100644
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
@@ -510,9 +511,18 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	if (ret)
 		return ret;
 	if (val != hw->whoami) {
-		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
-			val, hw->whoami, hw->name);
-		return -ENODEV;
+		/*
+		 * SPI interface has no ack mechanism.
+		 * 0xFF or 0x00 whoami means no response from the device.
+		 */
+		if (val == U8_MAX || val == 0)
+			return dev_err_probe(dev, -ENODEV,
+					     "invalid whoami %#04x expected %#04x (%s)\n",
+					     val, hw->whoami, hw->name);
+
+		dev_info(dev,
+			 "device id %#04x is not the %#04x associated with the FW-specified device (%s), probably using a valid fallback compatible\n",
+			 val, hw->whoami, hw->name);
 	}
 	st->name = hw->name;
 
-- 
2.55.0

