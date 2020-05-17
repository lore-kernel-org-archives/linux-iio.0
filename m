Return-Path: <SRS0=lwR9=67=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F95C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 17:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF3220820
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589736733;
	bh=5poLK969/K/jZ96IVNmjTZOOLTQT4txEZjZv3qZDL2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WtXaMJC6LsZzXjkjpXprn7IiDya+8VjheiYDPfar6k+yYzM/Nlx9U/aPh8pkoBatg
	 WPTKQQOTzGicV8DCW2wILwhJYmctdNzdnJ/XXsLTsVpRdV5czw4T3dom+aVyZcqvqP
	 b5ntI7iFr5/m9hJM9FiaDcK4gQiOWZSu7YS9J76o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEQRcN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 May 2020 13:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB6A20809;
        Sun, 17 May 2020 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736732;
        bh=5poLK969/K/jZ96IVNmjTZOOLTQT4txEZjZv3qZDL2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMqQtQf1/MA7nPKmPKRmRM3Dxnd2Ku3P7GgFthBoApYUgiUP7QugJGwVYoyunmQPM
         pvtQL8YlCFZghQuDjUzqvEGsN6rAeFTzINox/+ryK3G6jGAJetsEHjMY3e8BQ5vppn
         rlSiNbeSw9apZhGfhbThFxyMNccg2vVIyFffVBkI=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 06/11] iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:55 +0100
Message-Id: <20200517173000.220819-7-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517173000.220819-1-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 16 byte s16 array on the stack   As Lars also noted
this anti pattern can involve a leak of data to userspace and that
indeed can happen here.  We close both issues by moving to
a suitable structure in the iio_priv() data with alignment
ensured by use of an explicit c structure.  This data is allocated
with kzalloc so no data can leak appart from previous readings.

Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/mb1232.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 166b3e6d7db8..5ec2d306f1c1 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -40,6 +40,11 @@ struct mb1232_data {
 	 */
 	struct completion	ranging;
 	int			irqnr;
+	/* Ensure correct alignment of data to push to IIO buffer */
+	struct {
+		s16 distance;
+		s64 ts;
+	} scan;
 };
 
 static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
@@ -113,17 +118,13 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mb1232_data *data = iio_priv(indio_dev);
-	/*
-	 * triggered buffer
-	 * 16-bit channel + 48-bit padding + 64-bit timestamp
-	 */
-	s16 buffer[8] = { 0 };
 
-	buffer[0] = mb1232_read_distance(data);
-	if (buffer[0] < 0)
+	data->scan.distance = mb1232_read_distance(data);
+	if (data->scan.distance < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   pf->timestamp);
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

