Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 7/9] iio: mma8452: change iio event type to IIO_EV_TYPE_MAG
Date: Sat,  4 Jul 2015 15:55:08 +0200
Message-Id: <1436018110-3903-8-git-send-email-martink@posteo.de>
In-Reply-To: <1436018110-3903-1-git-send-email-martink@posteo.de>
References: <1436018110-3903-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

IIO_EV_TYPE_THRESH in rising direction describes an event where the
threshold is crossed in rising direction, positive or negative values
being possible. This is not the case here.

Since the threshold is no signed value and only the magnitude is compared,
IIO_EV_TYPE_MAG is what describes the behaviour of these devices, see the
sysfs-bus-iio ABI Documentation.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7f6e3b4..e23ebd0 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -598,21 +598,21 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
 	if (src & data->chip_info->ev_src_xe)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
 	if (src & data->chip_info->ev_src_ye)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
 	if (src & data->chip_info->ev_src_ze)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
-						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       ts);
 }
@@ -689,7 +689,7 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
 
 static const struct iio_event_spec mma8452_transient_event[] = {
 	{
-		.type = IIO_EV_TYPE_THRESH,
+		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
@@ -700,7 +700,7 @@ static const struct iio_event_spec mma8452_transient_event[] = {
 
 static const struct iio_event_spec mma8452_motion_event[] = {
 	{
-		.type = IIO_EV_TYPE_THRESH,
+		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
-- 
2.1.4
