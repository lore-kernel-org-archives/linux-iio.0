Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73F1C4321E
	for <linux-iio@archiver.kernel.org>; Wed, 16 Nov 2022 13:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiKPNkf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiKPNk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 08:40:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C421811;
        Wed, 16 Nov 2022 05:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4038C61DA9;
        Wed, 16 Nov 2022 13:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572CBC433D6;
        Wed, 16 Nov 2022 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606025;
        bh=bufem0bex8cDPdE7MAohrSty9+g5e79SyAqKPkv803s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMMadfEtXJ2PNlO3fBDydTHy/iDW6PQnPx7oBqF0H2hFMkX+ydUgOAYbjMEJgf8cS
         QVkCM6qG9NCWJpD4ncEbmMNJeF3sqV0TC8nCUszMYTGEa18pz/HQsUPXvIQeo6xv+h
         tAtWUZZr/KMuUpTJqlMI+YgQhW4K5Ney6srreNDFFbsPp8oUOx+Tne54wmDzpMD622
         NOiPwrX8tHtut/sJtH18GIYuvO+HXhKDWDNMmFXQwE1hCa3a71N2uqPNuzs1ztvhRv
         suHn76ZkHx7QCrr+4ZnD9fCRBDFxcHgC2Hx1uppmp2c30pHO6GLc/wShKQ8pwazaCE
         lbzxgsVw4tLxQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is
Date:   Wed, 16 Nov 2022 14:40:04 +0100
Message-Id: <55b15b3e8453a12edcf8195ef9c9243a76f87096.1668605631.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668605631.git.lorenzo@kernel.org>
References: <cover.1668605631.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device bindings for lsm6dso16is IMU sensor.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 5933270799f5..07d5aee7e442 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -33,6 +33,7 @@ properties:
           - st,lsm6dst
           - st,lsm6dsop
           - st,lsm6dsv
+          - st,lsm6dso16is
       - items:
           - const: st,asm330lhhx
           - const: st,lsm6dsr
-- 
2.38.1

