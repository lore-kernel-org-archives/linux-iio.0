Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48082 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbaAMV2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:28:37 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/6] staging:iio:accel:sca3000: Channels missing in temp_output case
Date: Mon, 13 Jan 2014 22:28:32 +0100
Message-Id: <1389648514-31429-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

issues introduced here 25888dc5,
staging:iio:sca3000 extract old event handling and move to poll for events

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/sca3000_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 159272e..0123bc0 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1170,11 +1170,10 @@ static int sca3000_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	if (st->info->temp_output)
 		indio_dev->info = &sca3000_info_with_temp;
-	else {
+	else
 		indio_dev->info = &sca3000_info;
-		indio_dev->channels = sca3000_channels;
-		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
-	}
+	indio_dev->channels = sca3000_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(indio_dev);
-- 
1.8.3.2

