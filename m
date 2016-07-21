Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19953 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbcGUP0t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 11:26:49 -0400
From: Phil Turnbull <phil.turnbull@oracle.com>
Cc: Phil Turnbull <phil.turnbull@oracle.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: iio: ad5933: Return correct value for AD5933_OUT_RANGE.
Date: Thu, 21 Jul 2016 11:23:13 -0400
Message-Id: <20160721152313.16832-1-phil.turnbull@oracle.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The 'break' statement after calling ad5933_cmd only breaks out of the
'for' loop, which then unconditionally sets the return value to -EINVAL.
Move the initialisation of 'ret' so we return the correct value.

Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9f43976..34a6990 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -419,6 +419,7 @@ static ssize_t ad5933_store(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
+		ret = -EINVAL;
 		for (i = 0; i < 4; i++)
 			if (val == st->range_avail[i]) {
 				st->ctrl_hb &= ~AD5933_CTRL_RANGE(0x3);
@@ -426,7 +427,6 @@ static ssize_t ad5933_store(struct device *dev,
 				ret = ad5933_cmd(st, 0);
 				break;
 			}
-		ret = -EINVAL;
 		break;
 	case AD5933_IN_PGA_GAIN:
 		if (sysfs_streq(buf, "1")) {
-- 
2.9.0.rc2

