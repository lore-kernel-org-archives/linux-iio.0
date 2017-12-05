Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] iio: dac: mcp4725: Remove unneeded conversions to bool
Date: Tue, 5 Dec 2017 13:12:01 -0600
Message-ID: <20171205191201.21572-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index afa856d10c26..8b5aad4c32d9 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -476,7 +476,7 @@ static int mcp4725_probe(struct i2c_client *client,
 		goto err_disable_vref_reg;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
-	data->powerdown = pd > 0 ? true : false;
+	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 	if (data->id == MCP4726)
-- 
2.15.0
