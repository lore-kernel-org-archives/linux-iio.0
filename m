Return-Path: <SRS0=BsLG=PW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05563C43387
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAE220873
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="yvqvJ9pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfAND4r (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:56:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36828 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfAND4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2019 22:56:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9500424plo.3
        for <linux-iio@vger.kernel.org>; Sun, 13 Jan 2019 19:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgtsCNC4lKMzHun3rXVG2z7hRy3IkPEkIrYF5GtUHHI=;
        b=yvqvJ9pzBeGiZieEYLEon0kn/HP1XhLGUcyHcGm0cHw9sZAPzkUhLIHRY5rnbx5PUI
         xnlr8DcE5Sz6wl6aOGS2FdjM1Uxk8vecSfp2uLz/2jvI8apbkYZUe0ZfmDOnEp0ZygyW
         xfqVxsgpNhzNSAKwmE2u9hHGO5bMOQKy9rloNYUg1VQpHfwVrdU/Jq8PW4eB1OzbXxdM
         5fhspjsVJQk7j1j+uPC0hga93ZBQibaQQCL2+fg7fSdAes8bKQX4KO4sSia9plkax8Zx
         zjcd1TaDa+lWAADzMZ7LKiQikAWnsnLQYv/BWUT5mYqT3dDvwQV48XkDU/xtG64oIQPA
         EXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgtsCNC4lKMzHun3rXVG2z7hRy3IkPEkIrYF5GtUHHI=;
        b=qudMNDkvFeoYaFqc5TZKHVCprjHa2RGMEo0gG2u7L5w1B9SKOWmA4h2pA6aGOrqNp/
         QcWlTGQ96cyLSatcVGbmD8RmjshL+TB8z85h0RCfjnplcL0GsdEHt4VGDUjImoSASGAH
         skEPTtZF5yfxrVM9HIgs4N65xgpsbw1y/d9372iuEC7H6r3ddXzAEiz3yYrmz0Igdwxn
         Sh/a+pFkveEaUqKaBxg4H+D3DTqZicdfUwTVcO6JJDP73F7jpt3JNSbs3SHd9VXjhouf
         LaRv5J5YGfz2svW1CcyzVpA0d4JjewKyPyGhU8tR3bMIxyBiPbCkrmMcERcFd/EChlHV
         lUxg==
X-Gm-Message-State: AJcUukdaczlWYLCOICNHWSeHPQVSQaAPWvHNUyhTz/Ibl0LQxGXAMJtp
        /dRMJiWGJIWYyo1LNECCppszQ186PqI=
X-Google-Smtp-Source: ALg8bN4ZWDlg6q6bM5OSxEnrsYKPoAbemcpIidCt7TQ5FvOpsj4cqHmO2yndJz//DlTKmmkyQdl6kg==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr24311473plt.101.1547438205790;
        Sun, 13 Jan 2019 19:56:45 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id l70sm93582741pgd.20.2019.01.13.19.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:56:45 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 4/5] dt-bindings:bmi160: add "BOTH" int pin type
Date:   Sun, 13 Jan 2019 19:56:20 -0800
Message-Id: <20190114035621.5252-5-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190114035621.5252-1-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

The bindings currently allow for interrupts routing to INT1 or INT2, but
the hardware allows for routing to both, so add "BOTH" as an int pin entry.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 Documentation/devicetree/bindings/iio/imu/bmi160.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
index 1aec19997fb5..a56d377dabf3 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -11,7 +11,8 @@ Required properties:
 Optional properties:
  - interrupts : interrupt mapping for IRQ
  - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
-   input, set to "INT2" if INT2 pin should be used instead
+   input, set to "INT2" if INT2 pin should be used instead, set to "BOTH" if
+   both should be used.
 
 Examples:
 
@@ -33,3 +34,13 @@ bmi160@0 {
 	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
 	interrupt-names = "INT2";
 };
+
+bmi160@0 {
+	compatible = "bosch,bmi160";
+	reg = <0>;
+	spi-max-frequency = <10000000>;
+
+	interrupt-parent = <&gpio2>;
+	interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "BOTH";
+};
-- 
2.11.0

