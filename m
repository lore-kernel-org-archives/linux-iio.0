Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Dan Carpenter <dan.carpenter@oracle.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] Staging: iio/dac/ad5064.c: signedness bug in ad5064_read_raw()
Date: Tue, 15 Nov 2011 16:58:13 +0100
Message-ID: <1321372694-5948-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

regulator_get_voltage() returns an int so "scale_uv" should be an
int.  Making it unsigned here breaks the error handling.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5064.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index a701063..867e4ab 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -280,8 +280,8 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	unsigned int vref;
+	int scale_uv;
 
 	switch (m) {
 	case 0:
-- 
1.7.7.1
