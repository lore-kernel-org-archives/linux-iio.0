Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34361C4742C
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CAA2071A
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151824;
	bh=XhYT2AOhH58Can+mXfLz18ftGCjw/6Y9cju2fRNLQMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B11EsaRdV9lPKPk7lNB9fzBQzC83kKn3dS+CMxhUsMUqYK0UIxna2gmHvMWjw3eMA
	 a28V277c/DyHAeoLcqFxrQUh3MwuZpGaT33vkqGdrIfWC8mJf1jZIQ6ZMq2dxiVLt+
	 URs7j2dPyh96//XE4DBDZdFs2t7bu6JCjEAAEQw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJaNnn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgJaNnn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:43 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F202074F;
        Sat, 31 Oct 2020 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151822;
        bh=XhYT2AOhH58Can+mXfLz18ftGCjw/6Y9cju2fRNLQMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2pZOTO+BrAn21gToa1EQQfWIEaqRaqIzLgRRRtxkVdy0L2YDFSy28RgElqEIg0vb
         Kc97yRA5HtFZRYEDpJu2OnjJ6458vYE71VqXUi1fcSIfv+K7VbIbey4kBD5jSPgGfq
         e50v0hYzS9xKB0f6fNlqeNg0qYSlvyIfR1dUKNVc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 01/29] dt-bindings:iio:humidity:hdc100x Drop separate doc + add to trivial-devices
Date:   Sat, 31 Oct 2020 13:40:42 +0000
Message-Id: <20201031134110.724233-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding for this i2c device with no properties beyond
reg and compatible.  Hence doesn't need it's own document.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../bindings/iio/humidity/hdc100x.txt           | 17 -----------------
 .../devicetree/bindings/trivial-devices.yaml    | 10 ++++++++++
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
deleted file mode 100644
index c52333bdfd19..000000000000
--- a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* HDC100x temperature + humidity sensors
-
-Required properties:
-  - compatible: Should contain one of the following:
-	ti,hdc1000
-	ti,hdc1008
-	ti,hdc1010
-	ti,hdc1050
-	ti,hdc1080
-  - reg: i2c address of the sensor
-
-Example:
-
-hdc100x@40 {
-	compatible = "ti,hdc1000";
-	reg = <0x40>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ab623ba930d5..d37f757e6bd1 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -356,6 +356,16 @@ properties:
           - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1000
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1008
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1010
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1050
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1080
             # Temperature sensor with 2-wire interface
           - ti,lm73
             # Temperature sensor with integrated fan control
-- 
2.28.0

