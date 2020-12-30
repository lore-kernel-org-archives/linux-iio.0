Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466D3C433E6
	for <linux-iio@archiver.kernel.org>; Wed, 30 Dec 2020 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB92220B
	for <linux-iio@archiver.kernel.org>; Wed, 30 Dec 2020 12:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgL3MWE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Dec 2020 07:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgL3MWE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 07:22:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27FE72220B;
        Wed, 30 Dec 2020 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609330884;
        bh=lxNPnzdDyjWsyS+E0orDPDGd4R0X6oWe5CXCiakGWUs=;
        h=From:To:Cc:Subject:Date:From;
        b=MdYSn7V0atcJ5SjuK+YnCZgiE5cGJBUpcGalIHnrn7Z58qPKeK2t0oGEdg58X7Z/H
         GdO7Edg9Y1sCM0a+0h8N+P31+KGpQwzuPxyaG8xisTnYeB9cHJdkOvA8qqxBvN+Iih
         3lSobYSuawF71NYXbnBM0LQxdyfRBcOySIrKs/4j5T7So5W5Flm+nuhufMSoyxws3w
         DU7hUaXhBD7SebYUUkPJrS9c+WvHn0ngaEejVVYydzwWLCZYL1ApBZpPau+vyDbf1T
         hNhKYP06DGQH4PnBwGJAN2ecM1MQ1A5R7t9L/38tG17s8FnJg8BgaeWkyNcfIEjxg8
         lJ+17jYO/uGow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings:iio:health:ti,afe4404: Fix wrong compatible value.
Date:   Wed, 30 Dec 2020 12:19:19 +0000
Message-Id: <20201230121919.238335-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cut and paste error.

Documentation/devicetree/bindings/iio/health/ti,afe4403.example.dt.yaml:
heart_mon@0: 'spi-max-frequency' does not match any of the regexes:
'pinctrl-[0-9]+'

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: f494151b5eba ("dt-bindings:iio:health:ti,afe4404: txt to yaml conversion")
---
 Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
index 3b4d6c48b8bb..c0e815d9999e 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 properties:
   compatible:
-    const: ti,afe4403
+    const: ti,afe4404
 
   reg:
     maxItems: 1
-- 
2.30.0

