Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com [198.54.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CD3AFCE1;
	Fri, 24 Jul 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924888; cv=none; b=eAdPARlX67i4bGJMVhxUbKE/Mc8D0T3+3xWHqHbtObdiHlKSnH7xhjpRJ57lOaJ/8yFN+1ieT6Y0HGJJantTp3oU2YpLOa8UHbL0+AZnZ2YtFgu1Z+ORoH5ibYSsuIHX00F5EbEO+dmqWtHvXJJDOrIXB1Bm+640OstMcHNJKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924888; c=relaxed/simple;
	bh=AK2yOPCXCzkTWRJ+7PX/06kW9b8hIuQOGbVbAZd0JEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcfqDfQRSxIFrY+Jl2QTtlVaM0LCfOhDtGjAtMaN009IdWokFpgWYnHF7x5KQR9YQc3tDkGZDmHa5jiKgSZ1lhMg0tRejn1K4R3IsSNf8K2itrQInuctOoEs0DadvUmEcWRjwdNScT/+SWz5eTY2eY/giA/DUxyvBtfvOi2dXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-08 [87.215.145.39])
	by mta-13.privateemail.com (Postfix) with ESMTPA id 4h6KLF4pY4z3hhTR;
	Fri, 24 Jul 2026 16:27:48 -0400 (EDT)
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
Subject: [PATCH v2 2/4] iio: imu: inv_icm42600: warn on whoami mismatch instead of failing probe
Date: Fri, 24 Jul 2026 22:27:06 +0200
Message-ID: <20260724202708.128267-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A WHOAMI value differing from the one the compatible implies aborts
probe with -ENODEV, which prevents a register-compatible part described
with a fallback compatible from probing at all.

The devicetree compatible is authoritative for which part is fitted:
demote the mismatch to a warning and continue, as st_sensors does since
commit a3c2c5c937ed ("iio: st_sensors: relax WhoAmI check in
st_sensors_verify_id()"). This changes the probe outcome on mismatch
for all parts the driver supports.

Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
and matched as icm42631, warns once and probes, and accelerometer,
gyroscope and temperature reads work.

Suggested-by: Conor Dooley <conor@kernel.org>
Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
New in v2.
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dc97d8a274e3..f306e3ffca48 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -509,11 +509,9 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
 	if (ret)
 		return ret;
-	if (val != hw->whoami) {
-		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
-			val, hw->whoami, hw->name);
-		return -ENODEV;
-	}
+	if (val != hw->whoami)
+		dev_warn(dev, "unexpected whoami %#02x, expected %#02x (%s)\n",
+			 val, hw->whoami, hw->name);
 	st->name = hw->name;
 
 	/* reset to make sure previous state are not there */
-- 
2.55.0

