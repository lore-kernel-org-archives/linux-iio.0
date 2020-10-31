Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B47C5517A
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8EB20853
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151863;
	bh=3VVLUi4wlIzQzCDCMT93AnsiDsNg8FKNZYkMTif4bQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQafkNA4NmrW2kP4TDxcFVLMkDKBjZzEJlkoq61buGFdYy1ZjJ54rJ5xBhFROmcEw
	 D2KGYC5MKUc8tbVTaT46ThdSs92kpJ4UkQ/2kdqpyXe+9RhWEzAVNcF5XAn0FdD1MY
	 4J4ZA9e85KBerdqKXKpnjIQNAoLtkx+E2ZY8G5mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgJaNoW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgJaNoW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 338F520723;
        Sat, 31 Oct 2020 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151861;
        bh=3VVLUi4wlIzQzCDCMT93AnsiDsNg8FKNZYkMTif4bQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRjtbkYE5PgMSRNBOpjkVaXCz5tjbdi4ayP4cLQHzcLxl5+xtp06kcDU6uTSLZxoP
         oZCXannz/ZQvqTIigsCzyDRYbUlSdkWHvTZvH7/ngZfIxXGK6pQZE7ijoSHk7S3woF
         WoWqd8nYWqXN05nIDytSqq4d6Ge3qFWslXXqUpD8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 26/29] dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
Date:   Sat, 31 Oct 2020 13:41:07 +0000
Message-Id: <20201031134110.724233-27-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The existing binding description brings little value and the similar
meas,* parts are in trivial-devices.yaml so move this one there
to join them.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/iio/temperature/tsys01.txt       | 19 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt b/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
deleted file mode 100644
index 0d5cc5595d0c..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* TSYS01 - Measurement Specialties temperature sensor
-
-Required properties:
-
-	- compatible: should be "meas,tsys01"
-	- reg: I2C address of the sensor (changeable via CSB pin)
-
-		------------------------
-		| CSB | Device Address |
-		------------------------
-		   1         0x76
-		   0	     0x77
-
-Example:
-
-tsys01@76 {
-	compatible = "meas,tsys01";
-	reg = <0x76>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8d8eadbab473..cb4fd8f29675 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -144,6 +144,8 @@ properties:
           - meas,ms8607-humidity
             # Measurement Specialities temp and pressure part of ms8607 device
           - meas,ms8607-temppressure
+            # Measurement Specialties temperature sensor
+          - meas,tsys01
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.28.0

