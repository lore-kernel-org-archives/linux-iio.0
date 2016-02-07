Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34541 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbcBGWWS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2016 17:22:18 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com, arnd@arndb.de,
	geert@linux-m68k.org, irina.tirdea@intel.com,
	daniel.baluta@intel.com, octavia.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH 4/5] iio: hmc5843: Fix comment style warnings
Date: Mon,  8 Feb 2016 00:21:50 +0200
Message-Id: <1454883711-15489-5-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
References: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix comment style warnings in order to comply with Coding Style
standard provided by Documentation/CodingStyle.

This patch solves following issue found with checkpatch:
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843.h     | 4 ++--
 drivers/staging/iio/magnetometer/hmc5843_i2c.c | 2 +-
 drivers/staging/iio/magnetometer/hmc5843_spi.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.h b/drivers/staging/iio/magnetometer/hmc5843.h
index 06f35d3..cb284cf 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.h
+++ b/drivers/staging/iio/magnetometer/hmc5843.h
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * */
+ */
 
 #ifndef HMC5843_CORE_H
 #define HMC5843_CORE_H
@@ -38,7 +38,7 @@ enum hmc5843_ids {
  * @regmap:		hardware access register maps
  * @variant:		describe chip variants
  * @buffer:		3x 16-bit channels + padding + 64-bit timestamp
- **/
+ */
 struct hmc5843_data {
 	struct device *dev;
 	struct mutex lock;
diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
index 3e06ceb..6f7b8fb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * */
+ */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
index 1549192..85adcdd 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * */
+ */
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
-- 
1.9.1

