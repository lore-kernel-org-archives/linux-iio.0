Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19AFC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AA92146E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="PiYF7MVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBTOHQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:07:16 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:22722 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfBTOHQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 09:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550671634;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+rQcdnByN85IlKxFe3UXL2+usgDxL4sMCHhdK2LMnFI=;
        b=PiYF7MVjkRgb7S0VKf6kvVU6FdMlm1ccM/DrXwj61ey2bvtmoBKVXCdEpopKDBtFwU
        20N4Rc7A9SUd/Owd81FXbZGy6QJDK8p6MZhYVWvtiZrAeLsddMc/SHsyNs+JNCD0aMS2
        CR0vUcWVPU6C97lKtKB2FMi/suV6uomwCSG8ngamW3l1lsZ2jyYmFqbv6FhxjqnTGOAD
        /9hisKsOvUo9zQV08fDYziSf91wgoYfmkH4FGEDD8fznWH/97g4xhcuyHdtcaO0dXkST
        fhTvaZD9a9XyMHYLwAnYOPQafB23zPLHXbCZtqYmWtJAQyrWuUiWgFgQCdynpRn6vRGW
        x2TA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE10EqY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:01:00 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] iio: gyro: bmg160: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:53 +0100
Message-Id: <56495e0c2fe1b943430c26e14924a436718af9b9.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch allows to read a mount-matrix device tree
property and report to user-space or in-kernel iio
clients.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/gyro/bmg160_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca31628a93..7ae59be9a5ef 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -102,6 +102,7 @@ struct bmg160_data {
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
+	struct iio_mount_matrix orientation;
 	struct mutex mutex;
 	s16 buffer[8];
 	u32 dps_range;
@@ -794,6 +795,18 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static const struct iio_mount_matrix *
+bmg160_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	return &((struct bmg160_data *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmg160_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmg160_get_mount_matrix),
+	{ },
+};
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
 
 static IIO_CONST_ATTR(in_anglvel_scale_available,
@@ -831,6 +844,7 @@ static const struct iio_event_spec bmg160_event = {
 		.storagebits = 16,					\
 		.endianness = IIO_LE,					\
 	},								\
+	.ext_info = bmg160_ext_info,					\
 	.event_spec = &bmg160_event,					\
 	.num_event_specs = 1						\
 }
@@ -1075,6 +1089,11 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	data->irq = irq;
 	data->regmap = regmap;
 
+	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	ret = bmg160_chip_init(data);
 	if (ret < 0)
 		return ret;
-- 
2.19.1

