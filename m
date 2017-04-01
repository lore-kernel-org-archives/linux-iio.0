Return-Path: <SRS0=bHRo=3J=gmail.com=singhalsimran0@kernel.org>
Date: Sat, 1 Apr 2017 19:41:53 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad5504: Remove unnecessary cast on void pointer
Message-ID: <20170401141153.GA26918@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|
- (T*)
  e
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/dac/ad5504.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 22a027d..712d86b 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -223,7 +223,7 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
 					    0,
 					    IIO_EV_TYPE_THRESH,
 					    IIO_EV_DIR_RISING),
-		       iio_get_time_ns((struct iio_dev *)private));
+		       iio_get_time_ns(private));
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4
