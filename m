Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E2C43219
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FD361051
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 21:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbhIBVPr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:15:47 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37715 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346973AbhIBVPp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id EEAB224000D;
        Thu,  2 Sep 2021 21:14:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 08/16] iio: adc: max1027: Simplify the _set_trigger_state() helper
Date:   Thu,  2 Sep 2021 23:14:29 +0200
Message-Id: <20210902211437.503623-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The call to max1027_enable_trigger() is the same in both cases thanks to
the 'state' variable, so factorize a little bit to simplify the code and
explain why we call this helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 7611d96fc901..9269931ca09d 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -395,11 +395,17 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	struct max1027_state *st = iio_priv(indio_dev);
 	int ret;
 
+	/*
+	 * In order to disable the convst trigger, start acquisition on
+	 * conversion register write, which basically disables triggering
+	 * conversions upon cnvst changes and thus has the effect of disabling
+	 * the external hardware trigger.
+	 */
+	ret = max1027_enable_trigger(indio_dev, state);
+	if (ret)
+		return ret;
+
 	if (state) {
-		ret = max1027_enable_trigger(indio_dev, state);
-		if (ret)
-			return ret;
-
 		/*
 		 * Scan from chan 0 to the highest requested channel.
 		 * Include temperature on demand.
@@ -412,11 +418,6 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 		ret = spi_write(st->spi, &st->reg, 1);
 		if (ret < 0)
 			return ret;
-	} else {
-		/* Start acquisition on conversion register write */
-		ret = max1027_enable_trigger(indio_dev, state);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
-- 
2.27.0

