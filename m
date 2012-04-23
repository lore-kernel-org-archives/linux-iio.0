Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1059 "EHLO
	smtp-out-078.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753504Ab2DWRtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Apr 2012 13:49:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] staging:iio:dac:ad5446: Remove unused struct field
Date: Mon, 23 Apr 2012 19:51:31 +0200
Message-Id: <1335203497-11041-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the unused "poll_work" field from the ad5446_state struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 4ea3476..72ad07f 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -34,7 +34,6 @@
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
- * @poll_work:		bottom half of polling interrupt handler
  * @vref_mv:		actual reference voltage used
  * @xfer:		default spi transfer
  * @msg:		default spi message
@@ -45,7 +44,6 @@ struct ad5446_state {
 	struct spi_device		*spi;
 	const struct ad5446_chip_info	*chip_info;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
 	unsigned short			vref_mv;
 	unsigned			cached_val;
 	unsigned			pwr_down_mode;
-- 
1.7.9.5

