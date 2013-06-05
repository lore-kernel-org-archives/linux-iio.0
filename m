Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:common: Added check memory allocation failed
Date: Wed,  5 Jun 2013 09:21:29 +0200
Message-Id: <1370416890-4659-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1370416890-4659-1-git-send-email-denis.ciocca@st.com>
References: <1370416890-4659-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 7389785..71a2c5f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -57,6 +57,11 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 			u8 *rx_array;
 			rx_array = kmalloc(byte_for_channel * num_data_channels,
 					   GFP_KERNEL);
+			if (!rx_array) {
+				len = -ENOMEM;
+				goto st_sensors_free_memory;
+			}
+
 			len = sdata->tf->read_multiple_byte(&sdata->tb,
 				sdata->dev, addr[0],
 				byte_for_channel * num_data_channels,
-- 
1.7.9.5
