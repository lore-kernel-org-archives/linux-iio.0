Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B2C55178
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9071C20731
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604169101;
	bh=AQQPLmLXrA1DR2XyDrR/4spukAO5L8cfh4AIrsyfBPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IP6EVJnKKInH/LyFum7ELV6YFdM35m7NZm9pm/6UoaZfYcnox0GY02bWBTFjpo5Ot
	 +4YS9qAn/XjPlB9lbC55LKRhdQ3/rLXXT8pac4qsQg8XAQ9qq+dE5d6UGuQYmSV6Bx
	 A3HKncYoLhdPYrTWI5dqc7Rp/+iEKDLNRrz37cv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgJaSbl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFD720724;
        Sat, 31 Oct 2020 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169100;
        bh=AQQPLmLXrA1DR2XyDrR/4spukAO5L8cfh4AIrsyfBPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHJlbquaHfXaRo4vdPpM09DjBxXHnsMyDUgrtBGdFVAIcQGvryc6IpKKROg7g63XB
         wD9z3NWtH5Xv4totgkwYih07Pdf9JjMJ7wv/NzP3kBpOg5MpZpZrKD/foVfIkr7Cxx
         7eYrJqAeEy7ype/3zTV+lvz4hAAMJ/OOKk7vgrhc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jandy Gou <qingsong.gou@ck-telecom.com>
Subject: [PATCH 6/7] dt-bindings:iio:magnetometer:memsic,mmc35240: move to trivial-devices.yaml
Date:   Sat, 31 Oct 2020 18:29:21 +0000
Message-Id: <20201031182922.743153-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Extremely simple binding so no need to maintain a separate file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jandy Gou <qingsong.gou@ck-telecom.com>
---
 .../bindings/iio/magnetometer/mmc35240.txt          | 13 -------------
 .../devicetree/bindings/trivial-devices.yaml        |  2 ++
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt b/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
deleted file mode 100644
index a01235c7fa15..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* MEMSIC MMC35240 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "memsic,mmc35240"
-  - reg : the I2C address of the magnetometer
-
-Example:
-
-mmc35240@30 {
-        compatible = "memsic,mmc35240";
-        reg = <0x30>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 015905312a0f..172bf7e19401 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -134,6 +134,8 @@ properties:
           - maxim,max31730
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
+            # MEMSIC magnetometer
+          - memsic,mmc35240
             # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
             # Measurement Specialities I2C temperature and humidity sensor
-- 
2.28.0

