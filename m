Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73133C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3312146E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mCfeC4O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfBTOHC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:07:02 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:34003 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBTOHC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 09:07:02 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 09:07:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550671620;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tAOISD3iWzCXIygNiYBq/rqPTyFXJizn2hEMyYbGHpg=;
        b=mCfeC4O8Qro1VxCzVl7oFSsTYEgAsgXLYxdBSkuUuZ2wkvB0mppTLrP5KkDF9aW4Vm
        kStlqa+xR0kNt+Fu9Nd3nDAWHW6J2I0V50Eop6lf+aSxP8uEnS5S1H3uCnvzge6MZJtw
        dh3DGPx1LY7XVl988x0lRb/xaf7jvhMig15whXBnpgmOZ2ws37xd45VH4hAezem9qwWH
        lgVtx1gDArrA1Y7prRazMxzC6Ehjs6JLLWc/Z9k4rzCu/lmCvBw2QBGB8Dijee2HDR6Y
        7ikRPt0SgRPNhNNQaDN7OtIt7OkxRGeGG918/nmzGlKshvMBD8GbjtiIybTUjYWngAvS
        O1/w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE11Eqa
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
Subject: [PATCH 8/9] iio: magnetometer: bmc150: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:55 +0100
Message-Id: <2600653840b79a9817b68c17b47ef9b043137d20.1550671256.git.hns@goldelico.com>
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
 drivers/iio/magnetometer/bmc150_magn.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d91cb845e3d6..48e3a16432b4 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -143,6 +143,7 @@ struct bmc150_magn_data {
 	 */
 	struct mutex mutex;
 	struct regmap *regmap;
+	struct iio_mount_matrix orientation;
 	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
 	s32 buffer[6];
 	struct iio_trigger *dready_trig;
@@ -612,6 +613,18 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
 	return len;
 }
 
+static const struct iio_mount_matrix *
+bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	return &((struct bmc150_magn_data *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmc150_magn_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_magn_get_mount_matrix),
+	{ },
+};
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
 
 static struct attribute *bmc150_magn_attributes[] = {
@@ -638,6 +651,7 @@ static const struct attribute_group bmc150_magn_attrs_group = {
 		.storagebits = 32,					\
 		.endianness = IIO_LE					\
 	},								\
+	.ext_info = bmc150_magn_ext_info,				\
 }
 
 static const struct iio_chan_spec bmc150_magn_channels[] = {
@@ -861,6 +875,11 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	data->irq = irq;
 	data->dev = dev;
 
+	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	if (!name && ACPI_HANDLE(dev))
 		name = bmc150_magn_match_acpi_device(dev);
 
-- 
2.19.1

