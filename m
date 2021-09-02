Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FD5C433EF
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6D461051
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbhIBVPj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:15:39 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57995 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhIBVPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:39 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 624F4240006;
        Thu,  2 Sep 2021 21:14:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 01/16] iio: adc: max1027: Fix style
Date:   Thu,  2 Sep 2021 23:14:22 +0200
Message-Id: <20210902211437.503623-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Follow checkpatch.pl's main advices before hacking into the driver, mainly:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
CHECK: Comparison to NULL could be written "!foo"
CHECK: Alignment should match open parenthesis

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index b753658bb41e..5c4633a54b30 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -327,8 +327,8 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 }
 
 static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
-				      unsigned reg, unsigned writeval,
-				      unsigned *readval)
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
 {
 	struct max1027_state *st = iio_priv(indio_dev);
 	u8 *val = (u8 *)st->buffer;
@@ -424,7 +424,7 @@ static int max1027_probe(struct spi_device *spi)
 	pr_debug("%s: probe(spi = 0x%p)\n", __func__, spi);
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL) {
+	if (!indio_dev) {
 		pr_err("Can't allocate iio device\n");
 		return -ENOMEM;
 	}
@@ -443,9 +443,9 @@ static int max1027_probe(struct spi_device *spi)
 	indio_dev->available_scan_masks = st->info->available_scan_masks;
 
 	st->buffer = devm_kmalloc_array(&indio_dev->dev,
-				  indio_dev->num_channels, 2,
-				  GFP_KERNEL);
-	if (st->buffer == NULL) {
+					indio_dev->num_channels, 2,
+					GFP_KERNEL);
+	if (!st->buffer) {
 		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
 		return -ENOMEM;
 	}
@@ -462,7 +462,7 @@ static int max1027_probe(struct spi_device *spi)
 
 		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
 						  indio_dev->name);
-		if (st->trig == NULL) {
+		if (!st->trig) {
 			ret = -ENOMEM;
 			dev_err(&indio_dev->dev,
 				"Failed to allocate iio trigger\n");
-- 
2.27.0

