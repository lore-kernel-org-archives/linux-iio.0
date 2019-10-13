Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8300C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D679206A3
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570960171;
	bh=ZIG4b452sQEinvlbGhBWG24HjZ4Gg3aAK0imX1/iELg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Aox0g8EFdC2xalQGsAFCdz4ZsmlLNy+TINmMFR2l01/1Tor0aK6r0z4H58BfalPj9
	 sRGWJ7hP9Fmf7Hw7+/shQ0OtsvEClrEWBcFnaTYvs4zMKzqc/5AwwJRbOWQFW2ISnE
	 hvtlOyO2lMOR3v39d4hn5Xp3QUjgC4gbcQw4HRlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfJMJta (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 05:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfJMJta (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:49:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1818820673;
        Sun, 13 Oct 2019 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570960169;
        bh=ZIG4b452sQEinvlbGhBWG24HjZ4Gg3aAK0imX1/iELg=;
        h=From:To:Cc:Subject:Date:From;
        b=w7Z2bcIrgGTGB2Y2lq99kDkWl7NGKJsDnIUR8/NxTNK3vCqGk3cxS9Rrt4k8u8+7O
         Vm5G0vWH8jiRhriX+AaQEZB7Mx9NqL8ND0fstRTqblcRPgXoShB9jd2hYXFtc8pKSM
         pJsvp1UUQhlU94jakk2SwmnnKjHMKI9rVLb8SZTE=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Date:   Sun, 13 Oct 2019 10:47:22 +0100
Message-Id: <20191013094722.1429243-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Highlighted by sparse:
CHECK   drivers/iio/adc/ti-adc084s021.c
drivers/iio/adc/ti-adc084s021.c:79:26: warning: incorrect type in assignment (different base types)
drivers/iio/adc/ti-adc084s021.c:79:26:    expected unsigned short [unsigned] [short] [usertype] <noident>
drivers/iio/adc/ti-adc084s021.c:79:26:    got restricted __be16 <noident>
drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted __be16
drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted __be16
drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted __be16
drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted __be16

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mårten Lindahl <martenli@axis.com>
---
 drivers/iio/adc/ti-adc084s021.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index bdedf456ee05..42966f2eb3d8 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -68,7 +68,7 @@ static int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
 {
 	int n_words = (adc->spi_trans.len >> 1) - 1; /* Discard first word */
 	int ret, i = 0;
-	u16 *p = data;
+	__be16 *p = data;
 
 	/* Do the transfer */
 	ret = spi_sync(adc->spi, &adc->message);
@@ -87,6 +87,7 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
 {
 	struct adc084s021 *adc = iio_priv(indio_dev);
 	int ret;
+	__be16 value;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -101,13 +102,13 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
 		}
 
 		adc->tx_buf[0] = channel->channel << 3;
-		ret = adc084s021_adc_conversion(adc, val);
+		ret = adc084s021_adc_conversion(adc, &value);
 		iio_device_release_direct_mode(indio_dev);
 		regulator_disable(adc->reg);
 		if (ret < 0)
 			return ret;
 
-		*val = be16_to_cpu(*val);
+		*val = be16_to_cpu(value);
 		*val = (*val >> channel->scan_type.shift) & 0xff;
 
 		return IIO_VAL_INT;
-- 
2.23.0

