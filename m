Return-Path: <SRS0=Jp6i=JO=gmail.com=karim.eshapa@kernel.org>
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH 4/4] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt handler
Date: Fri, 29 Jun 2018 01:49:28 +0200
Message-Id: <20180628234928.4205-1-karim.eshapa@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
as GFP_KERNEL may sleep according to slab allocator.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..25c4fbc303f7 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -692,7 +692,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	unsigned int *channels;
 	int i, ret;
 
-	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
+	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_ATOMIC);
 	if (!channels)
 		return IRQ_HANDLED;
 
-- 
2.17.1
