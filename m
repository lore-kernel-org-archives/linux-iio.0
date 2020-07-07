Return-Path: <SRS0=vYQU=AS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B26C433E0
	for <linux-iio@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9042F20720
	for <linux-iio@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155601;
	bh=nDDzab1Qtd7CrcV08n8lx+NRUphDaDMkyRYG5qKLPYE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hWTpuza41QC5EX3FkL0RSsQe2OWoLehghvy/nHtrKo+x6WW2aksnglPOhvFDaXQo3
	 XOjlXxZpCPy0OG5qGciYpUh0IyaOP8ysHryBFYMZBeqjc2pFYaPOqAc5SCICDWt6bg
	 XTJOUPRIbtYnHa7hXOrklGqNuSXtZVeVf6CjFNt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGGVAB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVAB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07531206F6;
        Tue,  7 Jul 2020 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594155600;
        bh=nDDzab1Qtd7CrcV08n8lx+NRUphDaDMkyRYG5qKLPYE=;
        h=From:To:Cc:Subject:Date:From;
        b=XB6tAYGQJlhUS+naFyIvdQt2ZT+Wdyuvj2Dx/IrTKZRis1rKaf+w8mlYE40KK2yJm
         0MlPDvepDM+tDOTEqGUDgtDxSdd/XjrRw9KazQeCsy/N5IcrJgL7tJlSQMkZv3OxL2
         VCNLR4OTYrzVBbbmJcA+vXixVQ16zGgEXirke3y0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:magn:hmc5843 Fix parameter to IIO_ENUM
Date:   Tue,  7 Jul 2020 21:57:57 +0100
Message-Id: <20200707205757.410931-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Passing a boolean to this macro is incorrect. If intent is the attribute
applied to all channels it should be IIO_SHARED_BY_ALL.
That will result in no prefix, as per the hmc5843 ABI docs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 1474ba63babe..9703bcf38fd8 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
 };
 
 static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
-	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
+	IIO_ENUM("meas_conf", IIO_SHARED_BY_ALL, &hmc5843_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ }
@@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
 };
 
 static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
-	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
+	IIO_ENUM("meas_conf", IIO_SHARED_BY_ALL, &hmc5983_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ }
-- 
2.27.0

