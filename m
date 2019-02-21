Return-Path: <SRS0=ELbO=Q4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBEC43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAAD2083E
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550762442;
	bh=SZFL6Lu1AFRdCs9JSHW4T+KJPnG2PIcg+tIKGFsdagM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TT+F1dFFi68+ZovRtoGQCZrk5gR7bW+eU5Ps/FaPGMP1eGT5xos8qEGNsEEleNCTk
	 mZDCsWkNs0dEqfVYrM1Y0TfzS4PDo00EV2zvHmGz76mkGZoDW2T0CBNLh7Jss0iyaW
	 V6zcnk8B+bpEZez3QqpuUe2lC0VokWk0dnX7MBVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBUPUm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:20:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUPUm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Feb 2019 10:20:42 -0500
Received: from lore-desk.lan (unknown [151.66.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE0E2084D;
        Thu, 21 Feb 2019 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550762441;
        bh=SZFL6Lu1AFRdCs9JSHW4T+KJPnG2PIcg+tIKGFsdagM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBF4HiUiqXXf7iGLGBMDMqas9b6zU++/5DGN7/hpWCuf5XPtqyVdh85i8852K+Pch
         0YOHTMWN9aFJ1hkWs66ubu+e6oBdtcC+KlELwr1fojuQmDWeVX0KNyVxhEEk8/uizP
         XyahKezRe0nCg/XMOp3rYfrn30BAByeTBEL1n+eQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhh device bindings
Date:   Thu, 21 Feb 2019 16:20:21 +0100
Message-Id: <1df29add6d5a0fcdd51594f8cf4366c9086f6fc9.1550753006.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550753006.git.lorenzo@kernel.org>
References: <cover.1550753006.git.lorenzo@kernel.org>
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
index 69d53d98d0f0..8f1b09e39c72 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -8,6 +8,7 @@ Required properties:
   "st,lsm6dsm"
   "st,ism330dlc"
   "st,lsm6dso"
+  "st,asm330lhh"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.20.1

