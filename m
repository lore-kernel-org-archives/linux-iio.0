Return-Path: <SRS0=FTHv=3T=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82260C2D0DB
	for <linux-iio@archiver.kernel.org>; Thu, 30 Jan 2020 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E520CC7
	for <linux-iio@archiver.kernel.org>; Thu, 30 Jan 2020 13:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgA3Nmn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:42:43 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53262 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3Nmm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Jan 2020 08:42:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B5E6DFB02;
        Thu, 30 Jan 2020 14:42:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NLp-z8NNH201; Thu, 30 Jan 2020 14:42:37 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CD7524091D; Thu, 30 Jan 2020 14:42:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
Date:   Thu, 30 Jan 2020 14:42:35 +0100
Message-Id: <86e272aaf6726d6d5171445e7f2df6cdbb74057f.1580391472.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1580391472.git.agx@sigxcpu.org>
References: <cover.1580391472.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This will be useful when introducing runtime pm.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b0e241aaefb4..8f198383626b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -335,17 +335,18 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = data->chip_spec->measure_light(data, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+			if (!ret)
+				ret = IIO_VAL_INT;
+			break;
 		case IIO_PROXIMITY:
 			ret = data->chip_spec->measure_proximity(data, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+			if (!ret)
+				ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type != IIO_LIGHT)
 			return -EINVAL;
-- 
2.23.0

