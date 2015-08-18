Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 18 Aug 2015 12:16:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch v3] iio: tsl4531: fix error handling in tsl4531_check_id()
Message-ID: <20150818091633.GC3965@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55D1F82F.8020303@ti.com>
List-ID: <linux-iio@vger.kernel.org>

The tsl4531_check_id() function returned 1 on "found" and 0 on "not
found" and negative error codes on failure.  This was non-standard and
bug prone.  The caller treated all non-zero values including error codes
as "found".

This patch fixes it by changing the tsl4531_check_id() to return zero on
success or a negative error code, and updates the caller.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v3: slightly different fix again
v2: different fix

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 2697918..cf94ec7 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -158,9 +158,9 @@ static int tsl4531_check_id(struct i2c_client *client)
 	case TSL45313_ID:
 	case TSL45315_ID:
 	case TSL45317_ID:
-		return 1;
-	default:
 		return 0;
+	default:
+		return -ENODEV;
 	}
 }
 
@@ -180,9 +180,10 @@ static int tsl4531_probe(struct i2c_client *client,
 	data->client = client;
 	mutex_init(&data->lock);
 
-	if (!tsl4531_check_id(client)) {
+	ret = tsl4531_check_id(client);
+	if (ret) {
 		dev_err(&client->dev, "no TSL4531 sensor\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONTROL,
