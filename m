Return-Path: <SRS0=8+PZ=OF=osadl.org=hofrat@kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint() failure
Date: Mon, 26 Nov 2018 10:39:04 +0100
Message-Id: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignments to  attr.name  are not safe if not checked. On error
ad7280_attr_init() returns a negative return so -ENOMEM should be
OK here (passed on as return value of the probe function).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
---

Problem located with an experimental coccinelle script

As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
unreadable in this case the  (var  == NULL)  variant was used. Not
sure if there are objections against this (checkpatch.pl issues
a CHECK on this).

Patch was compile tested with: x86_64_defconfig + STAGING=y
SPI=y, IIO=y, AD7280=m

Patch is against 4.20-rc4 (localversion-next is next-20181126)

 drivers/staging/iio/adc/ad7280a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0bb9ab1..5b87530 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -584,6 +584,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_switch_en",
 					       index, index + 1);
+			if (st->iio_attr[cnt].dev_attr.attr.name  == NULL)
+				return -ENOMEM;
+
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 			cnt++;
@@ -600,6 +603,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_timer",
 					       index, index + 1);
+			if (st->iio_attr[cnt].dev_attr.attr.name == NULL)
+				return -ENOMEM;
+
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 		}
-- 
2.1.4
