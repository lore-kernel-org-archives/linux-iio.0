Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D065C43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BE21916
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="kdHcXhxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfBRODy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389771AbfBRODx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Feb 2019 09:03:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so13900665edb.5
        for <linux-iio@vger.kernel.org>; Mon, 18 Feb 2019 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
        b=kdHcXhxCjuyfL/RsbUdI7m1L2Yqy6Ch6aOf/JLBNnD5HRcGRSlgFnLV7GDHT0+O/ZH
         WwhadtXZC4vVGNOZDuBn55xN7S4uRWX++KyhraFKHbfOfDIpV2BF2i1X1ZZmPSUG4VoF
         AkRhIRakB9igwGHCOjQRaHFAWn158WcLofcO9Bvujyxj6a9Q5/FR2tK/sXcaVtMFDepB
         mzDtU5X9T6XAokc0oVHVyJYLk6aWrjK7mlq7vIRYN+67ZQfflVjoZTlS3hBnJ8v3vCvY
         cUmqgkNmUgZCJM9+9LD/mdkYFxEuSclcXauFOzLsjW1gmke/0ca5/PZRLVfeL0qwR77Y
         7kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
        b=a4S8VO/pgx/cbD/2nmCiAEsRU/cdhYTsn1q0WWRmuC6XDwlwphfs7gBD85l8ugsSGe
         JhJLaGx+2Dfsz+uyzZiMaRIxasHFy3qdNPO5vdyijz8LmHOKJ9Igwrw/LBleN/xMcH59
         HAc6z6IxUmB6o/TDm+qnbROdHvE5z9mraKV7TNZl0Y0wUW2liYjiseBhpIP9uMVUNbo5
         /VQRHvc17XKBOr49zUm1+mRCkQyw+2CMlFEZifDc/uxiI0ARnHonpppHEb4Gc0HZLxJ5
         03LsLXcRXqsuD5DxqPvK80/c0lanjk2CH/pX1yqWHs9qFO1ugfZJpp0IcP0S0ahDI7Od
         PJkQ==
X-Gm-Message-State: AHQUAuZ08VerAVkfF6FYEPC5l7KUOw8WwIlTKqAEBzI1FUI9ZP/wPle9
        wOXNvYFFBGEVVKndLtkmdrOTIw==
X-Google-Smtp-Source: AHgI3IZi9n1v6BYfISfADbqQLufHezmPHIqiJiJUI3/6IPWV+cI2byGpqq/pa18Sn/cvn8B5knGS2w==
X-Received: by 2002:a17:906:ee2:: with SMTP id x2mr16832980eji.202.1550498631380;
        Mon, 18 Feb 2019 06:03:51 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:50 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 4/8] dt-bindings: iio/counter: ftm-quaddec
Date:   Mon, 18 Feb 2019 15:03:17 +0100
Message-Id: <20190218140321.19166-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../bindings/iio/counter/ftm-quaddec.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.17.1

