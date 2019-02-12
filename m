Return-Path: <SRS0=KJmS=QT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A79C282C4
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF99214DA
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfBLOdv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:33:51 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:40186 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbfBLOdv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Feb 2019 09:33:51 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 09:33:50 EST
Received: from jax4mhob14.registeredsite.com (jax4mhob14.registeredsite.com [64.69.218.102])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x1CEQ2H9011869
        for <linux-iio@vger.kernel.org>; Tue, 12 Feb 2019 09:26:03 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.205])
        by jax4mhob14.registeredsite.com (8.14.4/8.14.4) with ESMTP id x1CEQ09A152003
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Tue, 12 Feb 2019 09:26:00 -0500
Received: (qmail 28747 invoked by uid 0); 12 Feb 2019 14:26:00 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 12 Feb 2019 14:26:00 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] iio/gyro/bmg160: Use millidegrees for temperature scale
Date:   Tue, 12 Feb 2019 15:25:49 +0100
Message-Id: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Standard unit for temperature is millidegrees Celcius, whereas this driver
was reporting in degrees. Fix the scale factor in the driver.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/gyro/bmg160_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca316..ad7f8cb 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -585,8 +585,9 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val2 = 500000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = 500;
+			*val2 = 0;
+			return IIO_VAL_INT;
 		case IIO_ANGL_VEL:
 		{
 			int i;
-- 
1.9.1

