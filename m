Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33711 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030859AbcGKPZP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 11:25:15 -0400
Date: Mon, 11 Jul 2016 08:25:07 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tiberiu.a.breana@intel.com, mranostay@gmail.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bma220_spi: set up buffer timestamps for
 non-zero values
Message-ID: <6097ec724dae1e1fc5a9838b840ba9710a494a6d.1468203399.git.amsfield22@gmail.com>
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
 drivers/iio/accel/bma220_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 1098d10..5099f29 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -253,7 +253,7 @@ static int bma220_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 					 bma220_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-- 
2.1.4

