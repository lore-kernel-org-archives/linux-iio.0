Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:56337 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbbF3L23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 30 Jun 2015 07:28:29 -0400
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net, jic23@kernel.org
Cc: christoph.muellner@theobroma-systems.com,
	martin.kepplinger@theobroma-systems.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/2] iio: mma8452: change iio event type to IIO_EV_TYPE_MAG
Date: Tue, 30 Jun 2015 13:26:42 +0200
Message-Id: <1435663602-29868-3-git-send-email-martink@posteo.de>
In-Reply-To: <1435663602-29868-1-git-send-email-martink@posteo.de>
References: <1435663602-29868-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_EV_TYPE_THRESH with the RISING event assumes a signed threshold value
and describes the crossing in the rising direction, positive or negative
values.

This is not the case here. It's the magnitude of the acceleration
value that is compared and IIO_EV_TYPE_MAG describes the behaviour of these
devices.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index a5fd3ff..1c48d9d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -604,21 +604,21 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
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
@@ -695,7 +695,7 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
 
 static const struct iio_event_spec mma8452_transient_event[] = {
 	{
-		.type = IIO_EV_TYPE_THRESH,
+		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
@@ -706,7 +706,7 @@ static const struct iio_event_spec mma8452_transient_event[] = {
 
 static const struct iio_event_spec mma8452_motion_event[] = {
 	{
-		.type = IIO_EV_TYPE_THRESH,
+		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
-- 
2.1.4

