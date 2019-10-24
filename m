Return-Path: <SRS0=W9g2=YR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000BC47E49
	for <linux-iio@archiver.kernel.org>; Thu, 24 Oct 2019 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8734521655
	for <linux-iio@archiver.kernel.org>; Thu, 24 Oct 2019 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571931785;
	bh=HhFbC2II2pSDPgNJOx7TiRm3MahsD/AaLXNIkeaHEhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+FFBK5aa/RR9VTGR8wn52xqDAF+6+Elb/gNPt8+y5oov3Pkuz4uqkwNvcjV2jaHC
	 TTRUf1xKQavw80Fb01AQ2lrONNESAqAlZPteKB6fsDBd6Fdez7Ih5bkep7zUBowURr
	 eCulp8yTja/EbDccsSl+2YUhTr6nrzB4NqP3n0ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409734AbfJXPnE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406101AbfJXPnE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Oct 2019 11:43:04 -0400
Received: from wlan-180-98.mxp.redhat.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E70620650;
        Thu, 24 Oct 2019 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571931784;
        bh=HhFbC2II2pSDPgNJOx7TiRm3MahsD/AaLXNIkeaHEhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS3VqL7diKw6RyyAz37CeXaOrl7CvoJEb4Er/tS2NPpfwWnw8M6j0HgPqYVPm2hK+
         iktWM8OZEsTI1698zCniPUos5OxecNvwHzS7F7tmkkCfiH2ggbeBzpBk2JO2AVaNjA
         /t+HUkKhbS0LYSlBdbJ/0kLeHVXB8zvmiTNOiFVk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx device bindings
Date:   Thu, 24 Oct 2019 17:42:34 +0200
Message-Id: <1e96ac17ca6819cf8f35c757a63e11e815455225.1571931470.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1571931470.git.lorenzo@kernel.org>
References: <cover.1571931470.git.lorenzo@kernel.org>
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
index fc018ecba086..cef4bc16fce1 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -15,6 +15,7 @@ Required properties:
   "st,ism330dhcx"
   "st,lsm9ds1-imu"
   "st,lsm6ds0"
+  "st,lsm6dsrx"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.21.0

