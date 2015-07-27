Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48505 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbbG0OJw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:09:52 -0400
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
Subject: [PATCH 7/8] iio: mma8452: leave sysfs namings to the iio core
Date: Mon, 27 Jul 2015 16:08:14 +0200
Message-Id: <1438006095-26920-8-git-send-email-martink@posteo.de>
In-Reply-To: <1438006095-26920-1-git-send-email-martink@posteo.de>
References: <1438006095-26920-1-git-send-email-martink@posteo.de>
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
index dc66815..918ab59 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -747,7 +747,6 @@ static struct attribute *mma8452_event_attributes[] = {
 
 static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
-	.name = "events",
 };
 
 #define MMA8452_CHANNEL(axis, idx, bits) { \
-- 
2.1.4

