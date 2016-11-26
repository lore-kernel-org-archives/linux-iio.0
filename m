Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.145.3]:41119 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752435AbcKZWji (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2016 17:39:38 -0500
Received: from cm5.websitewelcome.com (unknown [108.167.139.22])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 73DFF7745F2B5
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2016 16:39:35 -0600 (CST)
From: Boyan Vladinov <nayobix@nayobix.org>
To: gregkh@linuxfoundation.org, lars@metafoo.de,
        Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Boyan Vladinov <nayobix@nayobix.org>
Subject: [PATCH v3] Staging: iio: adc: fix sysfs files modes in ad7192.c
Date: Sat, 26 Nov 2016 14:39:24 -0800
Message-Id: <1480199964-9554-1-git-send-email-nayobix@nayobix.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes warnings found by checkpatch.pl:
- sysfs entries user/group modes to use their octal representation
- use the IIO_DEVICE_ATTR_[RO|RW] macroses
- coding style

Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
---
 drivers/staging/iio/adc/ad7192.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1fb68c01abd5..29b8a291fb6a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -340,15 +340,21 @@ ad7192_show_scale_available(struct device *dev,
 	return len;
 }
 
+static ssize_t
+in_voltage_scale_available_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return ad7192_show_scale_available(dev, attr, buf);
+}
+
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
 			     in_voltage-voltage_scale_available,
-			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
+			     0444, ad7192_show_scale_available, NULL, 0);
 
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		       ad7192_show_scale_available, NULL, 0);
+static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
 
-static ssize_t ad7192_show_ac_excitation(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t ac_excitation_en_show(struct device *dev,
+				     struct device_attribute *attr,
 					 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -357,8 +363,8 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	return sprintf(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
 }
 
-static ssize_t ad7192_show_bridge_switch(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t bridge_switch_en_show(struct device *dev,
+				     struct device_attribute *attr,
 					 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -367,8 +373,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 	return sprintf(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
 }
 
-static ssize_t ad7192_set(struct device *dev,
-			  struct device_attribute *attr,
+static ssize_t bridge_switch_en_store(struct device *dev,
+				      struct device_attribute *attr,
 			  const char *buf,
 			  size_t len)
 {
@@ -412,13 +418,16 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
-		       ad7192_show_bridge_switch, ad7192_set,
-		       AD7192_REG_GPOCON);
+static ssize_t ac_excitation_en_store(struct device *dev,
+				      struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	return bridge_switch_en_store(dev, attr, buf, len);
+}
+
+static IIO_DEVICE_ATTR_RW(bridge_switch_en, AD7192_REG_GPOCON);
 
-static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
-		       ad7192_show_ac_excitation, ad7192_set,
-		       AD7192_REG_MODE);
+static IIO_DEVICE_ATTR_RW(ac_excitation_en, AD7192_REG_MODE);
 
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
-- 
2.7.4

