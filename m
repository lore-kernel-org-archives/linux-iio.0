Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:33787 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbbGERvx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 5 Jul 2015 13:51:53 -0400
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	stable@vger.kernel.org
Subject: [BUG] [PATCH] iio: mma8452: use iio event type IIO_EV_TYPE_MAG
Date: Sun,  5 Jul 2015 19:50:18 +0200
Message-Id: <1436118618-24819-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_EV_TYPE_THRESH in rising direction describes an event where the
threshold is crossed in rising direction, positive or negative values
being possible. This is not the case here.

Since the threshold is no signed value and only the magnitude is compared,
IIO_EV_TYPE_MAG is what describes the behaviour of these devices, see the
sysfs-bus-iio ABI Documentation.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: stable@vger.kernel.org
---

if we can resolve this quickly, I know what to base my work on ;)

thanks!


 drivers/iio/accel/mma8452.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e8e2077..13ea1ea 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -557,21 +557,21 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
 	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
 	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
 	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 }
@@ -644,7 +644,7 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
 
 static const struct iio_event_spec mma8452_transient_event[] = {
 	{
-		.type = IIO_EV_TYPE_THRESH,
+		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
-- 
2.1.4

