Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30858 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965296AbcBQRkr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Feb 2016 12:40:47 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	=?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>
Subject: [PATCH v2 3/6] iio:pressure:ms5611: power regulator support
Date: Wed, 17 Feb 2016 18:38:41 +0100
Message-ID: <704bdf6619be84f5029299d1844f50d9a767d0f4.1455729921.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455729921.git.gregor.boirie@parrot.com>
References: <cover.1455729921.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Grégor Boirie <gregor.boirie@parrot.com>

Add support for an optional regulator which, if found into device-tree,
will power on device at probing time.
The regulator is declared into ms5611 DTS entry as a "vdd-supply" property.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/ms5611_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index acd8e37..992ad8d 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -290,6 +291,18 @@ static const struct iio_info ms5611_info = {
 static int ms5611_init(struct iio_dev *indio_dev)
 {
 	int ret;
+	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
+	                                           "vdd");
+
+	/* Enable attached regulator if any. */
+	if (!IS_ERR(vdd)) {
+		ret = regulator_enable(vdd);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+			        "failed to enable Vdd supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	ret = ms5611_reset(indio_dev);
 	if (ret < 0)
-- 
2.1.4

