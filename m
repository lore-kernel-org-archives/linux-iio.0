Return-Path: <SRS0=2qIu=DR=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2 7/7] iio: adc: ina2xx: Actually align the loop with the conversion ready flag
Date: Thu, 21 Dec 2017 19:31:38 +0100
In-Reply-To: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <12b5a27e-ffdc-4a89-bd4f-4c48c3ec9717@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Currently, the registers are read out once per conversion interval. If
the reading is delayed as the conversion has not yet finished, this extra
time is treated as being part of the readout, although it should delay
the start of the poll interval. This results in the interval starting
slightly earlier in each iteration, until all time between reads is
spent polling the status registers instead of sleeping.

To fix this, the delay has to account for the state of the conversion
ready flag. Whenever the conversion is already finished, schedule the next
read on the regular interval, otherwise schedule it one interval after the
flag bit has been set.

Split the work function in two functions, one for the status poll and one
for reading the values, to be able to note down the time when the flag
bit is raised.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v2:
- Describe old behaviour in commit message more clearly

 drivers/iio/adc/ina2xx-adc.c | 57 +++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index b7407ac91b59..80af0d2322a3 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -697,13 +697,10 @@ static const struct iio_chan_spec ina219_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-static int ina2xx_work_buffer(struct iio_dev *indio_dev)
+static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
 {
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
-	/* data buffer needs space for channel data and timestap */
-	unsigned short data[4 + sizeof(s64)/sizeof(short)];
-	int bit, ret, i = 0;
-	s64 time;
+	int ret;
 	unsigned int alert;
 
 	/*
@@ -717,22 +714,29 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
 	 * resp. the BUS_VOLTAGE register (INA219).
 	 */
-	if (!chip->allow_async_readout)
-		do {
-			if (chip->config->chip_id == ina226) {
-				ret = regmap_read(chip->regmap,
-						  INA226_MASK_ENABLE, &alert);
-				alert &= INA226_CVRF;
-			} else {
-				ret = regmap_read(chip->regmap,
-						  INA2XX_BUS_VOLTAGE, &alert);
-				alert &= INA219_CNVR;
-			}
+	if (chip->config->chip_id == ina226) {
+		ret = regmap_read(chip->regmap,
+				  INA226_MASK_ENABLE, &alert);
+		alert &= INA226_CVRF;
+	} else {
+		ret = regmap_read(chip->regmap,
+				  INA2XX_BUS_VOLTAGE, &alert);
+		alert &= INA219_CNVR;
+	}
 
-			if (ret < 0)
-				return ret;
+	if (ret < 0)
+		return ret;
 
-		} while (!alert);
+	return !!alert;
+}
+
+static int ina2xx_work_buffer(struct iio_dev *indio_dev)
+{
+	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
+	/* data buffer needs space for channel data and timestap */
+	unsigned short data[4 + sizeof(s64)/sizeof(short)];
+	int bit, ret, i = 0;
+	s64 time;
 
 	time = iio_get_time_ns(indio_dev);
 
@@ -776,6 +780,21 @@ static int ina2xx_capture_thread(void *data)
 	ktime_get_ts64(&next);
 
 	do {
+		while (!chip->allow_async_readout) {
+			ret = ina2xx_conversion_ready(indio_dev);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * If the conversion was not yet finished,
+			 * reset the reference timestamp.
+			 */
+			if (ret == 0)
+				ktime_get_ts64(&next);
+			else
+				break;
+		}
+
 		ret = ina2xx_work_buffer(indio_dev);
 		if (ret < 0)
 			return ret;
-- 
2.15.1
