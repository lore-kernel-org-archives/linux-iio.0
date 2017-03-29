Return-Path: <SRS0=023H=3G=gmail.com=singhalsimran0@kernel.org>
Date: Wed, 29 Mar 2017 19:41:31 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH] iio: accel: bma180: Set up buffer timestamps for non-zero
 values
Message-ID: <20170329141131.GA23646@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Use the iio_pollfunc_store_time parameter during triggered buffer set-up
to get valid timestamps.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index efc6773..4ae5c80 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -762,7 +762,7 @@ static int bma180_probe(struct i2c_client *client,
 			goto err_trigger_free;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 			bma180_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
-- 
2.7.4
