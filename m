Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50812 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756403AbcJ1KA2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:28 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 04/10] staging: iio: tsl2583: remove redundant power_state sysfs attribute
Date: Fri, 28 Oct 2016 06:00:15 -0400
Message-Id: <1477648821-3786-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO devices have a /sys/bus/iio/devices/iio:deviceX/power/ directory
that allows viewing and controling various power parameters. The tsl2583
driver also has an additional custom sysfs attribute named power_state
that is not needed. This patch removes the redundant power_state sysfs
attribute.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 47fd373..f8ccb4d 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -511,33 +511,6 @@ static int taos_chip_off(struct iio_dev *indio_dev)
 
 /* Sysfs Interface Functions */
 
-static ssize_t taos_power_state_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", chip->taos_chip_status);
-}
-
-static ssize_t taos_power_state_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	int value;
-
-	if (kstrtoint(buf, 0, &value))
-		return -EINVAL;
-
-	if (!value)
-		taos_chip_off(indio_dev);
-	else
-		taos_chip_on(indio_dev);
-
-	return len;
-}
-
 static ssize_t taos_gain_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -785,9 +758,6 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
-		taos_power_state_show, taos_power_state_store);
-
 static DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
 		taos_gain_show, taos_gain_store);
 static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
@@ -810,7 +780,6 @@ static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
 		taos_luxtable_show, taos_luxtable_store);
 
 static struct attribute *sysfs_attrs_ctrl[] = {
-	&dev_attr_power_state.attr,
 	&dev_attr_illuminance0_calibscale.attr,			/* Gain  */
 	&dev_attr_illuminance0_calibscale_available.attr,
 	&dev_attr_illuminance0_integration_time.attr,	/* I time*/
-- 
2.7.4

