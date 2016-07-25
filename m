Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56572 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbcGYWlI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 18:41:08 -0400
From: Colin King <colin.king@canonical.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ad5755: fix off-by-one on devnr limit check
Date: Mon, 25 Jul 2016 23:40:01 +0100
Message-Id: <1469486401-17839-1-git-send-email-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison for devnr limits is off-by-one, the current check
allows 0 to AD5755_NUM_CHANNELS and the limit should be in fact
0 to AD5755_NUM_CHANNELS - 1.  This can lead to an out of bounds
write to pdata->dac[devnr]. Fix this by replacing > with >= on the
comparison.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0fde593..5f79682 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -655,7 +655,7 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 
 	devnr = 0;
 	for_each_child_of_node(np, pp) {
-		if (devnr > AD5755_NUM_CHANNELS) {
+		if (devnr >= AD5755_NUM_CHANNELS) {
 			dev_err(dev,
 				"There is to many channels defined in DT\n");
 			goto error_out;
-- 
2.8.1

