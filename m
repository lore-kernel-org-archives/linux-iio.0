Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35234 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223AbcGKP0P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 11:26:15 -0400
Date: Mon, 11 Jul 2016 08:26:13 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tiberiu.a.breana@intel.com, mranostay@gmail.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: humidity: am2315: set up buffer timestamps for
 non-zero values
Message-ID: <b246c9e7acf284069789cce4228b8d0e1733bbc8.1468203399.git.amsfield22@gmail.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1468203399.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the iio_pollfunc_store_time parameter during triggered buffer
set-up to get valid timestamps.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/humidity/am2315.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 3e200f6..ff96b6d 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -244,7 +244,7 @@ static int am2315_probe(struct i2c_client *client,
 	indio_dev->channels = am2315_channels;
 	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 					 am2315_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-- 
2.1.4

