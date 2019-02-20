Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D68CC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290D2147A
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550687040;
	bh=lYGfJpYLNnnp7CHqcE5YIq/veFJuIhIRZfTjzCT7OII=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qpTa2QQDw9viRvvcYjCuHRpuFSRom9RByzdSLlCW2NcRWnzo2saSRn8/srsQzDqST
	 2LU1hfHhn9RxD2PGlcA2iUveNOQaRwA+ukVe1wqq1KcLx3QkCb0+OAnf6T4qLHFFDL
	 jxhmkMeMT0eLsko3Yg3OnbbV94dRH8Ul9H0o6db8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfBTSX7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfBTSX7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 13:23:59 -0500
Received: from localhost.localdomain (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACE0206B7;
        Wed, 20 Feb 2019 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550687038;
        bh=lYGfJpYLNnnp7CHqcE5YIq/veFJuIhIRZfTjzCT7OII=;
        h=From:To:Cc:Subject:Date:From;
        b=1owYn4ik0WJ7rN7kQXZP6e5sMwapF9BR6zDumjm3E/Cd8L5RQ7o2lKStV1oUkaCAb
         cNhOfa7mDkFkvonwVUw1wnB/Ju0YT6kqr4GABM4n0Ejb5GUkQNonT27Yv156vIAPLw
         iRDoTWDqvdlulSMUwRcS69W+XcAMhjuaBKt2eH70=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:dac:ad5064 mlock cleanup - move to a local lock.
Date:   Wed, 20 Feb 2019 18:23:44 +0000
Message-Id: <20190220182344.19236-1-jic23@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

indio_dev->mlock is intended to protect state transitions in
the core. It's scope is tightly defined. For device specific
uses such as those made here, we should define a local lock
allowing the scope of the lock to be defined near to what it
is protecting.

These mlock changes can be non obvious, but given we don't do
anything other than direct for DACs, these ones are easy to do.

If anyone wants to help with this particular effort it would
be most welcome!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5064.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 2f98cb2a3b96..6c3ba143839b 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -112,6 +112,8 @@ struct ad5064_state {
 	bool				use_internal_vref;
 
 	ad5064_write_func		write;
+	/* Lock used to maintain consistency between cached and dev state */
+	struct mutex lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -248,11 +250,11 @@ static int ad5064_set_powerdown_mode(struct iio_dev *indio_dev,
 	struct ad5064_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->pwr_down_mode[chan->channel] = mode + 1;
 
 	ret = ad5064_sync_powerdown_mode(st, chan);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -291,11 +293,11 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->pwr_down[chan->channel] = pwr_down;
 
 	ret = ad5064_sync_powerdown_mode(st, chan);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret ? ret : len;
 }
 
@@ -349,12 +351,12 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = ad5064_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
 				chan->address, val, chan->scan_type.shift);
 		if (ret == 0)
 			st->dac_cache[chan->channel] = val;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -856,6 +858,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 		return  -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
 	dev_set_drvdata(dev, indio_dev);
 
 	st->chip_info = &ad5064_chip_info_tbl[type];
-- 
2.20.1

