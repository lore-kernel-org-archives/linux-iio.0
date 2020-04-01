Return-Path: <SRS0=slhR=5R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF1C43331
	for <linux-iio@archiver.kernel.org>; Wed,  1 Apr 2020 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05342063A
	for <linux-iio@archiver.kernel.org>; Wed,  1 Apr 2020 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="UgfhwJhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgDAQ5t (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:57:49 -0400
Received: from www381.your-server.de ([78.46.137.84]:46642 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbgDAQ5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qMmfCU+ahUMs2BevCfrx+AdQfOBvj0SgwP/PbTk63nU=; b=UgfhwJhIoXc+kODByWLYpNG13M
        DHMmC43dWDOXYJv4OLPoHkphZ735DnReH0wxvmqyD6Lx1hJZ6s3Ee3HgaFxICZZX89eNmiXpEZS4a
        Qx65QENA3wtvEtvRB+uBiYA5jGRtYk9MvaLN0SiQ6gytFpMjj7NINhTmvjRrnP5RgH9jku5aFu0Na
        bCnOhJJhPPPkNk735/fOkFwxYkliehGA+0e7VnLsjQuckwKdnw6B43icWVjeSralfW8iNqWIOwHZ7
        dXUf2W3T4cuFgHAnAilZbuPVElOM8/tPB6OCChqwVLuJY6hsIEXxSvhWfnVBLf+4nx+X0SUfqzTh0
        HbwC5FwQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jJggU-0002o9-R5; Wed, 01 Apr 2020 18:57:46 +0200
Received: from [82.135.74.241] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jJggU-000TQk-HU; Wed, 01 Apr 2020 18:57:46 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Date:   Wed,  1 Apr 2020 18:57:06 +0200
Message-Id: <20200401165706.30416-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25769/Wed Apr  1 14:53:49 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO DMA buffer is a DMA buffer implementation. As such it should
include buffer_impl.h rather than buffer.h.

The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
access to the struct iio_buffer definition. The code currently only works
because all places that use buffer-dma.h include buffer_impl.h before it.

The include to buffer.h in industrialio-buffer-dma.c  can be removed since
those file does not reference any of buffer consumer functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Don't remove buffer.h include in buffer-dma.h since it is needed
	  after all.
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 1 -
 include/linux/iio/buffer-dma.h               | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index a74bd9c0587c..d348af8b9705 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -12,7 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
 #include <linux/dma-mapping.h>
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 016d8a068353..ff15c61bf319 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -11,7 +11,7 @@
 #include <linux/kref.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 
 struct iio_dma_buffer_queue;
 struct iio_dma_buffer_ops;
-- 
2.20.1

