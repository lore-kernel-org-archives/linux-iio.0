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
Subject: [PATCH] iio: mcp320x: Fix occasional incorrect readings
Date: Tue,  5 May 2015 11:29:55 -0500
Message-Id: <1430843395-19446-1-git-send-email-mwelling@ieee.org>
List-ID: <linux-iio@vger.kernel.org>

Without the cacheline alignment, the readings will occasionally incorrectly
return 0.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/iio/adc/mcp320x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index efbfd12..46b98cf 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -60,7 +60,7 @@ struct mcp320x {
 	struct spi_message msg;
 	struct spi_transfer transfer[2];
 
-	u8 tx_buf;
+	u8 tx_buf ____cacheline_aligned;
 	u8 rx_buf[2];
 
 	struct regulator *reg;
-- 
1.7.9.5
