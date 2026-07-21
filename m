Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1124400E1A
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646237; cv=none; b=R/bU5JclCPyhBGOR70bDGqww5fHXsuuO6uCOu7vqvtI14BGOXIIjmL4SclxlhXX0aURWHLzQ0VZ8f11/kB0fW8DdUFMkggLNw+f8Xzh18DED2ID6rQxftJjA00Ikel7zQjp+WmdPHpuu4qecP2J6K9TYqSo3SC/GztzOQnCOZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646237; c=relaxed/simple;
	bh=Zaila6GKu+De9A/9ewWdgxmvgJz7oI6zqspBju5Prv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzY9jOnDzLO5qAoWr3Wtm7gNwUFYKWZE5MlRkvZsgNVch0xBY1n0OWVko+8E1e7LYqw5oBMaAmPj0P0RgdSo0U4ajo9sy5yYmOqjqA1+AuALfzXlilMA5lIHsTdFgjy8vJgl5uMElDc0hOGnZP2GIR7jy2vcey/m4TGIdT+tae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=POFnV4FD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="POFnV4FD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784646228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tglCPgE4AKwdd0u8qEHvDa2UM6WGCVb/lrWKzOgfo3M=;
	b=POFnV4FDPEPtr/kg6uy1BnsEyK+xzndnLaI2b7tQoOxfw76tpKvrKEPNXH825sPJOnpOvS
	keutNYLxdRiJiPdSmXZto9XAXrfzWT3KtroMJ8VhN2xHzH5tvvhqzc6w3Bm8QBSJxiiVgT
	QCCKlpGVEeCFZyo9JvuPzhKyLgO4aN8=
From: Siratul Islam <siratul.islam@linux.dev>
To: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] iio: update email for Siratul Islam
Date: Tue, 21 Jul 2026 21:03:08 +0600
Message-ID: <20260721150314.24545-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Change personal email to the Linux specific one,
to have a single and focused point of interaction.

Signed-off-by: Siratul Islam <siratul.islam@linux.dev>
---
 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml         | 2 +-
 MAINTAINERS                                                   | 2 +-
 drivers/iio/proximity/vl53l1x-i2c.c                           | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 501d858cb432..a337ff5b852e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -817,6 +817,7 @@ Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
 Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@saxnet.de>
 Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
 Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
+Siratul Islam <siratul.islam@linux.dev> <email@sirat.me>
 SJ Park <sj@kernel.org>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
 Srinivas Kandagatla <srini@kernel.org> <srinivas.kandagatla@st.com>
diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index f7f8be1e379d..d23dc59505cc 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -8,7 +8,7 @@ title: ST VL53L0X/VL53L1X ToF ranging sensor
 
 maintainers:
   - Song Qiang <songqiang1304521@gmail.com>
-  - Siratul Islam <email@sirat.me>
+  - Siratul Islam <siratul.islam@linux.dev>
 
 properties:
   compatible:
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea..712505519c39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25682,7 +25682,7 @@ F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
 ST VL53L1X ToF RANGER(I2C) IIO DRIVER
-M:	Siratul Islam <email@sirat.me>
+M:	Siratul Islam <siratul.islam@linux.dev>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index dc4ffbc95d1f..aef5f26d1e1c 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -2,7 +2,7 @@
 /*
  * Support for ST VL53L1X FlightSense ToF Ranging Sensor on a i2c bus.
  *
- * Copyright (C) 2026 Siratul Islam <email@sirat.me>
+ * Copyright (C) 2026 Siratul Islam <siratul.islam@linux.dev>
  *
  * Datasheet available at
  * <https://www.st.com/resource/en/datasheet/vl53l1x.pdf>
@@ -750,6 +750,6 @@ static struct i2c_driver vl53l1x_driver = {
 };
 module_i2c_driver(vl53l1x_driver);
 
-MODULE_AUTHOR("Siratul Islam <email@sirat.me>");
+MODULE_AUTHOR("Siratul Islam <siratul.islam@linux.dev>");
 MODULE_DESCRIPTION("ST VL53L1X ToF ranging sensor driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.55.0

