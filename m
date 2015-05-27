Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 27 May 2015 11:24:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] iio: light: signedness bug in stk3310_write_raw()
Message-ID: <20150527082425.GB19423@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

"index" needs to be signed for the error handling to work.

Fixes: be9e6229d676 ('iio: light: Add support for Sensortek STK3310')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e79b9d8..fee4297 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -370,7 +370,7 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	int ret;
-	unsigned int index;
+	int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
