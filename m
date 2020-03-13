Return-Path: <SRS0=K2ZU=46=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CEC5ACBF
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108B720746
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyxX49Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCMN3h (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:29:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37219 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgCMN3h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 09:29:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id a141so10299439wme.2;
        Fri, 13 Mar 2020 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrKXBoCUuu/YXqMOvtISka4qMKizynY2Llltse6yD6g=;
        b=qyxX49HaParr7PiDqXQONEAb/n7pPXecdHvAmUVpO5OuIVuIcNMDojbPcdI0q0TPjG
         nc5DSGPWl3L5lOoCf6P+l6kHHpRcCuQce/bNmJ0xhIxb1xzbXDwHWr1V/mUcoU2d73B1
         MnNPr3We5V4qXIgdlBw8g7vu6b2uYGXD6SrFnZ8/IvCkPhBFNb8Zm/RHLnRJVbs0Lw+G
         4muHqX0te/9whiCol62XG4uNvwtQMNgYdHs/QgbIotLFLCBzWeWczsekko11so2edADB
         wACeRvN45Vo/10Rg3BOwdal8Lov7IyL93myUW8yO/0zMOEhz0kwr8eHzPomG0Qo3GueR
         BgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DrKXBoCUuu/YXqMOvtISka4qMKizynY2Llltse6yD6g=;
        b=AXRTva0u/BNNcHz7WKnBLBF1AB7udJU5djKnPnXcdd2urOENnLBpDMaPQzthbS+Zgd
         mRXGFAI/Cjgs9+MRmpTi5+J8uXptdULNaBb+dohBOl2P4L1ean5xYkUKfIN7Ctmh/F+0
         o8Flgmu7AW8cJ6ufBGrYgVGX+kI/eQmgkbxTdZI526SY60p289OaC4MKrvEUHVGxkk+E
         YxrU8V+OVYXhGIE28d0u3Bp3j2N+gaRuF34iqewxRJSwWqoo/0kaFiqKlQXi2Us0H31g
         oh4X9p9xvVqkOpaWz4M5vPBGN40Yfb0PXVHP3MEOQgR0CjDAE2Ffd3w5/qGRKj70NASX
         TaNw==
X-Gm-Message-State: ANhLgQ19yOKvcvI/MExhe5stbstYVXZou5SN4JRGj4lLZ4UyrZ8xx3lP
        HY48F4PgkJ10kQh1yRBc+h0=
X-Google-Smtp-Source: ADFU+vvarS9F0YQaqPnisaiFvsN9qJoio2i1gsSUt5Bw5Hz7yjOJCrg5MUUMxARRBgAHPqRgrJrTqg==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr11210048wmt.137.1584106174949;
        Fri, 13 Mar 2020 06:29:34 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z19sm17576705wma.41.2020.03.13.06.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:29:34 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: iio: adc: rockchip-saradc: add description for rk3308
Date:   Fri, 13 Mar 2020 14:29:25 +0100
Message-Id: <20200313132926.10543-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200313132926.10543-1-jbx6244@gmail.com>
References: <20200313132926.10543-1-jbx6244@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-saradc", "rockchip,rk3399-saradc"
for saradc nodes on a rk3308 platform to rockchip-saradc.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 2908788b3..d3b78604b 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -17,6 +17,7 @@ properties:
       - const: rockchip,rk3399-saradc
       - items:
           - enum:
+            - rockchip,rk3308-saradc
             - rockchip,rk3328-saradc
             - rockchip,rv1108-saradc
           - const: rockchip,rk3399-saradc
-- 
2.11.0

