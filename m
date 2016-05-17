Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcEQV4H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 May 2016 17:56:07 -0400
From: Matt Ranostay <matt.ranostay@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt.ranostay@intel.com>,
	daniel.baluta@intel.com
Subject: [PATCH] iio: adc: ti-ads1015: add datasheet names
Date: Tue, 17 May 2016 15:02:03 -0700
Message-Id: <1463522523-25791-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add datasheet names for ADC channels to allow iio consumers access.

Cc: daniel.baluta@intel.com
Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 NOTES: Requires previous ADS1115 patchst applied first

 drivers/iio/adc/ti-ads1015.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a835423..8be192a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -110,6 +110,7 @@ static const struct {
 		.shift = 4,					\
 		.endianness = IIO_CPU,				\
 	},							\
+	.datasheet_name = "AIN"#_chan,				\
 }
 
 #define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
@@ -130,6 +131,7 @@ static const struct {
 		.shift = 4,					\
 		.endianness = IIO_CPU,				\
 	},							\
+	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
 }
 
 #define ADS1115_V_CHAN(_chan, _addr) {				\
@@ -147,6 +149,7 @@ static const struct {
 		.storagebits = 16,				\
 		.endianness = IIO_CPU,				\
 	},							\
+	.datasheet_name = "AIN"#_chan,				\
 }
 
 #define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
@@ -166,6 +169,7 @@ static const struct {
 		.storagebits = 16,				\
 		.endianness = IIO_CPU,				\
 	},							\
+	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
 }
 
 struct ads1015_data {
-- 
2.7.4

