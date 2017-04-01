Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35005 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdDAOQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 10:16:34 -0400
Date: Sat, 1 Apr 2017 19:46:24 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: Remove unnecessary cast on void pointer
Message-ID: <20170401141624.GA31145@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|
- (T*)
  e
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index e11653d..f570b48 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -364,7 +364,7 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
-	struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
+	struct st_lsm6dsx_hw *hw = private;
 	struct st_lsm6dsx_sensor *sensor;
 	int i;
 
@@ -388,7 +388,7 @@ static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
-	struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
+	struct st_lsm6dsx_hw *hw = private;
 	int count;
 
 	mutex_lock(&hw->fifo_lock);
-- 
2.7.4

