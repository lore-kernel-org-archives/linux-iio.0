Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:43194 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbbIYJzm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 05:55:42 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 9801D209FD
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 11:55:40 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: adc: ad799x: leave sysfs naming to the core
Date: Fri, 25 Sep 2015 11:54:01 +0200
Message-Id: <1443174841-25782-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This shouldn't change anything since the core calls the events folder
"events" anyways.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/adc/ad799x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b99de00..01d7158 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -528,7 +528,6 @@ static struct attribute *ad799x_event_attributes[] = {
 
 static struct attribute_group ad799x_event_attrs_group = {
 	.attrs = ad799x_event_attributes,
-	.name = "events",
 };
 
 static const struct iio_info ad7991_info = {
-- 
2.1.4

