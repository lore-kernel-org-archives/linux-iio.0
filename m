Return-Path: <SRS0=0VFF=7D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74203C433DF
	for <linux-iio@archiver.kernel.org>; Thu, 21 May 2020 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3942720759
	for <linux-iio@archiver.kernel.org>; Thu, 21 May 2020 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590083729;
	bh=qZmqlxEXBN+2lwP8EI9Q7NjOkjJaN5E6FX5FqRcBsWY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yhwSftM8PQPIYw1hKpFAafk+UivbNTqIVkdFTc2BpGDqQv3QdLFhA5KmNiVP3ylbq
	 DPGWdIDu36j6VoS19KHqbgDKqdtSkD5mTzFq9Djb59VEd0e/Eo+csbkGcEAsgHQ1KV
	 /c4csmlsWva71UAzovhkmkTqdhp3hwMr30dQ6oFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgEURz2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 May 2020 13:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgEURz2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 13:55:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C6A206D4;
        Thu, 21 May 2020 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083728;
        bh=qZmqlxEXBN+2lwP8EI9Q7NjOkjJaN5E6FX5FqRcBsWY=;
        h=From:To:Cc:Subject:Date:From;
        b=XfXn6i8aYSjJMH1aSpgt2+AtCuR/1dzyZX7B6eHbAgryECM44IrwN+VJMW1ExAcSA
         NMfXpj58ke9Fw9ZgGGAJthqZR/h50A/gTR9mJEENyH6ClnyU3eFhBfM+7KkLdLkPIO
         W1Wg9/zrG7Q4t+LrnUQjrjllR206OlvX70Y0MPVg=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH] iio: make iio_device_get_drvdata take a const struct iio_dev *.
Date:   Thu, 21 May 2020 18:53:22 +0100
Message-Id: <20200521175322.247947-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As this just calls dev_get_drvdata underneath which is happy with
a const struct device * we should change and avoid potentially
casting away a const in order to then put it back again.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..e846a0a7001e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -669,7 +669,7 @@ static inline void iio_device_set_drvdata(struct iio_dev *indio_dev, void *data)
  *
  * Returns the data previously set with iio_device_set_drvdata()
  */
-static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
+static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 {
 	return dev_get_drvdata(&indio_dev->dev);
 }
-- 
2.26.2

