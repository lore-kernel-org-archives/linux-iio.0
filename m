Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:51488
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753066AbeFGSxG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Jun 2018 14:53:06 -0400
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Harinath Nampally <harinath922@gmail.com>,
        Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
Date: Thu,  7 Jun 2018 21:52:50 +0300
Message-Id: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Interrupts are ignored if no event bit is set in the status status
register and this breaks the buffer interface. No data is shown when
running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
crazy.

Fix by not returning IRQ_NONE if DRDY is set.

Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
multiple events")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Perhaps this whole early-exit check could be dropped? It is not clear
how it helps.

If for some models we want to ignore unsupported events then maybe this
should be checked for each individual bit. Instead of

if (src & MMA8452_INT_FF_MT) {

Check for:

if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA8452_INT_FF_MT))

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7a2da7f9d4dc..5485b35fe553 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
 		return IRQ_NONE;
 
-	if (!(src & data->chip_info->enabled_events))
+	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
 		return IRQ_NONE;
 
 	if (src & MMA8452_INT_DRDY) {
 		iio_trigger_poll_chained(indio_dev->trig);
 		ret = IRQ_HANDLED;
-- 
2.17.1

