Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbaG1LTb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:19:31 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH 5/5] staging: iio: adis16240: fix sparse warnings regarding incorrect argument type
Date: Mon, 28 Jul 2014 14:18:33 +0300
Message-Id: <1406546313-23031-6-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Silence the following sparse warnings by changing cast from u16 to
__be16:

  CHECK   drivers/staging/iio/accel/adis16240_core.c
drivers/staging/iio/accel/adis16240_core.c:128:51: warning: incorrect
type in argument 3 (different signedness)
drivers/staging/iio/accel/adis16240_core.c:128:51:    expected unsigned
short [usertype] *val
drivers/staging/iio/accel/adis16240_core.c:128:51:    got signed short
*<noident>
drivers/staging/iio/accel/adis16240_core.c:142:51: warning: incorrect
type in argument 3 (different signedness)
drivers/staging/iio/accel/adis16240_core.c:142:51:    expected unsigned
short [usertype] *val
drivers/staging/iio/accel/adis16240_core.c:142:51:    got signed short
*<noident>

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 7fbaba4..1360099 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -491,7 +491,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_ANGL:
-		pos = be16_to_cpup((u16 *)st->rx);
+		pos = be16_to_cpup((__be16 *) st->rx);
 		if (st->hysteresis)
 			pos >>= 16 - st->resolution;
 		*val = pos;
@@ -499,7 +499,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_ANGL_VEL:
 		negative = st->rx[0] & 0x80;
-		vel = be16_to_cpup((s16 *)st->rx);
+		vel = be16_to_cpup((__be16 *) st->rx);
 		vel >>= 16 - st->resolution;
 		if (vel & 0x8000) {
 			negative = (0xffff >> st->resolution) << st->resolution;
-- 
1.9.1

