Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:47137 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751478AbdJ1VNG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Oct 2017 17:13:06 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2 2/3] iio: adc: ina2xx: Use LSB specifier instead of divider in config
Date: Sat, 28 Oct 2017 23:12:47 +0200
In-Reply-To: <20171028211249.24148-1-stefan.bruens@rwth-aachen.de>
References: <20171028211249.24148-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <b1ed2d5d-f548-4d88-b563-58a86008e661@rwthex-w2-a.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While the config uses the physical value corresponding to the LSB
for both the power and the bus voltage register, the shunt voltage is
specified as parts of 1 mV. Use the LSB physical value for all registers.

No functional change.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v2:
- new patch

 drivers/iio/adc/ina2xx-adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 84094235ff7e..c59843de3999 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -115,7 +115,7 @@ enum ina2xx_ids { ina219, ina226 };
 struct ina2xx_config {
 	u16 config_default;
 	int calibration_factor;
-	int shunt_div;
+	int shunt_voltage_lsb;	/* nV */
 	int bus_voltage_shift;	/* position of lsb */
 	int bus_voltage_lsb;	/* uV */
 	int power_lsb;		/* uW */
@@ -138,7 +138,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
 		.calibration_factor = 40960000,
-		.shunt_div = 100,
+		.shunt_voltage_lsb = 10000,
 		.bus_voltage_shift = INA219_BUS_VOLTAGE_SHIFT,
 		.bus_voltage_lsb = 4000,
 		.power_lsb = 20000,
@@ -147,7 +147,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
 		.calibration_factor = 5120000,
-		.shunt_div = 400,
+		.shunt_voltage_lsb = 2500,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
 		.power_lsb = 25000,
@@ -204,9 +204,9 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->address) {
 		case INA2XX_SHUNT_VOLTAGE:
-			/* processed (mV) = raw/shunt_div */
-			*val2 = chip->config->shunt_div;
-			*val = 1;
+			/* processed (mV) = raw * lsb(nV) / 1000000 */
+			*val = chip->config->shunt_voltage_lsb;
+			*val2 = 1000000;
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_BUS_VOLTAGE:
-- 
2.14.3

