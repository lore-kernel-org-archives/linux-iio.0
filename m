Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 13 Aug 2015 23:21:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] iio: tsl4531: fix error handling in tsl4531_check_id()
Message-ID: <20150813202027.GA4385@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The caller expect us to return zero if the ID doesn't match.  Negative
error codes are treated as success.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 2697918..730fd2b 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -151,7 +151,7 @@ static int tsl4531_check_id(struct i2c_client *client)
 {
 	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	switch (ret >> TSL4531_ID_SHIFT) {
 	case TSL45311_ID:
