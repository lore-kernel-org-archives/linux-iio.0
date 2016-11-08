Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47282 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbcKHK1S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:18 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 15/23] staging: iio: tsl2583: fix multiline comment syntax
Date: Tue,  8 Nov 2016 05:16:40 -0500
Message-Id: <1478600208-21153-16-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The definition of the tsl2583_device_lux struct has a series of single
line comments. There are two other cases where the multiline comments
did not have an initial blank line. Change these comments to use the
proper multiline syntax.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index eff59f37..5ef403c 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -93,9 +93,11 @@ struct tsl2583_lux {
 	unsigned int ch1;
 };
 
-/* This structure is intentionally large to accommodate updates via sysfs. */
-/* Sized to 11 = max 10 segments + 1 termination segment */
-/* Assumption is one and only one type of glass used  */
+/*
+ * This structure is intentionally large to accommodate updates via sysfs.
+ * Sized to 11 = max 10 segments + 1 termination segment. Assumption is that
+ * one and only one type of glass used.
+ */
 static struct tsl2583_lux tsl2583_device_lux[11] = {
 	{  9830,  8520, 15729 },
 	{ 12452, 10807, 23344 },
@@ -261,7 +263,8 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 		lux = (lux + (chip->als_time_scale >> 1)) /
 			chip->als_time_scale;
 
-	/* Adjust for active gain scale.
+	/*
+	 * Adjust for active gain scale.
 	 * The tsl2583_device_lux tables above have a factor of 8192 built in,
 	 * so we need to shift right.
 	 * User-specified gain provides a multiplier.
@@ -549,7 +552,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 
 	get_options(buf, ARRAY_SIZE(value), value);
 
-	/* We now have an array of ints starting at value[1], and
+	/*
+	 * We now have an array of ints starting at value[1], and
 	 * enumerated by value[0].
 	 * We expect each group of three ints is one table entry,
 	 * and the last table entry is all 0.
-- 
2.7.4

