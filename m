Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57064 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbbA1Uh3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:37:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: ak8975: fix AK09911 dependencies
Date: Wed, 28 Jan 2015 14:58:44 +0100
Message-ID: <7968545.0Cq9DcaG85@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ak8975 depends on I2C and GPIOLIB, so any symbols that selects
ak8975 must have the same dependency, or we get build errors:

drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
  ^
drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
  ret = i2c_smbus_write_byte_data(data->client,

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 57e73a423b1e85 ("iio: ak8975: add ak09911 and ak09912 support")
---
I found this recent regression doing ARM randconfig builds, please apply

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 4c7a4c52dd06..a5d6de72c523 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -18,6 +18,8 @@ config AK8975
 
 config AK09911
 	tristate "Asahi Kasei AK09911 3-axis Compass"
+	depends on I2C
+	depends on GPIOLIB
 	select AK8975
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.

