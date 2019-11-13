Return-Path: <SRS0=FlZf=ZF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90AC43331
	for <linux-iio@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E99222D0
	for <linux-iio@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfKMKJm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:09:42 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:46566 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKMKJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 05:09:42 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id RN9f2100P5USYZQ06N9fXv; Wed, 13 Nov 2019 11:09:39 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iUpal-0002J6-BY; Wed, 13 Nov 2019 11:09:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iUpal-0007Bx-8o; Wed, 13 Nov 2019 11:09:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iio: adc: max9611: Make enum relations more future proof
Date:   Wed, 13 Nov 2019 11:09:38 +0100
Message-Id: <20191113100938.27604-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The relations between enum values and array indices values are currently
not enforced by the code, which makes them fragile w.r.t. future
changes.

Fix this by:
  1. Using designated array initializers, to make sure array indices and
     enums values match,
  2. Linking max9611_csa_gain enum values to the corresponding
     max9611_conf_ids enum values, as the latter is cast to the former
     in max9611_read_csa_voltage().

No change in generated code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/max9611.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index b0755f25356d700d..cb306ff1a5d6a0b2 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -114,22 +114,17 @@ enum max9611_conf_ids {
  *		      where data shall be read from
  */
 static const unsigned int max9611_mux_conf[][2] = {
-	/* CONF_SENSE_1x */
-	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
-	/* CONF_SENSE_4x */
-	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
-	/* CONF_SENSE_8x */
-	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
-	/* CONF_IN_VOLT */
-	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
-	/* CONF_TEMP */
-	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
+	[CONF_SENSE_1x]	= { MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
+	[CONF_SENSE_4x]	= { MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
+	[CONF_SENSE_8x]	= { MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
+	[CONF_IN_VOLT]	= { MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
+	[CONF_TEMP]	= { MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
 };
 
 enum max9611_csa_gain {
-	CSA_GAIN_1x,
-	CSA_GAIN_4x,
-	CSA_GAIN_8x,
+	CSA_GAIN_1x = CONF_SENSE_1x,
+	CSA_GAIN_4x = CONF_SENSE_4x,
+	CSA_GAIN_8x = CONF_SENSE_8x,
 };
 
 enum max9611_csa_gain_params {
@@ -147,18 +142,9 @@ enum max9611_csa_gain_params {
  * value; use this structure to retrieve the correct LSB and offset values.
  */
 static const unsigned int max9611_gain_conf[][2] = {
-	{ /* [0] CSA_GAIN_1x */
-		MAX9611_CSA_1X_LSB_nV,
-		MAX9611_CSA_1X_OFFS_RAW,
-	},
-	{ /* [1] CSA_GAIN_4x */
-		MAX9611_CSA_4X_LSB_nV,
-		MAX9611_CSA_4X_OFFS_RAW,
-	},
-	{ /* [2] CSA_GAIN_8x */
-		MAX9611_CSA_8X_LSB_nV,
-		MAX9611_CSA_8X_OFFS_RAW,
-	},
+	[CSA_GAIN_1x] = { MAX9611_CSA_1X_LSB_nV, MAX9611_CSA_1X_OFFS_RAW, },
+	[CSA_GAIN_4x] = { MAX9611_CSA_4X_LSB_nV, MAX9611_CSA_4X_OFFS_RAW, },
+	[CSA_GAIN_8x] = { MAX9611_CSA_8X_LSB_nV, MAX9611_CSA_8X_OFFS_RAW, },
 };
 
 enum max9611_chan_addrs {
-- 
2.17.1

