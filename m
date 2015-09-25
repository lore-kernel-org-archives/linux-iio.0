Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:40408 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbbIYJxt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 05:53:49 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id B478B20A47
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 11:53:47 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: lars@metafoo.de, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: adc: max1363: leave sysfs naming to the core
Date: Fri, 25 Sep 2015 11:52:11 +0200
Message-Id: <1443174731-25727-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This shouldn't actually change anything since the core calls the events
sysfs folder "events" anyways.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/adc/max1363.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 1b3b74b..929508e 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1007,7 +1007,6 @@ static struct attribute *max1363_event_attributes[] = {
 
 static struct attribute_group max1363_event_attribute_group = {
 	.attrs = max1363_event_attributes,
-	.name = "events",
 };
 
 static int max1363_update_scan_mode(struct iio_dev *indio_dev,
-- 
2.1.4

