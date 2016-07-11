Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34322 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbcGKP1A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 11:27:00 -0400
Date: Mon, 11 Jul 2016 08:26:56 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tiberiu.a.breana@intel.com, mranostay@gmail.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: proximity: as3935: set up buffer timestamps for
 non-zero values
Message-ID: <5f812b15a69ff63f65c59deb9eec75a1ef26ccfc.1468203399.git.amsfield22@gmail.com>
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
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 2e3a70e..5656deb 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -397,7 +397,7 @@ static int as3935_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 		&as3935_trigger_handler, NULL);
 
 	if (ret) {
-- 
2.1.4

