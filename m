Return-Path: <cmo@melexis.com>
From: Crt Mori <cmo@melexis.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	Markus Pargmann <mpa@pengutronix.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 1/2] iio: fetch and enable regulators unconditionally
Date: Mon,  5 Sep 2016 11:14:48 +0200
Message-Id: <20160905091449.12297-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

This patch is inspired by a comment of Jonathan Cameron on patch of
Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio: st_sensors: fetch and enable regulators unconditionally").

The explanation for this change is same as in that patch:
"Supplies are *not* optional (optional means that the supply is
optional in the electrical sense, not the software sense) so we need to
get the and enable them at all times.

If the device tree or board file does not define suitable regulators for
the component, it will be substituted by a dummy regulator, or, if
regulators are disabled altogether, by stubs. There is no need to use the
IS_ERR_OR_NULL() check that is considered harmful.

Reported-by: Linus Wallerij <linus.walleij@linaro.org>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/pressure/ms5611_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index feb41f8..a74ed1f 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -416,8 +416,7 @@ static int ms5611_init(struct iio_dev *indio_dev)
 	return 0;
 
 err_regulator_disable:
-	if (!IS_ERR_OR_NULL(st->vdd))
-		regulator_disable(st->vdd);
+	regulator_disable(st->vdd);
 	return ret;
 }
 
@@ -425,8 +424,7 @@ static void ms5611_fini(const struct iio_dev *indio_dev)
 {
 	const struct ms5611_state *st = iio_priv(indio_dev);
 
-	if (!IS_ERR_OR_NULL(st->vdd))
-		regulator_disable(st->vdd);
+	regulator_disable(st->vdd);
 }
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
-- 
2.9.3
