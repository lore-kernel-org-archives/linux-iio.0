Return-Path: <robin@protonic.nl>
From: Robin van der Gracht <robin@protonic.nl>
To: jic23@kernel.org
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH] iio: st_sensors: Fix buffer copy
Date: Mon, 29 Sep 2014 15:00:07 +0200
Message-Id: <1411995607-22198-1-git-send-email-robin@protonic.nl>
List-ID: <linux-iio@vger.kernel.org>

Use byte_for_channel as iterator to properly initialize the buffer.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 1665c8e..e18bc67 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -71,7 +71,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 				goto st_sensors_free_memory;
 			}
 
-			for (i = 0; i < n * num_data_channels; i++) {
+			for (i = 0; i < n * byte_for_channel; i++) {
 				if (i < n)
 					buf[i] = rx_array[i];
 				else
-- 
1.9.1
