Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33456 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeDTTag (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:30:36 -0400
Date: Fri, 20 Apr 2018 21:30:32 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 07/13] staging: iio: ad2s1200: Improve readability with
 be16_to_cpup
Message-ID: <22b031a8baafad18c3ba2136f8d43fbb4083c1cf.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The manual states that the data is contained in the upper 12 bits
of the 16 bits read by spi. The code that extracts these 12 bits
is correct for both be and le machines, but this is not clear
from a first glance.

To improve readability the relevant expressions are replaced
with equivalent expressions that use be16_to_cpup.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 0a5fc9917e32..11ed9c7332e6 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -57,7 +57,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad2s1200_state *st = iio_priv(indio_dev);
 	int ret = 0;
-	s16 vel;
+	u16 vel;
 
 	mutex_lock(&st->lock);
 	gpio_set_value(st->sample, 0);
@@ -73,14 +73,13 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 		return ret;
 	}
 
+	vel = be16_to_cpup((__be16 *)st->rx);
 	switch (chan->type) {
 	case IIO_ANGL:
-		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+		*val = vel >> 4;
 		break;
 	case IIO_ANGL_VEL:
-		vel = (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-		vel = sign_extend32(vel, 11);
-		*val = vel;
+		*val = sign_extend32((s16)vel >> 4, 11);
 		break;
 	default:
 		mutex_unlock(&st->lock);
-- 
2.16.2

