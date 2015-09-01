Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:36297 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbbIALzP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Sep 2015 07:55:15 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id CA4F220BDA
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2015 13:47:17 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 6/6] iio: mma8452: leave sysfs namings to the iio core
Date: Tue,  1 Sep 2015 13:45:13 +0200
Message-Id: <1441107913-4112-7-git-send-email-martink@posteo.de>
In-Reply-To: <1441107913-4112-1-git-send-email-martink@posteo.de>
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This doesn't actually change anything since the core names the sysfs folder
for the iio event attributes "events" anyways. It only leaves the job to the
core.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15d50c9..1eccc2d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -772,7 +772,6 @@ static struct attribute *mma8452_event_attributes[] = {
 
 static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
-	.name = "events",
 };
 
 #define MMA8452_CHANNEL(axis, idx, bits) { \
-- 
2.1.4

