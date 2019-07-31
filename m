Return-Path: <SRS0=dOhm=V4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B876C433FF
	for <linux-iio@archiver.kernel.org>; Wed, 31 Jul 2019 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A68216C8
	for <linux-iio@archiver.kernel.org>; Wed, 31 Jul 2019 21:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zTUucayY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfGaVt2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:49:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1151 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730619AbfGaVt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:49:28 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLlVoU017013;
        Wed, 31 Jul 2019 23:49:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=8a3aEas+cZij9BIWUf7YwLaNz/lw4y7WhkIuL9xUQXY=;
 b=zTUucayYiaGCL27JmwWumjzK8ipKU4thM4VYz1nQSoMOU2jPSzIuD/4PGHhleqiNZUlD
 Tm6kfF7c7jO1RBxp/iKT5rn+UMbF+/N/mMX8bVzv2Ohu1+CdRb6eUrB5sY9CrvFlSrW6
 Jzu91jwPZyr9bQPo/5QSNwYjU1RFQweC7s57/5CzaBVOfM/fozqP680+yt0pd/JRZFZi
 dNowUnSI3sJdhzgmrYNJ3jVehvTEscYPbZ85x18Bar43ka69soLpdWK9bymg1OGqer2/
 jldxJQ7pay3aCDLVw67oiGCnTq479KCseu0H4pBdc3dRn8YXuY2/AU2TipS3iKb5Li3M 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0bra6knm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:49:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C81A31;
        Wed, 31 Jul 2019 21:49:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04065777E2;
        Wed, 31 Jul 2019 23:49:21 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:49:20
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 3/4] iio:magn: preenable/postenable/predisable fixup for ST magn buffer
Date:   Wed, 31 Jul 2019 14:48:59 -0700
Message-ID: <20190731214900.15380-4-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731214900.15380-1-denis.ciocca@st.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is trying to cleanup for good the buffers operation functions.
Let's rename the goto label using operation to perform and not
where it fails.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 30 ++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 9dba93539a99..658d627dad8e 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -31,40 +31,42 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	int err;
 
 	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
 				     GFP_DMA | GFP_KERNEL);
-	if (mdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (!mdata->buffer_data)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_magn_buffer_postenable_error;
+		goto st_magn_free_buffer;
+
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_magn_buffer_predisable;
 
-	return st_sensors_set_enable(indio_dev, true);
+	return 0;
 
-st_magn_buffer_postenable_error:
+st_magn_buffer_predisable:
+	iio_triggered_buffer_predisable(indio_dev);
+st_magn_free_buffer:
 	kfree(mdata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
-	if (err < 0)
-		goto st_magn_buffer_predisable_error;
 
-	err = iio_triggered_buffer_predisable(indio_dev);
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
 
-st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
 	return err;
 }
-- 
2.22.0

