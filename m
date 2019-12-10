Return-Path: <SRS0=JBba=2A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C007C2D0BF
	for <linux-iio@archiver.kernel.org>; Tue, 10 Dec 2019 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52035206D5
	for <linux-iio@archiver.kernel.org>; Tue, 10 Dec 2019 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013101;
	bh=zSqE42JyAS+kAssgLSdJJ9gq6wzq3ZS2rsSKxFgJUDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cRsSiSqjx6MtP2tcntnHpARq3d/mkxNvV1KS0crjC8I/5g1K/lKy6hy5RrtXStbfB
	 C8ne3G/pccB4I4rRJ++K2i6XUaP6/mmz0TJv+EOzR+8R+brWmz8WJVG6mkouJ8R+cP
	 XX/M+gY2C0m13iFLobMeGxVXTqni7+qtJDgIbOz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfLJVY7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfLJVKo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61751246AF;
        Tue, 10 Dec 2019 21:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012244;
        bh=zSqE42JyAS+kAssgLSdJJ9gq6wzq3ZS2rsSKxFgJUDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbhO+tlI7NDjY+W9d+KLUpggrz5jdQar3MLRPXMmdum0xvaYCvDwElbYk12kbFli7
         p5KFo49w+C5SKQnEN1P9WAbndQfRR8bGXbT+BroTa/7MwwdVn6Vhg9z7aK+AareeDc
         0vuNwS3HcGoplAGpxWm2UufTywBGr1SZG9aV2Eoc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 192/350] iio: dln2-adc: fix iio_triggered_buffer_postenable() position
Date:   Tue, 10 Dec 2019 16:04:57 -0500
Message-Id: <20191210210735.9077-153-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit a7bddfe2dfce1d8859422124abe1964e0ecd386e ]

The iio_triggered_buffer_postenable() hook should be called first to
attach the poll function. The iio_triggered_buffer_predisable() hook is
called last (as is it should).

This change moves iio_triggered_buffer_postenable() to be called first. It
adds iio_triggered_buffer_predisable() on the error paths of the postenable
hook.
For the predisable hook, some code-paths have been changed to make sure
that the iio_triggered_buffer_predisable() hook gets called in case there
is an error before it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/dln2-adc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 5fa78c273a258..65c7c9329b1c3 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -524,6 +524,10 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 	u16 conflict;
 	unsigned int trigger_chan;
 
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&dln2->mutex);
 
 	/* Enable ADC */
@@ -537,6 +541,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 				(int)conflict);
 			ret = -EBUSY;
 		}
+		iio_triggered_buffer_predisable(indio_dev);
 		return ret;
 	}
 
@@ -550,6 +555,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 		if (ret < 0) {
 			dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
+			iio_triggered_buffer_predisable(indio_dev);
 			return ret;
 		}
 	} else {
@@ -557,12 +563,12 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int ret;
+	int ret, ret2;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
 
 	mutex_lock(&dln2->mutex);
@@ -577,12 +583,14 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 	ret = dln2_adc_set_port_enabled(dln2, false, NULL);
 
 	mutex_unlock(&dln2->mutex);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
-		return ret;
-	}
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (ret == 0)
+		ret = ret2;
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
-- 
2.20.1

