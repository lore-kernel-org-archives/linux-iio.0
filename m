Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30862 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcBORx7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 12:53:59 -0500
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
Subject: [PATCH v1 3/5] iio:pressure:ms5611: power regulator support
Date: Mon, 15 Feb 2016 18:53:18 +0100
Message-ID: <e036950749dd366cc3cacce73c3c64b05802ee0d.1455557806.git.gregor.boirie@parrot.com>
In-Reply-To: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
References: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Grégor Boirie <gregor.boirie@parrot.com>

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/ms5611_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 65d8fd2..a024445 100644
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

