Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A2C433E0
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5223B2077D
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545385;
	bh=CS28lnsBO+exFHAiBdT6MA64+4LUqQXykTjN1/Az7R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wc5qUh2g3vgO1eT5Z95lVJUKgHInSWxkd5kBdtqDZPkoHdLckwVMtgNvGGIITnQw5
	 KqD0Vm+HBnD6nZcPM8rEQC9wc5h/5JGLmbUG9C8yxbRo1hS30PU+ybvJq5k/Q/H2mq
	 i1OoHt4ubEchQS1x259lo2PCsgMpqORo2l7/k98Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFGP4Y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgFGP4Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:24 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282BB2076A;
        Sun,  7 Jun 2020 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545384;
        bh=CS28lnsBO+exFHAiBdT6MA64+4LUqQXykTjN1/Az7R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2NMQfbUF+XgzhHP3ztWhKIDIL+k8yFhJwMTohLvnMMvbebhkxJ1rdNoDaEIG5ODT
         l0SeAvhLeRABjTHpYaj6YZ0GsppkOvy6y5jJsBiRum2NVkpL4AlbgBADxkW/xA7AyG
         yBQAG/rwAcGx3LiH7BvR32AHyp5StzAqH2MBjQso=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 07/32] iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
Date:   Sun,  7 Jun 2020 16:53:43 +0100
Message-Id: <20200607155408.958437-8-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607155408.958437-1-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
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
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

The explicit alignment of ts is necessary to ensure consistent
padding for x86_32 in which the ts would otherwise be 4 byte aligned.

Fixes: 283d26917ad6 ("iio: chemical: ccs811: Add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/ccs811.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 2b007e7568b2..60dd87e96f5f 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -78,6 +78,11 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	/* Ensures correct alignment of timestamp if present */
+	struct {
+		s16 channels[2];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static const struct iio_chan_spec ccs811_channels[] = {
@@ -327,17 +332,17 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ccs811_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	s16 buf[8]; /* s16 eCO2 + s16 TVOC + padding + 8 byte timestamp */
 	int ret;
 
-	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA, 4,
-					    (u8 *)&buf);
+	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA,
+					    sizeof(data->scan.channels),
+					    (u8 *)data->scan.channels);
 	if (ret != 4) {
 		dev_err(&client->dev, "cannot read sensor data\n");
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 
 err:
-- 
2.26.2

