Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:50167 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbbLOQqT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 15 Dec 2015 11:46:19 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 76B8820AEE
	for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2015 17:46:18 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 2/3] iio: mma8452: use enum for channel index
Date: Tue, 15 Dec 2015 17:45:00 +0100
Message-Id: <1450197901-9826-3-git-send-email-martink@posteo.de>
In-Reply-To: <1450197901-9826-1-git-send-email-martink@posteo.de>
References: <1450197901-9826-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This gets rid of some magic numbers by adding an enum.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 162bbef..ccc632a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -143,6 +143,13 @@ struct mma_chip_info {
 	u8 ev_count;
 };
 
+enum {
+	idx_x,
+	idx_y,
+	idx_z,
+	idx_ts,
+};
+
 static int mma8452_drdy(struct mma8452_data *data)
 {
 	int tries = 150;
@@ -816,31 +823,31 @@ static struct attribute_group mma8452_event_attribute_group = {
 }
 
 static const struct iio_chan_spec mma8452_channels[] = {
-	MMA8452_CHANNEL(X, 0, 12),
-	MMA8452_CHANNEL(Y, 1, 12),
-	MMA8452_CHANNEL(Z, 2, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8452_CHANNEL(X, idx_x, 12),
+	MMA8452_CHANNEL(Y, idx_y, 12),
+	MMA8452_CHANNEL(Z, idx_z, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
 };
 
 static const struct iio_chan_spec mma8453_channels[] = {
-	MMA8452_CHANNEL(X, 0, 10),
-	MMA8452_CHANNEL(Y, 1, 10),
-	MMA8452_CHANNEL(Z, 2, 10),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8452_CHANNEL(X, idx_x, 10),
+	MMA8452_CHANNEL(Y, idx_y, 10),
+	MMA8452_CHANNEL(Z, idx_z, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
 };
 
 static const struct iio_chan_spec mma8652_channels[] = {
-	MMA8652_CHANNEL(X, 0, 12),
-	MMA8652_CHANNEL(Y, 1, 12),
-	MMA8652_CHANNEL(Z, 2, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8652_CHANNEL(X, idx_x, 12),
+	MMA8652_CHANNEL(Y, idx_y, 12),
+	MMA8652_CHANNEL(Z, idx_z, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
 };
 
 static const struct iio_chan_spec mma8653_channels[] = {
-	MMA8652_CHANNEL(X, 0, 10),
-	MMA8652_CHANNEL(Y, 1, 10),
-	MMA8652_CHANNEL(Z, 2, 10),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8652_CHANNEL(X, idx_x, 10),
+	MMA8652_CHANNEL(Y, idx_y, 10),
+	MMA8652_CHANNEL(Z, idx_z, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
 };
 
 enum {
-- 
2.1.4

