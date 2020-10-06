Return-Path: <SRS0=IObS=DN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D6C41604
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2C720760
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601986100;
	bh=N6ZtcHj+m6WXi3W3oUj3iWA2g35xw2FMXehdmstLoYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kG5CGkg6DKYhqLR1a0nglaAKyZbdrEBMkcYnAn/+zEQbBLWFHMg14zvhERaehpA/O
	 uQtxMYFoQcNzpwypL45OZ6yyKhkI9LCHykStSh4VjXZbiDel1Y60fSZefMwy/995wg
	 ZhcRT39r9bQVhhSibSHfiaG49FT9L0gn4/b2DF6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJFMIT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Oct 2020 08:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgJFMIT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 08:08:19 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB52C20663;
        Tue,  6 Oct 2020 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601986099;
        bh=N6ZtcHj+m6WXi3W3oUj3iWA2g35xw2FMXehdmstLoYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqPamjRSmhhZsSs0XhPKDJfxRE/7ysSyYFwx9ljIikFdST5Gxf9irhwYpV2mv7Bnr
         1au4isBV138PRz39vv+6je8reHGrOjAWE7m6jRWEXwvLGrpYszMcq5u6SHS7X0XOiN
         1SnIk0rYeh2H2B0i3kzhw2n4U1VAVsGYtDCMgHbU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, mario.tesi@st.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dst device bindings
Date:   Tue,  6 Oct 2020 14:07:42 +0200
Message-Id: <05e4273f2544230049b2cd82c6bf1be788a8e483.1601985763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601985763.git.lorenzo@kernel.org>
References: <cover.1601985763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index cef4bc16fce1..7c6742d3e992 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -16,6 +16,7 @@ Required properties:
   "st,lsm9ds1-imu"
   "st,lsm6ds0"
   "st,lsm6dsrx"
+  "st,lsm6dst"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.26.2

