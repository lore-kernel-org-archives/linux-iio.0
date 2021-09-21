Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B216C433F5
	for <linux-iio@archiver.kernel.org>; Tue, 21 Sep 2021 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6343261178
	for <linux-iio@archiver.kernel.org>; Tue, 21 Sep 2021 11:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhIULzt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:55:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49381 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhIULzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:47 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0274324001F;
        Tue, 21 Sep 2021 11:54:17 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 11/16] iio: adc: max1027: Separate the IRQ handler from the read logic
Date:   Tue, 21 Sep 2021 13:54:03 +0200
Message-Id: <20210921115408.66711-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create a max1027_read_scan() helper which will make clearer the future IRQ
handler updates (no functional change).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index c7663e5dd38a..a044f4b598e0 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -439,22 +439,37 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static irqreturn_t max1027_trigger_handler(int irq, void *private)
+static int max1027_read_scan(struct iio_dev *indio_dev)
 {
-	struct iio_poll_func *pf = private;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int scanned_chans;
+	int ret;
 
 	scanned_chans = fls(*indio_dev->active_scan_mask) - 1;
 	if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
 		scanned_chans++;
 
 	/* fill buffer with all channel */
-	spi_read(st->spi, st->buffer, scanned_chans * 2);
+	ret = spi_read(st->spi, st->buffer, scanned_chans * 2);
+	if (ret < 0)
+		return ret;
 
 	iio_push_to_buffers(indio_dev, st->buffer);
 
+	return 0;
+}
+
+static irqreturn_t max1027_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	int ret;
+
+	ret = max1027_read_scan(indio_dev);
+	if (ret)
+		dev_err(&indio_dev->dev,
+			"Cannot read scanned values (%d)\n", ret);
+
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.27.0

