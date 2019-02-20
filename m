Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3EC10F01
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC142147A
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bXrOvUQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfBTOHC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:07:02 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:19389 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTOHC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 09:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550671620;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=n3NVFxThOA4c9quyqd6mpLDMi9kj62qkxH5lY19ulz0=;
        b=bXrOvUQKg04aWmoAYXzAQfvthnGRPNcMN/NV1SgRUSYXFDmEcRHl6FsKGSYNTFMuQu
        X+9Crbi+VNqI8sZx3tO7MAw/u4Gxr9NhkW+cojL19VmOYRDdmoPsWbrFxD6YMK8W25d4
        9hGuTDIFnmt4cfQ1nQYo4tmJendIF0rK1HDhQdNqdsEFKsRt4B/9cLgWPemEqGMwCx75
        Sbw06wGiOfJjoP8ltIGdKnshqwgMh1j+OZqhsHR9NSWLo2HHf9L4FEhZAd4+CcL84NR9
        4hDDPzZAg08AjcJVTQc+q2hTGUGFB5Yrkfw9Os3qXZ9rqbGmEjoVPgm+bral/XNCnDAb
        ++SQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE11EqZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:01:01 +0100 (CET)
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
Subject: [PATCH 7/9] iio: gyro: itg3200: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:54 +0100
Message-Id: <5184e7ed452ca66f48db6ba34de8f2bd607ead24.1550671256.git.hns@goldelico.com>
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
 drivers/iio/gyro/itg3200_core.c  | 18 ++++++++++++++++++
 include/linux/iio/gyro/itg3200.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index 7adecb562c81..b4bf721d309f 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -242,6 +242,18 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct iio_mount_matrix *
+itg3200_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	return &((struct itg3200 *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info itg3200_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, itg3200_get_mount_matrix),
+	{ },
+};
+
 #define ITG3200_ST						\
 	{ .sign = 's', .realbits = 16, .storagebits = 16, .endianness = IIO_BE }
 
@@ -255,6 +267,7 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
 	.address = ITG3200_REG_GYRO_ ## _mod ## OUT_H, \
 	.scan_index = ITG3200_SCAN_GYRO_ ## _mod, \
 	.scan_type = ITG3200_ST, \
+	.ext_info = itg3200_ext_info, \
 }
 
 static const struct iio_chan_spec itg3200_channels[] = {
@@ -297,6 +310,11 @@ static int itg3200_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	ret = of_iio_read_mount_matrix(&client->dev, "mount-matrix",
+				&st->orientation);
+	if (ret)
+		return ret;
+
 	i2c_set_clientdata(client, indio_dev);
 	st->i2c = client;
 
diff --git a/include/linux/iio/gyro/itg3200.h b/include/linux/iio/gyro/itg3200.h
index 2a820850f284..0a30fddccfb3 100644
--- a/include/linux/iio/gyro/itg3200.h
+++ b/include/linux/iio/gyro/itg3200.h
@@ -104,6 +104,7 @@
 struct itg3200 {
 	struct i2c_client	*i2c;
 	struct iio_trigger	*trig;
+	struct iio_mount_matrix orientation;
 };
 
 enum ITG3200_SCAN_INDEX {
-- 
2.19.1

