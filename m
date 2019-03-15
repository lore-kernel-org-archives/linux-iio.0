Return-Path: <SRS0=RKAC=RS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097DC43381
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C204F218AC
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552644531;
	bh=Wgr7uvi8J4ahKlSL56j0+O5RzYvitlrzCRnFjIqiWK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g/Ax6UtHpkONFLxKE3fjbl1zEfd6+pOYlU9rlzzMngJQYssD/+aZHb82WdVEardE+
	 nEUxLqbgvOP9nkqTo/nj+pz8jvP4/90gnY3AjR20dTa8uWUtOsV8LIjzeQA6h8RWNc
	 y/lEaF42noKYTUZrjgaLqK8V4cyz3jZOGcfSIhW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfCOKIv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfCOKIv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Mar 2019 06:08:51 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B3C218B0;
        Fri, 15 Mar 2019 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552644530;
        bh=Wgr7uvi8J4ahKlSL56j0+O5RzYvitlrzCRnFjIqiWK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAiwr/D2XQ5n8l8HZDk/tKJvhegTkc8QtMI64Bf6jvt/4GGbVgzk3XPDimCIsTWzh
         qiY8TXktnpa39LW3N3hnvVist2ZXbedORVkg6IsTbTU4rKlCZjAFDYOASFyybUMNAh
         RB5rCK2mQvr/PrGQ9k89j/ONuACpF0/vs+QQCfKU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsox device bindings
Date:   Fri, 15 Mar 2019 11:08:25 +0100
Message-Id: <a633a5633b93d4a131a88b94d29ea263eea64fe9.1552643968.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1552643968.git.lorenzo@kernel.org>
References: <cover.1552643968.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 8f1b09e39c72..4640a012c17a 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -9,6 +9,7 @@ Required properties:
   "st,ism330dlc"
   "st,lsm6dso"
   "st,asm330lhh"
+  "st,lsm6dsox"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.20.1

