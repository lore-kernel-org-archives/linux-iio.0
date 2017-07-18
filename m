Return-Path: <SRS0=AUVK=6V=gmail.com=gehariprasath@kernel.org>
From: Hari Prasath <gehariprasath@gmail.com>
To: lars@metafoo.de
Cc: gehariprasath@gmail.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: add space around substraction operation
Date: Tue, 18 Jul 2017 11:08:08 +0530
Message-Id: <20170718053808.13036-1-gehariprasath@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix checkpatch warning to add space around the substraction operation

Signed-off-by: Hari Prasath <gehariprasath@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d5ab83f..d79e774 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -745,14 +745,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
2.10.0.GIT
