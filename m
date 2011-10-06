Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 6 Oct 2011 09:15:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Bryan Freed <bfreed@chromium.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: [patch 2/2] Staging: iio/light/tsl2563: fix compile warning
Message-ID: <20111006061536.GB14701@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

This fixes a compile warning:
drivers/staging/iio/light/tsl2563.c:696:2:
	warning: initialization from incompatible pointer type [enabled by defau=
lt]
drivers/staging/iio/light/tsl2563.c:696:2:
	warning: (near initialization for =E2=80=98tsl2563_info.write_event_valu=
e=E2=80=99) [enabled by default]

The tsl2563_write_thresh() function returns zero on success and error
codes on failure, so nothing is lost by making the return type int
instead of ssize_t.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/li=
ght/tsl2563.c
index 8977f58..a5e08b3 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -569,7 +569,7 @@ static int tsl2563_read_thresh(struct iio_dev *indio_=
dev,
 	return 0;
 }
=20
-static ssize_t tsl2563_write_thresh(struct iio_dev *indio_dev,
+static int tsl2563_write_thresh(struct iio_dev *indio_dev,
 				  u64 event_code,
 				  int val)
 {
