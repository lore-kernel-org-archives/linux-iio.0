Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58698 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbbHTHH6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:07:58 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 01/18] iio: Export SPI module alias information in missing drivers
Date: Thu, 20 Aug 2015 09:07:14 +0200
Message-Id: <1440054451-1223-2-git-send-email-javier@osg.samsung.com>
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

 drivers/iio/amplifiers/ad8366.c | 1 +
 drivers/iio/frequency/adf4350.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index c0d364ebaea8..32b82a2dc894 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -195,6 +195,7 @@ static const struct spi_device_id ad8366_id[] = {
 	{"ad8366", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad8366_id);
 
 static struct spi_driver ad8366_driver = {
 	.driver = {
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 9890c81c027d..8bd873fc3787 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -621,6 +621,7 @@ static const struct spi_device_id adf4350_id[] = {
 	{"adf4351", 4351},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, adf4350_id);
 
 static struct spi_driver adf4350_driver = {
 	.driver = {
-- 
2.4.3

