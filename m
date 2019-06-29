Return-Path: <SRS0=duTD=U4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5955AC4321A
	for <linux-iio@archiver.kernel.org>; Sat, 29 Jun 2019 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D52321743
	for <linux-iio@archiver.kernel.org>; Sat, 29 Jun 2019 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561803248;
	bh=M2vob7JhqBqWeRxI1/r38gcAXr+gyORK3M0dMl07nX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFAjmlt4OTSbMMOeNcjaTnXyGu27YCP1hN+uSv5WEMipcIwJGirl5eSIIcnaJolzh
	 u5wvK/4/Guzrq5Bn8d6UaZEqKdoWB592zlejJgbKxEim7s7mBQNOXF3hVs6A9b0GwB
	 ubZyiIYapdtks9A6JzBJo12umABkEu30vZbQXYOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF2KOH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfF2KOH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Jun 2019 06:14:07 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D74B21670;
        Sat, 29 Jun 2019 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561803246;
        bh=M2vob7JhqBqWeRxI1/r38gcAXr+gyORK3M0dMl07nX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hkcf9psuqlEbUQ230brPCSAd2YIotTjGAWTJiZwaMgwR8qGAWjb65zONqHIUVNOKe
         VnuFgTDJNaBGoD68JuensHsTdLYxBtSGongzOlbio8IM15uO6cc7y/EL+f4VCpWTjM
         dGXWPmo9gCnrtgpjMCtbdhOjuap45yJG4GKPt1vk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c device bindings
Date:   Sat, 29 Jun 2019 12:13:54 +0200
Message-Id: <89edf867d6abb738527889040f030036173fd5b8.1561802767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561802767.git.lorenzo@kernel.org>
References: <cover.1561802767.git.lorenzo@kernel.org>
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
index efec9ece034a..92b48f242356 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -11,6 +11,7 @@ Required properties:
   "st,asm330lhh"
   "st,lsm6dsox"
   "st,lsm6dsr"
+  "st,lsm6ds3tr-c"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.21.0

