Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	devel@driverdev.osuosl.org,
	jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: fix pointer cast warning
Date: Sat, 14 Jul 2012 18:23:24 +0200
Message-Id: <1342283004-15118-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

fix compile warning reported by Fengguang Wu:

drivers/iio/light/adjd_s311.c: In function 'adjd_s311_trigger_handler':
drivers/iio/light/adjd_s311.c:188:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/iio/light/adjd_s311.c:188:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

   185              }
   186
   187              if (indio_dev->scan_timestamp)
 > 188                      *(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
   189                              = time_ns;
   190              iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
   191

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/iio/light/adjd_s311.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index e485142..1cbb449 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -185,7 +185,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 	}
 
 	if (indio_dev->scan_timestamp)
-		*(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
+		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
 			= time_ns;
 	iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
 
-- 
1.7.9.5
