Return-Path: <SRS0=W9FC=SG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D71C10F0C
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267D3217D9
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554393774;
	bh=llxs16q7EYlqiFKGtDDOi7Jy3jo/I4VPZ+bWG/xWlNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFLUtzENVeqXtXpEUjpi06aO2cYtN02i/EypU6jiSnqJ1fL/+w6iVsaytO5Vg1zRA
	 TUK5wT5WNo7TQFJuLW8nsv5KUOjegKTKOWU3qSZvd7oeBNcX2I5m4/6vJNUft6Hl8N
	 teL0Nu/qY4N5lkalrbaj7A5IlbP+60C9HYZcoN6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfDDQCx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbfDDQCw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Apr 2019 12:02:52 -0400
Received: from localhost.localdomain.com (unknown [151.66.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0528320855;
        Thu,  4 Apr 2019 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554393772;
        bh=llxs16q7EYlqiFKGtDDOi7Jy3jo/I4VPZ+bWG/xWlNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6MNLZx0JlhPllxgvQika5/EIAsJ7GZuOUrrJaor0Ep/wUsjUwp7m/J8r5HsfwRqs
         RuSrk8un/zD2+ywzUJozMaHER4WR5kCvoz8o4iiFwUbvv8YQ4Tfu2339cCqCpaS85/
         yrFm6IWTlHaPeMcSxmUdV/szk/b7+keckgpVygXM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsr device bindings
Date:   Thu,  4 Apr 2019 18:02:35 +0200
Message-Id: <d72fe86f431bbf68ebeec0b234f4c57881e86c82.1554393394.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554393393.git.lorenzo@kernel.org>
References: <cover.1554393393.git.lorenzo@kernel.org>
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
index 4640a012c17a..efec9ece034a 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -10,6 +10,7 @@ Required properties:
   "st,lsm6dso"
   "st,asm330lhh"
   "st,lsm6dsox"
+  "st,lsm6dsr"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.20.1

