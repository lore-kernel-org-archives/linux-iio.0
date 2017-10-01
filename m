Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:51883 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752178AbdJATsg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Oct 2017 15:48:36 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 1/3] iio: adc: ina2xx: Mask flag bits in bus voltage register
Date: Sun, 1 Oct 2017 21:48:16 +0200
In-Reply-To: <20171001194818.26017-1-stefan.bruens@rwth-aachen.de>
References: <20171001194818.26017-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <adb12c57-0653-4343-b551-9427d292c5fd@rwthex-w2-a.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lower bits of the INA219/220 bus voltage register are conversion
status flags, properly mask the value.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

 drivers/iio/adc/ina2xx-adc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index f387b972e4f4..361fb4e459d5 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -44,7 +44,6 @@
 
 #define INA226_MASK_ENABLE		0x06
 #define INA226_CVRF			BIT(3)
-#define INA219_CNVR			BIT(1)
 
 #define INA2XX_MAX_REGISTERS            8
 
@@ -79,6 +78,11 @@
 #define INA226_ITS_MASK		GENMASK(5, 3)
 #define INA226_SHIFT_ITS(val)	((val) << 3)
 
+/* INA219 Bus voltage register, low bits are flags */
+#define INA219_OVF		BIT(0)
+#define INA219_CNVR		BIT(1)
+#define INA219_BUS_VOLTAGE_MASK	GENMASK(16, 3)
+
 /* Cosmetic macro giving the sampling period for a full P=UxI cycle */
 #define SAMPLING_PERIOD(c)	((c->int_time_vbus + c->int_time_vshunt) \
 				 * c->avg)
@@ -170,6 +174,10 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 		else
 			*val  = regval;
 
+		if ((chip->config->chip_id == ina219) &&
+		    (chan->address == INA2XX_SHUNT_VOLTAGE))
+			*val &= INA219_BUS_VOLTAGE_MASK;
+
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -639,6 +647,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 		if (ret < 0)
 			return ret;
 
+		if ((chip->config->chip_id == ina219) &&
+		    (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_BUS_VOLTAGE))
+			val &= INA219_BUS_VOLTAGE_MASK;
+
 		data[i++] = val;
 
 		if (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_POWER)
-- 
2.14.1

