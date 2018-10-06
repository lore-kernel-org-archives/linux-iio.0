Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35673 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXbQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Oct 2018 19:31:16 -0400
Date: Sat, 6 Oct 2018 13:27:15 -0300
From: Gabriel Capella <gabriel@capella.pro>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181006162715.GA8476@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch does not change the logic, it only
corrects the checkpatch checks.

The patch fixes 2 checks of type:
"CHECK: spaces preferred around that '-'"

Signed-off-by: Gabriel Capella <gabriel@capella.pro>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..a4b4f8678c56 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
2.17.1 (Apple Git-112)


-- 
Gabriel Capella
gabrielcapella.com
hardwarelivreusp.org
+55 11 98124-5668
