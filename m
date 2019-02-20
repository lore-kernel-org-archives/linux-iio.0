Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2993C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374632146E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="VKE7nCNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBTOHH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:07:07 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:25364 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfBTOHH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 09:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550671625;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JjLKcD6SybLoGGMj2NW9my+OGmD8xw5CJs25CVdSDkU=;
        b=VKE7nCNZTZrw74CSV3fpiDmUqtFnmhFfu9Dafpvle3OwO1LLszVKXiFcJYNdEx8BF2
        iuTvGYRaJb4QrFeBeTwLVrKR1nXOv0xFTH6NaHGl0Ar2PffeW5WWjX/qa4UOI2zdkTh4
        QM/wYOjEZHUKX/AJpBm/uUBaBHmFmc7yIp4YkLkWz4GCZYzwXwLR5Q9f8ju2u5i+1hGo
        bHzP6WvOL/VXWqGac6fUtIkg52wkXGppUa8plxpmWTdFckJ6970wH4WnQc7jUeEJQCd1
        9r64eodlI6wMXFsHoQiJJl793WSs9h81slVj0q/HocwnPS7XGGkz9Qt8uDyiRzwBFrBc
        HGog==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE0xEqV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:00:59 +0100 (CET)
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
Subject: [PATCH 3/9] iio: accel: bmc150: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:50 +0100
Message-Id: <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com>
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
 drivers/iio/accel/bmc150-accel-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 383c802eb5b8..9178846cfddc 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -204,6 +204,7 @@ struct bmc150_accel_data {
 	int ev_enable_state;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
+	struct iio_mount_matrix orientation;
 };
 
 static const struct {
@@ -796,6 +797,18 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 	return sprintf(buf, "%d\n", state);
 }
 
+static const struct iio_mount_matrix *
+bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	return &((struct bmc150_accel_data *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_accel_get_mount_matrix),
+	{ },
+};
+
 static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
 static IIO_CONST_ATTR(hwfifo_watermark_max,
 		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
@@ -978,6 +991,7 @@ static const struct iio_event_spec bmc150_accel_event = {
 		.shift = 16 - (bits),					\
 		.endianness = IIO_LE,					\
 	},								\
+	.ext_info = bmc150_accel_ext_info,				\
 	.event_spec = &bmc150_accel_event,				\
 	.num_event_specs = 1						\
 }
@@ -1555,6 +1569,11 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	data->regmap = regmap;
 
+	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
+				       &data->orientation);
+	if (ret)
+		return ret;
+
 	ret = bmc150_accel_chip_init(data);
 	if (ret < 0)
 		return ret;
-- 
2.19.1

