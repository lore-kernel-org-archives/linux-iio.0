Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD515C433EF
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AC2610C8
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347017AbhIBVPq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:15:46 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45861 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbhIBVPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:43 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 35F5B240008;
        Thu,  2 Sep 2021 21:14:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 06/16] iio: adc: max1027: Rename a helper
Date:   Thu,  2 Sep 2021 23:14:27 +0200
Message-Id: <20210902211437.503623-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make it clear that the *_set_trigger_state() hook is responsible for
cnvst based conversions by renaming the helper. This may avoid
confusions with software trigger support that is going to be
introduced.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max1027.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 3c41d2c0ed2a..efea5ea14615 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -375,7 +375,7 @@ static int max1027_validate_trigger(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
+static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct max1027_state *st = iio_priv(indio_dev);
@@ -436,7 +436,7 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 static const struct iio_trigger_ops max1027_trigger_ops = {
 	.validate_device = &iio_trigger_validate_own_device,
-	.set_trigger_state = &max1027_set_trigger_state,
+	.set_trigger_state = &max1027_set_cnvst_trigger_state,
 };
 
 static const struct iio_info max1027_info = {
-- 
2.27.0

