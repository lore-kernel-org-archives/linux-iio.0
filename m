Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58706 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbbHTHIB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:01 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 02/18] staging: iio: hmc5843: Export missing SPI module alias information
Date: Thu, 20 Aug 2015 09:07:15 +0200
Message-Id: <1440054451-1223-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
regardless of the mechanism that was used to register the device
(i.e: OF or board code) and the table that is used later to match
the driver with the device (i.e: SPI id table or OF match table).

So drivers needs to export the SPI id table and this be built into
the module or udev won't have the necessary information to autoload
the needed driver module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/staging/iio/magnetometer/hmc5843_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
index 8e658f736e1f..4dfb372d2fec 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
@@ -81,6 +81,7 @@ static const struct spi_device_id hmc5843_id[] = {
 	{ "hmc5983", HMC5983_ID },
 	{ }
 };
+MODULE_DEVICE_TABLE(spi, hmc5843_id);
 
 static struct spi_driver hmc5843_driver = {
 		.driver = {
-- 
2.4.3

