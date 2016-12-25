Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33462 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754008AbcLYUEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 15:04:37 -0500
Received: by mail-oi0-f68.google.com with SMTP id f201so43119460oib.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 12:04:37 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCHv4 2/8] Fixed variables not being consistently lower case
Date: Sun, 25 Dec 2016 13:56:40 -0600
Message-Id: <1482696216-8013-3-git-send-email-scott@matheina.com>
In-Reply-To: <1482696216-8013-1-git-send-email-scott@matheina.com>
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Across the file, variables were sometimes upper case, some times
lower case, this fix addresses a few of the instances with this
inconsistency.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 08413a8..13d9ed2 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1755,55 +1755,55 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 		time = iio_get_time_ns(indio_dev);
 		if (stat1 & BIT(0))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_RISING),
+				       iio_unmod_event_code(iio_temp, 0,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_rising),
 				       time);
 		if (stat1 & BIT(1))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_FALLING),
+				       iio_unmod_event_code(iio_temp, 0,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_falling),
 				       time);
 		if (stat1 & BIT(2))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_RISING),
+				       iio_unmod_event_code(iio_temp, 1,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_rising),
 				       time);
 		if (stat1 & BIT(3))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_FALLING),
+				       iio_unmod_event_code(iio_temp, 1,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_falling),
 				       time);
 		if (stat1 & BIT(5))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 1,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_EITHER),
+				       iio_unmod_event_code(iio_voltage, 1,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_either),
 				       time);
 		if (stat1 & BIT(6))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 2,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_EITHER),
+				       iio_unmod_event_code(iio_voltage, 2,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_either),
 				       time);
 		if (stat1 & BIT(7))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 3,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_EITHER),
+				       iio_unmod_event_code(iio_voltage, 3,
+							    iio_ev_type_thresh,
+							    iio_ev_dir_either),
 				       time);
 		}
 	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+				       iio_unmod_event_code(iio_voltage,
 							    0,
-							    IIO_EV_TYPE_THRESH,
-							    IIO_EV_DIR_RISING),
+							    iio_ev_type_thresh,
+							    iio_ev_dir_rising),
 				       iio_get_time_ns(indio_dev));
 	}

--
2.7.4

