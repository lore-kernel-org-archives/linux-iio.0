Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:57696 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbATJ2E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jan 2015 04:28:04 -0500
Received: by mail-we0-f169.google.com with SMTP id p10so12408131wes.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2015 01:28:02 -0800 (PST)
Date: Tue, 20 Jan 2015 11:27:58 +0200
From: Asaf Vertz <asaf.vertz@tandemg.com>
To: gregkh@linuxfoundation.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, roberta.dobrescu@gmail.com,
	paulmck@linux.vnet.ibm.com, mario.schuknecht@dresearch-fe.de,
	aybuke.147@gmail.com, tinajohnson.1234@gmail.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: tsl2x7x_core: fix format string warnings
Message-ID: <20150120092758.GA4321@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixed the following warnings (reported by cppcheck):
[drivers/staging/iio/light/tsl2x7x_core.c:1150]: (warning) %d in format string (no. 1)
requires 'int' but the argument type is 'unsigned int'.
[drivers/staging/iio/light/tsl2x7x_core.c:1150]: (warning) %d in format string (no. 2)
requires 'int' but the argument type is 'unsigned int'.
[drivers/staging/iio/light/tsl2x7x_core.c:1150]: (warning) %d in format string (no. 3)
requires 'int' but the argument type is 'unsigned int'.

Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 423f96b..4a5dc26 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1147,7 +1147,7 @@ static ssize_t tsl2x7x_luxtable_show(struct device *dev,
 	int offset = 0;
 
 	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%d,%d,%d,",
+		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
 			chip->tsl2x7x_device_lux[i].ratio,
 			chip->tsl2x7x_device_lux[i].ch0,
 			chip->tsl2x7x_device_lux[i].ch1);
-- 
1.7.0.4

