Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36046 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbcHOXKA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 19:10:00 -0400
Date: Mon, 15 Aug 2016 16:09:36 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: temperature: add Kconfig selects for triggered buffer
Message-ID: <20160815230929.GA12208@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Select IIO_BUFFER and IIO_TRIGGERED_BUFFER to compile maxim_thermocouple.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Changes in v2
 - split off from a group patch destined for another branch
 - rebased on iio/togreg

 drivers/iio/temperature/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1d3da05..5ea77a7 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -6,6 +6,8 @@ menu "Temperature sensors"
 config MAXIM_THERMOCOUPLE
 	tristate "Maxim thermocouple sensors"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for the Maxim series of
 	  thermocouple sensors connected via SPI.
-- 
2.1.4

