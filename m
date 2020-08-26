Return-Path: <SRS0=Zetw=CE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792DC433E1
	for <linux-iio@archiver.kernel.org>; Wed, 26 Aug 2020 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4772067C
	for <linux-iio@archiver.kernel.org>; Wed, 26 Aug 2020 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgHZJzM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:55:12 -0400
Received: from mailout02.rmx.de ([62.245.148.41]:45527 "EHLO mailout02.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgHZJzL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 05:55:11 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout02.rmx.de (Postfix) with ESMTPS id 4Bc1SB5vZszNkKC;
        Wed, 26 Aug 2020 11:55:06 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4Bc1RS0phwz2TSDJ;
        Wed, 26 Aug 2020 11:54:28 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.64) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 26 Aug
 2020 11:54:03 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] iio: light: as73211: Fix AS73211_CREG1_GAIN_1
Date:   Wed, 26 Aug 2020 11:52:48 +0200
Message-ID: <20200826095247.16368-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.64]
X-RMX-ID: 20200826-115432-4Bc1RS0phwz2TSDJ-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wrong value was introduced during review process.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
Patch against jic23/iio.git, branch testing

 drivers/iio/light/as73211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 3383aaacbf52..e76747b99b92 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -56,7 +56,7 @@
 #define AS73211_AGEN_MUT(x)       FIELD_PREP(AS73211_AGEN_MUT_MASK, (x))
 
 #define AS73211_CREG1_GAIN_MASK   GENMASK(7, 4)
-#define AS73211_CREG1_GAIN_1      13
+#define AS73211_CREG1_GAIN_1      11
 #define AS73211_CREG1_TIME_MASK   GENMASK(3, 0)
 
 #define AS73211_CREG3_CCLK_MASK   GENMASK(1, 0)
@@ -217,7 +217,7 @@ static void as73211_integration_time_calc_avail(struct as73211_data *data)
 
 static unsigned int as73211_gain(struct as73211_data *data)
 {
-	/* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
+	/* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
 	return BIT(AS73211_CREG1_GAIN_1 - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
 }
 
@@ -473,7 +473,7 @@ static int _as73211_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || !is_power_of_2(val) || val2)
 			return -EINVAL;
 
-		/* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
+		/* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
 		reg_bits = AS73211_CREG1_GAIN_1 - ilog2(val);
 		if (!FIELD_FIT(AS73211_CREG1_GAIN_MASK, reg_bits))
 			return -EINVAL;
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

