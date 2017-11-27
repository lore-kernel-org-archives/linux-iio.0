Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:54363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdK0LwQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Nov 2017 06:52:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: common: ssp_sensors: use ktime_get_real_ns() timestamps
Date: Mon, 27 Nov 2017 12:51:48 +0100
Message-Id: <20171127115158.2884398-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

getnstimeofday() suffers from the overflow in y2038 on 32-bit
architectures and requires a conversion into the nanosecond format that
we want here.

This changes ssp_parse_dataframe() to use ktime_get_real_ns() directly,
which does not have that problem.

An open question is what time base should be used here. Normally
timestamps should use ktime_get_ns() or ktime_get_boot_ns() to read
monotonic time instead of "real" time, which suffers from time jumps
due to settimeofday() calls or leap seconds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 704284a475ae..2ab106bb3e03 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -277,12 +277,9 @@ static int ssp_handle_big_data(struct ssp_data *data, char *dataframe, int *idx)
 static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 {
 	int idx, sd;
-	struct timespec ts;
 	struct ssp_sensor_data *spd;
 	struct iio_dev **indio_devs = data->sensor_devs;
 
-	getnstimeofday(&ts);
-
 	for (idx = 0; idx < len;) {
 		switch (dataframe[idx++]) {
 		case SSP_MSG2AP_INST_BYPASS_DATA:
@@ -329,7 +326,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 	}
 
 	if (data->time_syncing)
-		data->timestamp = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+		data->timestamp = ktime_get_real_ns();
 
 	return 0;
 }
-- 
2.9.0

