Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:43910 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754AbbIYJqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 05:46:54 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 3062B209FB
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 11:46:52 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/3] iio: dac: ad5504: leave sysfs naming to the core
Date: Fri, 25 Sep 2015 11:45:10 +0200
Message-Id: <1443174310-20428-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This shouldn't actually change anything since the core calls the events
sysfs folder "events" anyways.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/dac/ad5504.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 581ec14..e6e9756 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -214,7 +214,6 @@ static struct attribute *ad5504_ev_attributes[] = {
 
 static struct attribute_group ad5504_ev_attribute_group = {
 	.attrs = ad5504_ev_attributes,
-	.name = "events",
 };
 
 static irqreturn_t ad5504_event_handler(int irq, void *private)
-- 
2.1.4

