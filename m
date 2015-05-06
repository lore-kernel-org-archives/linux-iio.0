Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
From: Michael Welling <mwelling@ieee.org>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	san@rosetechnology.dk,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH v2] iio: mcp320x: Fix occasional incorrect readings
Date: Wed,  6 May 2015 11:49:17 -0500
Message-Id: <1430930957-14588-1-git-send-email-mwelling@ieee.org>
List-ID: <linux-iio@vger.kernel.org>

Without the cacheline alignment, the readings will occasionally incorrectly
return 0.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---

v2: Moved buffers to the end of the mcp320x struct per suggestion to keep
them on their own cacheline.

 drivers/iio/adc/mcp320x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index efbfd12..8d9c9b9 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -60,12 +60,12 @@ struct mcp320x {
 	struct spi_message msg;
 	struct spi_transfer transfer[2];
 
-	u8 tx_buf;
-	u8 rx_buf[2];
-
 	struct regulator *reg;
 	struct mutex lock;
 	const struct mcp320x_chip_info *chip_info;
+
+	u8 tx_buf ____cacheline_aligned;
+	u8 rx_buf[2];
 };
 
 static int mcp320x_channel_to_tx_data(int device_index,
-- 
1.7.9.5
