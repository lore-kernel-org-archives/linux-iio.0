Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<dan.carpenter@oracle.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: ad9523: Fix argument type mismatch
Date: Fri, 8 Jun 2012 13:04:51 +0200
Message-ID: <1339153491-23423-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

drivers/iio/frequency/ad9523.c:378 ad9523_vco_out_map()
	 warn: value 2 can't fit into 1 'out'

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/frequency/ad9523.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 7272924..43f47d9 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -361,7 +361,7 @@ static int ad9523_io_update(struct iio_dev *indio_dev)
 }
 
 static int ad9523_vco_out_map(struct iio_dev *indio_dev,
-			      unsigned ch, bool out)
+			      unsigned ch, unsigned out)
 {
 	struct ad9523_state *st = iio_priv(indio_dev);
 	int ret;
-- 
1.7.0.4
