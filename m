Return-Path: <SRS0=JBba=2A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06403C2D0C5
	for <linux-iio@archiver.kernel.org>; Tue, 10 Dec 2019 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCE1206D5
	for <linux-iio@archiver.kernel.org>; Tue, 10 Dec 2019 21:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013125;
	bh=tkOpwSDV7vgPsGvpRYsdLPmzvmcFNmPQMjROjg37NxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2SqclBAlFvshbzMH0sr5brNxOOaMmamHwB8WoMntlNJPSMTIadHwR3xi5VbZM9hJx
	 BYgEPRdxTy/CEsprY92DsQwXyPvr7Iix5nvoTmvWqqCsML65xqlLlF6AnX3i6i8D3P
	 CGYwvxUC4j4xAZdy2TzNcupGnEdqY6nltj2kUFh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfLJVZX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbfLJVZW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Dec 2019 16:25:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30135214AF;
        Tue, 10 Dec 2019 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013121;
        bh=tkOpwSDV7vgPsGvpRYsdLPmzvmcFNmPQMjROjg37NxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfMzogzpHHFnAlDSkWsxik+dq+vflGj96EXBRuy+K8dXYFWDOm8CPKWbt24llueLU
         NQIxV5O/PTeSZQ9CNYNnw3dqX9JyokdOC2RIWN+ZZONbxtnNgsaDRwTqNnZNALtEzn
         ZJIp+Pbkkq2asw0VIpbaio0Y21KY6dkb8S4Ad5fE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 008/292] iio: max31856: add missing of_node and parent references to iio_dev
Date:   Tue, 10 Dec 2019 16:20:27 -0500
Message-Id: <20191210212511.11392-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210212511.11392-1-sashal@kernel.org>
References: <20191210212511.11392-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrea Merello <andrea.merello@gmail.com>

[ Upstream commit 505ea3ada665c466d0064b11b6e611b7f995517d ]

Adding missing indio_dev->dev.of_node references so that, in case multiple
max31856 are present, users can get some clues to being able to distinguish
each of them. While at it, add also the missing parent reference.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/max31856.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index f184ba5601d94..73ed550e3fc95 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -284,6 +284,8 @@ static int max31856_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->info = &max31856_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max31856_channels;
-- 
2.20.1

