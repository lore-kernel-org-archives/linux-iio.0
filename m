Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25AFC63697
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B8824654
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbzo4By/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgKQPL5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgKQPL4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 10:11:56 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDCF2467D;
        Tue, 17 Nov 2020 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605625916;
        bh=7aqPylBcPE0hTvcFZP+WuGwwl5Fz+j301oNokWu+JEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wbzo4By/GeevfmD8hHukUcf6TjvwChQgTSVlBSksEQdqRzeeGUL5xCTtbUNxHWToT
         X/kkYDK/qP3A5ks6gJogIVg6csMi2c9ZdgaH8LOgWcAN2ILTbEcSmNEORuUqqla0fs
         92HBZ++7PcALKpQcgVu6lZtNqGZZKjyXF7lMv/JI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: introduce vdd-vddio regulators bindings
Date:   Tue, 17 Nov 2020 16:11:38 +0100
Message-Id: <fd692095f2cdda5a99327f57e69c34a4ffce232f.1605625579.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605625579.git.lorenzo@kernel.org>
References: <cover.1605625579.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 7c6742d3e992..bc3448df9647 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -20,6 +20,10 @@ Required properties:
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
+- vdd-supply: an optional regulator that needs to be on to provide VDD
+  power to the sensor.
+- vddio-supply: an optional regulator that needs to be on to provide the
+  VDD IO power to the sensor.
 - st,drdy-int-pin: the pin on the package that will be used to signal
   "data ready" (valid values: 1 or 2).
 - st,pullups : enable/disable internal i2c controller pullup resistors.
-- 
2.26.2

