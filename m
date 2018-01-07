Return-Path: <SRS0=94De=EC=googlemail.com=gebulmer@kernel.org>
From: George Edward Bulmer <gebulmer@googlemail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	masneyb@onstation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	George Edward Bulmer <gebulmer@googlemail.com>
Subject: [PATCH] staging: iio: light: Add breaks to lengthy lines
Date: Sun,  7 Jan 2018 15:08:01 +0000
Message-Id: <20180107150801.21617-1-gebulmer@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes three instances of checkpatch warning:
WARNING: line over 80 characters

Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 42ed9c015aaf..126e11530ce0 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1441,7 +1441,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_available
+		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1455,7 +1456,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_available
+		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1471,7 +1473,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_available
+		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-- 
2.15.1
