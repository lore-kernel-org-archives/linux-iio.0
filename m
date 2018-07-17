Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:60791 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbeGQRaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jul 2018 13:30:17 -0400
From: Tomas Novotny <tomas@novotny.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 2/4] iio: vcnl4000: add VCNL4010 device id
Date: Tue, 17 Jul 2018 18:46:53 +0200
Message-Id: <20180717164655.27142-3-tomas@novotny.cz>
In-Reply-To: <20180717164655.27142-1-tomas@novotny.cz>
References: <20180717164655.27142-1-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver already supports VCNL4010/20 devices. The supported features
and detectable product id are the same, so add shared id for them.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/vcnl4000.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 32c0b531395f..0688214fc152 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -48,6 +48,7 @@
 
 enum vcnl4000_device_ids {
 	VCNL4000,
+	VCNL4010,
 };
 
 struct vcnl4000_data {
@@ -68,6 +69,7 @@ struct vcnl4000_chip_spec {
 
 static const struct i2c_device_id vcnl4000_id[] = {
 	{ "vcnl4000", VCNL4000 },
+	{ "vcnl4010", VCNL4010 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
@@ -157,6 +159,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4000_measure_light,
 		.measure_proximity = vcnl4000_measure_proximity,
 	},
+	[VCNL4010] = {
+		.prod = "VCNL4010/4020",
+		.init = vcnl4000_init,
+		.measure_light = vcnl4000_measure_light,
+		.measure_proximity = vcnl4000_measure_proximity,
+	},
 };
 
 static const struct iio_chan_spec vcnl4000_channels[] = {
-- 
2.12.3

