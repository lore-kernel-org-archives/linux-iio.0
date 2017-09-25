Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36949 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934583AbdIYKkN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2017 06:40:13 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH v3 1/3] iio: accel: mma8452: Rename structs holding event configuration registers to more appropriate names.
Date: Mon, 25 Sep 2017 06:40:06 -0400
Message-Id: <1506336008-4480-2-git-send-email-harinath922@gmail.com>
In-Reply-To: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Improves code readability, no impact on functionality.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma8452.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 6194169..3472e7e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -135,7 +135,7 @@ struct mma8452_event_regs {
 		u8 ev_count;
 };
 
-static const struct mma8452_event_regs ev_regs_accel_falling = {
+static const struct mma8452_event_regs ff_mt_ev_regs = {
 		.ev_cfg = MMA8452_FF_MT_CFG,
 		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
 		.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
@@ -145,7 +145,7 @@ static const struct mma8452_event_regs ev_regs_accel_falling = {
 		.ev_count = MMA8452_FF_MT_COUNT
 };
 
-static const struct mma8452_event_regs ev_regs_accel_rising = {
+static const struct mma8452_event_regs trans_ev_regs = {
 		.ev_cfg = MMA8452_TRANSIENT_CFG,
 		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
 		.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
@@ -777,12 +777,12 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
 					& MMA8452_INT_TRANS) &&
 				(data->chip_info->enabled_events
 					& MMA8452_INT_TRANS))
-				*ev_reg = &ev_regs_accel_rising;
+				*ev_reg = &trans_ev_regs;
 			else
-				*ev_reg = &ev_regs_accel_falling;
+				*ev_reg = &ff_mt_ev_regs;
 			return 0;
 		case IIO_EV_DIR_FALLING:
-			*ev_reg = &ev_regs_accel_falling;
+			*ev_reg = &ff_mt_ev_regs;
 			return 0;
 		default:
 			return -EINVAL;
-- 
2.7.4

