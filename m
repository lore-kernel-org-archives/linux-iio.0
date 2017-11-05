Return-Path: <SRS0=kOQ+=CD=gmail.com=harinath922@kernel.org>
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amsfield22@gmail.com,
	martink@posteo.de
Subject: [PATCH v4 2/2] iio: accel: mma8452: Rename config structs for readability
Date: Sun,  5 Nov 2017 13:00:03 -0500
Message-Id: <1509904804-4608-3-git-send-email-harinath922@gmail.com>
In-Reply-To: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Rename structs holding event configuration registers
to more appropriate names. This naming is consistent
with the event config register names given in the
mma845x and fxls8471 datasheets.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 v4:
 Shorter subject line and better description in commit message

 drivers/iio/accel/mma8452.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 16adf47..43c3a6b 100644
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
