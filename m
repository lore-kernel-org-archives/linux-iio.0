Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30858 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbcCAKbE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 05:31:04 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v4 1/3] iio:pressure:ms5611: fix oops when probing regulator
Date: Tue, 1 Mar 2016 11:31:36 +0100
Message-ID: <3c096730728684f1ce127602179c3ba73cd66cb4.1456828051.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1456828051.git.gregor.boirie@parrot.com>
References: <cover.1456828051.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When not compiled-in, regulator layer will return a NULL pointer when
trying to get a reference to any regulator using devm_regulator_get().  As
IS_ERR() does not consider this an error, the ms5611 probing operation will
try to enable a NULL regulator, which will invariably cause a kernel
crash.
This patch fixes this situation by using devm_regulator_get_optional()
instead of devm_regulator_get().

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/ms5611_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 992ad8d..a9c4d49 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -291,8 +291,8 @@ static const struct iio_info ms5611_info = {
 static int ms5611_init(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
-	                                           "vdd");
+	struct regulator *vdd =
+		devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
 
 	/* Enable attached regulator if any. */
 	if (!IS_ERR(vdd)) {
@@ -302,6 +302,10 @@ static int ms5611_init(struct iio_dev *indio_dev)
 			        "failed to enable Vdd supply: %d\n", ret);
 			return ret;
 		}
+	} else {
+		ret = PTR_ERR(vdd);
+		if (ret != -ENODEV)
+			return ret;
 	}
 
 	ret = ms5611_reset(indio_dev);
-- 
2.1.4

