Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.148.196]:36439 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752335AbcKYED2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 23:03:28 -0500
Received: from cm2.websitewelcome.com (cm2.websitewelcome.com [192.185.178.13])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 149F5255EE741
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2016 21:39:06 -0600 (CST)
From: Boyan Vladinov <nayobix@nayobix.org>
To: gregkh@linuxfoundation.org, lars@metafoo.de,
        Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Boyan Vladinov <nayobix@nayobix.org>
Subject: [PATCH v2] Staging: iio: adc: fix sysfs files modes in ad7192.c
Date: Thu, 24 Nov 2016 19:38:18 -0800
Message-Id: <1480045098-2843-1-git-send-email-nayobix@nayobix.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes sysfs entries user/group modes and coding style warnings
found by checkpatch.pl tool. Also use the IIO_DEVICE_ATTR_[RO|RW] and
macros to create device attributes

Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
---
 drivers/staging/iio/adc/ad7192.c | 45 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1fb68c01abd5..630b04d8128f 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -324,8 +324,8 @@ static int ad7192_setup(struct ad7192_state *st,
 }
 
 static ssize_t
-ad7192_show_scale_available(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+in_v_m_v_scale_available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
@@ -340,15 +340,19 @@ ad7192_show_scale_available(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
-			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
+static ssize_t
+in_voltage_scale_available_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return in_v_m_v_scale_available_show(dev, attr, buf);
+}
+
+static IIO_DEVICE_ATTR_RO(in_v_m_v_scale_available, 0);
 
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
@@ -357,8 +361,8 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	return sprintf(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
 }
 
-static ssize_t ad7192_show_bridge_switch(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t bridge_switch_en_show(struct device *dev,
+				     struct device_attribute *attr,
 					 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -367,8 +371,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 	return sprintf(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
 }
 
-static ssize_t ad7192_set(struct device *dev,
-			  struct device_attribute *attr,
+static ssize_t bridge_switch_en_store(struct device *dev,
+				      struct device_attribute *attr,
 			  const char *buf,
 			  size_t len)
 {
@@ -412,13 +416,16 @@ static ssize_t ad7192_set(struct device *dev,
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

