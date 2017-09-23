Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36960 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdIWU4j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 16:56:39 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH 2/2] iio: accel: mma8452: Fix code style warning for unsigned int declarations
Date: Sat, 23 Sep 2017 16:56:30 -0400
Message-Id: <1506200190-11115-3-git-send-email-harinath922@gmail.com>
In-Reply-To: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
References: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace 'unsigned' with 'unsigned int'
to improve code readability.

Issue found by checkpatch.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma8452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 4a33a26..6194169 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1088,8 +1088,8 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
 }
 
 static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
-				  unsigned reg, unsigned writeval,
-				  unsigned *readval)
+				  unsigned int reg, unsigned int writeval,
+				  unsigned int *readval)
 {
 	int ret;
 	struct mma8452_data *data = iio_priv(indio_dev);
-- 
2.7.4

