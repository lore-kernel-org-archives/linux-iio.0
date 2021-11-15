Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0897FC4332F
	for <linux-iio@archiver.kernel.org>; Mon, 15 Nov 2021 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FEB61882
	for <linux-iio@archiver.kernel.org>; Mon, 15 Nov 2021 14:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKOO1m (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:27:42 -0500
Received: from aposti.net ([89.234.176.197]:51242 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236300AbhKOO1J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 09:27:09 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 06/15] iio: buffer-dmaengine: Enable write support
Date:   Mon, 15 Nov 2021 14:19:16 +0000
Message-Id: <20211115141925.60164-7-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-1-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
functions provided by the buffer-dma core, to enable write support in
the buffer-dmaengine code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ac26b04aa4a9..5cde8fd81c7f 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.read = iio_dma_buffer_read,
+	.write = iio_dma_buffer_write,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
 	.data_available = iio_dma_buffer_data_available,
+	.space_available = iio_dma_buffer_space_available,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,
-- 
2.33.0

