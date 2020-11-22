Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB533C56202
	for <linux-iio@archiver.kernel.org>; Sun, 22 Nov 2020 11:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34A208C3
	for <linux-iio@archiver.kernel.org>; Sun, 22 Nov 2020 11:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5p4DaFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgKVL5a (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Nov 2020 06:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVL53 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 06:57:29 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CF420936;
        Sun, 22 Nov 2020 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606046249;
        bh=irV3AVBbUxFfydDuyRS3PQ8RbTnVQzCV8HI4RiThvy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5p4DaFkgX22lkp+XqWwE+2D1v2+frtzriez8ounYBQzDmuL+SnQhDH+Q4+nfntNQ
         EMY2pM30wVRhaNalzn5lYh+nd1HXDdf1ov4Rditj4aSU5UBtI4JApCUtvQ50DmelLS
         4CdP4x+g2RfIVvNdaVOf1M3nk6gyPVY6MpmEByhE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings
Date:   Sun, 22 Nov 2020 12:56:49 +0100
Message-Id: <9579804f52ccab74a5ca5c7a55b5072b7304bea9.1606045688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606045688.git.lorenzo@kernel.org>
References: <cover.1606045688.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
index 396451c26728..598473df74fa 100644
--- a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
@@ -26,6 +26,8 @@ properties:
       The interrupt/data ready line will be configured as open drain, which
       is useful if several sensors share the same interrupt line.
 
+  vdd-supply: true
+
   interrupts:
     maxItems: 1
 
-- 
2.28.0

