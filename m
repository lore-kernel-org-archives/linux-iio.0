Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Dan Carpenter <dan.carpenter@oracle.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] Staging: iio/dac/ad5360.c: signedness bug in ad5360_read_raw()
Date: Tue, 15 Nov 2011 16:58:14 +0100
Message-ID: <1321372694-5948-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1321372694-5948-1-git-send-email-lars@metafoo.de>
References: <1321372694-5948-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

ad5360_get_channel_vref() returns an int and scale_uv should be the
same.  Making it unsigned here breaks the error handling.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5360.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index c5bf582..012d714 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -371,8 +371,8 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	unsigned int ofs_index;
+	int scale_uv;
 	int ret;
 
 	switch (m) {
-- 
1.7.7.1
