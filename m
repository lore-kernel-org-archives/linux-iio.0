Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:47920 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbKKSjW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 11 Nov 2015 13:39:22 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 5CEF320AF5
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2015 19:39:21 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 2/3] iio: mma8452: use enum for numbering the axis
Date: Wed, 11 Nov 2015 19:38:13 +0100
Message-Id: <1447267094-2248-2-git-send-email-martink@posteo.de>
In-Reply-To: <1447267094-2248-1-git-send-email-martink@posteo.de>
References: <1447267094-2248-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the newly added enum that numbers x, y and z axis.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index dedcc1d..38652e1 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -912,30 +912,30 @@ static struct attribute_group mma8452_event_attribute_group = {
 }
 
 static const struct iio_chan_spec mma8452_channels[] = {
-	MMA8452_CHANNEL(X, 0, 12),
-	MMA8452_CHANNEL(Y, 1, 12),
-	MMA8452_CHANNEL(Z, 2, 12),
+	MMA8452_CHANNEL(X, axis_x, 12),
+	MMA8452_CHANNEL(Y, axis_y, 12),
+	MMA8452_CHANNEL(Z, axis_z, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec mma8453_channels[] = {
-	MMA8452_CHANNEL(X, 0, 10),
-	MMA8452_CHANNEL(Y, 1, 10),
-	MMA8452_CHANNEL(Z, 2, 10),
+	MMA8452_CHANNEL(X, axis_x, 10),
+	MMA8452_CHANNEL(Y, axis_y, 10),
+	MMA8452_CHANNEL(Z, axis_z, 10),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec mma8652_channels[] = {
-	MMA8652_CHANNEL(X, 0, 12),
-	MMA8652_CHANNEL(Y, 1, 12),
-	MMA8652_CHANNEL(Z, 2, 12),
+	MMA8652_CHANNEL(X, axis_x, 12),
+	MMA8652_CHANNEL(Y, axis_y, 12),
+	MMA8652_CHANNEL(Z, axis_z, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec mma8653_channels[] = {
-	MMA8652_CHANNEL(X, 0, 10),
-	MMA8652_CHANNEL(Y, 1, 10),
-	MMA8652_CHANNEL(Z, 2, 10),
+	MMA8652_CHANNEL(X, axis_x, 10),
+	MMA8652_CHANNEL(Y, axis_y, 10),
+	MMA8652_CHANNEL(Z, axis_z, 10),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-- 
2.1.4

