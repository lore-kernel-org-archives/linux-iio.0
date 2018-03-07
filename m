Return-Path: <SRS0=6AR7=F5=gmail.com=arushisinghal19971997@kernel.org>
Date: Wed, 7 Mar 2018 18:47:17 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: Remove unnecessary cast on void pointer
Message-ID: <20180307131717.GA12326@seema-Inspiron-15-3567>
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

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bfe180a..bf76a86 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -254,7 +254,7 @@ static const struct attribute_group ad7816_attribute_group = {
 static irqreturn_t ad7816_event_handler(int irq, void *private)
 {
 	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
-		       iio_get_time_ns((struct iio_dev *)private));
+		       iio_get_time_ns(private));
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4
