Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F .
 Davis" <afd@ti.com>
Subject: [PATCH] iio: dac: mcp4725: Remove unneeded conversions to bool
Date: Fri, 1 Jul 2016 09:33:52 -0500
Message-ID: <20160701143352.17224-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index cca935c..c3bb3fd 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -361,7 +361,7 @@ static int mcp4725_probe(struct i2c_client *client,
 		return err;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
-	data->powerdown = pd > 0 ? true : false;
+	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
-- 
2.9.0
