Return-Path: <SRS0=NC80=CQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0238AC43461
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6454208C7
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495928;
	bh=kA8UYqwwvl1jhQhlspmrYdcfKcMzh6l6VSdMPGeBWuE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oc3agrSCSMv1/+ZHOP3BO1dTP9rxe7sEalWtJZoPI8sW8JCMAw27yEzLtgpqFfc5D
	 Mf8SPiGQc4OAkkfiRforHdVe8jte+GwMJOpcTnAxFljKmqILsrg9/ZhVzgE93wz+IS
	 +V77BX5XqITIQPzs+Ci+30O2ZP0kaRUlcnUf+2+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIGQMc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgIGQMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C751820757;
        Mon,  7 Sep 2020 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495140;
        bh=kA8UYqwwvl1jhQhlspmrYdcfKcMzh6l6VSdMPGeBWuE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZHzrPDfLcGKn97n0Gxq++gyxmTSFHfBIT21e2wfJZGkv3gY+Rj/jixhYdec2zzumj
         s0n9f4k8HFlLPZbhMIw5WfXBsnuDsDBJwdUGmLI6SDCyNrwZsYWgOlRz/n+sGIg9VB
         gazM7/e3slTF9HAs7T63IAcFbWvHNakMc958tqgs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 01/25] dt-bindings: samsung: pmu: document S5Pv210
Date:   Mon,  7 Sep 2020 18:11:17 +0200
Message-Id: <20200907161141.31034-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compatible for the Samsung S5Pv210 SoC PMU.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
index edbe8c69387b..17678d9686c1 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
@@ -24,6 +24,7 @@ select:
           - samsung,exynos5420-pmu
           - samsung,exynos5433-pmu
           - samsung,exynos7-pmu
+          - samsung-s5pv210-pmu
   required:
     - compatible
 
@@ -40,6 +41,7 @@ properties:
           - samsung,exynos5420-pmu
           - samsung,exynos5433-pmu
           - samsung,exynos7-pmu
+          - samsung-s5pv210-pmu
       - const: syscon
 
   reg:
-- 
2.17.1

