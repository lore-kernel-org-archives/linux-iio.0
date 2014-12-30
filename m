Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 1/2] iio: light: Annotate Kconfig entry with module name information
Date: Tue, 30 Dec 2014 20:48:49 +0200
Message-Id: <1419965330-4102-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl warning:
WARNING: please write a paragraph that describes the config symbol fully

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 5bea821..fce4d688 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -95,6 +95,9 @@ config HID_SENSOR_ALS
 	  Say yes here to build support for the HID SENSOR
 	  Ambient light sensor.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-sensor-als.
+
 config HID_SENSOR_PROX
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-- 
1.9.1
