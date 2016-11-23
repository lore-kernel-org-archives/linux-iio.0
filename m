Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.35]:54895 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754327AbcKWHpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 02:45:51 -0500
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 9DB7F24E047E2
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2016 01:25:25 -0600 (CST)
From: Boyan Vladinov <nayobix@nayobix.org>
To: gregkh@linuxfoundation.org, lars@metafoo.de,
        Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Boyan Vladinov <nayobix@nayobix.org>
Subject: [PATCH] Staging: iio: adc: fix sysfs files modes in ad7192.c
Date: Tue, 22 Nov 2016 23:25:14 -0800
Message-Id: <1479885914-17615-1-git-send-email-nayobix@nayobix.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes sysfs entries user/group modes and coding style warnings
found by checkpatch.pl tool

Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
---
 drivers/staging/iio/adc/ad7192.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1fb68c01abd5..3f9f54b654f7 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -341,10 +341,10 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
-			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
+			     in_voltage - voltage_scale_available,
+			     0444, ad7192_show_scale_available, NULL, 0);
 
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
 		       ad7192_show_scale_available, NULL, 0);
 
 static ssize_t ad7192_show_ac_excitation(struct device *dev,
@@ -412,11 +412,11 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(bridge_switch_en, 0444 | 0200,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
 
-static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(ac_excitation_en, 0444 | 0200,
 		       ad7192_show_ac_excitation, ad7192_set,
 		       AD7192_REG_MODE);
 
-- 
2.7.4

