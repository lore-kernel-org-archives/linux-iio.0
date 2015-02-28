Return-Path: <marek.belisko@gmail.com>
Sender: Belisko Marek <marek.belisko@gmail.com>
From: Marek Belisko <marek@goldelico.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	hns@goldelico.com,
	Marek Belisko <marek@goldelico.com>
Subject: [PATCH] staging: iio: hmc5843: Set iio name property in sysfs
Date: Sat, 28 Feb 2015 21:54:42 +0100
Message-Id: <1425156882-27691-1-git-send-email-marek@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

Without this change file name for hmc5843 is empty in
/sys/bus/iio/devices/iio\:device*/name

With this change name is reported correctly:
cat /sys/bus/iio/devices/iio\:device*/name
hmc5843

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/staging/iio/magnetometer/hmc5843_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
index fd171d8..90cc18b 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_core.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
@@ -592,6 +592,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = dev;
+	indio_dev->name = dev->driver->name;
 	indio_dev->info = &hmc5843_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->variant->channels;
-- 
1.9.1
