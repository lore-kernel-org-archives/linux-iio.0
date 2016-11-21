Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: accel: mma8452: define unsigned return values where appropriate
Date: Mon, 21 Nov 2016 20:53:54 +0100
Message-Id: <1479758034-19220-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

smatch warned:
	sval_binop_signed: invalid divide LLONG_MIN/-1

and this fixes it. It's actually good to have, in order to avoid accidental
checking for negative return values here.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/accel/mma8452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 0e865a1..fba146f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -248,7 +248,7 @@ static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
 	return -EINVAL;
 }
 
-static int mma8452_get_odr_index(struct mma8452_data *data)
+static unsigned int mma8452_get_odr_index(struct mma8452_data *data)
 {
 	return (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
 			MMA8452_CTRL_DR_SHIFT;
@@ -260,7 +260,7 @@ static const int mma8452_samp_freq[8][2] = {
 };
 
 /* Datasheet table: step time "Relationship with the ODR" (sample frequency) */
-static const int mma8452_transient_time_step_us[4][8] = {
+static const unsigned int mma8452_transient_time_step_us[4][8] = {
 	{ 1250, 2500, 5000, 10000, 20000, 20000, 20000, 20000 },  /* normal */
 	{ 1250, 2500, 5000, 10000, 20000, 80000, 80000, 80000 },  /* l p l n */
 	{ 1250, 2500, 2500, 2500, 2500, 2500, 2500, 2500 },	  /* high res*/
-- 
2.1.4
