Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30846 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423066AbcBQRxK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Feb 2016 12:53:10 -0500
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
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v3 1/6] iio:pressure:ms5611: fix ms5607 temp compensation
Date: Wed, 17 Feb 2016 18:52:49 +0100
Message-ID: <44529c257a18d7fb978476375e8dad2dc92bcb12.1455731233.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455731233.git.gregor.boirie@parrot.com>
References: <cover.1455731233.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Computation of sens2 was wrong and is fixed by this patch, sens2 should be:
    2 * (t - 2000)^2
See page 8 of ms5607 datasheet here:
    http://www.meas-spec.com/product/pressure/MS5607-02BA03.aspx

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/pressure/ms5611_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index c7885f0c..84ab8d2 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -136,17 +136,17 @@ static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_inf
 
 	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
 	if (t < 2000) {
-		s64 off2, sens2, t2;
+		s64 off2, sens2, t2, tmp;
 
 		t2 = (dt * dt) >> 31;
-		off2 = (61 * (t - 2000) * (t - 2000)) >> 4;
-		sens2 = off2 << 1;
+		tmp = (t - 2000) * (t - 2000);
+		off2 = (61 * tmp) >> 4;
+		sens2 = tmp << 1;
 
 		if (t < -1500) {
-			s64 tmp = (t + 1500) * (t + 1500);
-
+			tmp = (t + 1500) * (t + 1500);
 			off2 += 15 * tmp;
-			sens2 += (8 * tmp);
+			sens2 += 8 * tmp;
 		}
 
 		t -= t2;
-- 
2.1.4

