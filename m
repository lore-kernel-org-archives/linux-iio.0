Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 02/12] iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
Date: Thu, 12 Jun 2014 06:54:06 +0200
Message-Id: <1402548856-3564-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 6eba301..6cf9ee1 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -105,9 +105,8 @@ enum {
  * struct ad799x_chip_info - chip specific information
  * @channel:		channel specification
  * @num_channels:	number of channels
- * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
- * @event_attrs:	pointer to the monitor event attribute group
+ * @info:		pointer to iio_info struct
  */
 struct ad799x_chip_info {
 	struct iio_chan_spec		channel[9];
-- 
1.9.1
